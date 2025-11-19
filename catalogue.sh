echo \\e[35m===============================================\\e[0m
echo Disable nodejs default version
echo \\e[35m===============================================\\e[0m
dnf module disable nodejs -y

echo \\e[35m===============================================\\e[0m
echo Enable nodejs 20 version
echo \\e[35m===============================================\\e[0m
dnf module enable nodejs:20 -y

echo \\e[35m===============================================\\e[0m
echo install nodejs
echo \\e[35m===============================================\\e[0m
dnf install nodejs -y

echo \\e[35m===============================================\\e[0m
echo application user
echo \\e[35m===============================================\\e[0m
useradd roboshop

echo \\e[35m===============================================\\e[0m
echo copy catalogue system config file
echo \\e[35m===============================================\\e[0m
cp catalogue.service /etc/systemd/system/catalogue.service

echo \\e[35m===============================================\\e[0m
echo copy mongo client config file
echo \\e[35m===============================================\\e[0m
cp mongo.repo /etc/yum.repos.d/mongo.repo

echo \\e[35m===============================================\\e[0m
echo create application directory
echo \\e[35m===============================================\\e[0m
mkdir /app

echo \\e[35m===============================================\\e[0m
echo Download application content
echo \\e[35m===============================================\\e[0m
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue-v3.zip
cd /app

echo \\e[35m===============================================\\e[0m
echo unzip application
echo \\e[35m===============================================\\e[0m
unzip /tmp/catalogue.zip

cd /app

echo \\e[35m===============================================\\e[0m
echo install node js dependencies
echo \\e[35m===============================================\\e[0m
npm install

echo \\e[35m===============================================\\e[0m
echo install mongoclient
echo \\e[35m===============================================\\e[0m
dnf install mongodb-mongosh -y

echo \\e[35m===============================================\\e[0m
echo Load schema
echo \\e[35m===============================================\\e[0m
mongosh --host mongodb-dev.rdevopsb87.online </app/db/master-data.js

echo \\e[35m===============================================\\e[0m
echo restart catalogue services
echo \\e[35m===============================================\\e[0m
systemctl enable catalogue
systemctl restart catalogue