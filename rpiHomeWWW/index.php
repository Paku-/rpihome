<?php
header("Cache-Control: max-age=0,no-cache,no-store,post-check=0,pre-check=0, must-revalidate"); // HTTP/1.1
header("Expires: Sat, 26 Jul 2014 05:00:00 GMT"); // Date in the past

require_once 'set_config_vars.php';

?>
<!DOCTYPE html>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html;charset=ISO-8859-1" >
<title>RPiHome</title>
<link rel="stylesheet" type="text/css" href="./styles/rpihome.css">


<body>
	<script type="text/javascript" src="./js/scripts.js"></script>

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
