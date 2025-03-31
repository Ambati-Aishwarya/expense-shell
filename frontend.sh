#!/bin/bash

component=frontend
logfile=/tmp/$component.log
if [ $(id -u) -ne 0 ]; then
  echo -e "\e[31m you should be root user to run this script \e[0m"
  echo -e "\e[31m execute the script as root  user \n\t sudo bash $0 \e[0m"
  exit 2
fi
stat() {
if [ $1 -eq 0 ]; then
  echo -e "\e[32m success \e[0m"
  else
    echo -e "\e[31m failure \e[0m"
fi
}

echo -n "installing ngnix"
dnf install nginx -y   &>> $logfile

echo -n "configuring proxy:"
cp expense.conf /etc/nginx/default.d/ &>> $logfile
stat $?

echo -n "clearing old web content:"
rm -rf /user/share/nginx/html/*
stat $?

echo -n "downloading $component content"
curl -o /tmp/$component.zip https://expense-web-app.s3.amazonaws.com/frontend.zip &>> $logfile
stat $?

echo -n "extracting $component content"
cd  /usr/share/nginx/html 
unzip -o /tmp/$component.zip &>> $logfile
stat $?

echo -n "restarting nginix"
systemctl restart nginx 
stat $?
echo -n "$component executed sucessfully"