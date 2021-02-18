#!/usr/bin/env python

import rospy
from math import sin
from math import pi
import numpy as np
from std_msgs.msg import Float64
from tf.transformations import euler_from_quaternion, quaternion_from_euler
import time
import threading
# import trac_ik
from trac_ik_python.trac_ik import IK
#from trac_ik_python.trac_ik_wrap import TRAC_IK
import pwd, sys, os
name = pwd.getpwuid( os.getuid() ).pw_name
file_path = '/home/%s/Robotics/src/ar3/scripts'%name
sys.path.insert(1,file_path)
from RobotControllerClass import RobotController

def main():

    rospy.init_node('Joint_Control', anonymous='True')

    robot_controller = RobotController()

    rate = rospy.Rate(60)

    with open('/home/kurt/Robotics/src/ar3/urdf/AR3_noGazebo.urdf', 'r') as fp:
        urdf = fp.read()
    Solver = IK("world", "flange", urdf_string=urdf)

    print("IK solver uses link chain:")
    print(Solver.link_names)

    print("IK solver base frame:")
    print(Solver.base_link)

    print("IK solver tip link:")
    print(Solver.tip_link)

    print("IK solver for joints:")
    print(Solver.joint_names)

    # print("IK solver using joint limits:")
    # lb, up = Solver.get_joint_limits()
    # print("Lower bound: " + str(lb))
    # print("Upper bound: " + str(up))
    

    qinit = [0.0] * Solver.number_of_joints
    # print(Solver.number_of_joints)

    x = 0.0; y = -0.3 ; z = 0.35
    quat = quaternion_from_euler(0.,3.14,3.14,'rxyz')
    rx,ry,rz,rw = quat

    bx = by = bz = .03
    brx = bry = brz = 2*pi * .1

    # sol = Solver.get_ik(qinit,x,y,z,rx,ry,rz,rw,bx,by,bz,brx,bry,brz)
    sol = Solver.get_ik(qinit,x,y,z,rx,ry,rz,rw)
    if not sol:
        print('No solution found!')
        return
    print("Solution found: ",sol)
    
    
    # userIn = raw_input("Can the robot begin moving? Ensure the space is clear (y/n): ")
    # assert userIn=='y','Robot wont begin moving.'

    # robot_controller.AR3Control.home = 0
    # robot_controller.AR3Control.run = 1
    # robot_controller.AR3Control.rest = 0
    # while not rospy.is_shutdown():
    #     angs = list(sol)
    #     if angs:
    #         # angs.pop()
    #         robot_controller.AR3Control.joint_angles = angs
    #         robot_controller.send_joints()
    #     # rate.sleep()

    #     resp = raw_input("Waiting...")


if __name__ == "__main__":
    main()
