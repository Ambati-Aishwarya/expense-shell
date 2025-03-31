#!/bin/bash

component=mysql
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

echo -n "installing $component server"
dnf install mysql-server -y   &>> $logfile
stat $?

echo -n "starting $component Server"
systemctl enable mysqld &>> $logfile
systemctl start mysqld  &>> $logfile
stat $?

echo -n "configuring $component root password:"
mysql_secure_installation --set-root-pass ExpenseApp@1
stat $?

echo -n "***** $component execution completed *****"
