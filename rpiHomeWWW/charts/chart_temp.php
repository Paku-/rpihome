<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=ISO-8859-1" >

<title>Temperature sensor data chart</title>

<link rel="stylesheet" href="./jqwidgets/styles/jqx.base.css"
	type="text/css" />



<script type="text/javascript" src="./scripts/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="./jqwidgets/jqxcore.js"></script>
<script type="text/javascript" src="./jqwidgets/jqxdata.js"></script>
<script type="text/javascript" src="./jqwidgets/jqxdraw.js"></script>
<script type="text/javascript" src="./jqwidgets/jqxchart.core.js"></script>

<script type="text/javascript">
	$(document).ready(function () {
		var source =
		{
			 datatype: "json",
			 datafields: [
				 { name: 'Time', type: 'date'},
				 { name: 'Temp'}
			],
			url: 'chart_temp_data.php?hours=48'
		};		
		
	   var dataAdapter = new $.jqx.dataAdapter(source,
		{
			autoBind: true,
			async: false,
			downloadComplete: function () { },
			loadComplete: function () { },
			loadError: function () { }
		});
		
		
	 // prepare jqxChart settings
		var settings = {
			title: "rpiHome",
			description: "DS1820 Temperature Sensor",
			enableAnimations:true,
			showLegend: true,
			padding: { left: 10, top: 10, right: 20, bottom: 10 },
			titlePadding: { left: 90, top: 0, right: 0, bottom: 10 },
			source: dataAdapter,
			xAxis:
				{
					//text: 'Category Axis',
					//textRotationAngle: 90,
					dataField: 'Time',
					formatFunction: function (value) {
						return $.jqx.dataFormat.formatdate(value, 'dd/MM/yyyy HH:mm:ss');
					},
					type: 'date',
			        baseUnit: 'hour',
		            valuesOnTicks: true,
		            //minValue: '01-01-2014',
		            //maxValue: '01-01-2016',
                    //minValue: new Date(2014, 0, 1),
                    //maxValue: new Date(2016, 11, 1),		            
		            tickMarks: {
		                  visible: true,
		                  interval: 1,
		                  color: '#BCBCBC'
		            },
		            unitInterval: 2,
		            gridLines: {
		                   visible: false,
		                   interval: 3,
		                   color: '#BCBCBC'
		            },
		            labels: {
		                  angle: -90,
		                  rotationPoint: 'topright',
		                  offset: { x: 0, y: -60 }
		            }						
						
				},
              valueAxis:
                {
                    visible: true,
                    title: { text: 'Temperature [°C]' },
                    tickMarks: { color: '#BCBCBC' }
                },				
			colorScheme: 'scheme04',
			seriesGroups:
				[
					{
						type: 'line',
						series: [
								{ 
									//emptyPointsDisplay: 'skip',
									dataField: 'Temp', 
									displayText: 'Temperature [°C]' 

									}								
						  ]
					}
				]
		};
		// setup the chart
		$('#jqxChart').jqxChart(settings);
	});
</script>
</head>

<body>

	<div id='jqxChart' style="width: 800px; height: 600px"></div>

</body>

</html>