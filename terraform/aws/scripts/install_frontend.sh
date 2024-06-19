#!/bin/bash
sudo yum install -y epel-release
sudo yum install -y nginx
sudo systemctl start nginx
sudo systemctl enable nginx
sudo yum install -y nodejs 
sudo npm install -g npm@9.2.0 
sudo npm install -g @angular/cli
#!/bin/bash

sudo yum install -y firewalld 
sudo systemctl start firewalld 
sudo systemctl enable firewalld 
sudo firewall-cmd --add-port=80/tcp --permanent 
sudo firewall-cmd --reload 

