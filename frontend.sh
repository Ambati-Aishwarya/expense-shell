#!/bin/bash

component =frontend
logfile=/tmp/$component.log
echo -n "installing ngnix"
dnf install nginx -y   &>> $logfile
if [ $? -eq 0 ]; then
  echo -e "\e[32m success \e[0m"
  else
    echo -e "\e[31m failure \e[0m"
fi
systemctl enable nginx &>> $logfile
echo -n "starting ngnix"
systemctl start nginx  &>> $logfile
if [ $? -eq 0 ]; then
  echo -e "\e[32m success \e[0m"
  else
    echo -e "failure"
  fi
echo -n "clearing old web content:"
rm -rf /user/share/nginx/html/*
if [ $? -eq 0 ]; then
  echo -e "\e[32m success \e[0m"
  else
    echo -e "failure"
  fi
echo -n "downloading component content"
curl -o /tmp/component.zip https://expense-web-app.s3.amazonaws.com/component.zip &>> $logfile
if [ $? -eq 0 ]; then
  echo -e "\e[32m success \e[0m"
  else
    echo -e "failure"
  fi
echo -n "extracting component content"
cd /usr/share/nginx/html 
unzip -o /tmp/component.zip &>> $logfile
if [ $? -eq 0 ]; then
  echo -e "\e[32m success \e[0m"
  else
    echo -e "failure"
  fi
echo -n "restarting nginix"
systemctl restart nginx 

echo -n "component executed sucessfully"