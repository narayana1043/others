#!/bin/bash

# current user level access required

# configuring up user name and email
echo 'git config --global user.name "Veera Marni"' 
sleep 1s
git config --global user.name "Veera Marni"
echo 'git config --global user.email "narayana1043@gmail.com"' 
sleep 1s
git config --global user.email "narayana1043@gmail.com"

# 6. Big Data Class setup

echo "Cloning Big Data class repo"
sleep 1s
cd ~ && mkdir code
cd code
git clone https://github.com/narayana1043/classes
cd ~/code/classes
sleep 2s
echo "**********Adding upstream for github*************" 
git remote add upstream https://github.com/cloudmesh/classes
echo "Done"
git remote -v
echo "**********Fetching upstream *************" 
git fetch upstream
echo "**********Rebase with upstream *************" 
git rebase upstream/master
git push origin master
cd ~/
echo "cloned and rebased with upstream"
sleep 2s
# installing python requirements
cd ~/code/classes
# virtaul env activate
workon env_i524
pip install -r requirements.txt
deactivate

# 11. Cloning other github repos

cd ~/code
echo ''
echo "************************************"
echo "cloning the following repos into ~/code"
echo "************************************"
echo "1. ubuntu_autosetup"
echo "2. Bigdata"
sleep 2s
git clone https://github.com/narayana1043/ubuntu_autosetup
chmod 775 -R ubuntu_autosetup
git clone https://github.com/narayana1043/Bigdata
echo "************************************"
echo 'Finished cloning'
echo "************************************"
sleep 2s

## 6. SSH setup for github
#TODO: verify if this works

#echo "Generating SSH Keys for github"
#echo "Provide all the information requested"
#ssh-keygen -t rsa -b 4096 -C "narayana1043@gmail.com"
#cat /home/veera/.ssh/id_rsa.pub
