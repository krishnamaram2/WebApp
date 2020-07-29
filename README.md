Project Title
=========================
This project implemented to touch and feel  3-tier web app communication


Technologies to be used
========================
Angular 6

SpringBoot 2 + Hibernate 5

MySQL


3-Tier Web Application installation and Setup Automation
======================================================================================================



# Phase 0: lauch ec2 instance and named as "Sandbox"

step 0: login to sandbox instance

step 1: repo file

$vi ansible.repo

[Ansible]

name = ansible

baseurl = https://releases.ansible.com/ansible/rpm/release/epel-7-x86_64/

enabled = 1

gpgcheck = 0

step 2: install packages

$vi setup.sh

yum update -y && yum upgrade -y

yum install git -y && yum install wget -y && yum install unzip -y && yum install curl -y && yum install epel-release -y

wget https://releases.hashicorp.com/packer/1.5.5/packer_1.5.5_linux_amd64.zip && unzip packer_1.5.5_linux_amd64.zip && mv packer /bin/ && rm -rf ./packer*

wget https://releases.hashicorp.com/terraform/0.12.24/terraform_0.12.24_linux_amd64.zip && unzip terraform_0.12.24_linux_amd64.zip && mv terraform /bin/ && rm -rf ./terraform* 

sudo mv ./ansible.repo /etc/yum.repos.d/

yum install ansible -y

rm -rf ./setup.sh

step 3: run script

$sudo sh setup.sh 

# Phase 1: Build custome AMI image using "Packer"

step 1: clone repo

$git clone https://github.com/krishnamaram2/Image_Builder.git

step 2: enter src directory

$cd Image_Builder/src

step 3: enter access key and secret key

$vi variables.json

{

"aws_access_key": "",

"aws_secret_key": "",

"region": "us-east-1"

}

Step 4: validate syntax

$packer validate -var-file=variables.json builders.json

Step 5: Build custome AMI

$packer build -var-file=variables.json builders.json


# Phase 2: Build infrastructure using "Terraform"


step 0: create the below objects in AWS

create s3 bucket

create file under above s3 bucket

create DynamoDB table

step 1: clone repo

$git clone https://github.com/krishnamaram2/Infrastructure_Manager.git


Step 2: move to directory

cd Infrastructure_Manager/src



Step 3: enter access key and secret key in the below files 

$vi backend.tf

terraform{

backend "s3"{

access_key = ""

secret_key = ""

region = "us-east-1"

bucket = "<<mybucket>>"

key = "<<myfile>>"

dynamodb_table = "<<mytable>>"

}

}


$vi config.json

{

"myregion" : "us-east-1",

"myaccesskey" : "",

"mysecretkey" : "",

"myamiid" : ""

}


Step 4:

$terraform init .

$terraform validate -var-file=config.json .

$terraform apply -var-file=config.json .



# Phase 3: Installing and configure using "Ansible"


Step 1: add public keys

$vi ssh-keys.sh

ssh-keygen -q -t rsa -N '' -f /home/centos/.ssh/id_rsa <<<y 2>&1 >/dev/null

cat /home/centos/.ssh/id_rsa.pub >> /home/centos/.ssh/authorized_keys

ssh -o StrictHostKeyChecking=no centos@localhost

$sudo ssh-keys.sh

step 2: executing playbooks

$vi playbook.sh

git clone https://github.com/krishnamaram2/Configuration_Manager.git

cd Configuration_Manager/src/plays

ansible-playbook -i hosts webapps.yml

$sudo sh playbook.sh























































Pre-Requisites
=======================
To bring up infrastructure follow the below on your local machine

Step 1: install necessary packages

$vi hardening.sh

$yum update -y && yum upgrade -y

$yum install git -y && yum install wget -y && yum install unzip -y && yum install curl -y && yum install epel-release -y

$wget https://releases.hashicorp.com/packer/1.5.5/packer_1.5.5_linux_amd64.zip

$unzip packer_1.5.5_linux_amd64.zip && mv packer /bin/ && rm -rf ./packer*

$wget https://releases.hashicorp.com/terraform/0.12.24/terraform_0.12.24_linux_amd64.zip

$unzip terraform_0.12.24_linux_amd64.zip && mv terraform /bin/ && rm -rf ./terraform*

add repo

$vi /etc/yum.repos.d/ansible.repo

[Ansible]

name = ansible

baseurl = https://releases.ansible.com/ansible/rpm/release/epel-7-x86_64/

enabled = 1

gpgcheck = 0

$yum install ansible -y


1.Traditional Web Application/Monolithic based Web Application
=================================================================


Manual Installation and set up  for 3-tier Web application
================================================================


a.Web Server(Apache HTTP) Set up
=====================================

Step 1: Launch EC2 instance

$sudo yum update -y && sudo yum install wget -y && sudo yum install git -y

Step 2: install apache http server

$sudo yum install httpd -y

$sudo systemctl start httpd
$sudo systemctl enable httpd

Step 3: Build and deploy angular code into web server

$git clone https://github.com/krishnamaram2/WebApp.git

$cd WebApp/binary

$less dist/main.js |  grep this.baseUrl = 'http://<app-server-ip>:8080/Student/api/'; note:have to edit two times(nile 314, 701)

$cp -rf dist /var/www/html


b.App Server(Apache Tomcat) Set up
========================================

Step 1: Launch EC2 instance

$sudo yum update -y && sudo yum install wget -y && sudo yum install git -y

