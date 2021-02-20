# Steps To Install Odoo 14 On Ubuntu 20.04 LTS  

Odoo is now ready to launch the latest version of Odoo 14 with too many new features.

This blog is to provide steps for installation and configuration of Odoo for production environment using Git source and Python environment on an Ubuntu 20.04 LTS.


## Step 1 : Update Server
```
sudo apt-get update
```
```                      
sudo apt-get upgrade -y
```                    
## Step 2 : Create Odoo User in Ubuntu
```                     
sudo adduser -system -home=/opt/odoo -group odoo
```                    
## Step 3 : Install PostgreSQL Server
```                     
sudo apt-get install postgresql -y
```                    
## Step 4 : Create Odoo user for PostgreSQL
```
sudo su - postgres -c "createuser -s odoo" 2> /dev/null || true
```                    
## Step 5 : Install Python Dependencies
```
sudo apt-get install git python3 python3-pip build-essential wget python3-dev python3-venv python3-wheel libxslt-dev libzip-dev libldap2-dev libsasl2-dev python3-setuptools node-less libjpeg-dev gdebi -y
```                    
## Step 6 : Install Python PIP Dependencies
```
sudo apt-get install libpq-dev python-dev libxml2-dev libxslt1-dev libldap2-dev libsasl2-dev libffi-dev
```                    
```
sudo -H pip3 install -r https://raw.githubusercontent.com/odoo/odoo/master/requirements.txt
```                    
## Step 7 : Install other required packages
```
sudo apt-get install nodejs npm -y
```                    
```
sudo npm install -g rtlcss
```                    
## Step 8 : Install Wkhtmltopdf
```
sudo apt-get install xfonts-75dpi
```                    
```
sudo wget https://github.com/wkhtmltopdf/packaging/releases/download/0.12.6-1/wkhtmltox_0.12.6-1.bionic_amd64.deb
```
```
sudo dpkg -i wkhtmltox_0.12.6-1.bionic_amd64.deb
```
```
sudo cp /usr/local/bin/wkhtmltoimage /usr/bin/wkhtmltoimage
```
```
sudo cp /usr/local/bin/wkhtmltopdf /usr/bin/wkhtmltopdf
```
## Step 9 : Create Log directory
```
sudo mkdir /var/log/odoo
```
```
sudo chown odoo:odoo /var/log/odoo
```                 
## Step 10 :Install Odoo

```
sudo apt-get install git
```                 
```
sudo git clone --depth 1 --branch 14.0 https://www.github.com/odoo/odoo /odoo/odoo-server
```                    
## Step 11 : Setting permissions on home folder
```
sudo chown -R odoo:odoo /odoo/*
```
## Step 12 : Create server config file
```
sudo touch /etc/odoo-server.conf
```
```                     
sudo su root -c "printf '[options] \n; This is the password that allows database operations:\n' >> /etc/odoo-server.conf"
```                    
```
sudo su root -c "printf 'admin_passwd = admin\n' >> /etc/odoo-server.conf"
```
```
sudo su root -c "printf 'xmlrpc_port = 8069\n' >> /etc/odoo-server.conf"
```
```
sudo su root -c "printf 'logfile = /var/log/odoo/odoo-server.log\n' >> /etc/odoo-server.conf"
```
```
sudo su root -c "printf 'addons_path=/odoo/odoo-server/addons\n' >> /etc/odoo-server.conf"
```
```
sudo chown odoo:odoo /etc/odoo-server.conf
```
```
sudo chmod 640 /etc/odoo-server.conf
```
## Step 13 : Now Start Odoo
```
sudo su - odoo -s /bin/bash
```
```                     
cd /odoo/odoo-server
```
```
./odoo-bin -c /etc/odoo-server.conf
```
Now your odoo instance is up and running. 

Go to web browser and access your odoo at localhost:8069