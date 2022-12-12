#!/bin/bash
set -x

# Configuracion de las variables

source variables.sh

# Creación de la Base de Datos y del Usuario

mysql -u root <<< "DROP DATABASE IF EXISTS $DB_NAME"
mysql -u root <<< "CREATE DATABASE $DB_NAME CHARACTER SET utf8mb4"
mysql -u root <<< "DROP USER IF EXISTS $DB_USER"
mysql -u root <<< "CREATE USER IF NOT EXISTS '$DB_USER'@'%' IDENTIFIED BY '$DB_PASS'"
mysql -u root <<< "GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'%'"


# Vamos al directorio /tmp

cd /tmp

# Eliminamos el directorio que nos hemos descargado previamente
rm -rf iaw-practica-lamp

#Clonamos el repositorio de josejuan

git clone https://github.com/josejuansanchez/iaw-practica-lamp.git

# Modificamos el nombre de la base de datos del script sql
sed -i "s/lamp_db/$DB_NAME/" /tmp/iaw-practica-lamp/db/database.sql

# Importamos la base de datos

mysql -u root < /tmp/iaw-practica-lamp/db/database.sql