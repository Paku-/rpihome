<?php
require_once ('set_config_vars.php');

$id1 = $_GET ['id1'];
$id2 = $_GET ['id2'];

// build query
$query = 'SELECT * FROM log WHERE id > 0 ';
if (is_numeric ( $id1 )) {
	$query .= ' AND id >= :id1';
}
if (is_numeric ( $id2 )) {
	$query .= ' AND id <= :id2';
}
$query .= ' ORDER BY time DESC, id DESC';

// Execute query
$qry_result = $db->prepare ( $query );
$qry_result->execute ( array (
		':id1' => $id1,
		':id2' => $id2 
) );
if (! $qry_result) {
	$message = '<pre>Invalid query: ' . $db->error . '</pre>';
	$message .= '<pre>Whole query: ' . $query . '</pre>';
	die ( $message );
}

print "<a href=\"#\" onclick=\"showLog()\">Refresh</a>";

print "<form name=\"Ranges\">ID Range: ";
print "<input type=\"text\" id=\"id1\" value=\"" . $id1 . "\"onchange=\"showLog()\" size=\"5\" />";
print "<input type=\"text\" id=\"id2\" value=\"" . $id2 . "\"onchange=\"showLog()\" size=\"5\" /> <br />";

print "</form>";

// Build Result String.
$display_string = "<table class=\"log\">";
$display_string .= "<tr>";
$display_string .= "<th>ID</th>";
$display_string .= "<th>Time</th>";
$display_string .= "<th>Severity</th>";
$display_string .= "<th>Entry</th>";
$display_string .= "</tr>";

// Insert a new row in the table for each result returned.
while ( $row = $qry_result->fetch ( PDO::FETCH_ASSOC ) ) {
	$display_string .= "<tr>";
	$display_string .= "<td>" . $row ['id'] . "</td>";
	$display_string .= "<td>" . $row ['time'] . "</td>";
	$display_string .= "<td>" . $row ['severity'] . "</td>";	
	$display_string .= "<td>" . $row ['data'] . "</td>";
	$display_string .= "</tr>";
}

$display_string .= "</table>";

print $display_string;

if ($rowConfig ['debugMode']) {
	// Debug output.
	print '<pre>Range Set: ' . $id1 . '<->' . $id2 . '</pre>';
	print '<pre>Select: ' . $query . '</pre>';
}
?>
