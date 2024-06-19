#!/bin/bash

# Instalar PostgreSQL en CentOS/RHEL
sudo dnf install -y https://download.postgresql.org/pub/repos/yum/reporpms/EL-9-x86_64/pgdg-redhat-repo-latest.noarch.rpm
sudo dnf -qy module disable postgresql
sudo dnf install -y postgresql16-server
sudo /usr/pgsql-16/bin/postgresql-16-setup initdb
sudo systemctl enable postgresql-16
sudo systemctl start postgresql-16



# Ajustar la configuración de PostgreSQL para permitir conexiones remotas

# Ruta al archivo de configuración de PostgreSQL
archivo_configuracion="/var/lib/pgsql/16/data/postgresql.conf"

# Habilitar escucha en todas las direcciones IP
sudo sed -i "s/#listen_addresses = 'localhost'/listen_addresses = '*'/g" $archivo_configuracion

# Permitir acceso desde cualquier dirección IP en pg_hba.conf
sudo su -c "echo 'host    all             all             0.0.0.0/0               md5' >> /var/lib/pgsql/16/data/pg_hba.conf"

# Reiniciar PostgreSQL para aplicar los cambios de configuración
sudo systemctl restart postgresql-16

# Configurar el firewall para permitir el acceso al puerto de PostgreSQL (5432)
sudo yum install -y firewalld
sudo systemctl start firewalld
sudo systemctl enable firewalld
sudo firewall-cmd --add-port=5432/tcp --permanent
sudo firewall-cmd --reload

# Crear la base de datos y el usuario (ejemplo)
# Cambia 'postgres' por el usuario adecuado si es necesario
sudo -u postgres psql -c "CREATE DATABASE linktic;"
sudo -u postgres psql -c "CREATE USER admin WITH PASSWORD 'admin';"
sudo -u postgres psql -c "GRANT ALL PRIVILEGES ON DATABASE linktic TO admin;"

sudo -u postgres psql -c "CREATE USER wilmertorres WITH PASSWORD 'Shacall1989*';"
sudo -u postgres psql -c "GRANT ALL PRIVILEGES ON DATABASE linktic TO wilmertorres;"




