
echo Disable nodejs default version
dnf module disable nodejs -y

echo Enable nodejs 20 version
dnf module enable nodejs:20 -y

echo install nodejs
dnf install nodejs -y

echo application user
useradd roboshop

echo copy catalogue system config file
cp catalogue.service /etc/systemd/system/catalogue.service

echo copy mongo client config file
cp mongo.repo /etc/yum.repos.d/mongo.repo

echo create application directory
mkdir /app

echo Download application content
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue-v3.zip
cd /app

echo unzip application
unzip /tmp/catalogue.zip

cd /app

echo install node js dependencies
npm install

echo install mongoclient
dnf install mongodb-mongosh -y

echo Load schema
mongosh --host mongodb-dev.rdevopsb87.online </app/db/master-data.js

echo restart catalogue services
systemctl enable catalogue
systemctl restart catalogue