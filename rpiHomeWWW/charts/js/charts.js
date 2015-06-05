function setChart(selector,period) {
	var source = {
		datatype : "json",
		datafields : [ {
			name : 'Time',
			type : 'date'
		}, {
			name : 'Sensor1'
		}, {
			name : 'Sensor2'
		} ],
		//show last x hours
		url : 'chart_temp_data.php?hours='+48
	};

	var dataAdapter = new $.jqx.dataAdapter(source, {
		autoBind : true,
		async : false,
		downloadComplete : function() {
		},
		loadComplete : function() {
		},
		loadError : function() {
		}
	});

	// prepare jqxChart settings
	var settings = {
		title : "rpiHome",
		description : "DS1820 Temperature Sensors",
		enableAnimations : true,
		showLegend : true,
		padding : {
			left : 10,
			top : 10,
			right : 20,
			bottom : 10
		},
		titlePadding : {
			left : 90,
			top : 0,
			right : 0,
			bottom : 10
		},
		source : dataAdapter,
		xAxis : {
			// text: 'Category Axis',
			// textRotationAngle: 90,
			dataField : 'Time',
			formatFunction : function(value) {
				// return $.jqx.dataFormat.formatdate(value, 'dd/MM/yyyy
				// HH:mm:ss');
				return $.jqx.dataFormat.formatdate(value, 'HH:mm:ss');
			},
			type : 'date',
			baseUnit : 'hour',
			valuesOnTicks : true,
			// minValue: '01-01-2014',
			// maxValue: '01-01-2016',
			// minValue: new Date(2014, 0, 1),
			// maxValue: new Date(2016, 11, 1),
			tickMarks : {
				visible : true,
				interval : 1,
				color : '#BCBCBC'
			},
			unitInterval : 2,
			gridLines : {
				visible : false,
				interval : 3,
				color : '#BCBCBC'
			},
			labels : {
				angle : -90,
				rotationPoint : 'topright',
				offset : {
					x : 0,
					y : -30
				}
			},
			/*
			 * formatFunction : function(value, dataIndex) {
			 * 
			 * var hours = value.getHours(); var minutes = value.getMinutes();
			 * var seconds = value.getSeconds();
			 * 
			 * if (hours < 10) hours = '0' + hours;
			 * 
			 * if (minutes < 10) minutes = '0' + minutes;
			 * 
			 * if (seconds < 10) seconds = '0' + seconds;
			 * 
			 * return hours + ":" + minutes + ":" + seconds; },
			 */
			rangeSelector : {
				serieType : 'area',
				padding : { /* left: 0, right: 0, */
					top : 20,
					bottom : 0
				},
				renderTo : $('#ChartSelectorContainer'),
				backgroundColor : 'white',
				size : 150,
				gridLines : {
					visible : false
				},
			}

		},
		valueAxis : {
			visible : true,
			title : {
				text : 'Temperature [°C]'
			},
			tickMarks : {
				color : '#BCBCBC'
			}
		},
		colorScheme : 'scheme05',
		seriesGroups : [ {
			type : 'line',
			series : [ {
				// emptyPointsDisplay: 'skip',
				// legendFormatFunction: legendFormatFunction,

				dataField : 'Sensor1',
				displayText : 'Sensor 1'

			}, {
				dataField : 'Sensor2',
				displayText : 'Sensor 2'

			} ]
		} ]
	};

	return settings;

}