# uninstall mysql ubuntu 18.04
$ sudo apt-get remove --purge mysql-server mysql-client mysql-common -y
$ sudo apt-get autoremove -y
$ sudo apt-get autoclean
rm -rf /etc/mysql
# Delete all MySQL files on your server:
sudo find / -iname 'mysql*' -exec rm -rf {} \;
