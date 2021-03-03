CentOs nginx deployment nuxt ssr server rendering
tags: nginx  nuxt  srr  Server rendering  Nuxt server-side rendering deployment


# First, initialize the service to install the basic environment tools
```
yum -y install gcc gcc-c++ autoconf pcre-devel make automake
yum -y install wget httpd-tools vim
```
# Second, install node/npm
1, to the local disk
```
cd /usr/local
```
2, install nodejs
```
wget https://nodejs.org/dist/v8.9.1/node-v8.9.1-linux-x64.tar.gz 
```
3, decompression
```
tar -zxvf node-v8.9.1-linux-x64.tar.gz -C /usr/local
```
4, change the name
```
mv /usr/local/node-v8.9.1-linux-x64/ /usr/local/node8.9.1
```
5, the soft connection points to node npm
```
ln -s /usr/local/node8.9.1/bin/node  /usr/local/bin/node
ln -s /usr/local/node8.9.1/bin/npm  /usr/local/bin/npm 
```

# Third, install VUE
1, CD to project directory

2, install VUE scaffolding
```
npm install -g vue-cli
```
After installation vue -V If bash: vue: command not found needs to modify environment variables, the steps are as follows:
```
npm root -g
```
Get /usr/local/node/lib/node_modules and check if the path is correct.

If there is a problem, you can reassign it:
```
npm config set prefix /usr/local
```
$PATH can be set according to the global path
Run the command directly
```
export PATH=$PATH:/usr/local/node
```
Execute and modify vi /etc/profile and add the following two lines (DEMO) code to the end of the file.
```
PATH=$PATH:/usr/local/node
export PATH
```
run
```
source /etc/profile
```
View Results
```
echo $PATH
```
Get /usr/local/node/lib/node_modules:/usr/local/node/bin
Install VUE again
```
npm install --global vue-cli
```
3, establish a vue soft connection
```
ln -s /usr/local/node8.9.1/bin/npm  /usr/local/bin/npm
```
4, initialize the nuxt project
```
vue init nuxt/starter
```
5, install the dependency package
```
npm install
```
6, put the nuxt command that nuxt comes with in the project directory
```
Ln -s project path /node_modules/nuxt/bin/nuxt project path /nuxt
```
7, server package
```
npm run build
```
# Fourth, install nginx
1. Modify the latest installation source of nginx
```
vim /etc/yum.repos.d/nginx.repo
```
Add the following code:
```
[nginx]
name=nginx repo
 Baseurl=http://nginx.org/packages/centos/version number/$basearch/
gpgcheck=0
enabled=1
```
2, perform the installation
```
yum install nginx
```
After installation nginx -v to see if the installation is successful, start nginx after successful installation
```
nginx
```
(Start nginx, stop nginx -s quit or nginx -s stop), after entering the browser, enter the server IP to see the nginx welcome interface.

3, modify the nginx reverse proxy
```
cd /etc/nginx/conf.d
```
4, modify the configuration file reverse proxy to nuxt default port 3000 port
```
vim default.conf
```
Add proxy_passhttp://localhost:3000; OK, as follows
```
...
location / {
	proxy_pass http://localhost:3000;
       # root   /usr/share/nginx/html;
       # index  index.html index.htm;
}
...
```
Save and restart nginx. At this time, the browser sees the nuxt welcome interface from the new input server IP, indicating that the nginx reverse proxy succeeds.

Fifth, install PM2
1. Install pm2 node process manager
```
npm install -g pm2
```
2, establish a PM2 soft connection
```
ln -s /usr/local/node8.9.1/bin/pm2  /usr/local/bin/pm2
```
3. Start the project with PM2
```
Pm2 start npm --name "project name" -- run start
```
Before using PM2 to start the project, pay attention to cd to the project directory and run npm run build under the command to use PM2.

4, PM2 common commands

#View process: 
pm2 list  
 # (0 is the process id)  
pm2 show 0  
 #   
pm2 start 0   
 #stop     
pm2 stop 0  
 #   
pm2 reload 0  
 # /Uninstall  
pm2 delete 0  
 #display background log  
pm2 logs 0  