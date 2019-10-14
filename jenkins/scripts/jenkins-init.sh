#!/bin/bash

sudo apt-get update
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) \
    stable"

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-get update -y && apt-get install docker-ce docker-ce-cli containerd.io -y

# jenkins repository
wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -
sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
sudo apt-get update

# install dependencies
sudo apt-get install -y python openjdk-8-jre
sudo update-java-alternatives --set java-1.8.0-openjdk-amd64
# install jenkins
sudo apt-get install -y jenkins=${JENKINS_VERSION} unzip

# install pip
wget -q https://bootstrap.pypa.io/get-pip.py
sudo python get-pip.py
rm -f get-pip.py
# install awscli
sudo pip install awscli

# install terraform
wget -q https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip \
&& sudo unzip -o terraform_${TERRAFORM_VERSION}_linux_amd64.zip -d /usr/local/bin \
&& rm terraform_${TERRAFORM_VERSION}_linux_amd64.zip

# clean up
sudo apt-get clean

