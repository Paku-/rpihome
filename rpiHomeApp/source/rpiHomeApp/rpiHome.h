/*
 * rpihome.h
 *
 *  Created on: 19 sty 2015
 *      Author: paku
 */

#ifndef SOURCE_RPIHOME_INCLUDE_RPIHOME_H_
#define SOURCE_RPIHOME_INCLUDE_RPIHOME_H_

#include <string>
#include <iostream>
#include <fstream>
#include <string>
#include <cstdio>
#include <queue>
#include <stdlib.h>

#include <boost/format.hpp>
#include <boost/lexical_cast.hpp>
//#include <boost/tokenizer.hpp>
#include <boost/algorithm/string.hpp>

#include <wiringPi.h>

#include <mysql_connection.h>
#include <cppconn/driver.h>
#include <cppconn/exception.h>
#include <cppconn/resultset.h>
#include <cppconn/statement.h>
#include <cppconn/prepared_statement.h>

/*
 * Define your mySQL DB server details here
 */
#define MYSQL_SERVER "tcp://127.0.0.1:3306"
#define DB_USER "user"
#define DB_PASS "pass"
#define DB_NAME "rpihome"

/*
 * Define your OneWire bus-master files name.
 * Usually you do not have to change this lines!
 */

#define W1_MASTER_FILE 		"/sys/devices/w1_bus_master1/w1_master_slaves"
#define W1_SENSORS_FOLDER 	"/sys/bus/w1/devices/"
#define W1_SENSORS_FILE 	"/w1_slave"

#define CPU_TEMP_FILE 		"/sys/class/thermal/thermal_zone0/temp"

const size_t SUCCESS = 0;
const size_t SUCCESS_HELP_ONLY = 1;
const size_t ERROR_IN_COMMAND_LINE = 2;
const size_t ERROR_UNHANDLED_EXCEPTION = 3;

#define ACTION_MESSAGE_LOW  		0 //source message with severity LOW
#define ACTION_MESSAGE_MID  		1 //source message with severity MID
#define ACTION_MESSAGE_HIGH 		2 //source message with severity HIGH
#define ACTION_TEMP_DATA 			3 //temperature sensor data
#define ACTION_RELAY_ON 			4 //relays action ON
#define ACTION_RELAY_OFF 			5 //relays action OFF

#define SOURCE_SYSTEM  	"SYS"
#define SOURCE_RELAY  	"RELAY"
#define SOURCE_TEMP 	"TEMP"

#define TITLE "rpiHomeApp - RaspberryPi Remote Control For Home Appliances by Paku 2014,2015"

//runtime command line arguments store
struct args_s {

	int daemon;	//run in daemon mode
	int logger; //log into the DB
	int period; //set interval
	int termo;	// read 1w temperature sensors
	int verbose;	// be verbose
};

//main RPiHome class
class rpiHome {

private:

	int boardRevision;
	const char* sql_server;
	const char* sql_user;
	const char* sql_password;
	const char* sql_database;

	sql::Driver *driver;
	sql::Connection *con;

	int checkPin(int pinNo);

public:

	//cmdline args store
	args_s args;

	rpiHome();
	~rpiHome();
	rpiHome(const char* server, const char* user, const char* password, const char* database);

	int init(const char* server, const char* user, const char* password, const char* database);

	int getBoardRevision();

	int storeBoardRevision();

	int setOutputMode();

	int setOutputPins();

	int getTemps();

	int checkPins();

	void store_args(args_s args);

	int log(int action, const std::string &source, const std::string &message);

	void sqlException(sql::SQLException &e);
};

#endif /* SOURCE_RPIHOME_INCLUDE_RPIHOME_H_ */
