nodejs() {

  dnf module disable nodejs -y
  dnf module enable nodejs:20 -y

  dnf install nodejs -y

  useradd roboshop

  cp catalogue.service /etc/systemd/system/catalogue.service
  cp mongo.repo /etc/yum.repos.d/mongo.repo
  rm -fr /app
  mkdir /app

  curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue-v3.zip
  cd /app
  unzip /tmp/catalogue.zip

  cd /app
  npm install

  dnf install mongodb-mongosh -y
  mongosh --host 172.31.65.47 </app/db/master-data.js


  systemctl daemon-reload

  systemctl enable catalogue
  systemctl restart catalogue
}