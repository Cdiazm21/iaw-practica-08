#!/bin/bash
set -x

# Configuracion de las variables

source variables.sh

# Accedemos al directorio temporal /tmp
cd /tmp

# Eliminamos el directorio que nos hemos descargado previamente
rm -rf iaw-practica-lamp

# Clonamos el repositorio de josejuan

git clone https://github.com/josejuansanchez/iaw-practica-lamp.git

# Movemos el código fuente de la aplicación
mv /tmp/iaw-practica-lamp/src/* /var/www/html

# Cambiamos los permisos de los archivos a los de apache en /var/www/html
chown www-data:www-data /var/www/html -R

# Borramos el archivo index.html
rm -rf /var/www/html/index.html

# Configuramos las variables
sed -i "s/localhost/$DB_HOST_PRIVATE_IP/" /var/www/html/config.php
sed -i "s/lamp_db/$DB_NAME/" /var/www/html/config.php
sed -i "s/lamp_user/$DB_USER/" /var/www/html/config.php
sed -i "s/lamp_password/$DB_PASS/" /var/www/html/config.php