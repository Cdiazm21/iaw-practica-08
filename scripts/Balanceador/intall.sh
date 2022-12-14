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

# Borramos el archivo de index.html
rm -f /var/www/html/index.html


##############Modulos para proxy inverso y balanceo de carga#################

a2enmod proxy proxy_http proxy_balancer headers ssl proxy_ajp lbmethod_bybusyness rewrite deflate
a2enmod lbmethod_byrequests

#Cipiamso el archivo de configuración de apache

cp ../../conf/000-default.conf /etc/apache2/sites-available/000-default.conf

# Reemplazamos las variables del archivo de configuración

sed -i "s/IP_HTTP_SERVER_1/$IP_HTTP_SERVER_1/" /etc/apache2/sites-available/000-default.conf
sed -i "s/IP_HTTP_SERVER_2/$IP_HTTP_SERVER_2/" /etc/apache2/sites-available/000-default.conf

#Reiniciamos el servidor

systemctl restart apache2

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