Step 2: install openjdk

sudo yum install java-1.8.0-openjdk-devel -y

Step 3: install set up tomcat app server

$sudo groupadd tomcat

$sudo useradd -M -s /bin/nologin -g tomcat -d /opt/tomcat tomcat

$sudo yum install wget -y

$wget https://downloads.apache.org/tomcat/tomcat-8/v8.5.51/bin/apache-tomcat-8.5.51.tar.gz 

$sudo mkdir /opt/tomcat

$sudo tar xvf apache-tomcat-8*tar.gz -C /opt/tomcat --strip-components=1

$cd /opt/tomcat

$sudo chgrp -R tomcat /opt/tomcat

$sudo chmod -R g+r conf

$sudo chmod g+x conf

$sudo chown -R tomcat webapps/ work/ temp/ logs/

$sudo vi /etc/systemd/system/tomcat.service

[Unit]

Description=Apache Tomcat Web Application Container

After=syslog.target network.target

[Service]

Type=forking

Environment=JAVA_HOME=/usr/lib/jvm/jre

Environment=CATALINA_PID=/opt/tomcat/temp/tomcat.pid

Environment=CATALINA_HOME=/opt/tomcat

Environment=CATALINA_BASE=/opt/tomcat

Environment='CATALINA_OPTS=-Xms512M -Xmx1024M -server -XX:+UseParallelGC'

Environment='JAVA_OPTS=-Djava.awt.headless=true -Djava.security.egd=file:/dev/./urandom'

ExecStart=/opt/tomcat/bin/startup.sh

ExecStop=/bin/kill -15 $MAINPID

User=tomcat

Group=tomcat

UMask=0007

RestartSec=10

Restart=always

[Install]

WantedBy=multi-user.target

$sudo systemctl daemon-reload

$sudo systemctl start tomcat

$sudo systemctl enable tomcat

Step 4: build source code and deploy war file

$git clone https://github.com/krishnamaram2/WebApp.git

$cd WebApp/binary

$cp -rf Student.war /opt/tomcat/webapps

$less /opt/tomcat/webapps/Student/WEB-INF/classes/application.properties | grep db.url= jdbc:mysql://<db-server-ip>:3306/indigo
 
 
c.Database Server(MySQL) Set up
====================================

Step 1: Launch EC2 instance

$sudo yum update -y && sudo yum install wget -y && sudo yum install git -y

Step 2:install MySQL server

$sudo wget https://dev.mysql.com/get/mysql80-community-release-el7-1.noarch.rpm

$sudo rpm -Uvh mysql80-community-release-el7-1.noarch.rpm

$sudo yum install mysql-server -y

$sudo systemctl start mysqld

$sudo mysql_secure_installation

$sudo grep 'temporary password' /var/log/mysqld.log

Step 3: create database and user for MySQL 

$mysql -u <<user>> -p
  
mysql>create database indigo;

mysql>CREATE USER '<user_name>'@'%' IDENTIFIED BY '<passwd>';
 
mysql>GRANT ALL ON *.* TO '<user>'@'%';
  
mysql>FLUSH PRIVILEGES;

$git clone https://github.com/krishnamaram2/WebApp.git

$cd WebApp/binary

$mysql -u <user_name> -p indigo < indigo.sql




Automation for 3-tier Web Application 
=============================================

# Execution Flow

1.Build Custom AMI using Packer


2.Provision infra using Terraform

3.Configure softwares using Ansible


step 2: clone repo for terraform code

$git clone https://github.com/krishnamaram2/Infrastructure_Manager.git && cd Infrastructure_Manager/src

Step 3: enter access key and secret key in the below files

vi backend.tf

terraform{

backend "s3"{

access_key = ""

secret_key = ""

region = "us-east-1"

bucket = "<bucketname>"

key = "<fileneame>"

dynamodb_table = "<tablename>"

}

}

vi config.json

{

"myregion" : "us-east-1",

"myaccesskey" : "",

"mysecretkey" : "",

"myamiid" : "ami-0affd4508a5d2481b"

}

Step 4: execute the below terraform commands

terraform init .

$terraform validate -var-file=config.json .

$terraform apply -var-file=config.json .


Automation for 3-tier Web Application 
=============================================

Login on web/app/db server and execute the below commands

Step 1: install necessary packages

$yum update -y && yum upgrade -y

$yum install git -y && yum install wget -y && yum install unzip -y && yum install curl -y && yum install epel-release

add repo

$vi /etc/yum.repos.d/ansible.repo

[Ansible]

name = ansible

baseurl = https://releases.ansible.com/ansible/rpm/release/epel-7-x86_64/

enabled = 1

gpgcheck = 0

$yum install ansible -y

Step 2:  enable password authentication

$sudo su -l

$passwd root

$vi /etc/ssh/sshd_config

PasswordAuthentication yes

permitroorlogin yes

$systemctl restart sshd

$ssh-keygen

$ssh-copy-id root@localhost

 enter password for root user

Step 3: clone repo for Ansible playbooks

$git clone https://github.com/krishnamaram2/Configuration_Manager.git

$cd Configuration_Manager/src


a.Apache HTTP server


$ansible-playbook -i hosts webserver.yml

b.Apache Tomcat server


$ansible-playbook -i hosts appserver.yml

c.MySQL server


$ansible-playbook -i hosts dbserver.yml














 







2.Distributed Web Application/Constainerized Web Application/Miscro services based web Application
===================================================================================================














