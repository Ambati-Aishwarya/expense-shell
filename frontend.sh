#!/bin/bash
dnf install nginx -y   &>> /tmp/frontend.log
systemctl enable nginx &>> /tmp/frontend.log
systemctl start nginx  &>> /tmp/frontend.log
rm -rf /usr/share/nginx/html/* 
curl -o /tmp/frontend.zip https://expense-web-app.s3.amazonaws.com/frontend.zip
cd /usr/share/nginx/html 
unzip /tmp/frontend.zip
systemctl restart nginx 
set host-name frontend