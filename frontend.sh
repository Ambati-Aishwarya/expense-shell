#!/bin/bash

component =frontend
echo -n "installing ngnix"
dnf install nginx -y   &>> /tmp/component.log
if [ $? -eq 0 ]; then
  echo -e "\e[32m success \e[0m"
  else
    echo -e "\e[31m failure \e[0m"
fi
systemctl enable nginx &>> /tmp/component.log
echo -n "starting ngnix"
systemctl start nginx  &>> /tmp/component.log
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
curl -o /tmp/component.zip https://expense-web-app.s3.amazonaws.com/component.zip
if [ $? -eq 0 ]; then
  echo -e "\e[32m success \e[0m"
  else
    echo -e "failure"
  fi
echo -n "extracting component content"
cd /usr/share/nginx/html 
unzip -o /tmp/component.zip &>> /tmp/component.log
if [ $? -eq 0 ]; then
  echo -e "\e[32m success \e[0m"
  else
    echo -e "failure"
  fi
echo -n "restarting nginix"
systemctl restart nginx 

echo -n "component executed sucessfully"