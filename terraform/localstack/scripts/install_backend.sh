#!/bin/bash

# Nombre del archivo de registro
logfile="execution_log.txt"


# Instala el repositorio EPEL (Extra Packages for Enterprise Linux)
yum install -y epel-release 
# Instala el repositorio de Node.js
curl -sL https://rpm.nodesource.com/setup_18.x | sudo bash - 

# git
echo "________________________________________________________________________________________________" >> $logfile 2>&1
sudo yum install git -y 
cd /home/ec2-user/ && git clone https://github.com/dvwilmertorres/nodejs_appi.git 

# Instala Node.js y npm
sudo yum install -y nodejs 
sudo npm install -g npm@9.2.0 

# Muestra la versión de Node.js
node --version 

# Muestra la versión de npm
npm --version 

echo "Valor de mongodb_public_dns: ${mongodb_public_dns}" >> $logfile 2>&1
echo "El valor de conexion es: mongodb://admin:admin@${mongodb_public_dns}:27017/?tls=false&authSource=unirdb" >> $logfile 2>&1


# Establece la variable de entorno con el valor de mongodb_public_dns
sudo bash -c 'export MONGODB_URL2="mongodb://admin:admin@${mongodb_public_dns}:27017/?tls=false&authSource=unirdb"'

export MONGODB_URL="mongodb://admin:admin@${mongodb_public_dns}:27017/?tls=false&authSource=unirdb" >> $logfile 2>&1
 

sudo yum install -y firewalld 
sudo systemctl start firewalld 
sudo systemctl enable firewalld 
sudo firewall-cmd --add-port=3000/tcp --permanent 
sudo firewall-cmd --reload 

cd /home/ec2-user/nodejs_appi/application/backend/controllers/ && node testController.js >> $logfile 2>&1