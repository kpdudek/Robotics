#!/usr/bin/env python

from ar3.msg import ar3_feedback, ar3_control
import rospy
import time
from math import sin
from math import pi
import numpy as np
from std_msgs.msg import Float64
import sys


class RobotController(object):
    def __init__(self):
        # ROS stuff
        self.AR3Control = ar3_control()
        self.AR3Feedback = ar3_feedback()

        self.AR3ControlPub = rospy.Publisher('/AR3/Control', ar3_control, queue_size = 1)
        self.AR3FeedbackSub = rospy.Subscriber('/AR3/Feedback', ar3_feedback, self.AR3FeedbackCallback)

    def AR3FeedbackCallback(self,data):
        self.AR3Feedback.joint_angles = list(data.joint_angles)
        self.AR3Feedback.setpoint_angles = list(data.setpoint_angles)
        self.AR3Feedback.eStop = data.eStop
        self.AR3Feedback.homed = data.homed
        self.AR3Feedback.running = data.running
        self.AR3Feedback.resting = data.resting
        self.AR3Feedback.gripper_angle = data.gripper_angle

    def send_joints(self):
        self.AR3ControlPub.publish(self.AR3Control)

    def clc(self):
        print('\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n')
        print('AR3@Controller:$ '),

    