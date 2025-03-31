#!/bin/bash
component=backend
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
echo -n "installing NodeJS:"
 dnf dnf module disable nodejs -y &>> $logfile
 dnf module enable nodejs:20 -y &>> $logfile
 dnf install nodejs -y &>> $logfile
 stat $?

 echo -n "creating application user -$appUser :"
 mkdir /app
 useradd $appuser &>> $logfile
 stat $?
