<?php

include('../db.php');
//require_once ('set_config_vars.php');

//get temp sensor data
$query = "SELECT time,data FROM log WHERE severity=3";

// Execute query
$qry_result = $db->prepare ( $query );
$qry_result->execute ( );

if (! $qry_result) {
	$message = '<pre>Invalid query: ' . $db->error . '</pre>';
	$message .= '<pre>Whole query: ' . $query . '</pre>';
	die ( $message );
}

// get data and store in a json array
while ( $row = $qry_result->fetch ( PDO::FETCH_ASSOC ) ) {	
	$sensor[] = array(
			'Time' => $row['time'],
			//divide by 1000 for true centigrade temp. scale
			'Temp' => $row['data']/1000
	);
}

echo json_encode($sensor);