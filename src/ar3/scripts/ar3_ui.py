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

        # Show main window
        self.show()

    def goto(self):
        angles = []
        for widget in self.joint_values.children():
            if isinstance(widget, QDoubleSpinBox):
                # print(widget.value())
                angles.append(widget.value())
        print(angles)
        self.robot_controller.AR3Control.joint_angles = angles
        self.robot_controller.send_joints()

    def rest(self):
        self.robot_controller.AR3Control.joint_angles = [0.0,1.355,1.8,0.0,5.1,0.0]
        self.robot_controller.send_joints()

    def zero(self):
        self.robot_controller.AR3Control.joint_angles = [0.0,0.0,0.0,0.0,0.0,0.0]
        self.robot_controller.send_joints()
    
    def update_feedback_label(self,data):
        label_str = ''
        label_str += f'E-Stopped: {data.eStop}\n'
        label_str += f'Homed: {data.homed}\n'
        label_str += f'Resting: {data.resting}\n'
        label_str += f'Running: {data.running}\n'
        label_str += f'Gripper State: {data.gripper_closed}\n'
        label_str += f'Encoder Pulses: {data.encoder_pulses}\n'
        label_str += 'Joint Angles: %.2f %.2f %.2f %.2f %.2f %.2f\n'%(data.joint_angles[0],data.joint_angles[1],data.joint_angles[2],data.joint_angles[3],data.joint_angles[4],data.joint_angles[5])
        label_str += 'Setpoint Angles: %.2f %.2f %.2f %.2f %.2f %.2f\n'%(data.setpoint_angles[0],data.setpoint_angles[1],data.setpoint_angles[2],data.setpoint_angles[3],data.setpoint_angles[4],data.setpoint_angles[5])

        self.feedback_label.setText(label_str)


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