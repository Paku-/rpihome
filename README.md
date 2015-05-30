#RaspberryPi  based Remote Control System for home appliances

The goal of this code is to build a platform to control home equipment by the remote (like web or mobile/sms) access.

Current implementation (v0.1) cover following functionalities:
* Control over the relays module using the web GUI - this allow appliances to be controlled using the web browser.
* Temperature collector - DS1820 chip based sensor delivers the temperature history for the location.
* Charts - sensors (like temperature, humidity or RPi input ports state) data visualization using charts.

Here are some pics.
![alt tag](https://raw.github.com/Paku-/rpihome/master/screenshots/relays.jpg)
![alt tag](https://raw.github.com/Paku-/rpihome/master/screenshots/chart.jpg)
![alt tag](https://raw.github.com/Paku-/rpihome/master/screenshots/log.jpg)

##Hardware
* RPi board
* RPi compatible Relays board.
* DS1820 temperature sensor.

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
You may use any web server suitable for PHP applications, like Apache or lighttpd (tested). PHP5 support has to be installed as well.
```
sudo apt-get install php5 php5-mysql lighttpd
```
Test if your web server is running by coping the 'index.php' file into web server root folder
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

#to be continued .... shortly.

But in very short words:

install libraries:

```
sudo apt-get install  libboost-program-options-dev
sudo apt-get install  libboost-dev
sudo apt-get install  libmysqlcppconn-dev
```

copy rpihome/rpiHomeApp somewhere

create and enter build folder
```
mkdir myBuild
cd myBuild
```
Call cmake to configure source code, then make it.

```
cmake .. ; make
```
for help call
```
rpiHomeApp -h
```

Use CRON to call it 
```
sudo crontab -e
```
(every 15 seconds example)
```
* * * * * /home/pi/rpiHomeApp -l -t >> /var/log/rpiHomeApp.log 2>&1
* * * * * sleep 15 ; /home/pi//rpiHomeApp -l >> /var/log/rpiHomeApp.log 2>&1
* * * * * sleep 30 ; /home/pi/rpiHomeApp -l >> /var/log/rpiHomeApp.log 2>&1
* * * * * sleep 45 ; /home/pi/rpiHomeApp -l >> /var/log/rpiHomeApp.log 2>&1
```






