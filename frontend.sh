#!/bin/bash
echo -n "installing ngnix"
dnf install nginx -y   &>> /tmp/frontend.log
echo -n "enabling ngnix"
systemctl enable nginx &>> /tmp/frontend.log
echo -n "starting ngnix"
systemctl start nginx  &>> /tmp/frontend.log
# rm -rf /usr/share/nginx/html/* 
#curl -o /tmp/frontend.zip https://expense-web-app.s3.amazonaws.com/frontend.zip
#cd /usr/share/nginx/html 
#unzip /tmp/frontend.zip
#systemctl restart nginx 
#set host-name frontend