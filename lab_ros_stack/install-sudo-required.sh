#!/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "This script must be run with sudo"
  exit
fi

# --- ROS Relate Stuff

#source the list
sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-key 421C365BD9FF1F717815A3895523BAEEB01FA116

apt-get update  # To get the latest package lists


#check the ubuntu version and source the correct version of ros
#we still think it will work with indigo
UBUNTU_VERSION=$(lsb_release -rs)
if [ $UBUNTU_VERSION == "16.04" ]
then
ROS_VERSION='kinetic'
fi
if [ $UBUNTU_VERSION == "14.04" ]
then
ROS_VERSION='indigo'
fi

#install ros
apt-get install ros-$ROS_VERSION-desktop-full -y
apt-get install python-rosinstall -y
apt-get install git-core python-argparse python-wstool python-vcstools python-rosdep ros-$ROS_VERSION-control-msgs ros-$ROS_VERSION-joystick-drivers -y

#catkin build tools to make life easier
apt-get install python-catkin-tools -y
#TTS modules
apt-get install espeak festival-dev libttspico-dev -y
#Audio libraries, ALSA
apt-get install libasound2-dev -y