echo
echo Disable nodejs default version
echo
dnf module disable nodejs -y &>/tmp/roboshop.log

echo
echo Enable nodejs 20 version
echo
dnf module enable nodejs:20 -y &>/tmp/roboshop.log

echo
echo install nodejs
echo
dnf install nodejs -y &>/tmp/roboshop.log

echo
echo application user
echo
useradd roboshop &>/tmp/roboshop.log

echo
echo copy catalogue system config file
echo
cp catalogue.service /etc/systemd/system/catalogue.service &>/tmp/roboshop.log

echo
echo copy mongo client config file
echo
cp mongo.repo /etc/yum.repos.d/mongo.repo &>/tmp/roboshop.log

echo
echo create application directory
echo
mkdir /app &>/tmp/roboshop.log

echo
echo Download application content
echo

curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue-v3.zip &>/tmp/roboshop.log
cd /app

echo
echo unzip application
echo
unzip /tmp/catalogue.zip &>/tmp/roboshop.log

cd /app

echo
echo install node js dependencies
echo
npm install &>/tmp/roboshop.log

echo
echo install mongoclient
echo
dnf install mongodb-mongosh -y &>/tmp/roboshop.log

echo
echo Load schema
echo
mongosh --host mongodb-dev.rdevopsb87.online </app/db/master-data.js &>/tmp/roboshop.log

echo
echo restart catalogue services
echo
systemctl enable catalogue
systemctl restart catalogue &>/tmp/roboshop.log