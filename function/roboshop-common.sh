nodejs() {
 color=\\e[35m
 nocolor=\\e[0m
   echo -e ${color}Disable default NodeJs ${nocolor}
  dnf module disable nodejs -y

  echo -e ${color}Enable nodeJS${nocolor}
  dnf module enable nodejs:20 -y

  echo -e ${color}Install nodeJS${nocolor}
  dnf install nodejs -y

  echo -e ${color}Add roboshop user${nocolor}
  useradd roboshop

  echo -e ${color}Copy nodejs config file${nocolor}
  cp ${component}.service /etc/systemd/system/${component}.service

  echo -e ${color} copy mongodb repository${nocolor}
  cp mongo.repo /etc/yum.repos.d/mongo.repo
  rm -fr /app
  mkdir /app

 echo -e ${color}Download catalogue source code${nocolor}
  curl -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}-v3.zip
  cd /app

  echo ${color}Unzip catalogue source file${nocolor}
  unzip /tmp/${component}.zip

 echo -e ${color}install NodeJS dependencies${nocolor}
  cd /app
  npm install

 echo -e ${color} Install mongodb DB${nocolor}
  dnf install mongodb-mongosh -y
  echo -e ${color}Add mongodb schema\\[0m
  mongosh --host 172.31.65.47 </app/db/master-data.js


  systemctl daemon-reload
 echo -e ${color}start catalogue services${nocolor}
  systemctl enable ${component}
  systemctl restart ${component}
}