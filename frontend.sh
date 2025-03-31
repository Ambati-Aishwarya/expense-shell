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
# rm -rf /usr/share/nginx/html/* 
#curl -o /tmp/frontend.zip https://expense-web-app.s3.amazonaws.com/frontend.zip
#cd /usr/share/nginx/html 
#unzip /tmp/frontend.zip
#systemctl restart nginx 
#set host-name frontend