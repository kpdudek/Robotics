#!/usr/bin/env python

import random, sys, os, math, time, numpy
import threading

import rospy, rospkg
import tf

from trac_ik_python.trac_ik import IK
from tf.transformations import euler_from_quaternion, quaternion_from_euler

class GCodeGenerator():
    def __init__(self):
        rospy.init_node('gcode_generator', anonymous='True')
        self.rospack = rospkg.RosPack()
        self.ar3_path = self.rospack.get_path('ar3')
        self.program_buffer = []
        self.expected_len = 0
        self.previous_pose = [0.0]*6

        with open(self.ar3_path+'/urdf/AR3_noGazebo.urdf', 'r') as fp:
            urdf = fp.read()
        self.solver = IK("world", "flange", urdf_string=urdf)

    def save_queue(self):
        print('Saving queue')
        fp = open(self.ar3_path+'/src/ar3/programs/test.txt','w')
        for line in self.program_buffer:
            fp.write(line+'\n')
        fp.close()

    def queue_home_config(self):
        self.expected_len += 1
        home_config = [0.0]*6
        self.add_to_queue(home_config)
    
    def queue_rest_config(self):
        self.expected_len += 1
        rest_angs = [0.007,0.585,1.020,-0.002,1.294,0.007]
        self.add_to_queue(rest_angs)

    def add_to_queue(self,angles):
        program_line = ''
        program_line += 'JMove'
        for angle in angles:
            program_line += ' %.3f'%angle
        
        gripper_angle = 0
        speed = 0.95
        program_line += ' %d'%gripper_angle
        program_line += ' %.2f'%speed

        self.program_buffer.append(program_line)
    
    def add_ik_to_queue(self,coord):
        self.expected_len += 1
        angs = self.get_ik(coord)
        if angs:
            self.add_to_queue(angs)

    def get_ik(self,coord):
        x,y,z = coord[0],coord[1],coord[2]
        quat = quaternion_from_euler(coord[3],coord[4],coord[5],'rxyz')
        rx,ry,rz,rw = quat     

        self.qinit = self.previous_pose
        angles = self.solver.get_ik(self.qinit,x,y,z,rx,ry,rz,rw)

        if not angles:
            print("Solution not found!")
            return 0
        else:
            print("Solution found!")
            self.previous_pose = coord
            return list(angles)

def main():
    gcode_generator = GCodeGenerator()
    x,y,z = -0.0,-0.5,0.3
    max_rx = 2.9
    horiz_rx = 1.67

    # Add home config
    gcode_generator.queue_home_config()

    # Move to rest pose
    gcode_generator.queue_rest_config()

    # Rotate about X - axis
    rx,ry,rz = horiz_rx,0.0,0.0
    coord = [x,y,z,rx,ry,rz]
    gcode_generator.add_ik_to_queue(coord)

    rx,ry,rz = max_rx,0.0,0.0
    coord = [x,y,z,rx,ry,rz]
    gcode_generator.add_ik_to_queue(coord)

    # Rotate about Z - axis
    rx,ry,rz = max_rx,0.0,-1.4
    coord = [x,y,z,rx,ry,rz]
    gcode_generator.add_ik_to_queue(coord)

    rx,ry,rz = max_rx,0.0,1.4
    coord = [x,y,z,rx,ry,rz]
    gcode_generator.add_ik_to_queue(coord)

    gcode_generator.queue_rest_config()

    # Rotate about Y - axis
    rx,ry,rz = max_rx,0.7,0.0
    coord = [x,y,z,rx,ry,rz]
    gcode_generator.add_ik_to_queue(coord)

    rx,ry,rz = max_rx,-0.7,0.0
    coord = [x,y,z,rx,ry,rz]
    gcode_generator.add_ik_to_queue(coord)

    gcode_generator.queue_rest_config()

    # Back left
    x,y,z = 0.2,-0.4,0.151
    rx,ry,rz = 2.896,0.0,0.0
    coord = [x,y,z,rx,ry,rz]
    gcode_generator.add_ik_to_queue(coord)

    # Back right
    x,y,z = -0.2,-0.4,0.151
    rx,ry,rz = 2.896,0.0,0.0
    coord = [x,y,z,rx,ry,rz]
    gcode_generator.add_ik_to_queue(coord)

    # Forward low - rotate about X - axis
    x,y,z = -0.0,-0.6,0.0
    rx,ry,rz = 1.771,0.0,0.0
    coord = [x,y,z,rx,ry,rz]
    gcode_generator.add_ik_to_queue(coord)

    x,y,z = -0.0,-0.6,0.0
    rx,ry,rz = 3.0,0.0,0.0
    coord = [x,y,z,rx,ry,rz]
    gcode_generator.add_ik_to_queue(coord)

    x,y,z = -0.0,-0.6,0.0
    rx,ry,rz = 1.771,0.0,0.0
    coord = [x,y,z,rx,ry,rz]
    gcode_generator.add_ik_to_queue(coord)

    # Forward high
    x,y,z = -0.0,-0.6,0.4
    rx,ry,rz = 1.771,0.0,0.0
    coord = [x,y,z,rx,ry,rz]
    gcode_generator.add_ik_to_queue(coord)

    # Move to rest pose
    gcode_generator.queue_rest_config()

    # Add home config
    gcode_generator.queue_home_config()

    print('Expected length: {} | Actual length: {}'.format(gcode_generator.expected_len,len(gcode_generator.program_buffer)))
    if gcode_generator.expected_len != len(gcode_generator.program_buffer):
        print('Generated program with errors!')

    gcode_generator.save_queue()

if __name__ == '__main__':
    try:
        main()
    finally:
        pass