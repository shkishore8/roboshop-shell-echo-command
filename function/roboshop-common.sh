nodejs() {

   echo -e \\e[35mDisable default NodeJs \\e[0m
  dnf module disable nodejs -y

  echo -e \\e[35mEnable nodeJS\\e[0m
  dnf module enable nodejs:20 -y

  echo -e \\e[35mInstall nodeJS\\e[0m
  dnf install nodejs -y

  echo -e \\e[35mAdd roboshop user\\e[0m
  useradd roboshop

  echo -e \\e[35mCopy nodejs config file\\e[0m
  cp ${component}.service /etc/systemd/system/${component}.service

  echo -e \\e[35m copy mongodb repository\\e[0m
  cp mongo.repo /etc/yum.repos.d/mongo.repo
  rm -fr /app
  mkdir /app

 echo -e \\e[35eDownload catalogue source code\\e[0m
  curl -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}-v3.zip
  cd /app

  echo \\e[35mUnzip catalogue source file\\e[0m
  unzip /tmp/${component}.zip

 echo -e \\e[35m install NodeJS dependencies\\e[0m
  cd /app
  npm install

 echo -e \\e[35 Install mongodb DB\\e[0m
  dnf install mongodb-mongosh -y
  echo -e \\e[35mAdd mongodb schema\\[0m
  mongosh --host 172.31.65.47 </app/db/master-data.js


  systemctl daemon-reload
 echo -e \\e[35mstart catalogue services\\e[0m
  systemctl enable ${component}
  systemctl restart ${component}
}