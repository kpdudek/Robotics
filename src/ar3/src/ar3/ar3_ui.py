#!/usr/bin/env python

from PyQt5.QtWidgets import * 
from PyQt5 import QtCore, QtGui, QtSvg, uic
from PyQt5.QtGui import * 
from PyQt5.QtCore import * 
import random, sys, os, math, time, numpy
import threading

from ar3.msg import ar3_feedback, ar3_control
import rospy, rospkg
import tf

from trac_ik_python.trac_ik import IK
from tf.transformations import euler_from_quaternion, quaternion_from_euler

from RobotControllerClass import RobotController
from utils.PaintUtils import DarkColors

class AR3Controller(QMainWindow):

    def __init__(self,screen):
        QMainWindow.__init__(self)
        rospy.init_node('ar3_ui', anonymous='True')

        self.rospack = rospkg.RosPack()
        self.ar3_path = self.rospack.get_path('ar3')

        uic.loadUi(self.ar3_path+'/src/ar3/ui/ar3_controller.ui', self)
        self.joint_jog_widget = uic.loadUi(self.ar3_path+'/src/ar3/ui/joint_controller.ui')
        self.pose_jog_widget = uic.loadUi(self.ar3_path+'/src/ar3/ui/pose_controller.ui')
        self.width = 1800
        self.height = 850
        self.screen_height = screen.size().height()
        self.screen_width = screen.size().width()
        self.setWindowTitle("AR3 Controller")
        welcome_width = 800
        welcome_height = 600
        self.setGeometry(math.floor((self.screen_width-welcome_width)/2), math.floor((self.screen_height-welcome_height)/2), welcome_width, welcome_height) 

        with open(self.ar3_path+'/urdf/AR3_noGazebo.urdf', 'r') as fp:
            urdf = fp.read()
        self.solver = IK("world", "flange", urdf_string=urdf)
        self.qinit = [0.0] * self.solver.number_of_joints
        
        
        self.ar3_feeback_sub = rospy.Subscriber('/AR3/Feedback',ar3_feedback,self.update_feedback_label)
        self.listener = tf.TransformListener()
        self.robot_controller = RobotController()
        self.robot_controller.AR3Control.home = 0
        self.robot_controller.AR3Control.run = 1
        self.robot_controller.AR3Control.rest = 0
        self.feedback_angles = []
        self.setpoint_angles = []

        self.joint_radiobutton.toggled.connect(self.set_jog_type)
        self.pose_radiobutton.toggled.connect(self.set_jog_type)
        self.jog_layout.addWidget(self.joint_jog_widget)
        self.jog_layout.addWidget(self.pose_jog_widget)
        self.pose_jog_widget.hide()

        self.goto_button.clicked.connect(self.goto)
        self.rest_button.clicked.connect(self.rest)
        self.zero_button.clicked.connect(self.zero)
        self.move_gripper_button.clicked.connect(self.move_gripper)
        self.add_to_queue_button.clicked.connect(self.add_to_queue)
        self.start_queue_button.clicked.connect(self.start_queue)
        self.clear_queue_button.clicked.connect(self.clear_queue)
        self.pull_current_config_button.clicked.connect(self.pull_current_config)

        self.joint_spinboxes = [self.joint_jog_widget.joint_1_setpoint,self.joint_jog_widget.joint_2_setpoint,self.joint_jog_widget.joint_3_setpoint,
                                self.joint_jog_widget.joint_4_setpoint,self.joint_jog_widget.joint_5_setpoint,self.joint_jog_widget.joint_6_setpoint]
        
        self.pose_spinboxes = [self.pose_jog_widget.x_spinbox, self.pose_jog_widget.y_spinbox, self.pose_jog_widget.z_spinbox,
                               self.pose_jog_widget.rx_spinbox,self.pose_jog_widget.ry_spinbox,self.pose_jog_widget.rz_spinbox]

        self.joint_lcds = [self.j1_lcd,self.j2_lcd,self.j3_lcd,self.j4_lcd,self.j5_lcd,self.j6_lcd]
        self.tcp_lcds = [self.x_lcd,self.y_lcd,self.z_lcd,self.rx_lcd,self.ry_lcd,self.rz_lcd]

        self.set_jog_type()

        # Show main window
        self.show()

    def pull_current_config(self):
        idx = 0
        for spinbox in self.joint_spinboxes:
            spinbox.setValue(self.feedback_angles[idx])
            idx += 1
        print(self.feedback_angles)

        (trans,rot) = self.listener.lookupTransform('/world', '/flange', rospy.Time(0))
        rot = euler_from_quaternion(rot,'rxyz')
        tcp_pose = list(trans)+list(rot)
        idx = 0
        for spinbox in self.pose_spinboxes:
            spinbox.setValue(tcp_pose[idx])
            idx += 1

        self.gripper_angle_spinbox.setValue(int(self.robot_controller.AR3Feedback.gripper_angle))

    def set_jog_type(self):
        if self.joint_radiobutton.isChecked():
            self.joint_jog_widget.show()
            self.pose_jog_widget.hide()
        if self.pose_radiobutton.isChecked():
            self.pose_jog_widget.show()
            self.joint_jog_widget.hide()

    def add_to_queue(self):
        angles = list(self.feedback_angles)
        angles.append(self.robot_controller.AR3Feedback.gripper_angle)
        angles.append(self.speed_spinbox.value())
        self.queue_list.addItem(str(angles))
        print("Queueing: ",angles)
    
    def clear_queue(self):
        self.queue_list.clear()

    def wait_for_move(self):
        flag = True
        while flag:
            flag = False
            for idx in range(0,6):
                if abs(self.setpoint_angles[idx] - self.feedback_angles[idx]) > 0.01:
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
        try:
            idx = 0
            for lcd in self.joint_lcds:
                lcd.display('%0.3f'%data.joint_angles[idx])
                idx += 1
            self.feedback_angles = data.joint_angles

            (trans,rot) = self.listener.lookupTransform('/world', '/flange', rospy.Time(0))
            rot = euler_from_quaternion(rot,'rxyz')
            tcp_pose = list(trans)+list(rot)
            idx = 0
            for lcd in self.tcp_lcds:
                lcd.display('%0.3f'%tcp_pose[idx])
                idx += 1

            self.gripper_lcd.display(data.gripper_angle)
            
            if data.eStop:
                self.state_label.setText("E-STOP PRESSED")
            elif data.running:
                self.state_label.setText("RUNNING")
        except:
            print('Failed to update the current config panel.')

def main():
    # create pyqt5 app
    QApplication.setStyle("fusion")
    dark_mode = True

    app = QApplication(sys.argv)

    palette = DarkColors().palette
    app.setPalette(palette)
    
    # create the instance of our Window 
    main_window = AR3Controller(app.primaryScreen()) 

    # start the app 
    sys.exit(app.exec_()) 

if __name__ == '__main__':
    try:
        main()
    finally:
        pass