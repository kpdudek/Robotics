#!/usr/bin/env python

from PyQt5.QtWidgets import * 
from PyQt5 import QtCore, QtGui, QtSvg, uic
from PyQt5.QtGui import * 
from PyQt5.QtCore import * 

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