#/bin/sh
sudo yum -y install epel-release
echo "initialization of ansible installation..."
sudo yum -y install ansible
cat <<EOT >> /etc/hosts
10.10.0.2 control-node
10.10.0.3 app01
10.10.0.4 db01
EOT