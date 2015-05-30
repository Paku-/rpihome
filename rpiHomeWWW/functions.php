<?php
function checkQueryResult($q_result) {
	if (! $q_result) {
		$message = '<pre>Invalid query: ' . $db->error . '</pre>';
		$message .= '<pre>Whole query: ' . $query . '</pre>';
		die ( $message );
	}
}