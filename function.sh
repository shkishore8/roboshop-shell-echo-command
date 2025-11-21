
#Declaring the function
 sample () {
   echo sample function

 }
  #calling function
 sample
#source common-function
 source comman-function.sh
 sample1

# Access the variable across the function
a=10
source comman-function.sh
sample
echo b -$b
