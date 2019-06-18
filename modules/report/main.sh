#!/usr/bin/env bash

# $1 →  File to delete : Target urls
# $2 →  Report file    : All texts
# $3 →  Wordlist       : Output general
# $4 →  Target
export numberOfUrls="$(cat $1 | wc -l)"
export numberOfContents="$(wc -c $2 | awk '{print $1}')"
export numberOfWords="$(wc -w $2 | awk '{print $1}')"
export numberOfResult="$(cat $3 | wc -l)"
export head="$(echo 'Delicously generated by D4N155')"
# Defining name → $4
export name="$(echo $4 | cut -d '.' -f 1)"

# Values
export contentsOfUrls="$(cat $1)"

__make(){
# Make $report-$name.html
echo -e """
<!DOCTYPE html>
<html>
<head>
    <title>Report of $name</title>
    <link rel='stylesheet' href='https://jul10l1r4.github.io/Texto-farmatacao/dark.css'/>
    
</head>
<body class='dark'>
	<h1 class='center' style='text-transform: uppercase'>$name</h1>
	<div style='margin:auto;min-width: 60%;max-width: 80%'>
		<canvas id='bar-chartcanvas'></canvas>
	</div>

   	<script
			  src='https://code.jquery.com/jquery-3.3.1.min.js'
			  integrity='sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8='
			  crossorigin='anonymous'></script>
    <script src='https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.4.0/Chart.min.js'></script>

    <script>
""" > ./report-$name.html
echo '$(document).ready(function () {var ctx = $("#bar-chartcanvas");' >> ./report-$name.html
echo -e """ 
	var data = {
		datasets : [
			{
				label : 'Urls',
				data : [$numberOfUrls],
				backgroundColor :	'rgba(41, 128, 185, 0.3)',
				borderColor :	'rgb(41, 128, 185)',
				borderWidth : 1
			},
			{
				label : 'Numbers of characters',
				data : [$numberOfContents],
				backgroundColor :	'rgba(52, 73, 94, 0.3)',
				borderColor :	'rgb(52, 73, 94)',
				borderWidth : 1
			},
      {
				label : 'Numbers of words',
				data : [$numberOfWords],
				backgroundColor :	'rgba(192, 57, 43, 0.3)',
				borderColor :	'rgb(192, 57, 43)',
				borderWidth : 1
			},
      {
				label : 'Passwords',
				data : [$numberOfResult],
				backgroundColor :	'rgba(26, 188, 156, 0.3)',
				borderColor :	'rgb(26, 188, 156)',
				borderWidth : 1
			}
		]
	};

	var options = {
		title : {
			display : true,
			position : 'top',
			text : 'Details',
			fontSize : 18,
			fontColor : '#ddd'
		},
		legend : {
			display : true,
			position : 'bottom'
		},
		scales : {
			yAxes : [{
				ticks : {
					min : 0
				}
			}]
		}
	};

	var chart = new Chart( ctx, {
		type : 'bar',
		data : data,
		options : options
	});

});
    </script>
    <h3 class='center'>read urls</h3>
    <div style='display:block;text-align:center;width:100%'>
      <pre class='center' style='color:#aaa;background:#111;margin:auto;width:80%;border-radius:10px'>$contentsOfUrls</pre>
    </div>
</body>
</html>
""" >> ./report-$name.html && \
  ( echo -e "$correct The file has been saved in\n $orange \t→ report-$name.html $end \nOpen with you browser" ) || \
  ( echo -e "$incorrect Dont can write in this directory?" )

  # Head default of groff
  # https://www.gnu.org/software/groff/manual/groff.html#Page-Layout
  echo """
.TL
Report of $name
.PP
Was processed \fB$numberOfUrls\fP 
urls with \fB$numberOfContents\fP letters and
\fB$numberOfWords\fP words,
resulted in \fB$numberOfResult\fP passwords possibles, based on these
.HnS 1
.HR
.URL https://adasecurity.github.io/D4N155/theories/ operations
.HR
.HnE

Urls analyzed:
.CDS
$contentsOfUrls
.CDE

.PP
\fIGenerated by D4N155\fP

""" | groff -ms -mwww  -T pdf > "./report-$name.pdf" && \
  ( echo -e "$correct The file has been saved in\n $orange \t→ report-$name.pdf $end " ) || \
  ( echo -e "$incorrect groff dont are installed?";exit 2 )
}

# call
__make

