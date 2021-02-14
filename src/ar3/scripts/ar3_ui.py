#!/usr/bin/env python3

from PyQt5.QtWidgets import * 
from PyQt5 import QtCore, QtGui, QtSvg, uic
from PyQt5.QtGui import * 
from PyQt5.QtCore import * 
import random, sys, os, math, time, numpy
import pathlib

from teensy.msg import ar3_control
from ar3.msg import ar3_feedback
import rospy

import pwd
name = pwd.getpwuid( os.getuid() ).pw_name
file_path = '/home/%s/Robotics/src/ar3/scripts'%name
sys.path.insert(1,file_path)
from RobotControllerClass import RobotController

class ElementColors():
    ###################################################
    # Game Colors
    ###################################################
    brown = {'hex':'#996633','rgb':[153,102,51]}
    sky_blue = {'hex':'#1BADDE','rgb':[27,173,222]}
    midnight_blue = {'hex':'#051962','rgb':[5,25,98]}
    star_gold = {'hex':'#F7D31E','rgb':[247, 211, 30]}
    white = {'hex':'#FFFFFF','rgb':[255,255,255]}
    forest_green = {'hex':'#38690E','rgb':[56,105,14]}

    ###################################################
    # Welcome Screen Colors
    ###################################################
    title_blue = '#000080'
    title_white = '#FFFFFF'
    divider_color = '#ff9955'
    background_color = '#353535'
    warning_text = '#FB0101'

class DarkColors(ElementColors):
    
    def __init__(self):
        super().__init__()
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
        super().__init__()
        
        self.width = 1800
        self.height = 850

        self.screen_height = screen.size().height()
        self.screen_width = screen.size().width()

        # setting title 
        self.setWindowTitle("AR3 Controller")

        welcome_width = 800
        welcome_height = 600
        self.setGeometry(math.floor((self.screen_width-welcome_width)/2), math.floor((self.screen_height-welcome_height)/2), welcome_width, welcome_height) 

        uic.loadUi(f'/home/kurt/Robotics/src/ar3/scripts/ar3_controller.ui', self)

        rospy.init_node('Joint_Control', anonymous='True')
        self.ar3_feeback_sub = rospy.Subscriber('/AR3/Feedback',ar3_feedback,self.update_feedback_label)

        self.robot_controller = RobotController()
        self.robot_controller.AR3Control.home = 0
        self.robot_controller.AR3Control.run = 1
        self.robot_controller.AR3Control.rest = 0

        self.goto_button.clicked.connect(self.goto)
        self.rest_button.clicked.connect(self.rest)
        self.zero_button.clicked.connect(self.zero)
        self.move_gripper_button.clicked.connect(self.move_gripper)

        self.joint_spinboxes = [self.joint_1_setpoint,self.joint_2_setpoint,self.joint_3_setpoint,
                                self.joint_4_setpoint,self.joint_5_setpoint,self.joint_6_setpoint]
        self.joint_lcds = [self.j1_lcd,self.j2_lcd,self.j3_lcd,self.j4_lcd,self.j5_lcd,self.j6_lcd]

        # Show main window
        self.show()

    def move_gripper(self):
        self.gripper_angle = self.gripper_angle_spinbox.value()
        self.robot_controller.AR3Control.gripper_angle = self.gripper_angle
        self.robot_controller.send_joints()

    def goto(self):
        angles = [self.joint_1_setpoint.value(),self.joint_2_setpoint.value(),
                    self.joint_3_setpoint.value(),self.joint_4_setpoint.value(),
                    self.joint_5_setpoint.value(),self.joint_6_setpoint.value()]

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
        # for spinbox in self.joint_spinboxes:
        #     spinbox.setValue(0.0)
        self.gripper_angle = self.gripper_angle_spinbox.value()
        self.speed = self.speed_spinbox.value()

        self.robot_controller.AR3Control.speed = self.speed
        self.robot_controller.AR3Control.gripper_angle = self.gripper_angle
        self.robot_controller.AR3Control.joint_angles = [0.0,0.0,0.0,0.0,0.0,0.0]
        self.robot_controller.send_joints()
    
    def update_feedback_label(self,data):
        idx = 0
        for lcd in self.joint_lcds:
            lcd.display(data.joint_angles[idx])
            idx += 1

        self.gripper_lcd.display(data.gripper_angle)
        
        if data.eStop:
            self.state_label.setText(f"E-STOP PRESSED")
        elif data.running:
            self.state_label.setText(f"RUNNING")

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
    sys.exit(app.exec()) 

if __name__ == '__main__':
    try:
        main()
    finally:
        pass