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

import sys, os, pwd
from ar3.RobotControllerClass import RobotController

class Interpreter(object):
    def __init__(self):
        self.joint_state_sub = rospy.Subscriber('/joint_states', JointState, callback=self.joint_state_callback)
        self.AR3FeebackPub = rospy.Publisher('/AR3/Feedback', ar3_feedback, queue_size=10)

        self.AR3_Feedback = ar3_feedback()
        
        self.joint_state = JointState()
        self.send_joints()
    
    def joint_state_callback(self,data):        
        self.joint_state = data
        self.AR3_Feedback.joint_angles = data.position

    def send_joints(self):
        self.AR3FeebackPub.publish(self.AR3_Feedback)

def main():
        rospy.init_node('rviz_feedback', anonymous='True')
        rate = rospy.Rate(10)

        interpreter = Interpreter()
        while not rospy.is_shutdown():
            interpreter.send_joints()
            rate.sleep()
                

if __name__ == "__main__":
        main()