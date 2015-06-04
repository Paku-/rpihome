<?php

include('../db.php');
include('../functions.php');
//require_once ('set_config_vars.php');

$hours = $_GET ['hours'];

//by default show last 24h
if (!is_numeric ( $hours )) {
	$hours = 24;
}

//get temp sensor data
//$query = "SELECT time,data FROM log WHERE severity=3 AND time>CURDATE()- INTERVAL 1 DAY;";
$query = "SELECT time,message FROM log WHERE action=3 AND source LIKE 'TEMP_28%' AND time>NOW()- INTERVAL :hours HOUR;";


// Execute query
$qry_result = $db->prepare ( $query );
$qry_result->execute ( array (
		':hours' => $hours
));


checkQueryResult($qry_result);

// get data and store in a json array
while ( $row = $qry_result->fetch ( PDO::FETCH_ASSOC ) ) {	
	$sensor[] = array(
			'Time' => $row['time'],
			//divide by 1000 for true centigrade temp. scale
			'Temp' => $row['message']/1000
	);
}

echo json_encode($sensor);