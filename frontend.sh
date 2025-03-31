#!/bin/bash

component=frontend
logfile=/tmp/$component.log
stat() {
if [ $1 -eq 0 ]; then
  echo -e "\e[32m success \e[0m"
  else
    echo -e "\e[31m failure \e[0m"
fi
}
echo -n "installing ngnix"
dnf install nginx -y   &>> $logfile

echo -n "starting ngnix"
systemctl enable nginx &>> $logfile
systemctl start nginx  &>> $logfile
stat $?

echo -n "clearing old web content:"
rm -rf /user/share/nginx/html/*
stat $?

echo -n "downloading component content"
curl -o /tmp/component.zip https://expense-web-app.s3.amazonaws.com/component.zip &>> $logfile
stat $?

echo -n "extracting component content"
cd /usr/share/nginx/html 
unzip /tmp/component.zip &>> $logfile
stat $?

echo -n "restarting nginix"
systemctl restart nginx 
stat $?
echo -n "component executed sucessfully"