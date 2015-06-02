//common ajaxRequest variable creation.
function getAjaxRequest() {

	var ajaxRequest;

	try {
		// most new browsers
		ajaxRequest = new XMLHttpRequest();
	} catch (e) {
		// older Internet Explorer Browsers
		try {
			ajaxRequest = new ActiveXObject("Msxml2.XMLHTTP");
		} catch (e) {
			try {
				ajaxRequest = new ActiveXObject("Microsoft.XMLHTTP");
			} catch (e) {
				// Something went wrong
				alert("Your browser does not support javascipt or something went wrong !!!");
				return false;
			}
		}
	}
	return ajaxRequest;
}

// Paku - change the main section content
function changeSection(secID) {

	var ajaxRequest = getAjaxRequest();

	// Create a function that will receive data sent from the server
	ajaxRequest.onreadystatechange = function() {
		if (ajaxRequest.readyState == 4) {
			var ajaxDisplay = document.getElementById('section');
			ajaxDisplay.innerHTML = ajaxRequest.responseText;
		}
	};

	switch (secID) {
	case 1:
		query = "pins.php?sort=BCM";
		break;
	case 2:
		query = "log.php?id1=0&id2=99999";
		break;
	case 3:
		query = "config.php?";
		break;
	default:
	}

	//debug IE caching state
	//console.log(ajaxRequest.msCaching);

	ajaxRequest.open("GET", query + random_mark(), true);
	ajaxRequest.send(null);

}


// Paku - change the log table content
function showLog() {
	var ajaxRequest = getAjaxRequest();

	ajaxRequest.onreadystatechange = function() {
		if (ajaxRequest.readyState == 4) {
			var ajaxDisplay = document.getElementById('section');
			ajaxDisplay.innerHTML = ajaxRequest.responseText;
		}
	};
	
	var id1 = document.getElementById('id1').value;
	var id2 = document.getElementById('id2').value;
	
	var queryString = "?id1=" + id1 + "&id2=" + id2;
	
	ajaxRequest.open("GET", "log.php" + queryString+random_mark(), true);
	ajaxRequest.send(null);
}


// Paku - change the PINs' table content
function showPins(sort, pinID, field) {
	var ajaxRequest = getAjaxRequest();

	// Create a function that will receive data sent from the server
	ajaxRequest.onreadystatechange = function() {
		if (ajaxRequest.readyState == 4) {
			var ajaxDisplay = document.getElementById('section');
			ajaxDisplay.innerHTML = ajaxRequest.responseText;
		}
	};
	var queryString = "?sort=" + sort + "&id=" + pinID + "&field=" + field;
	
	ajaxRequest.open("GET", "pins.php" + queryString+random_mark(), true);
	ajaxRequest.send(null);
}


// Paku - fill in config page
function showConfig(updateConfig, debugMode, showDisabledPins) {
	var ajaxRequest = getAjaxRequest();

	// Create a function that will receive data sent from the server
	ajaxRequest.onreadystatechange = function() {
		if (ajaxRequest.readyState == 4) {
			var ajaxDisplay = document.getElementById('section');
			ajaxDisplay.innerHTML = ajaxRequest.responseText;
		}
	};

	var queryString = "?updateConfig=" + updateConfig + "&debugMode="
			+ debugMode + "&showDisabledPins=" + showDisabledPins;
	
	ajaxRequest.open("GET", "config.php" + queryString+random_mark(), true);
	ajaxRequest.send(null);
}


/*
 * other utility functions
 */

//IE local caching disabled
function random_mark(){
	return "&ticker=" + Math.random();
}


