![alt tag](https://travis-ci.org/Paku-/rpihome.svg?branch=master)
#RaspberryPi  based Remote Control System for home appliances.

This code goal is to build a platform to control home equipment by the remote access (like web, mobile/sms or network scripts), as well as the every house real-world data collecting  (like temperature, humidity, wind speed, luminance or IR security sensors).

Current implementation (v0.1) cover following functionalities:

* Control over the relays module using the web GUI - this allow appliances to be controlled using the web browser.
* Temperature collector - DS1820 chip based sensor delivers the temperature history for the location.
* Charts for temperature visualization.

![alt tag](https://raw.github.com/Paku-/rpihome/master/docs/screenshots/relays.jpg)

![alt tag](https://raw.github.com/Paku-/rpihome/master/docs/screenshots/chart.jpg)

![alt tag](https://raw.github.com/Paku-/rpihome/master/docs/screenshots/log.jpg)

##Hardware
* RPi board
* RPi compatible Relays board.
* DS1820 (1Wire) temperature sensor.

External hardware connections are extremely easy as you may see on the pictures below.

![alt tag](https://raw.github.com/Paku-/rpihome/master/docs/screenshots/kit.jpg)

![alt tag](https://raw.github.com/Paku-/rpihome/master/docs/screenshots/module.jpg)

![alt tag](https://raw.github.com/Paku-/rpihome/master/docs/screenshots/temp.jpg)


##Software
Software platform consist of two main parts - the web server and a command line tool (board controller). SMS control module is a next developing step.

#Installation
To make rpihome running you have to install ( and configure) some software, build the rpiHomeApp application from sources and copy the web part of platform the root folder of your web server.

Below you will find required modules installation instructions, but start from updating your current software by:
```
sudo apt-get update
sudo apt-get upgrade
```
##Web server
You may use any web server suitable for PHP applications, like Apache or lighttpd (tested). PHP5 support including PDO DB abstraction layer has to be installed as well.
```
sudo apt-get install php5 php5-mysql php-pdo lighttpd
```
Configure modules given above then test if your web server is running by coping the 'index.php' file into web server root folder.
You will find the file inside the following repository location: 
```
rpihome/rpiHomeWWW/webPHPtest/index.php
```

Change the links IP address inside the file first, then point your browser there.
Detailed information on your web server installation is what you want to see.

##Database
mySQL server is used as the DB backend. 

```
sudo apt-get install mysql-server
```
Configure and remember your mySQL server root user name and password!

Once server is running populate the 'rpihome' named database using rpihome.sql file found here:
```
rpihome/rpiHomeWWW/db/rpihome.sql
```
You can do it using command like this:
```
mysql -u root -p < rpihome.sql
```

##Check it all!

At this point you should be able to browse rpihome web interface after coping content of the repository folder
```
rpihome/rpiHomeWWW
```
into the web server folder of your choice.

But have in mind to change the mySQL login details inside the file named 'db.php' first
```
rpihome/rpiHomeWWW/db.php
```
Lines to be configured:
```
// Enter Database connection details below:
$db_Host = 'localhost'; 
$db_User = 'user'; 
$db_Password = 'pass'; 
$db_DataBase = 'rpihome'; 
```

##Build the rpiHomeApp command line tool

###What is the rpiHomeApp

rpiHomeApp tool is responsible for data collecting and then spowing the appropiete actions.
It's designed as one pass tool. It means you have to run it each time you want it to manage system state.
This way it's very open so you may call it from cron, a web server, other script or any other tool able to run system commands.

Here is the cron example as it's seems to be the easiest way to go.

Start from editing the root crontab
```
sudo crontab -e
```
and put lines as below to call rpiHomeApp every 15 seconds.
```
* * * * * /home/pi/rpiHomeApp -l -t >> /var/log/rpiHomeApp.log 2>&1
* * * * * sleep 15 ; /home/pi//rpiHomeApp -l >> /var/log/rpiHomeApp.log 2>&1
* * * * * sleep 30 ; /home/pi/rpiHomeApp -l >> /var/log/rpiHomeApp.log 2>&1
* * * * * sleep 45 ; /home/pi/rpiHomeApp -l >> /var/log/rpiHomeApp.log 2>&1
```

Have in mind we asked rpiHomeApp to mesure the temperature once per minute only here, while relays state will be checked out every 15 seconds.

ok, but first you have to build it ...

### rpiHomeApp build procedure.

rpiHomeApp code is a C++ application build with some external libraries like:

* wiringPi
* boost
* mySqlCPPConnector

Code build process is tested using Travis CI. 
So my advice is to look inside the 
````
.travis.yml 
````
file in the main folder. You will find all (step by step) commands to build rpiHomeApp there.

Just a summary:
````
# we need g++ 4.7.2 at least 
sudo apt-get install gcc-4.8 g++-4.8 -qq

#install wiring Pi library
git clone git://git.drogon.net/wiringPi
cd wiringPi
./build
cd ..

#install boost,mySqlConnector libs  
sudo apt-get install libboost-program-options-dev libboost-dev libmysqlcppconn-dev -qq

#actually build rpiHomeApp
cd rpiHomeApp
mkdir build
cd build

#ask cmake to use the proper compiler
CC=gcc-4.8 CXX=g++-4.8 cmake ..
make

#test it's running
./rpiHomeApp -h
````

You should be done with your rpiHome instalation at this point.

