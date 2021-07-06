# Cockpit is

1. Install cockpit:
sudo yum install cockpit

2. Enable cockpit:
sudo systemctl enable --now cockpit.socket

3. Open the firewall if necessary:

sudo firewall-cmd --permanent --zone=public --add-service=cockpit
sudo firewall-cmd --reload

4. Access in IP_ADDRESS:9090