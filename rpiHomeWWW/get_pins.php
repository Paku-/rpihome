<?php
require_once ('set_config_vars.php');

// Set up calling params.
$column_whitelist = array (
		'ID',
		'Dir',
		'BCM',
		'WPi',
		'Name',
		'State',
		'Enabled' 
);

$id = isset ( $_GET ['id'] ) && is_numeric ( $_GET ['id'] ) ? $_GET ['id'] : 0;
$sort = isset ( $_GET ['sort'] ) && in_array ( $_GET ['sort'], $column_whitelist ) ? $_GET ['sort'] : 'BCM';
$field = isset ( $_GET ['field'] ) && in_array ( $_GET ['field'], $column_whitelist ) ? $_GET ['field'] : 'none';

$query_update = "";

try {
	// Update state and enabled fields as needed.
	
	if ($id > 0) {
		$query_update = "UPDATE pinState SET $field = NOT $field WHERE ID=:id";
		$qry_result = $db->prepare ( $query_update );
		$qry_result->bindParam ( ':id', $id, PDO::PARAM_INT );
		$qry_result->execute ();
		checkQueryResult($qry_result);
		
	}
	
	// Select rows
	$query = "SELECT * FROM pinState WHERE ID > 0";
	if ($showDisabledPins == 0) {
		$query .= " AND Enabled = 1";
	}
	$query .= " ORDER BY $sort ASC";
	
	$qry_result = $db->prepare ( $query );
	$qry_result->execute ();
	checkQueryResult($qry_result);
	
	// Refresh using current sort order.
	print "<a href=\"#\" onclick=\"showPins('" . urlencode ( $sort ) . "')\">Refresh</a>";
	
	// Build Result String.
	// Important %2B0 is url encoded "+0" string passed to mySQL to force numerical varchars to be sorted as true numbers.
	$display_string = "<table class=\"pins\">";
	$display_string .= "<tr>";
	
	if ($debugMode) {
		$display_string .= "<th><a href=\"#\" onclick=\"showPins('ID',0,'none')\">ID</a></th>";
		$display_string .= "<th><a href=\"#\" onclick=\"showPins('Dir',0,'none')\">Output</a></th>";
	}
	
	$display_string .= "<th><a href=\"#\" onclick=\"showPins('BCM',0,'none')\">BCM#</a></th>";
	$display_string .= "<th><a href=\"#\" onclick=\"showPins('WPi',0,'none')\">WPi#</a></th>";
	$display_string .= "<th><a href=\"#\" onclick=\"showPins('Name',0,'none')\">Name</a></th>";
	
	$display_string .= "<th><a href=\"#\" onclick=\"showPins('State',0,'none')\">State</a></th>";
	$display_string .= "<th><a href=\"#\" onclick=\"showPins('Enabled',0,'none')\">Enabled</a></th>";
	$display_string .= "</tr>";
	
	while ( $row = $qry_result->fetch ( PDO::FETCH_ASSOC ) ) {
		$display_string .= "<tr>";
		
		if ($debugMode) {
			$display_string .= "<td>" . $row ['ID'] . "</td>";
			$display_string .= "<td>" . $row ['Output'] . "</td>";
		}
		
		$display_string .= "<td>" . $row ['BCM'] . "</td>";
		$display_string .= "<td>" . $row ['WPi'] . "</td>";
		$display_string .= "<td>" . $row ['Name'] . "</td>";
		
		// On/Off.
		if ($row ['Enabled'] == 1) {
			$display_string .= "<td><a href=\"#\" onclick=\"showPins('" . urlencode ( $sort ) . "'," . $row ['ID'] . ",'State'" . ")\">";
			$display_string .= $row ['State'] ? "<img src=\"$on\" />" : "<img src=\"$off\" />";
			$display_string .= "</a></td>";
		} else {
			$display_string .= "<td>";
			$display_string .= $row ['State'] ? "<img src=\"$on_disabled\" />" : "<img src=\"$off_disabled\" />";
			$display_string .= "</td>";
		}
		
		// Enabled.
		$display_string .= "<td><a href=\"#\" onclick=\"showPins('" . urlencode ( $sort ) . "'," . $row ['ID'] . ",'Enabled'" . ")\">";
		$display_string .= $row ['Enabled'] ? "<img src=\"$on\" />" : "<img src=\"$off\" />";
		$display_string .= "</a></td>";
		$display_string .= "</tr>";
	}
	$display_string .= "</table>";
	
	print $display_string;
	
	if ($debugMode) {
		// Debug output.
		print '<pre>' . $sort . ' ' . $id . ' ' . $field . '</pre>';
		print '<pre>' . $query . '</pre>';
		print '<pre>' . $query_update . '</pre>';
	}
} catch ( Exception $e ) {
	print '<pre>' . 'Exception -> ';
	var_dump ( $e->getMessage () );
	print '</pre>';
}
?>
