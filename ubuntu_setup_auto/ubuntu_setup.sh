#!/bin/bash

# super-user permissions required
# welcome note
echo "Working on your request"


# Function to install your packages
pkg_install(){
	echo "******************************************"
	printf "installing $1 \n"
	echo "******************************************"
	sudo apt install --assume-yes $1
	printf "\n"
	echo "******************************************"
	printf "Done with installing $1 \n"
	echo "******************************************"
	printf "\n"
	sleep 3s
}


# Function to Download and Install Applications
app_install(){
	cd ~/Downloads
		
	read filename_extension <<< $(echo $1 | sed 's#.*/##')
	echo "******************************************"
	printf "installing $filename_extension \n"
	echo "******************************************"
	
	# checking for file
	
	if [ ! -z "$filename_extension" ]; then
		echo "$filename_extension Status OK"
		
		# looking for extensions
		
		extension="${filename_extension##*.}"
		echo $extension
		
		# downloading software 
		
		wget $1
		
		# procedure for deb extension installation
		
		if [ "$extension" == "deb" ]; then 
			sudo apt install --assume-yes ./$filename_extension
			printf "\n"
			echo "******************************************"
			printf "Done with installing $filename_extension \n"
			echo "******************************************"
			printf "\n"
		fi
		
		# procedure for tar.gz extension installation and moving to /opt/
		
		if [ "$extension" == "gz" ]; then 
			tar -xvf $filename_extension
			filename=`basename $filename_extension .tar.gz`
			echo $filename
			sleep 2s
			chmod 775 $filename
			sudo mv $filename /opt/pycharm
			printf "\n"
			echo "******************************************"
			printf "Done with installing $filename_extension \n"
			echo "******************************************"
			printf "\n"
		fi
		
		# procedure for .tgz extension installation and moving to /opt/
		
		if [ "$extension" == "tgz" ]; then 
			tar -xvzf $filename_extension
			filename=`basename $filename_extension .tgz`
			echo $filename
			sleep 2s
			chmod 775 $filename
			sudo mv $filename /opt/spark/
			printf "\n"
			echo "******************************************"
			printf "Done with installing $filename_extension \n"
			echo "******************************************"
			printf "\n"
		fi
	
	# else case output
	
	else
		echo "Failure "
	fi
	sleep 3s
}

# Programs to Install

pkg_install 'gedit-plugins'
pkg_install 'gdebi'
pkg_install 'jabref'
pkg_install 'emacs'
pkg_install 'shutter'


# 1. Google Chrome Download and Install

sudo apt-get update
url=https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
app_install $(echo $url) 

# 2. Pycharm Install

sudo apt-get update
url=https://download.jetbrains.com/python/pycharm-community-2016.3.2.tar.gz
app_install $(echo $url)

# 3. RStudio Install

sudo echo "deb http://cran.rstudio.com/bin/linux/ubuntu xenial/" | sudo tee -a /etc/apt/sources.list
gpg --keyserver keyserver.ubuntu.com --recv-key E084DAB9
gpg -a --export E084DAB9 | sudo apt-key add -
sudo apt-get update
pkg_install 'r-base' 
pkg_install 'r-base-dev'
pkg_install 'gdebi-core'
url=https://download1.rstudio.org/rstudio-1.0.136-amd64.deb
app_install $(echo $url)

# 4. Git-Hub

pkg_install 'git'

## configuring up user name and email
#echo 'git config --global user.name "Veera Marni"' 
#sleep 1s
#git config --global user.name "Veera Marni"
#echo 'git config --global user.email "narayana1043@gmail.com"' 
#sleep 1s
#git config --global user.email "narayana1043@gmail.com"


# 5. Python PIP and VirtualEnv Setup
echo "*********************************"
echo "***Setting up python virtualenv**"
sleep 2s
pkg_install 'python-pip'
sudo pip install --upgrade pip
sudo pip install virtualenv
sudo pip install virtualenvwrapper
echo '' >> ~/.bashrc
echo '# Added by Veera' >> ~/.bashrc
mkvirtualenv env_i524
echo 'export WORKON_HOME=$HOME/.virtualenvs' >> ~/.bashrc
echo 'source /usr/local/bin/virtualenvwrapper.sh' >> ~/.bashrc
source ~/.bashrc
source ~/.virtualenvs/env_i524/bin/activate
cd ~/code/classes
pip install --upgrade pip
source ~/.virtualenvs/env_i524/bin/deactivate
sudo chmod -R 775 ~/.virtualenvs
echo "***Setting up python virtualenv Done**"
sleep 2s

## 6. Big Data Class setup

#echo "Cloning Big Data class repo"
#sleep 1s
#cd ~ && mkdir code
#cd code
#git clone https://github.com/narayana1043/classes
#sudo chmod a+rwx $HOME
#cd ~/code/classes
#sleep 2s
#echo "**********Adding upstream for github*************" 
#git remote add upstream https://github.com/cloudmesh/classes
#echo "Done"
#git remote -v
#echo "**********Fetching upstream *************" 
#git fetch upstream
#echo "**********Rebase with upstream *************" 
#git rebase upstream/master
#git push origin master
#cd ~/
#echo "cloned and rebased with upstream"
#sleep 2s

# 7. Ipython and Ipython Notebook setup

echo "Ipython notebook installation in virtualenv env_i524"
sleep 2s
source ~/.virtualenvs/env_i524/bin/activate
pip install ipython
pip install jupyter
source ~/.virtualenvs/env_i524/bin/deactivate
echo "Ipython setup completed"
sleep 1s

# 8. Installing JAVA

echo "Installing JAVA on Ubnutu:: package details:'openjdk-8-jre-headless'"
sleep 3s
pkg_install 'openjdk-8-jre-headless'
echo "Completed Installing JAVA"
sleep 1s

