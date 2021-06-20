
# Install 

dnf install httpd -y
systemctl enable --now httpd
systemctl status httpd

# Allow

firewall-cmd --add-service=http --permanent
firewall-cmd --reload
firewall-cmd --list-services	
