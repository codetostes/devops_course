#/bin/bash
# Add jenkins and docker repositories
wget --no-check-certificate -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat/jenkins.repo
rpm --import https://pkg.jenkins.io/redhat/jenkins.io.key
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

# Install applications. Dependante + core (Jenkins and Docker)
yum install yum-utils epel-release git wget java-11-openjdk-devel -y 
yum install jenkins docker-ce docker-ce-cli containerd.io -y

# Install Docker compose
curl -L "https://github.com/docker/compose/releases/download/1.25.5/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose 

# Give jenkins permission to run docker
usermod -aG docker jenkins

# Reload, enable and start services
systemctl deamon-reload
systemctl enable docker
systemctl enable jenkins
systemctl start docker
systemctl start jenkins