# 9. Spark setup

echo "Installing Spark and setting requirements"
sleep 2s
url=http://d3kbcqa49mib13.cloudfront.net/spark-2.1.0-bin-hadoop2.7.tgz
app_install $(echo $url)
echo "" >> ~/.bashrc
echo "# Adding Spark Path" >> ~/.bashrc
echo "export SPARK_HOME=/opt/spark/" >> ~/.bashrc
echo "export PYTHONPATH=$SPARK_HOME/python/lib/py4j-0.10.4-src.zip:$PYTHONPATH" >> ~/.bashrc
source ~/.virtualenvs/env_i524/bin/activate
ipython profile create pyspark
deactivate
cd ~/Downloads
sudo chmod -R a+rwx ~/
wget https://raw.githubusercontent.com/narayana1043/ubuntu_autosetup/master/00-pyspark-setup.py
sudo mv -f ~/Downloads/00-pyspark-setup.py ~/.ipython/profile_pyspark/startup/
sudo chmod -R a+rwx ~/
cd ~
echo "Spark Installation and setup completed"
sleep 2s

# 10. Latex "texlive-latex-base" and "texstudio"

echo "************************************"
echo "Installing texlive-latex-base only"
echo "************************************"
echo "This is not same as texlive-full and has libraries that mostly frequently used or required. However the libraries can be installed at a later point based on needs."
echo "sudo apt install texlive-latex-base"
sleep 4s
pkg_install 'texlive-latex-base'
echo "************************************"
echo "Tex live installation done"
echo "************************************"
sleep 2s
echo ""
echo "************************************"
echo "Installing texstudio"
echo "************************************"
sleep 1s
echo "sudo apt-get install texstudio"
pkg_install 'texstudio'
echo "************************************"
echo "Tex Studio installation done"
echo "************************************"
sleep 2s
echo ""

## 11. Cloning other github repos

#cd ~/code
#echo ''
#echo "************************************"
#echo "cloning the following repos into ~/code"
#echo "************************************"
#echo "1. ubuntu_autosetup"
#echo "2. Bigdata"
#sleep 2s
#git clone https://github.com/narayana1043/ubuntu_autosetup
#chmod 775 -R ubuntu_autosetup
#git clone https://github.com/narayana1043/Bigdata
#echo "************************************"
#echo 'Finished cloning'
#echo "************************************"
#sleep 2s

# 12. Installing Google drive for Ubuntu

echo "************************************"
echo 'Installing Google drive for Ubuntu'
echo "************************************"
sudo apt-add-repository ppa:nilarimogard/webupd8 -y
sudo apt-get update
pkg_install 'grive'

echo "************************************"
echo 'Google Drive Installed'
echo "************************************"

# Final Steps

printf "\n"
echo "******************************************"
printf "Final Setup Steps:\n" && sleep 1s
echo "Applications will auto start" && sleep 1s
echo "Add the desktop entries and close the Application and Choose Y" && sleep 1s
echo "******************************************"
printf "\n"

# 1. Pycharm

echo "Pycharm Information: go to tools--> Add desktop Entry" 
sleep 3s
sudo /opt/pycharm/bin/pycharm.sh
read -p "Press any key to continue... " -n1 -s
echo '**********************************************************'
echo ''

# 2. R Studio

echo "R Studio Information: Auto added as Desktop Entry"
echo '**********************************************************'
echo ''

# 3. VirtualEnv

 echo "Try virtualenv"
 echo "Type the commands in new terminal"
echo "1. cd ~"
echo "2. workon env_i524"
read -p "Press any key to continue... " -n1 -s
echo '**********************************************************'
echo ''

# 4. IPython and spark integration

echo "Check for IPython and spark integration"
echo "1. cd ~"
echo "2. ipython --profile=pyspark"
read -p "Press any key to continue... " -n1 -s
echo '**********************************************************'
echo ''

# 5. Check your alsamixer settings

echo "General Audio check"
echo "Set all HP/Speak -- MM --> 00"
read -p "Press any key to continue... " -n1 -s
echo '**********************************************************'
echo ''

## 6. SSH setup for github

#echo "Generating SSH Keys for github"
#echo "Provide all the information requested"
#ssh-keygen -t rsa -b 4096 -C "narayana1043@gmail.com"
#cat /home/veera/.ssh/id_rsa.pub


# Deleting unwanteds

echo "****************************************"
echo "Deleting all unwanted packages and files"
echo "Making More Space"
echo "****************************************"
echo ""
echo "Clearing Downloads Folder"
rm -rf ~/Downloads
sleep 2s
echo "Removing Packages"
sleep 1s
echo "Running apt-get autoremove"
sudo apt-get autoremove
sleep 2s
echo "Running apt-get autoclean"
sudo apt-get autoclean
sleep 2s
echo "Running apt-get update"
sudo apt-get update
sleep 2s
echo "Running apt-get upgrade"
sudo apt-get upgrade
sleep 2s

# Long Job to be done at the end

echo "****************************************"
echo "****************************************"
echo "****************************************"
echo "****************************************"
echo "IMPORTANT NOTE"
echo "Syncing google drive"
echo "This might take a long time"
echo "****************************************"
echo "****************************************"
echo "****************************************"
echo 5s
cd ~
mkdir gdrive
cd ~/gdrive
grive -a
sudo chmod 775 ~/grive
echo "****************************************"
echo "****************************************"
echo "****************************************"
echo "****************************************"
echo ""
echo "Syncing google drive completed"
echo "permissions are also adjusted"
echo ""
echo "****************************************"
echo "****************************************"
echo "****************************************"
echo 5s


