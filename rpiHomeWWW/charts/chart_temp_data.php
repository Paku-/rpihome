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
$query = "SELECT time,data FROM log WHERE severity=3 AND time>NOW()- INTERVAL :hours HOUR;";

//$query = "SELECT time,data FROM log WHERE severity=3";

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
			'Temp' => $row['data']/1000
	);
}

echo json_encode($sensor);