### Check Support
https://dev.mysql.com/downloads/repo/yum/
```
# wget https://dev.mysql.com/get/mysql57-community-release-el7-9.noarch.rpm
# md5sum mysql57-community-release-el7-9.noarch.rpm
# rpm -ivh mysql57-community-release-el7-9.noarch.rpm

```

### Install Package
yum install mysql-server mysql -y


### Enable Start Boot
```
# systemctl start mysqld
# systemctl enable mysqld
```

### mysqld.log
```
# grep 'temporary password' /var/log/mysqld.log
```

### secure our Databbase
```
# mysql_secure_installation
```

### Testing
```
# mysqladmin -u root -p version
```
