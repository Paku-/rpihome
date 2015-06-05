<?php
include ('../db.php');
include ('../functions.php');
// require_once ('set_config_vars.php');

$hours = $_GET ['hours'];

// by default show last 24h
if (! is_numeric ( $hours )) {
	$hours = 24;
}

// get temp sensor data
// $query = "SELECT time,data FROM log WHERE severity=3 AND time>CURDATE()- INTERVAL 1 DAY;";
$query = "SELECT time,message FROM log WHERE action=3 AND source LIKE 'TEMP_28%' AND time>NOW()- INTERVAL :hours HOUR;";

$query = "SELECT l1.time as l1time,l1.message as l1mess, l2.message as l2mess, l1.id as l1id, l2.id as l2id
FROM log l1 JOIN log l2 ON l1.source LIKE 'TEMP_10%' AND l2.source LIKE 'TEMP_28%'
AND l2.id = l1.id + 1 AND ABS(TIMESTAMPDIFF(SECOND,l2.time, l1.time)) < 10 AND l1.time>NOW()- INTERVAL :hours HOUR;";

// FROM log l1 JOIN log l2 ON l1.source LIKE 'TEMP_10%' AND l2.source LIKE 'TEMP_28%'
//FROM log l1 JOIN log l2 ON l1.action=3 AND l2.action=3

// Execute query
$qry_result = $db->prepare ( $query );
$qry_result->execute ( array (
		':hours' => $hours 
) );

checkQueryResult ( $qry_result );

// get data and store in a json array
while ( $row = $qry_result->fetch ( PDO::FETCH_ASSOC ) ) {
	$sensor [] = array (
			'Time' => $row ['l1time'],
			// divide by 1000 for true centigrade temp. scale
			'Sensor1' => $row ['l1mess'] / 1000,
			'Sensor2' => $row ['l2mess'] / 1000
			//,
			//'ID1' => $row ['l1id'] ,
			//'ID22' => $row ['l2id'] 
	);
}

echo json_encode ( $sensor );