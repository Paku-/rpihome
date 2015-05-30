<?php
//exec ( "pgrep x.sh", $pids );

print '<h1>Status:';
if (empty ( $pids )) {
	print ' STOPPED';
} else {
	print ' RUNNING';
}
print ".</h1>";

?>
