#/src/bin/bash
useradd sonar
# Add nodeSource yum repository
curl -sL https://rpm.nodesource.com/setup_10.x | sudo bash -

# Install dependant applications and core applications (Sonarqube + Sonar Scanner)
yum install wget unzip java-11-openjdk-devel nodejs -y
wget https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-9.6.1.59531.zip
wget https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-4.7.0.2747-linux.zip

# Unzip core applications to /opt
unzip sonarqube-9.6.1.59531.zip -d /opt/
unzip sonar-scanner-cli-4.7.0.2747-linux.zip -d /opt/
mv /opt/sonarqube-9.6.1.59531 /opt/sonarqube
mv /opt/sonar-scanner-4.7.0.2747-linux /opt/sonar-scanner

# Change owner for applications folder
chown -R sonar:sonar /opt/sonarqube
chown -R sonar:sonar /opt/sonar-scanner

# Configure Sonarqube service
touch /etc/systemd/system/sonar.service
echo > /etc/systemd/system/sonar.service
cat <<EOT >> /etc/systemd/system/sonar.service
[Unit]
Description=Sonarqube service
After=syslog.target network.target
[Service]
Type=forking
ExecStart=/opt/sonarqube/bin/linux-x86-64/sonar.sh start
ExecStop=/opt/sonarqube/bin/linux-x86-64/sonar.sh stop
User=sonar
Group=sonar
Restart=always
[Install]
WantedBy=multi-user.target
EOT

# Put Sonar-Scanner in Path
echo 'export PATH=$PATH:/opt/sonar-scanner/bin' | sudo tee -a /etc/profile

# Start Sonarqube service
systemctl start sonar
