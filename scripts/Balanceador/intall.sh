#!/bin/bash

set -x 

# Configuramos las variables

source variables.sh

# Actualizamos los repositorios
apt-get update

# Actualizamos los paquetes
apt-get upgrade -y

# Instalamos el servidor apache2
apt-get install apache2 -y

# Instalamos los modulos php

apt-get install php libapache2-mod-php php-mysql -y

# copiamos el archivo de phpinfo de php
cp ../php/info.php /var/www/html

# Borramos el archivo de index.html
rm -f /var/www/html/index.html


##############Modulos para proxy inverso y balanceo de carga#################

a2enmod proxy proxy_http proxy_balancer headers ssl proxy_ajp lbmethod_bybusyness rewrite deflate


#################Instalacion certbot#####################
# Realizamos la instalación y actualización de snapd.

sudo snap install core && sudo snap refresh core

# Eliminamos si existiese alguna instalación previa de certbot con apt.
sudo apt-get remove certbot

#Instalamos el cliente de Certbot con snapd.
sudo snap install --classic certbot

#Creamos una alias para el comando certbot.
sudo ln -s /snap/bin/certbot /usr/bin/certbot

# Obtenemos el certificado y configuramos el servidor web Apache.

sudo certbot --apache -m $EMAIL --agree-tos --no-eff-email -d $DOMAIN

# Reiniciamos servidor Apache

sudo systemctl restart apache2