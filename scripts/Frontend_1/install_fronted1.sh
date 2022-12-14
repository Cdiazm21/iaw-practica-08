#!/bin/bash
set -x

# Actualizamos los repositorios
apt-get update

# Actualizamos los paquetes
apt-get upgrade -y

# Instalamos el servidor apache2
apt-get install apache2 -y

# Instalamos los modulos php

apt-get install php libapache2-mod-php php-mysql -y

# copiamos el archivo de phpinfo de php
cp ../../php/info.php /var/www/html

# Borramos el archivo de index.html
rm -f /var/www/html/index.html