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
from teensy.msg import ar3_control
from ar3.msg import ar3_feedback
from sensor_msgs.msg import JointState

import sys, os, pwd
name = pwd.getpwuid( os.getuid() ).pw_name
file_path = '/home/%s/Robotics/src/ar3/scripts'%name
sys.path.insert(1,file_path)
from RobotControllerClass import RobotController

class Interpreter(object):
    def __init__(self):
        self.joint_state_publisher = rospy.Publisher('/joint_states', JointState, queue_size=10)
        self.AR3ControlSub = rospy.Subscriber('/AR3/Control', ar3_control, self.AR3ControlCallback)
        
        self.t_prev = time.time()
        self.speed = 0.00001
        self.rate = 30.0

        pulse1Rev = 1.0 / (1600.0*10.0*4.0) # pulse/rev, gearbox, pulley ratio
        pulse2Rev = 1.0 / (3200.0*50.0) # pulse/rev, gearbox
        pulse3Rev = 1.0 / (1600.0*50.0) # pulse/rev, gearbox
        pulse4Rev = 1.0 / (1600.0*(13.0+(212.0/289.0))*2.4893) # pulse/rev, gearbox, pulley ratio
        pulse5Rev = 1.0 / (1.0/((8.0/1600.0)/(2.0*pi*13.675))) # pulse/rev, lead screw
        pulse6Rev = 1.0 / (800.0*(19.0+(38.0/187.0))) # pulse/rev, gearbox
        self.step_sizes = [pulse1Rev,pulse2Rev,pulse3Rev,pulse4Rev,pulse5Rev,pulse6Rev]

        self.AR3_Control = ar3_control()
        
        self.joint_state = JointState()
        self.joint_state.name = ['joint1', 'joint2', 'joint3', 'joint4', 'joint5', 'joint6']
        self.joint_state.header.stamp = rospy.Time.now()
        self.joint_state.position = [0]*6
        self.send_joints()
    
    def AR3ControlCallback(self,data):
        self.AR3_Control = data
    
    def send_joints(self):
        self.joint_state.header.stamp = rospy.Time.now()
        angles = []
        for idx in range(0,len(self.AR3_Control.joint_angles)):
            setpoint = self.AR3_Control.joint_angles[idx]
            current = self.joint_state.position[idx]
            error = setpoint - current

            step = self.step_sizes[idx] * ((1.0/self.rate)/self.speed)
            if abs(error) >= step:
                step_angle = current + step*np.sign(error)
            else:
                step_angle = setpoint
            angles.append(step_angle)
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