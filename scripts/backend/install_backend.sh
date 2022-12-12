#!/bin/bash
set -x

#################################################
##### Instalación de backend en la pila lamp ####
#################################################

#Actualizamos los repositorios
apt update

# Instalamos Mysql Server

install mysql-server -y

# Cambiamos las variables de mysql para que me accepte conexiones desde cualquier interfaz
sed -i 's/127.0.0.1/0.0.0.0/' /etc/mysql/mysql.conf.d/mysqld.cnf

# Reiniciamos el servicio de mysql

systemctl restart mysql