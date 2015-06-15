/*
 * rpiHomeApp.cpp

 *
 *  Created on: 19 sty 2015
 *      Author: paku
 */

#include <boost/program_options.hpp>
namespace po = boost::program_options;

#include "rpiHome.h"

using namespace std;

int get_cmd_line_params(rpiHome* thisRPiHome, int ac, char *av[]) {

	// Declare the supported options.
	po::options_description desc("RPiHome options");
	desc.add_options()("help,h", "this help message")("daemon,d", "run in daemon mode (not implemented)")("logger,l", "log into the DB")("termo,t",
			"read and log temperature (1Wire DS18x20 temperature sensors only)")("verbose,v", "be verbose, enable stdio output messages.");

	po::variables_map vm;

	try {

		po::store(po::parse_command_line(ac, av, desc), vm);

		if (vm.count("help")) {
			cout << TITLE << endl << desc << endl;
			return SUCCESS_HELP_ONLY;
		}

		po::notify(vm);

	}

	catch (po::error& e) {
		cerr << "#STOP#" << endl << "Command line parser error: " << e.what() << endl << endl;
		cerr << desc << endl;
		return ERROR_IN_COMMAND_LINE;
	}

	//thisRPiHome->args.daemon=vm.count("daemon");

	thisRPiHome->args.verbose = vm.count("verbose");
	thisRPiHome->args.termo = vm.count("termo");
	thisRPiHome->args.logger = vm.count("logger");

	//show title in verbose mode
	if (thisRPiHome->args.verbose)
		cout << TITLE << endl;

	return SUCCESS;

}

int main(int argc, char *argv[]) {

	rpiHome* myRPiHome = new rpiHome();

	switch (get_cmd_line_params(myRPiHome, argc, argv)) {
	case SUCCESS:
		break;
	case SUCCESS_HELP_ONLY:
		return EXIT_SUCCESS;
		break;
	case ERROR_IN_COMMAND_LINE:
		return EXIT_FAILURE;
		break;
	case ERROR_UNHANDLED_EXCEPTION:
		return EXIT_FAILURE;
		break;
	default:
		return EXIT_FAILURE;
		break;
	}

	//init main object
	myRPiHome->init(MYSQL_SERVER, DB_USER, DB_PASS, DB_NAME);

	myRPiHome->setOutputPins();

	myRPiHome->getTemps();

	return EXIT_SUCCESS;
}

