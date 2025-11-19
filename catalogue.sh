echo ===============================================
echo Disable nodejs default version
echo ===============================================
dnf module disable nodejs -y

echo ===============================================
echo Enable nodejs 20 version
echo ===============================================
dnf module enable nodejs:20 -y

echo ===============================================
echo install nodejs
echo ===============================================
dnf install nodejs -y

echo ===============================================
echo application user
echo ===============================================
useradd roboshop

echo ===============================================
echo copy catalogue system config file
echo ===============================================
cp catalogue.service /etc/systemd/system/catalogue.service

echo ===============================================
echo copy mongo client config file
echo ===============================================
cp mongo.repo /etc/yum.repos.d/mongo.repo

echo ===============================================
echo create application directory
echo ===============================================
mkdir /app

echo ===============================================
echo Download application content
echo ===============================================
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue-v3.zip
cd /app

echo ===============================================
echo unzip application
echo ===============================================
unzip /tmp/catalogue.zip

cd /app

echo ===============================================
echo install node js dependencies
echo ===============================================
npm install

echo ===============================================
echo install mongoclient
echo ===============================================
dnf install mongodb-mongosh -y

echo ===============================================
echo Load schema
echo ===============================================
mongosh --host mongodb-dev.rdevopsb87.online </app/db/master-data.js

echo ===============================================
echo restart catalogue services
echo ===============================================
systemctl enable catalogue
systemctl restart catalogue