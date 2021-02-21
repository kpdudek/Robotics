#!/usr/bin/env python

import rospy
from math import sin
from math import pi
import math
import numpy as np
from std_msgs.msg import Float64
import time
import sys
import os,getopt
from ar3.msg import ar3_feedback, ar3_control
from sensor_msgs.msg import JointState
from std_msgs.msg import Bool

import sys, os, pwd
from ar3.RobotControllerClass import RobotController

class Joint(object):
    def __init__(self,name,step_size):
        self.name = name
        self.step_size = step_size

        self.angle = 0.0
        self.setpoint = 0.0
        self.error = 0.0

        self.speed = 0.000025

        self.steps_to_go = 0.0
    
    def update_position(self,speed_cmd,rate,max_steps_to_go):
        self.speed_cmd = speed_cmd
        self.rate = rate

        self.error = self.setpoint - self.angle
        self.speed = ((1.0 - self.speed_cmd) * 75.0 * 0.000001) + (15.0*0.000001)

        step = self.step_size * ((1.0/self.rate)/self.speed)
        if abs(self.error) >= step:
            self.angle += step*np.sign(self.error)
        else:
            self.angle = self.setpoint

        # print(self.error,self.step_size)
        self.steps_to_go = self.error/self.step_size
    

class Interpreter(object):
    def __init__(self):
        self.joint_state_publisher = rospy.Publisher('/joint_states', JointState, queue_size=10)
        self.AR3ControlSub = rospy.Subscriber('/AR3/Control', ar3_control, self.AR3ControlCallback)
        self.AR3FeedbackSub = rospy.Subscriber('/AR3/Feedback', ar3_feedback, self.AR3FeedbackCallback)

        self.t_prev = time.time()
        self.speed = 0.000025
        self.rate = 30.0

        self.simulated_robot_flag_sub = rospy.Subscriber('/AR3/is_simulated',Bool,self.simulated_robot_callback)
        self.simulated = False

        self.feedback_angles = [0.0]*6

        pulse1Rev = 1.0 / (1600.0*10.0*4.0) # pulse/rev, gearbox, pulley ratio
        pulse2Rev = 1.0 / (1600.0*50.0) # pulse/rev, gearbox
        pulse3Rev = 1.0 / (1600.0*50.0) # pulse/rev, gearbox
        pulse4Rev = 1.0 / (1600.0*(13.0+(212.0/289.0))*2.4893) # pulse/rev, gearbox, pulley ratio
        pulse5Rev = 1.0 / (1.0/((8.0/1600.0)/(2.0*pi*13.675))) # pulse/rev, lead screw
        pulse6Rev = 1.0 / (1600.0*(19.0+(38.0/187.0))) # pulse/rev, gearbox
        self.step_sizes = [pulse1Rev,pulse2Rev,pulse3Rev,pulse4Rev,pulse5Rev,pulse6Rev]

        self.joints = []
        for idx in range(6):
            self.joints.append(Joint(str(idx),self.step_sizes[idx]))
        self.max_steps_to_go = 0.0

        self.AR3_Control = ar3_control()
        
        self.joint_state = JointState()
        self.joint_state.name = ['joint1', 'joint2', 'joint3', 'joint4', 'joint5', 'joint6']
        self.joint_state.header.stamp = rospy.Time.now()
        self.joint_state.position = [0]*6
        self.send_joints()
    
    def simulated_robot_callback(self,data):
        self.simulated = True
    
    def AR3ControlCallback(self,data):
        self.AR3_Control = data
        for idx in range(6):
            if self.joints[idx].setpoint != data.joint_angles[idx]:
                self.new_goal = True
                self.joints[idx].setpoint = data.joint_angles[idx]
        if self.new_goal:
            self.max_steps_to_go = 0.0
            for joint in self.joints:
                if abs(joint.steps_to_go) > self.max_steps_to_go:
                    self.max_steps_to_go = abs(joint.steps_to_go)
                # print(joint.steps_to_go)
            self.new_goal = False
            # print(self.max_steps_to_go)

    def AR3FeedbackCallback(self,data):
        self.feedback_angles = data.joint_angles
    
    def send_joints(self):
        self.joint_state.header.stamp = rospy.Time.now()

        if self.simulated:
            for idx in range(6):
                self.joints[idx].update_position(self.AR3_Control.speed,self.rate,self.max_steps_to_go)
            
            angles = []
            for idx in range(6):
                angles.append(self.joints[idx].angle)
        else:
            angles = self.feedback_angles
        
        self.joint_state.position = angles
        self.joint_state_publisher.publish(self.joint_state)

def main():
        rospy.init_node('rviz_interpreter', anonymous='True')
    
        interpreter = Interpreter()
        rate = rospy.Rate(interpreter.rate)
        while not rospy.is_shutdown():
            interpreter.send_joints()
            rate.sleep()
                

if __name__ == "__main__":
        main()