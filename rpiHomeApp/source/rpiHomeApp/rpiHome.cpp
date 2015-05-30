#include "rpiHome.h"

using namespace std;

rpiHome::rpiHome() {

	//unknown board
	boardRevision = -1;

	sql_server = new char;
	sql_user = new char;
	sql_password = new char;
	sql_database = new char;

	driver = NULL;
	con = NULL;

	return;
}

rpiHome::~rpiHome() {

	delete sql_server;
	delete sql_user;
	delete sql_password;
	delete sql_database;

	delete con;

}

rpiHome::rpiHome(const char* server, const char* user, const char* password, const char* database) {

	rpiHome();

	init(server, user, password, database);

	return;
}

int rpiHome::init(const char* server, const char* user, const char* password, const char* database) {

	//setup wiringPi API for Physical PINs numbering
	wiringPiSetupPhys();
	boardRevision = piBoardRev();

	//connect mySQL DB
	sql_server = server;
	sql_user = user;
	sql_password = password;
	sql_database = database;

	try {

		/* Connect to the MySQL test database */
		driver = get_driver_instance();
		con = driver->connect(sql_server, sql_user, sql_password);
		con->setSchema(sql_database);

		//store current board Revision to the DB.
		storeBoardRevision();

		//set Pins in/out mode on init ONLY - but after the DB is ready
		setOutputMode();

	} catch (sql::SQLException &e) {
		sqlException(e);
		return EXIT_FAILURE;
	}

	return EXIT_SUCCESS;
}

int rpiHome::getBoardRevision() {
	return boardRevision;
}

int rpiHome::storeBoardRevision() {


	sql::PreparedStatement  *prep_stmt;

	prep_stmt = con->prepareStatement("UPDATE config SET boardRev = ? WHERE configVersion = 1;");

	prep_stmt->setInt(1, getBoardRevision());
	prep_stmt->execute();

	delete prep_stmt;


/*
 * std statment version

	sql::Statement *stmt;

	sql::SQLString query = "Update config set boardRev = " + boost::lexical_cast<std::string>(getBoardRevision()) + ";";

	stmt = con->createStatement();
	stmt->execute(query);

	delete stmt;

*/

	if (args.verbose) {
		cout << "Board Revision set to: ";
		cout << getBoardRevision() << endl;
	}


	return EXIT_SUCCESS;

}

int rpiHome::checkPin(int pinNo) {
	return EXIT_SUCCESS;
}

int rpiHome::setOutputPins() {

	sql::Statement *stmt;
	sql::ResultSet *res;

	// changed PINs temporary store, PINNo,PINNewState integer pairs as int vector.
	std::queue<std::vector<int>> changedPINs;

	std::vector<int> tempPIN;

	stmt = con->createStatement();
	res = stmt->executeQuery("Select ID,Name,Enabled,Output,State from pinState where Output and Enabled;");

	if (args.verbose) {
		cout << "State set to: " << endl;
	}

	while (res->next()) {

		if (args.verbose) {

			cout << res->getString("ID") << "\t" << res->getString("Name") << "\t\t" << res->getString("Enabled") << "\t" << res->getString("Output") << "\t" << res->getString("State");

			if (atoi(res->getString("State").c_str())) {
				cout << "\t" << "ON";

			} else {
				cout << "\t" << "OFF";
			}

			cout << endl;
		}

		// store changed PINs
		if (digitalRead(atoi(res->getString("ID").c_str())) != atoi(res->getString("State").c_str())) {
			changedPINs.push(std::vector<int> { atoi(res->getString("ID").c_str()), atoi(res->getString("State").c_str()) });
		}

	}

	delete res;
	delete stmt;

	//change PINs DB.state and log it.
	while (!changedPINs.empty()) {
		tempPIN = changedPINs.front();
		changedPINs.pop();
		digitalWrite(tempPIN[0], tempPIN[1] ? HIGH : LOW);
		log(SEVERITY_LOW, str(boost::format("PIN %1% %2%") % physPinToGpio(tempPIN[0]) % (tempPIN[1] ? "ON" : "OFF")));

	}

	return EXIT_SUCCESS;
}

