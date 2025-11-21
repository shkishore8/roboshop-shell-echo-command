nodejs() {
 color=\\e[35m
 nocolor=\\e[0m
   echo -e colorDisable default NodeJs nocolor
  dnf module disable nodejs -y

  echo -e colorEnable nodeJSnocolor
  dnf module enable nodejs:20 -y

  echo -e colorInstall nodeJSnocolor
  dnf install nodejs -y

  echo -e colorAdd roboshop usernocolor
  useradd roboshop

  echo -e colorCopy nodejs config filenocolor
  cp ${component}.service /etc/systemd/system/${component}.service

  echo -e color copy mongodb repositorynocolor
  cp mongo.repo /etc/yum.repos.d/mongo.repo
  rm -fr /app
  mkdir /app

 echo -e \\e[35eDownload catalogue source codenocolor
  curl -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}-v3.zip
  cd /app

  echo colorUnzip catalogue source filenocolor
  unzip /tmp/${component}.zip

 echo -e colorinstall NodeJS dependenciesnocolor
  cd /app
  npm install

 echo -e \\e[35 Install mongodb DBnocolor
  dnf install mongodb-mongosh -y
  echo -e colorAdd mongodb schema\\[0m
  mongosh --host 172.31.65.47 </app/db/master-data.js


  systemctl daemon-reload
 echo -e colorstart catalogue servicesnocolor
  systemctl enable ${component}
  systemctl restart ${component}
}