#!/bin/bash
#
# Copyright (c) 2021, NVIDIA CORPORATION.  All rights reserved.
#
# NVIDIA CORPORATION and its licensors retain all intellectual property
# and proprietary rights in and to this software, related documentation
# and any modifications thereto.  Any use, reproduction, disclosure or
# distribution of this software and related documentation without an express
# license agreement from NVIDIA CORPORATION is strictly prohibited.

# Build ROS dependency
echo "source ~/ros2_humble/install/setup.bash" >> ~/.bashrc
source ~/ros2_humble/install/setup.bash

#echo "source /workspaces/isaac_ros-dev/install/setup.bash" >> ~/.bashrc
#source /workspaces/isaac_ros-dev/install/setup.bash

sudo apt-get update
#rosdep update

# Restart udev daemon
sudo service udev restart

$@
