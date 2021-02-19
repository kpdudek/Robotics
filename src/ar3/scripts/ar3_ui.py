#!/usr/bin/env python

from PyQt5.QtWidgets import * 
from PyQt5 import QtCore, QtGui, QtSvg, uic
from PyQt5.QtGui import * 
from PyQt5.QtCore import * 
import random, sys, os, math, time, numpy
# import pathlib
import threading

from teensy.msg import ar3_control
from ar3.msg import ar3_feedback
import rospy

from trac_ik_python.trac_ik import IK
from tf.transformations import euler_from_quaternion, quaternion_from_euler

import pwd
name = pwd.getpwuid( os.getuid() ).pw_name
file_path = '/home/%s/Robotics/src/ar3/scripts'%name
sys.path.insert(1,file_path)
from RobotControllerClass import RobotController

class ElementColors(object):
    def __init__(self):
        ###################################################
        # Game Colors
        ###################################################
        self.brown = {'hex':'#996633','rgb':[153,102,51]}
        self.sky_blue = {'hex':'#1BADDE','rgb':[27,173,222]}
        self.midnight_blue = {'hex':'#051962','rgb':[5,25,98]}
        self.star_gold = {'hex':'#F7D31E','rgb':[247, 211, 30]}
        self.white = {'hex':'#FFFFFF','rgb':[255,255,255]}
        self.forest_green = {'hex':'#38690E','rgb':[56,105,14]}

        ###################################################
        # Welcome Screen Colors
        ###################################################
        self.title_blue = '#000080'
        self.title_white = '#FFFFFF'
        self.divider_color = '#ff9955'
        self.background_color = '#353535'
        self.warning_text = '#FB0101'

class DarkColors(ElementColors):
    
    def __init__(self):
        # super(ElementColors,self).__init__()
        ElementColors.__init__(self)
        self.palette = QPalette()
        self.palette.setColor(QPalette.Window, QColor(self.background_color))
        self.palette.setColor(QPalette.WindowText, Qt.white)
        self.palette.setColor(QPalette.Base, QColor(25, 25, 25))
        self.palette.setColor(QPalette.AlternateBase, QColor(53, 53, 53))
        self.palette.setColor(QPalette.ToolTipBase, Qt.white)
        self.palette.setColor(QPalette.ToolTipText, Qt.white)
        self.palette.setColor(QPalette.Text, Qt.white)
        self.palette.setColor(QPalette.Button, QColor(53, 53, 53))
        self.palette.setColor(QPalette.ButtonText, QColor(255, 153, 85)) #Qt.white
        self.palette.setColor(QPalette.BrightText, Qt.red)
        self.palette.setColor(QPalette.Link, QColor(255, 153, 85))
        self.palette.setColor(QPalette.Highlight, QColor(255, 153, 85))
        self.palette.setColor(QPalette.HighlightedText, Qt.black)

