#!/usr/bin/env python3

import rospy
import numpy as np
import sys, os, pwd
import os,getopt, time

from math import pi
from std_msgs.msg import Bool
from sensor_msgs.msg import JointState
from ar3.msg import ar3_feedback, ar3_control
from ar3.RobotControllerClass import RobotController

def map(x,in_min,in_max,out_min,out_max):
    '''Equivilent of Arduino's map() function
    
    '''
    return float((x - in_min) * (out_max - out_min) / (in_max - in_min) + out_min)

class Joint(object):
    def __init__(self,name,step_size,rate):
        self.name = name
        self.step_size = step_size
        self.rate = rate

        self.pulse_min = 30.0
        self.pulse_max = 400.0
        self.pul_delay = 30.0

        self.angle = 0.0
        self.setpoint = 0.0
        self.error = 0.0
        self.steps_to_go = 0.0
    
    def update_position(self,rate,max_steps_to_go):
        self.rate = rate
        self.error = self.setpoint - self.angle

        steps = abs(((1.0/self.rate) / (self.pul_delay*0.000001))/2.0 * self.step_size)

        if abs(self.error) >= steps:
            self.angle += steps*np.sign(self.error)
        else:
            self.angle = self.setpoint

        self.steps_to_go = round(self.error/self.step_size)
    
    def change_speed(self,spd):
        self.pul_delay = map(spd,0.0,1.0,self.pulse_max,self.pulse_min)
    

class Interpreter(object):
    def __init__(self):
        self.joint_state_publisher = rospy.Publisher('/joint_states', JointState, queue_size=10)
        self.AR3ControlSub = rospy.Subscriber('/AR3/Control', ar3_control, self.AR3ControlCallback)
        self.AR3FeedbackSub = rospy.Subscriber('/AR3/Feedback', ar3_feedback, self.AR3FeedbackCallback)

        self.t_prev = time.time()
        self.rate = 60.0

        self.simulated_robot_flag_sub = rospy.Subscriber('/AR3/is_simulated',Bool,self.simulated_robot_callback)
        self.simulated = False

        self.feedback_angles = [0.0]*6

        pulse1Rev = (1.0 / (1600.0*10.0*4.0))*2*pi # pulse/rev, gearbox, pulley ratio
        pulse2Rev = (1.0 / (1600.0*50.0))*2*pi # pulse/rev, gearbox
        pulse3Rev = (1.0 / (1600.0*50.0))*2*pi # pulse/rev, gearbox
        pulse4Rev = (1.0 / (1600.0*(13.0+(212.0/289.0))*2.4893))*2*pi # pulse/rev, gearbox, pulley ratio
        pulse5Rev = (1.0 / (1.0/((8.0/1600.0)/(2.0*pi*13.675))))*2*pi # pulse/rev, lead screw
        pulse6Rev = (1.0 / (1600.0*(19.0+(38.0/187.0))))*2*pi # pulse/rev, gearbox
        self.step_sizes = [pulse1Rev,pulse2Rev,pulse3Rev,pulse4Rev,pulse5Rev,pulse6Rev]

        self.speed = 0.0
        self.joints = []
        for idx in range(6):
            self.joints.append(Joint(str(idx),self.step_sizes[idx],self.rate))
        self.max_steps_to_go = 0.0
        self.new_goal = False

        self.AR3_Control = ar3_control()
        self.joint_state = JointState()
        self.joint_state.name = ['joint1', 'joint2', 'joint3', 'joint4', 'joint5', 'joint6']
        self.joint_state.header.stamp = rospy.Time.now()
        self.joint_state.position = [0]*6
        self.send_joints()
    
    def simulated_robot_callback(self,data):
        self.simulated = True
    
    def AR3ControlCallback(self,data):          
        self.speed = data.speed
        for idx in range(6):
            self.joints[idx].setpoint = float(data.joint_angles[idx])
            self.joints[idx].change_speed(self.speed)
        self.new_goal = True

    def AR3FeedbackCallback(self,data):
        self.feedback_angles = data.joint_angles
    
    def send_joints(self):
        self.joint_state.header.stamp = rospy.Time.now()

        if self.simulated:
            angles = []
            for idx in range(6):
                self.joints[idx].update_position(self.rate,self.max_steps_to_go)
                angles.append(self.joints[idx].angle)

            if self.new_goal:
                self.max_steps_to_go = -1.0
                for idx,joint in enumerate(self.joints):
                    if abs(joint.steps_to_go) > self.max_steps_to_go:
                        self.max_steps_to_go = abs(joint.steps_to_go)
                        max_idx = idx
                
                self.joints[max_idx].change_speed(self.speed)
                max_time = self.max_steps_to_go * self.joints[max_idx].pul_delay

                for idx,joint in enumerate(self.joints):
                    if idx != max_idx:
                        if not self.joints[idx].steps_to_go == 0:
                            self.joints[idx].pul_delay = max_time/self.joints[idx].steps_to_go
                self.new_goal = False
        else:
            angles = self.feedback_angles
        
        self.joint_state.position = angles
        self.joint_state_publisher.publish(self.joint_state)

def main():
        rospy.init_node('rviz_interpreter', anonymous='True')

        t = time.time()
        t_prev = time.time()
        
        interpreter = Interpreter()
        rate = rospy.Rate(interpreter.rate)
        while not rospy.is_shutdown():
            t = time.time()
            interpreter.send_joints()

            if t-t_prev > (1.0/3.0):
                # print()
                # for joint in interpreter.joints:
                    # print(joint.setpoint)
                t_prev = t
                
            rate.sleep()
                

if __name__ == "__main__":
        main()