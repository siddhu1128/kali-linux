#!/bin/bash
if [ $USER != 'root'];then
	echo "Switch to root and try again"
	exit 1
fi
# Setting Up Kali Linux
systemctl start postgresql
systemctl enable postgresql
systemctl start metasploit
systemctl stop metasploit

# Enable metasploit logging
echo "spool /root/msf_console.log" > /root/.msf4/msfconsole.rc
## Logs will be stored at /root/msf_consolr.log

# Tools installation
mkdir -p /root/Tools

# The Backdoor Factory
git clone https://github.com/secretsquirrel/the-backdoor-factory /opt/the-backdoor-factory
cd /opt/the-backdoor-factory
./install.sh

# HTTPScreenShot
## HTTPScreenShot is a tool for grabbing screenshots and HTML of large number of websites
pip install selenium
git clone https://github.com/breenmachine/httpscreenshot.git /opt/httpscreenshot
cd /opt/httpscreenshot
chmod +x install-dependencies.sh && ./install-dependencies.sh

# Installing Docker and configuring metasploitable
mkdir -p /root/Tools/docker
cd /root/Tools/docker
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
echo 'deb [arch=amd64] https://download.docker.com/linux/debian buster stable' | sudo tee /etc/apt/sources.list.d/docker.list
sudo apt update
sudo apt install docker-ce -y
sudo systemctl start docker
sudo systemctl enable docker
docker pull tleemcjr/metasploitable2
docker run --name metasploitable -it tleemcjr/metasploitable2:latesh sh -c "/bin/services.sh && bash"
