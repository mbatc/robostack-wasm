#!/bin/bash

DISTRIBUTION=humble

# Download sources
wget https://raw.githubusercontent.com/ros2/ros2/$DISTRIBUTION/ros2.repos
mkdir src
vcs import src < ros2.repos

# Ignore some packages
touch \
    src/ros2/ros1_bridge/COLCON_IGNORE \
    src/ros2/rviz/COLCON_IGNORE \
    src/ros2/demos/COLCON_IGNORE \
    src/ros/resource_retriever/COLCON_IGNORE \
    src/ros/robot_state_publisher/COLCON_IGNORE \
    src/ros-visualization/COLCON_IGNORE
