<?php

//open DB
require_once ('db.php');
require_once ('functions.php');

// Raspberry Pi board revision.
$pi_rev = '3'; // Enter your Raspberry Pi revision number here.
               
// set global icons set
               
// Set up state icons.
$on = 'images/green.png';
$off = 'images/red.png';

$on_disabled = 'images/green_disabled.png';
$off_disabled = 'images/red_disabled.png';

// Get config setting
$queryConfig = 'SELECT * FROM config WHERE configVersion = 1';

$qry_resultConfig = $db->prepare ( $queryConfig );
$qry_resultConfig->execute ();

if (! $qry_resultConfig) {
	$message = '<pre>Invalid query: ' . $db->error . '</pre>';
	$message .= '<pre>Whole query: ' . $queryConfig . '</pre>';
	die ( $message );
}

$rowConfig = $qry_resultConfig->fetch ( PDO::FETCH_ASSOC );

// set app wide config variables
$debugMode = $rowConfig ['debugMode'];
$showDisabledPins = $rowConfig ['showDisabledPins'];
$boardRev = $rowConfig ['boardRev'];

if ($debugMode) {
	print '<pre>System Wide Config Variables: </pre>';
	print '<pre>';
	print 'debugMode: ' . $debugMode . '<br />';
	print 'showDisabledPins: ' . $showDisabledPins . '<br />';
	print '</pre>';
}





