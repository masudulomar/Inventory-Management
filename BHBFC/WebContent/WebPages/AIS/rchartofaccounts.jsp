<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="/resources/demos/style.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<style> 
body {
  /* background-image: url('../../Media/bg9.jpg') ;
  background-repeat: no-repeat;
  background-size: /* 300px 100px   auto ; */
  background-color: #cccccc; 
}

 {
	box-sizing: border-box;
}

input[type=text],select,textarea {
	width: 100%;
	padding: 12px;
	border: 1px solid #ccc;
	border-radius: 4px;
	resize: vertical;
}

label {
	padding: 12px 12px 12px 0;
	display: inline-block;
}

input[type=submit] {
	background-color: #339933;
	color: white;
	padding: 12px 20px;
	border: none;
	border-radius: 4px;
	cursor: pointer;
	float: left;
}

input[type=submit]:hover {
	background-color: #45a049;
}

.container {
	border-radius: 5px;
	background-color: #FAE5D3;
	padding: 20px;
}

.col-25 {
	float: left;
	width: 40%;
	margin-top: 6px;
}
.col-15{
float: left;
	width: 20%;
	margin-top: 6px;
}
.col-35{
float: left;
	width: 30%;
	margin-top: 6px;
}

.col-75 {
	float: left;
	width: 40%;
	margin-top: 6px;
}



/* Clear floats after the columns */
.row:after {
	content: "";
	display: table;
	clear: both;
}

/* Responsive layout - when the screen is less than 600px wide, make the two columns stack on top of each other instead of next to each other */
@media screen and (max-width: 600px) {
	.col-25,.col-75,input[type=submit] {
		width: 100%;
		margin-top: 0;
	}
}
</style> 
<script type="text/javascript">
var DataMap="";
function SetValue(key,value){
	var Node = key+"*"+value;
	if(DataMap!=""){
		DataMap=DataMap+"$"+Node;
	}
	else{
		DataMap="data="+Node;
	}
}
function clear(){
	DataMap="";
}
function initValues(){
	document.getElementById("User_Id").value= "<%= session.getAttribute("User_Id")%>";
	document.getElementById("BranchCode").value="<%= session.getAttribute("BranchCode")%>";
	document.getElementById("TransactionDate").focus();
}

function ViewGLList(event){
	
	var usr_brn = "<%= session.getAttribute("BranchCode")%>";	
	var DataString="loggedBranch="+usr_brn+"&ReportType=ViewGLList&BranchCode="+usr_brn;
	
		var xhttp = new XMLHttpRequest();		
		xhttp.open("POST", "TranReportServlet?"+DataString, true);		
		xhttp.responseType = "blob";
		xhttp.onreadystatechange = function () {
		    if (xhttp.readyState === 4 && xhttp.status === 200) {		    	
		        var filename = "Report_ViewGLList"+".pdf";
		        if (typeof window.chrome !== 'undefined') {
		            // Chrome version
		            var link = document.createElement('a');
		            link.href = window.URL.createObjectURL(xhttp.response);		       
		            window.open(link.href);		            
		            //link.download = "PdfName-" + new Date().getTime() + ".pdf";
		            //link.click();
		        } else if (typeof window.navigator.msSaveBlob !== 'undefined') {
		            // IE version
		            var blob = new Blob([xhttp.response], { type: 'application/pdf' });
		            window.navigator.msSaveBlob(blob, filename);
		           // window.open(window.navigator.msSaveBlob(blob, filename));
		        } else {
		            // Firefox version
		            var file = new File([xhttp.response], filename, { type: 'application/force-download' });
		            window.open(URL.createObjectURL(file));		            
		        }
		    }
		};
		xhttp.send();	
	
	
}

function ViewAccountsList(event){
	
	var usr_brn = "<%= session.getAttribute("BranchCode")%>";	
	var DataString="loggedBranch="+usr_brn+"&ReportType=ViewAccountsList&BranchCode="+usr_brn;
	var xhttp = new XMLHttpRequest();		
	xhttp.open("POST", "TranReportServlet?"+DataString, true);		
	xhttp.responseType = "blob";
	xhttp.onreadystatechange = function () {
	    if (xhttp.readyState === 4 && xhttp.status === 200) {		    	
	        var filename = "Report_ViewGLList"+".pdf";
	        if (typeof window.chrome !== 'undefined') {
	            // Chrome version
	            var link = document.createElement('a');
	            link.href = window.URL.createObjectURL(xhttp.response);		       
	            window.open(link.href);		            
	            //link.download = "PdfName-" + new Date().getTime() + ".pdf";
	            //link.click();
	        } else if (typeof window.navigator.msSaveBlob !== 'undefined') {
	            // IE version
	            var blob = new Blob([xhttp.response], { type: 'application/pdf' });
	            window.navigator.msSaveBlob(blob, filename);
	           // window.open(window.navigator.msSaveBlob(blob, filename));
	        } else {
	            // Firefox version
	            var file = new File([xhttp.response], filename, { type: 'application/force-download' });
	            window.open(URL.createObjectURL(file));		            
	        }
	    }
	};
	xhttp.send();	
	
	
}


</script>
<body onload="initValues()">
	<center>
	
	<br><br>
	<h2>[Chart of Accounts]</h2>
	<div class="container">
				
	<div class="row">
	<div class="col-75"></div>
	<div class="col-15">
		<input type="submit" id="reportView" value="View All Head" onclick="ViewGLList(event)" > 
	</div>
		
	<div class="col-15">
		<input type="submit" id="reportView" value="View All Accounts" onclick="ViewAccountsList(event)" > 
	</div>								
	</div>
				
									
	</div>
	</center>
</body>
</html>