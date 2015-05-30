<?php
// Enter Database connection details below, OR
// leave these lines default and run setup.py.
// eg; python setup.py OR ./setup.py
$db_Host = 'localhost'; // Enter your db Server address here.
$db_User = 'user'; // Enter your db Username here.
$db_Password = 'pass'; // Enter your db Password here.
$db_DataBase = 'rpihome'; // Enter your db Database here.

try {
	
	if ($db_Host == '' || $db_User == '' || $db_Password == '' || $db_DataBase == '') {
		die ( "Configure Database data" );
	}
	
	// MySQL Database
	$db = new PDO ( "mysql:host=$db_Host;dbname=$db_DataBase", $db_User, $db_Password );
	
	// SQLite Database
	// $db = new PDO ( "sqlite:./database.db" );
	
	$db->setAttribute ( PDO::ATTR_ERRMODE, PDO::ERRMODE_WARNING );
	// $db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
	// $db->setAttribute(PDO::ATTR_EMULATE_PREPARES, false);
} catch ( PDOException $e ) {
	echo $e->getMessage ();
}

?>
