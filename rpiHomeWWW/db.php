<?php
// Enter Database connection details below:
$db_Host = 'localhost'; 
$db_User = 'user'; 
$db_Password = 'pass'; 
$db_DataBase = 'rpihome'; 

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
