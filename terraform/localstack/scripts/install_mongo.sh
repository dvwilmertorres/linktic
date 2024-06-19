#!/bin/bash

# Crear el archivo del repositorio para MongoDB
cat <<EOF | sudo tee /etc/yum.repos.d/mongodb-org-7.0.repo
[mongodb-org-7.0]
name=MongoDB Repository
baseurl=https://repo.mongodb.org/yum/redhat/9/mongodb-org/7.0/x86_64/
gpgcheck=1
enabled=1
gpgkey=https://pgp.mongodb.com/server-7.0.asc
EOF

# Limpiar el caché de yum y actualizar el caché del repositorio
sudo yum clean all
sudo yum makecache

# Instalar MongoDB
sudo yum install -y mongodb-org


# Iniciar y habilitar el servicio de MongoDB
sudo systemctl start mongod
sudo systemctl enable mongod

# Ruta al archivo de configuración de MongoDB
archivo_configuracion="/etc/mongod.conf"

# Comando para modificar la línea en el archivo de configuración
sed -i 's/^ *bindIp: 127.0.0.1/  bindIp: 0.0.0.0/' $archivo_configuracion

sudo systemctl restart mongod

sudo yum install -y firewalld
sudo systemctl start firewalld
sudo systemctl enable firewalld
sudo firewall-cmd --add-port=27017/tcp --permanent
sudo firewall-cmd --reload


#Configuramos el usuario de conexion de la base de datos unirdb
# Crear base de datos unirdb
mongosh --eval 'use unirdb'
mongosh unirdb --eval 'db.createCollection("dataunir")'
mongosh unirdb --eval 'db.dataunir.insertOne({ name: "test" })'
# Crear usuario en unirdb
mongosh unirdb --eval 'db.createUser({user: "admin", pwd: "admin", roles: [{role: "readWrite", db: "unirdb"}]})'

