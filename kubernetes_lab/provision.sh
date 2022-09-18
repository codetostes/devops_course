#/bin/bash

#Install some tools
yum install wget unzip net-tools telnet git -y

# Install cluster k3s
curl -sfL https://get.k3s.io | sh -s - --cluster-init --tls-san 10.10.0.2 --node-ip 10.10.0.2 --node-external-ip 10.10.0.2

# Put /usr/local/bin in PATH
echo 'export PATH=$PATH:/usr/local/bin' >> /etc/profile

# Create kubectl alias
echo 'alias k=kubectl' >> /etc/profile

# bashrc to reload profile
echo 'source /etc/profile' >> ~/.bashrc

# Reload bashrc
source ~/.bashrc

# Install kube context to better mamagement
git clone https://github.com/ahmetb/kubectx /opt/kubectx
ln -s /opt/kubectx/kubectx  /usr/local/bin/kubectx
ln -s /opt/kubectx/kubens  /usr/local/bin/kubens

# Install kubernetes auto complete
yum install bash-completion -y
echo 'source <(kubectl completion bash)' >> ~/.bashrc
kubectl completion bash > /etc/bash_completion.d/kubectl
echo 'complete -F __start_kubectl k' >> ~/.bashrc

# Add private registry
touch /etc/rancher/k3s/registries.yaml
cat << EOT >> /etc/rancher/k3s/registries.yaml
mirrors:
  docker.io:
    endpoint:
      - "http://10.10.0.5:8123"
configs:
  "10.10.0.5:8123":
    auth:
      username: jenkins
      password: jenkins
EOT

# Restart Services
systemctl restart k3s
