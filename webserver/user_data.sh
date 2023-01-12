#!/bin/bash
sudo yum update -y
sudo amazon-linux-extras install epel -y
sudo hostnamectl set-hostname wordpress-web
# install php
sudo amazon-linux-extras install -y php8.0
# install apache
sudo yum install -y httpd 
sudo systemctl start httpd
sudo systemctl enable httpd
# download && install wordpress
wget https://wordpress.org/latest.tar.gz
tar -xzf latest.tar.gz

sudo yum install php-gd -y
sudo yum install mariadb -y 
sudo systemctl restart httpd
sudo cp -r wordpress/* /var/www/html
sudo chown -R apache:apache /var/www/html
sudo systemctl restart httpd

# Installing Git
yum -y update
yum -y install git
# Installing Gatsby + NodeJs
sudo yum install -y gcc-c++ make
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.37.2/install.sh | bash
. ~/.nvm/nvm.sh
yum install -y nodejs

# Installing Gatsby-CLI
npm -g i gatsby-cli@4.25.0

# create a new Gatsby site using the hello-world starter
gatsby new my-hello-world-starter https://github.com/gatsbyjs/gatsby-starter-hello-world
cd my-hello-world-starter/
gatsby build
gatsby serve --host 0.0.0.0 &