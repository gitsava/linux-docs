LAMP installations (Linux + Apache + MySQL + PHP/Perl/Python) are a popular setup for Ubuntu servers. There is a plethora of Open Source applications written using the LAMP application stack. Some popular LAMP applications are Wiki’s, Content Management Systems, and Management Software such as phpMyAdmin.

One advantage of LAMP is the substantial flexibility for different database, web server, and scripting languages. Popular substitutes for MySQL include PostgreSQL and SQLite. Python, Perl, and Ruby are also frequently used instead of PHP. While Nginx, Cherokee and Lighttpd can replace Apache.

The fastest way to get started is to install LAMP using tasksel. Tasksel is a Debian/Ubuntu tool that installs multiple related packages as a co-ordinated “task” onto your system. To install a LAMP server:

At a terminal prompt enter the following command:

sudo tasksel install lamp-server
After installing it you’ll be able to install most LAMP applications in this way:

Download an archive containing the application source files.

Unpack the archive, usually in a directory accessible to a web server.

Depending on where the source was extracted, configure a web server to serve the files.

Configure the application to connect to the database.

Run a script, or browse to a page of the application, to install the database needed by the application.

Once the steps above, or similar steps, are completed you are ready to begin using the application.

A disadvantage of using this approach is that the application files are not placed in the file system in a standard way, which can cause confusion as to where the application is installed. Another larger disadvantage is updating the application. When a new version is released, the same process used to install the application is needed to apply updates.

Fortunately, a number of LAMP applications are already packaged for Ubuntu, and are available for installation in the same way as non-LAMP applications. Depending on the application some extra configuration and setup steps may be needed, however.

This section covers how to install some LAMP applications.

phpMyAdmin
phpMyAdmin is a LAMP application specifically written for administering MySQL servers. Written in PHP, and accessed through a web browser, phpMyAdmin provides a graphical interface for database administration tasks.

Installation
Before installing phpMyAdmin you will need access to a MySQL database either on the same host as that phpMyAdmin is installed on, or on a host accessible over the network. For more information see MySQL documentation. From a terminal prompt enter:

sudo apt install phpmyadmin
At the prompt choose which web server to be configured for phpMyAdmin. The rest of this section will use Apache2 for the web server.

In a browser go to http://servername/phpmyadmin, replacing servername with the server’s actual hostname. At the login, page enter root for the username, or another MySQL user, if you have any setup, and enter the MySQL user’s password.

Once logged in you can reset the root password if needed, create users, create/destroy databases and tables, etc.

Configuration
The configuration files for phpMyAdmin are located in /etc/phpmyadmin. The main configuration file is /etc/phpmyadmin/config.inc.php. This file contains configuration options that apply globally to phpMyAdmin.

To use phpMyAdmin to administer a MySQL database hosted on another server, adjust the following in /etc/phpmyadmin/config.inc.php:

$cfg['Servers'][$i]['host'] = 'db_server';
Note

Replace db_server with the actual remote database server name or IP address. Also, be sure that the phpMyAdmin host has permissions to access the remote database.

Once configured, log out of phpMyAdmin and back in, and you should be accessing the new server.

The config.header.inc.php and config.footer.inc.php files in /etc/phpmyadmin directory are used to add a HTML header and footer to phpMyAdmin.

Another important configuration file is /etc/phpmyadmin/apache.conf, this file is symlinked to /etc/apache2/conf-available/phpmyadmin.conf, and, once enabled, is used to configure Apache2 to serve the phpMyAdmin site. The file contains directives for loading PHP, directory permissions, etc. From a terminal type:

sudo ln -s /etc/phpmyadmin/apache.conf /etc/apache2/conf-available/phpmyadmin.conf
sudo a2enconf phpmyadmin.conf
sudo systemctl reload apache2.service
For more information on configuring Apache2 see this documentation.

References
The phpMyAdmin documentation comes installed with the package and can be accessed from the phpMyAdmin Documentation link (a question mark with a box around it) under the phpMyAdmin logo. The official docs can also be access on the phpMyAdmin site.

Another resource is the phpMyAdmin Ubuntu Wiki page.

WordPress
Wordpress is a blog tool, publishing platform and CMS implemented in PHP and licensed under the GNU GPLv2.

Installation
To install WordPress, run the following comand in the command prompt:

    sudo apt install wordpress
You should also install apache2 web server and mysql server. For installing apache2 web server, please refer to Apache2 documentation. For installing mysql server, please refer to MySQL documentation.

Configuration
For configuring your first WordPress application, configure an apache site. Open /etc/apache2/sites-available/wordpress.conf and write the following lines:

        Alias /blog /usr/share/wordpress
        <Directory /usr/share/wordpress>
            Options FollowSymLinks
            AllowOverride Limit Options FileInfo
            DirectoryIndex index.php
            Order allow,deny
            Allow from all
        </Directory>
        <Directory /usr/share/wordpress/wp-content>
            Options FollowSymLinks
            Order allow,deny
            Allow from all
        </Directory>
           
Enable this new WordPress site

    sudo a2ensite wordpress
Once you configure the apache2 web server and make it ready for your WordPress application, you should restart it. You can run the following command to restart the apache2 web server:

sudo systemctl reload apache2.service
To facilitate multiple WordPress installations, the name of this configuration file is based on the Host header of the HTTP request. This means that you can have a configuration per VirtualHost by simply matching the hostname portion of this configuration with your Apache Virtual Host. e.g. /etc/wordpress/config-10.211.55.50.php, /etc/wordpress/config-hostalias1.php, etc. These instructions assume you can access Apache via the localhost hostname (perhaps by using an ssh tunnel) if not, replace /etc/wordpress/config-localhost.php with /etc/wordpress/config-NAME_OF_YOUR_VIRTUAL_HOST.php.

Once the configuration file is written, it is up to you to choose a convention for username and password to mysql for each WordPress database instance. This documentation shows only one, localhost, example.

Now configure WordPress to use a mysql database. Open /etc/wordpress/config-localhost.php file and write the following lines:

<?php
define('DB_NAME', 'wordpress');
define('DB_USER', 'wordpress');
define('DB_PASSWORD', 'yourpasswordhere');
define('DB_HOST', 'localhost');
define('WP_CONTENT_DIR', '/usr/share/wordpress/wp-content');
?>
Now create this mysql database. Open a temporary file with mysql commands wordpress.sql and write the following lines:

CREATE DATABASE wordpress;
CREATE USER 'wordpress'@'localhost'
IDENTIFIED BY 'yourpasswordhere';
GRANT SELECT,INSERT,UPDATE,DELETE,CREATE,DROP,ALTER
ON wordpress.*
TO wordpress@localhost;
FLUSH PRIVILEGES;
Execute these commands.

cat wordpress.sql | sudo mysql --defaults-extra-file=/etc/mysql/debian.cnf
Your new WordPress can now be configured by visiting http://localhost/blog/wp-admin/install.php. (Or http://NAME_OF_YOUR_VIRTUAL_HOST/blog/wp-admin/install.php if your server has no GUI and you are completing WordPress configuration via a web browser running on another computer.) Fill out the Site Title, username, password, and E-mail and click Install WordPress.

Note the generated password (if applicable) and click the login password. Your WordPress is now ready for use.