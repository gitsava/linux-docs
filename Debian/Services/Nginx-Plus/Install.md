Installation instructions for Debian Linux
If you already have old NGINX packages in your system, back up your configs and logs:

sudo cp -a /etc/nginx /etc/nginx-plus-backup
sudo cp -a /var/log/nginx /var/log/nginx-plus-backup
Create the /etc/ssl/nginx/ directory:

sudo mkdir -p /etc/ssl/nginx
Log in to NGINX Customer Portal and download the following two files:

nginx-repo.key
nginx-repo.crt
Copy the above two files to the Debian Linux server into /etc/ssl/nginx/ directory. Use your SCP client or other secure file transfer tools.
Download and add NGINX signing key and App-protect security updates signing key:

sudo wget https://cs.nginx.com/static/keys/nginx_signing.key && sudo apt-key add nginx_signing.key
sudo wget https://cs.nginx.com/static/keys/app-protect-security-updates.key && sudo apt-key add app-protect-security-updates.key
Install apt utils:

sudo apt-get install apt-transport-https lsb-release ca-certificates
Add NGINX Plus repository:

printf "deb https://plus-pkgs.nginx.com/debian `lsb_release -cs` nginx-plus\n" | sudo tee /etc/apt/sources.list.d/nginx-plus.list
If you have app-protect subscription, add app-protect security updates repository:

printf "deb https://app-protect-security-updates.nginx.com/debian `lsb_release -cs` nginx-plus\n" | sudo tee /etc/apt/sources.list.d/app-protect-security-updates.list
Download nginx-plus and app-protect security updates apt configuration files to /etc/apt/apt.conf.d:

sudo wget -P /etc/apt/apt.conf.d https://cs.nginx.com/static/files/90nginx
sudo wget -P /etc/apt/apt.conf.d https://cs.nginx.com/static/files/90app-protect-security-updates
Update the repository and install NGINX Plus:

sudo apt-get update
sudo apt-get install nginx-plus
Install app-protect and app-protect signatures, in case you have app-protect subscription:

sudo apt-get install app-protect app-protect-attack-signatures
Check the nginx binary version to ensure that you have NGINX Plus installed correctly:

nginx -v
Upgrading to a specific release
In order to upgrade from the previous version of nginx-plus, run apt-get update and apt-get install nginx-plus

Default repository path is configured to point to the latest NGINX Plus release with an ability to downgrade to one of the previous releases issued within 2 years. If you want to stick to the particular release, you should modify repository URL in the /etc/apt/sources.list.d/nginx-plus.list file in a following way:


deb https://plus-pkgs.nginx.com/Rxx/debian ...
where xx is a release number.


Please check NGINX Plus Releases History for more information about the latest NGINX Plus updates.

Also please visit NGINX Plus Admin Guide for more information about NGINX Plus initial deployment, configuration and tuning.