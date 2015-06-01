<?php
header( 'Expires: Sat, 26 Jul 1997 05:00:00 GMT' );
header( 'Last-Modified: ' . gmdate( 'D, d M Y H:i:s' ) . ' GMT' );
header( 'Cache-Control: no-store, no-cache, must-revalidate' );
header( 'Cache-Control: post-check=0, pre-check=0', false );
header( 'Pragma: no-cache' ); 

require_once 'set_config_vars.php';

?>
<!DOCTYPE html>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html;charset=ISO-8859-1" >
<title>RPiHome</title>
<link rel="stylesheet" type="text/css" href="./styles/rpihome.css">

<script type="text/javascript" src="./js/scripts.js"></script>

<body>


	<div id="header">
		<h1>RPiHome</h1>
	</div>
	<div id="nav">

		<ul class="nav">
			<li class="nav"><a href="#" onclick="changeSection(1)">PINs</a></li>
			<li class="nav"><a href="#" onclick="changeSection(2)">Log</a></li>
			<li class="nav"><a href="#" onclick="changeSection(3)">Config</a></li>
			<li class="nav"><a href="./charts/chart_temp.php">Charts</a></li>			
		</ul>

	</div>
	<div id="section">
		<?php //include 'get_status.php'; ?>	
	</div>
</body>
</html>
