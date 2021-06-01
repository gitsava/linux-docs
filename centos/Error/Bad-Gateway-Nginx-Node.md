## nginx + node.js + CentOS 7 = 502 Bad Gateway

I have setup a new Node.js / Express development environment on a CentOS 7 VM. I ‘ll describe the details in another post later.

To test my setp, I created a new Express application “helloworld”. The application listens on port 3000 and I was able to connect to the application using a browser.

Next, I configured NGINX as reverse proxy to use port 80 to access the helloworld application.

But I got an error

I checked the logs
```
# cat /var/log/audit/audit.log | grep nginx | grep denied
```
and got

type=AVC msg=audit(1546783734.750:239): avc:  denied  { name_connect } for  pid=11084 comm="nginx" dest=3000 scontext=system_u:system_r:httpd_t:s0 tcontext=system_u:object_r:ntop_port_t:s0 tclass=tcp_socket permissive=0

My best guess was SELinux.I checked, if SELinux was enabled.
```
# sestatus
```
 SELinux status:                 enabled
 SELinuxfs mount:                /sys/fs/selinux
 SELinux root directory:         /etc/selinux
 Loaded policy name:             targeted
 Current mode:                   enforcing
 Mode from config file:          enforcing
 Policy MLS status:              enabled
 Policy deny_unknown status:     allowed
 Max kernel policy version:      31

Next I checked the settings for httpd.
```
# getsebool -a | grep httpd
```
 httpd_anon_write --> off
 httpd_builtin_scripting --> on
 httpd_can_check_spam --> off
 httpd_can_connect_ftp --> off
 httpd_can_connect_ldap --> off
 httpd_can_connect_mythtv --> off
 httpd_can_connect_zabbix --> off
 httpd_can_network_connect --> off 
 httpd_can_network_connect_cobbler --> off
 httpd_can_network_connect_db --> off
 httpd_can_network_memcache --> off
 httpd_can_network_relay --> off
 httpd_can_sendmail --> off

So, httpd_can_network_connect was set to “Off”. This blocks the connection from the reverse proxy to the node.js application. As a result, you get the 502 Bad gateway error.

To enable the setting, execute the following command from the shell.
```
# setsebool -P httpd_can_network_connect on
```
or
```
# setsebool -P httpd_can_network_connect true
```
You do not need to reboot the machine or SELinux. 