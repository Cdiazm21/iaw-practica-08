#!/bin/bash

set -x 

# Configuramos las variables

source variables.sh

#################Instalacion certbot############
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