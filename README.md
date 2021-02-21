# Robotics
This repository contains software for controlling an AR3 robot by Chris Annin

[Annin Robotics](https://anninrobotics.com/)

## Installation
ROS Melodic is the only supported version.

Install the arduino IDE from here: https://www.arduino.cc/en/Main/Software

To use the Teensy with the Arduino IDE, install teensyduino following these instructions: https://www.pjrc.com/teensy/teensyduino.html

The communication from the GUI to the microcontroller is handled using ROS. Download the full ROS desktop install following these instructions: http://wiki.ros.org/melodic/Installation/Ubuntu

Then install rosserial for arduino:
```
sudo apt-get install python-catkin-tools
sudo apt-get install ros-melodic-rosserial-arduino
sudo apt-get install ros-melodic-rosserial
```

Install the remaining dependencies:
```
sudo apt-get install ros-melodic-trac-ik-python
sudo apt install python3 python3-pip
pip3 install PyQt5
pip3 install numpy
```

## Rviz simulation
```
roslaunch ar3 ar3_rviz.launch
```

## Connecting to the AR3 Microcontroller
```
roslaunch ar3 ar3.lauch
```

## AR3 HMI
```
rosrun ar3 ar3_ui.py
```
