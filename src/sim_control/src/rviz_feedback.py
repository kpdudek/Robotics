#!/usr/bin/env python

import rospy
from math import sin
from math import pi
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

class Interpreter(object):
    def __init__(self):
        self.joint_state_sub = rospy.Subscriber('/joint_states', JointState, callback=self.joint_state_callback)
        self.AR3ControlCallback = rospy.Subscriber('/AR3/Control', ar3_control, callback=self.ar3_control_callback)
        self.AR3FeebackPub = rospy.Publisher('/AR3/Feedback', ar3_feedback, queue_size=10)

        self.AR3_Feedback = ar3_feedback()

        self.simulated_robot_flag_pub = rospy.Publisher('/AR3/is_simulated',Bool,queue_size=10)
        self.simulated_robot_flag = Bool()
        self.simulated_robot_flag.data = True
        
        self.joint_state = JointState()
        self.send_joints()

    def ar3_control_callback(self,data):
        self.AR3_Feedback.gripper_angle = data.gripper_angle
    
    def joint_state_callback(self,data):        
        self.joint_state = data
        self.AR3_Feedback.joint_angles = data.position

    def send_joints(self):
        self.AR3FeebackPub.publish(self.AR3_Feedback)
        self.simulated_robot_flag_pub.publish(self.simulated_robot_flag)

def main():
        rospy.init_node('rviz_feedback', anonymous='True')
        rate = rospy.Rate(10)

        interpreter = Interpreter()
        while not rospy.is_shutdown():
            interpreter.send_joints()
            rate.sleep()
                

if __name__ == "__main__":
        main()