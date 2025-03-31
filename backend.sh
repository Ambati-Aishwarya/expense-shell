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

 id $appuser &>> $logfile
    if [ $? -eq 0 ]; then
        echo -e "\e[32m user $appuser is already there, so not creating \e[0m"
        echo -e "skipping"
    else
        useradd $appuser &>> $logfile
        mkdir /app &>> $logfile
        stat $?
    
    fi
    echo -n "downloading $component content"
    curl -o /tmp/$component.zip https://expense-web-app.s3.amazonaws.com/backend.zip &>> $logfile
    stat $?

    echo -n "configuring the permissions:"
    chmod -R 755 /app && chown -R $appuser:$appuser /app &>> $logfile
    stat $?

    echo -n "extracting $component content"
    cd /app/
    unzip -o /tmp/$component.zip &>> $logfile
    stat $?

    echo -n "generating $component artifacts"
    npm install $>> $logfile
    stat $?

    echo -n "configuring systemd service:"
    cp backend.service /etc/systemd/system/backend.service &>> $logfile
    stat $?

    echo -n "installing $component client:"
    dnf install mysql-sderver -y &>> $logfile
    stat $?

    echo -n "injecting &component schema:"
    mysql -h localhost -u root -pExpenseApp@1 < /app/schema.sql &>> $logfile
    stat $?

    echo -n "starting $component service:"
    systemctl daemon-reload &>> $logfile
    systemctl enable backend &>> $logfile
    systemctl start backend &>> $logfile
    stat $?

    echo -n "***** $component execution completed *****"
 
 