int rpiHome::setOutputMode() {

	sql::Statement *stmt;
	sql::ResultSet *res;

	stmt = con->createStatement();
	res = stmt->executeQuery("Select ID,Name,Enabled,Output from pinState where Enabled;");

	if (args.verbose) {
		cout << "Output mode for Enabled PINs set to: " << endl;
	}

	while (res->next()) {

		if (args.verbose) {

			cout << res->getString("ID") << "\t" << res->getString("Name") << "\t";

			if (atoi(res->getString("Output").c_str())) {
				cout << "OUT";
			} else {
				cout << "IN";
			}

			cout << endl;

		}

		// set Pins mode as in DB
		pinMode(atoi(res->getString("ID").c_str()), atoi(res->getString("Output").c_str()) ? OUTPUT : INPUT);

	}

	delete res;
	delete stmt;

	return EXIT_SUCCESS;

}

int rpiHome::checkPins() {
	return EXIT_SUCCESS;
}

void rpiHome::store_args(args_s new_args) {
	this->args = new_args;

}

int rpiHome::getTemps() {

// sensor file format for DS1820 sensor
//2e 00 44 53 ff ff 0e 10 1b : crc=1b YES
//2e 00 44 53 ff ff 0e 10 1b t=22875

	if (args.termo) {

		//sensor file name goes here !!!
		std::ifstream sensor(TEMP_SENSOR_FILE);
		std::stringstream buffer;

		buffer << sensor.rdbuf();

		std::string str = buffer.str();
		boost::trim(str);

		std::vector<std::string> strs;
		boost::split(strs, str, boost::is_any_of("="));

		/*
		 * debug output - last
		 for (auto &i : strs) {
		 std::cout << "<" << i << "> " << std::endl;
		 }
		 */

		/*
		 * same but using tokenizer
		 *
		 typedef boost::tokenizer<boost::char_separator<char> > tokenizer;

		 boost::char_separator<char> sep("=");
		 tokenizer tokens(str, sep);

		 std::cout << "Temps ON" << endl;

		 for (tokenizer::iterator tok_iter = tokens.begin(); tok_iter != tokens.end(); ++tok_iter)
		 std::cout << "<" << *tok_iter << "> ";
		 std::cout << "\n";
		 */

		//put last element into log table as it's a temperature from the sensor.
		log(SEVERITY_TEMP, strs.back());

		if (args.verbose) {
			std::cout << "Temp: " << strs.back() << endl;
		}

	}

	return EXIT_SUCCESS;
}

int rpiHome::log(int severity, const string &message) {

	//force DB logging for any severity above HIGH - like temp sensor data...
	if (args.logger || severity > SEVERITY_HIGH) {


		sql::PreparedStatement  *prep_stmt;

		prep_stmt = con->prepareStatement("INSERT INTO log (severity,data)  VALUES (?, ?)");

		prep_stmt->setInt(1, severity);
		prep_stmt->setString(2, message);
		prep_stmt->execute();

		delete prep_stmt;

	}

	return EXIT_SUCCESS;

	//using normal stmt.
	//sql::SQLString insertQuery = "insert into log (severity,data) values ('" + boost::lexical_cast<std::string>(severity) + "','" + message + "');";
	//sql::Statement *stmt;
	//stmt = con->createStatement();
	//stmt->execute(insertQuery);
	//delete stmt;



}

void rpiHome::sqlException(sql::SQLException &e) {

	cout << "# ERR: SQLException in " << __FILE__;
	cout << " (" << __FUNCTION__ << ") on line " << __LINE__ << endl;
	cout << "# ERR: " << e.what();
	cout << " (MySQL error code: " << e.getErrorCode();
	cout << ", SQLState: " << e.getSQLState() << " )" << endl;

	return;

}

