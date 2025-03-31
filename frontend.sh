#!/bin/bash
echo -n "installing ngnix"
dnf install nginx -y   &>> /tmp/frontend.log
if [ $? -eq 0 ]; then
  echo -e "\e[32m success \e[0m"
  else
    echo -e "\e[31m failure \e[0m"
fi
systemctl enable nginx &>> /tmp/frontend.log
echo -n "starting ngnix"
systemctl start nginx  &>> /tmp/frontend.log
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
echo -n "downloading frontend content"
curl -o /tmp/frontend.zip https://expense-web-app.s3.amazonaws.com/frontend.zip
if [ $? -eq 0 ]; then
  echo -e "\e[32m success \e[0m"
  else
    echo -e "failure"
  fi
echo -n "extracting frontend content"
cd /usr/share/nginx/html 
unzip /tmp/frontend.zip &>> /tmp/frontend.log
if [ $? -eq 0 ]; then
  echo -e "\e[32m success \e[0m"
  else
    echo -e "failure"
  fi
echo -n "restarting nginix"
systemctl restart nginx 

echo -n "frontend executed sucessfully"