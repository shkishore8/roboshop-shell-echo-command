nodejs() {
 color=\\e[35m
 nocolor=\\e[0m

  echo -e ${color}Disable default NodeJs ${nocolor}
  dnf module disable nodejs -y >>/tmp/roboshop.log
 echo status $?

  echo -e ${color}Enable nodeJS${nocolor}
  dnf module enable nodejs:20 -y >>/tmp/roboshop.log
  echo status $?

  echo -e ${color}Install nodeJS${nocolor}
  dnf install nodejs -y >>/tmp/roboshop.log
  echo status $?

  echo -e ${color}Add roboshop user${nocolor}
  useradd roboshop >>/tmp/roboshop.log
   echo status $?

  echo -e ${color}Copy nodejs config file${nocolor}
  cp ${component}.service /etc/systemd/system/${component}.service >>/tmp/roboshop.log
  echo status $?

  echo -e ${color} copy mongodb repository${nocolor}
  cp mongo.repo /etc/yum.repos.d/mongo.repo >>/tmp/roboshop.log
  rm -fr /app
  mkdir /app
  echo status $?

 echo -e ${color}Download catalogue source code${nocolor} >>/tmp/roboshop.log
  curl -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}-v3.zip
  cd /app
 echo status $?

  echo ${color}Unzip catalogue source file${nocolor}
  unzip /tmp/${component}.zip >>/tmp/roboshop.log
 echo status $?

 echo -e ${color}install NodeJS dependencies${nocolor}
  cd /app
  npm install >>/tmp/roboshop.log
 echo status $?

 echo -e ${color} Install mongodb DB${nocolor}
  dnf install mongodb-mongosh -y >>/tmp/roboshop.log
  echo status $?

  echo -e ${color}Add mongodb schema\\[0m
  mongosh --host 172.31.65.47 </app/db/master-data.js
  echo status $?


  systemctl daemon-reload >>/tmp/roboshop.log
 echo -e ${color}start catalogue services${nocolor}
  systemctl enable ${component} >>/tmp/roboshop.log
  systemctl restart ${component} >>/tmp/roboshop.log
  echo status $?
}