class AR3Controller(QMainWindow):

    def __init__(self,screen):
        # super(QMainWindow,self).__init__()
        QMainWindow.__init__(self)
        
        self.width = 1800
        self.height = 850

        self.screen_height = screen.size().height()
        self.screen_width = screen.size().width()

        # setting title 
        self.setWindowTitle("AR3 Controller")

        welcome_width = 800
        welcome_height = 600
        self.setGeometry(math.floor((self.screen_width-welcome_width)/2), math.floor((self.screen_height-welcome_height)/2), welcome_width, welcome_height) 

        with open('/home/kurt/Robotics/src/ar3/urdf/AR3_noGazebo.urdf', 'r') as fp:
            urdf = fp.read()
        self.solver = IK("world", "flange", urdf_string=urdf)
        self.qinit = [0.0] * self.solver.number_of_joints
        
        uic.loadUi('/home/kurt/Robotics/src/ar3/scripts/ar3_controller.ui', self)

        self.joint_jog_widget = uic.loadUi('/home/kurt/Robotics/src/ar3/scripts/joint_controller.ui')
        self.pose_jog_widget = uic.loadUi('/home/kurt/Robotics/src/ar3/scripts/pose_controller.ui')

        rospy.init_node('Joint_Control', anonymous='True')
        self.ar3_feeback_sub = rospy.Subscriber('/AR3/Feedback',ar3_feedback,self.update_feedback_label)

        self.joint_radiobutton.toggled.connect(self.set_jog_type)
        self.pose_radiobutton.toggled.connect(self.set_jog_type)
        self.jog_layout.addWidget(self.joint_jog_widget)
        self.jog_layout.addWidget(self.pose_jog_widget)
        self.pose_jog_widget.hide()

        self.feedback_angles = []
        self.setpoint_angles = []

        self.robot_controller = RobotController()
        self.robot_controller.AR3Control.home = 0
        self.robot_controller.AR3Control.run = 1
        self.robot_controller.AR3Control.rest = 0

        self.goto_button.clicked.connect(self.goto)
        self.rest_button.clicked.connect(self.rest)
        self.zero_button.clicked.connect(self.zero)
        self.move_gripper_button.clicked.connect(self.move_gripper)
        self.add_to_queue_button.clicked.connect(self.add_to_queue)
        self.start_queue_button.clicked.connect(self.start_queue)
        self.clear_queue_button.clicked.connect(self.clear_queue)

        self.joint_spinboxes = [self.joint_jog_widget.joint_1_setpoint,self.joint_jog_widget.joint_2_setpoint,self.joint_jog_widget.joint_3_setpoint,
                                self.joint_jog_widget.joint_4_setpoint,self.joint_jog_widget.joint_5_setpoint,self.joint_jog_widget.joint_6_setpoint]
        
        self.pose_spinboxes = [self.pose_jog_widget.x_spinbox, self.pose_jog_widget.y_spinbox, self.pose_jog_widget.z_spinbox,
                               self.pose_jog_widget.rx_spinbox,self.pose_jog_widget.ry_spinbox,self.pose_jog_widget.rz_spinbox]

        self.joint_lcds = [self.j1_lcd,self.j2_lcd,self.j3_lcd,self.j4_lcd,self.j5_lcd,self.j6_lcd]

        self.set_jog_type()
        # Show main window
        self.show()

    def set_jog_type(self):
        if self.joint_radiobutton.isChecked():
            self.joint_jog_widget.show()
            self.pose_jog_widget.hide()
        if self.pose_radiobutton.isChecked():
            self.pose_jog_widget.show()
            self.joint_jog_widget.hide()

    def add_to_queue(self):
        if self.joint_radiobutton.isChecked():
            angles = []
            for spinbox in self.joint_spinboxes:
                angles.append(spinbox.value())
            angles.append(self.gripper_angle_spinbox.value())
            angles.append(self.speed_spinbox.value())
            self.queue_list.addItem(str(angles))
        
        elif self.pose_radiobutton.isChecked():
            coord = []
            for spinbox in self.pose_spinboxes:
                coord.append(spinbox.value())

            quat = quaternion_from_euler(coord[3],coord[4],coord[5],'rxyz')
            rx,ry,rz,rw = quat
            x,y,z = coord[0],coord[1],coord[2]
            angles = self.solver.get_ik(self.qinit,x,y,z,rx,ry,rz,rw)
            print("Requested solution for: ",x,y,z,rx,ry,rz,rw)
            if not angles:
                print("Solution not found!")
                return
            else:
                angles = list(angles)
                print("Solution found!")

            angles.append(self.gripper_angle_spinbox.value())
            angles.append(self.speed_spinbox.value())
            self.queue_list.addItem(str(angles))
    
    def clear_queue(self):
        self.queue_list.clear()

    def wait_for_move(self):
        flag = True
        while flag:
            flag = False
            for idx in range(0,6):
                if abs(self.setpoint_angles[idx] - self.feedback_angles[idx]) > 0.005:
                    flag = True

    def run_queue(self):
        for idx in range(self.queue_list.count()):
            angles = self.queue_list.item(idx).text()
            angles = angles.strip('[]')
            angles = angles.replace(" ","")
            angles = angles.split(',')
            for idx,val in enumerate(angles):
                if idx < 6:
                    angles[idx] = float(val)
                elif idx == 6:
                    gripper_val = int(val)
                elif idx == 7:
                    speed = float(val)
            angles = angles[0:6]
            self.setpoint_angles = angles
            print(angles,gripper_val,speed)

            self.robot_controller.AR3Control.speed = speed
            self.robot_controller.AR3Control.gripper_angle = gripper_val
            self.robot_controller.AR3Control.joint_angles = angles
            self.robot_controller.send_joints()

            self.wait_for_move()
        print("Program completed")

    def start_queue(self):
        self.queue_thread = threading.Thread(target=self.run_queue)
        self.queue_thread.start()

    def move_gripper(self):
        self.gripper_angle = self.gripper_angle_spinbox.value()
        self.robot_controller.AR3Control.gripper_angle = self.gripper_angle
        self.robot_controller.send_joints()

    def goto(self):
        if self.joint_radiobutton.isChecked():
            angles = []
            for spinbox in self.joint_spinboxes:
                angles.append(spinbox.value())

            self.gripper_angle = self.gripper_angle_spinbox.value()
            self.speed = self.speed_spinbox.value()

            self.robot_controller.AR3Control.speed = self.speed
            self.robot_controller.AR3Control.gripper_angle = self.gripper_angle
            self.robot_controller.AR3Control.joint_angles = angles
            self.robot_controller.send_joints()
        
        elif self.pose_radiobutton.isChecked():
            coord = []
            for spinbox in self.pose_spinboxes:
                coord.append(spinbox.value())

            quat = quaternion_from_euler(coord[3],coord[4],coord[5],'rxyz')
            rx,ry,rz,rw = quat
            x,y,z = coord[0],coord[1],coord[2]
            angles = self.solver.get_ik(self.qinit,x,y,z,rx,ry,rz,rw)
            print("Requested solution for: ",x,y,z,rx,ry,rz,rw)
            if not angles:
                print("Solution not found!")
                return
            else:
                angles = list(angles)
                print("Solution found!")

            # angles = [0.0]*6
            self.gripper_angle = self.gripper_angle_spinbox.value()
            self.speed = self.speed_spinbox.value()

            self.robot_controller.AR3Control.speed = self.speed
            self.robot_controller.AR3Control.gripper_angle = self.gripper_angle
            self.robot_controller.AR3Control.joint_angles = angles
            self.robot_controller.send_joints()

    def rest(self):
        self.gripper_angle = self.gripper_angle_spinbox.value()
        self.speed = self.speed_spinbox.value()

        self.robot_controller.AR3Control.speed = self.speed
        self.robot_controller.AR3Control.gripper_angle = self.gripper_angle        
        self.robot_controller.AR3Control.joint_angles = [1.57,-.4,1.3,0.0,1.0,0.0]
        self.robot_controller.send_joints()

    def zero(self):
        self.gripper_angle = self.gripper_angle_spinbox.value()
        self.speed = self.speed_spinbox.value()

        self.robot_controller.AR3Control.speed = self.speed
        self.robot_controller.AR3Control.gripper_angle = self.gripper_angle
        self.robot_controller.AR3Control.joint_angles = [0.0,0.0,0.0,0.0,0.0,0.0]
        self.robot_controller.send_joints()
    
    def update_feedback_label(self,data):
        idx = 0
        for lcd in self.joint_lcds:
            lcd.display('%0.3f'%data.joint_angles[idx])
            idx += 1
        self.feedback_angles = data.joint_angles

        self.gripper_lcd.display(data.gripper_angle)
        
        if data.eStop:
            self.state_label.setText("E-STOP PRESSED")
        elif data.running:
            self.state_label.setText("RUNNING")

def main():
    # create pyqt5 app
    QApplication.setStyle("fusion")
    dark_mode = True

    app = QApplication(sys.argv)

    # Now use a palette to switch to dark colors
    if dark_mode:
        palette = DarkColors().palette
        app.setPalette(palette)
    else:
        palette = FusionColor().palette
        app.setPalette(palette)
    
    # create the instance of our Window 
    game_window = AR3Controller(app.primaryScreen()) 

    # start the app 
    sys.exit(app.exec_()) 

if __name__ == '__main__':
    try:
        main()
    finally:
        pass