#!/bin/bash

# Convert to collada
rosrun collada_urdf urdf_to_collada arm_5dof.urdf arm_5dof.dae

# Round to five decimals
rosrun moveit_ikfast round_collada_numbers.py arm_5dof.dae arm_5dof_rounded.dae 5

# Output info
openrave-robot.py arm_5dof_rounded.dae --info links

# Try generating translationdirection5d IK, does not work
python `openrave-config --python-dir`/openravepy/_openravepy_/ikfast.py --robot=arm_5dof_rounded.dae --iktype=translationdirection5d  --baselink=0 --eelink=5 --savefile=arm_5dof.cpp

# This works for some reason?
openrave.py --database inversekinematics --robot=arm_5dof.xml --usecached --perftiming=1000 --iktype=translationdirection5d


#python `openrave-config --python-dir`/openravepy/_openravepy_/ikfast.py --robot=arm_5dof_rounded.dae --iktype=transform6d  --baselink=0 --eelink=10 --savefile=arm_5dof.cpp
#openrave.py --database inversekinematics --robot=arm_5dof.xml --usecached --perftiming=1000
# openrave.py --database inversekinematics --robot=arm_5dof.xml --usecached --numiktests=1000 #--show

