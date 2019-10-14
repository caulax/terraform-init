#! /bin/bash
sudo apt-get update
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) \
    stable"

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-get update -y && apt-get install docker-ce docker-ce-cli containerd.io python -y
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
sudo python get-pip.py
sudo pip install awscli

export AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY}
export AWS_SECRET_ACCESS_KEY=${AWS_SECRET_KEY}
export AWS_DEFAULT_REGION=${AWS_REGION}

sudo `./aws ecr get-login | sed 's/-e none//g' -`

sudo docker pull 070858963885.dkr.ecr.eu-central-1.amazonaws.com/golang
sudo docker run -d --name golang -p 80:8000 070858963885.dkr.ecr.eu-central-1.amazonaws.com/golang
