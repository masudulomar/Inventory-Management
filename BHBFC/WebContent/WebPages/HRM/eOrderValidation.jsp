<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>

<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="/resources/demos/style.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

</head>
<style> 
body {
  background-color: #cccccc;
 /*  background-image: url('../../Media/bg6.jpg') ;
  background-repeat: repeat;
  background-size: /* 300px 100px   auto ; */
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
	background-color: #4CAF50;
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
	width: 20%;
	margin-top: 6px;
}
.colr-25 {
	float: left;
	width: 10%;
	margin-top: 6px;
}
.col-15{
float: left;
	width: 20%;
	margin-top: 6px;
}
.col-45{
float: left;
	width: 20%;
	margin-top: 6px;
}

.col-75 {
	float: left;
	width: 40%;
	margin-top: 6px;
}

.col-customize {
	float: left;
	width: 33%;
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


.alert {
	padding: 20px;
	background-color: #f44336;
	color: white;
}

.closebtn {
	margin-left: 15px;
	color: white;
	font-weight: bold;
	float: right;
	font-size: 22px;
	line-height: 20px;
	cursor: pointer;
	transition: 0.3s;
}

.closebtn:hover {
	color: black;
}

.alert {
	padding: 20px;
	background-color: #f44336;
	color: white;
}

.closebtn {
	margin-left: 15px;
	color: white;
	font-weight: bold;
	float: right;
	font-size: 22px;
	line-height: 20px;
	cursor: pointer;
	transition: 0.3s;
}

.closebtn:hover {
	color: black;
}

/* Tax Button  */

.taxButton {
  display: inline-block;
  border-radius: 4px;
  background-color: #4CAF50;
  border: none;
  color: #FFFFFF;
  text-align: center;
  font-size: 15px;
  padding: 10px;
  width: 150px;
  transition: all 0.5s;
  cursor: pointer;
  margin: 5px;
}

.taxButton {
  background-color: #ffe6e6; 
  color: black; 
  border: 2px solid #008CBA;
}

.taxButton span {
  cursor: pointer;
  display: inline-block;
  position: relative;
  transition: 0.3s;
}

.taxButton span:after {
  content: '\00bb';
  position: absolute;
  opacity: 0;
  top: 0;
  right: -20px;
  transition: 0.3s;
  
}

.taxButton:hover {
  background-color: #4CAF50;
  color: white;
}
.taxButton:hover span {
  padding-right: 25px;
}

.taxButton:hover span:after {
  opacity: 1;
  right: 0;
}

</style> 

<script type="text/javascript">
var DataMap="";
function SetValue(key,value,itemsl){
	if(itemsl=='L'){
		var Node ='"'+ key+'"'+":"+'"'+value+'"';
	}
	else{
		var Node ='"'+ key+'"'+":"+'"'+value+'"'+",";
	}
	DataMap=DataMap+Node;
   }
	function clear(){
		DataMap="";
	}
	function xmlFinal(){
		DataMap="{"+DataMap+"}";
   }
	

function initValues(){
	document.getElementById("OrderDetails").value="";
}


$(function() {
	$("#OrderDate").datepicker({
		dateFormat : 'dd-M-yy'
	});
});

function fetchData(){
	document.getElementById("OrderDetails").value="";
	if(document.getElementById("OrderDate").value==""){
		  alert("Order Date is Mendatory");
		  document.getElementById("OrderDate").focus();
	  }
	  else{
		  clear();	
			SetValue("OrderDate", document.getElementById("OrderDate").value,"N");
			SetValue("Class", "AccontingParameterSetup","N");
			SetValue("Method", "FetchOrderList","L");
			xmlFinal();
			$.ajax({
				  method: "POST",
				  url: "TransactionServlet",
				  data: { DataString: DataMap }
				})
				  .done(function( responseMessage ) {
				    var obj = JSON.parse(responseMessage);
				    if (obj.ERROR_MSG != "") {
						alert(obj.ERROR_MSG);
					} else {				 
						var item_srting=obj.ORDER_LIST;	
						var select = document.getElementById("OrderDetails");                  
						 var item_arrayList = item_srting.split(':');
						 for(var i = 0; i < item_arrayList.length; i++) {
							// item_arrayList[i] = item_arrayList[i].replace("/^\s*/", "").replace("/^\s*/", "");							 
							    var item_keyValue = item_arrayList[i].split('#');
							    var option = document.createElement("option");
							    option.value=item_keyValue[0] ;
							    option.text=item_keyValue[1];	
							    select.add(option, null);				   				   
						 }
					}
			});		  
	 }				
}

function RejectOrderDetails(event){
	var user = "<%= session.getAttribute("User_Id")%>";
	 var c = confirm("Are you sure ?");
	  if (c == true) {
		  
		  if(document.getElementById("OrderDate").value==""){
			  alert("Order Date is Mendatory");
			  document.getElementById("OrderDate").focus();
		  }
		  else{
			  if(document.getElementById("OrderDetails").value==""){
				  alert("Order Details Not Found");
				  document.getElementById("OrderDetails").focus();
			  }
			  else{
				    clear();
				    SetValue("User_Id",user,"N");	
				    SetValue("OrderDate",document.getElementById("OrderDate").value,"N");
				    SetValue("OrderDetails",document.getElementById("OrderDetails").value,"N");		    
					SetValue("Class","AccountingManagement","N");
					SetValue("Method","RejectTransaction","L");
					xmlFinal();
					$.ajax({
			 			  method: "POST",
			 			  url: "TransactionServlet",
			 			  data: { DataString: DataMap }
			 			})
			 			  .done(function( responseMessage ) {
			 			    var obj = JSON.parse(responseMessage);
				   			 if (obj.ERROR_MSG != "") {
									alert(obj.ERROR_MSG);
								} else {
									alert(obj.SUCCESS);
									initValues();
								}		
			 		});						  
			  }			    			  
		  }
		  		     
	  } else {
		  document.getElementById("rejId").focus();
	  }	
}


function AuthOrderDetails(event){
	var user = "<%= session.getAttribute("User_Id")%>";
	 var c = confirm("Are you sure ?");
	  if (c == true) {		  
		  if(document.getElementById("OrderDate").value==""){
			  alert("Order Date is Mendatory");
			  document.getElementById("OrderDate").focus();
		  }
		  else{
			  if(document.getElementById("OrderDetails").value==""){
				  alert("Order Details Not Found");
				  document.getElementById("OrderDetails").focus();
			  }
			  else{
				    clear();
				    SetValue("User_Id",user,"N");	
				    SetValue("OrderDate",document.getElementById("OrderDate").value,"N");
				    SetValue("OrderDetails",document.getElementById("OrderDetails").value,"N");		    
					SetValue("Class","AdminOperation","N");
					SetValue("Method","AuthorizeOrder","L");
					xmlFinal();
					$.ajax({
			 			  method: "POST",
			 			  url: "TransactionServlet",
			 			  data: { DataString: DataMap }
			 			})
			 			  .done(function( responseMessage ) {
			 			    var obj = JSON.parse(responseMessage);
				   			 if (obj.ERROR_MSG != "") {
									alert(obj.ERROR_MSG);
								} else {
									alert(obj.SUCCESS);
									initValues();
							}		
			 		});						
					
			  }			    			  
		  }
		  		     
	  } else {
		  document.getElementById("authId").focus();
	  }	
}

function ViewOrderDetails()
{	    
	   
	var usr_brn = "<%= session.getAttribute("BranchCode")%>";	
	var DataString="loggedBranch="+usr_brn+"&ReportType="+document.getElementById("ReportType").value+
	"&OrderDate="+document.getElementById("OrderDate").value+
	"&OrderDetails="+document.getElementById("OrderDetails").value;
	
		var xhttp = new XMLHttpRequest();		
		xhttp.open("POST", "HRMReportServlet?"+DataString, true);
		
		xhttp.responseType = "blob";
		xhttp.onreadystatechange = function () {
		    if (xhttp.readyState === 4 && xhttp.status === 200) {
		        var filename = "Report_"+ document.getElementById("ReportType").value +".pdf";
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
</head>
<body onload="initValues()">
		<center>
		<h2 style="color:#006600;">Office Order Validation</h2>
		
		<div class="container">
		<fieldset>	
		   <legend>Order Details</legend> 			
								
				<div class="row">
					<div class="col-25">
						<label for="OrderDate">Order Date</label>
					</div>
					<div class="col-25">
						<input type="text" id="OrderDate" name="OrderDate" onkeypress="BranchCodeValidation(event)">
					</div>
					<div class="colr-25"></div>
					<div class="colr-25">
						<input type="submit" id="fetchData" value="Fetch Data" onclick="fetchData(event)" >
					</div>
					
				</div>
				
				<div class="row">
					<div class="col-25">
						<label for="OrderDetails">Order Details</label>
					</div>
					<div class="col-75">
					<select id="OrderDetails" name="OrderDetails" ></select>
					
					</div>
				</div>
								
				<div class="row">
					<div class="col-25">
							<label for="ReportType">Report Type</label>
					</div>
					<div class="col-75">
						<select id="ReportType" name="ReportType" >
							<option value="PrintOrderList">Print Order</option>									
						</select>
					</div>
				</div>
				</fieldset>
				<div class="row">
					
					<div class="col-customize">
						<input type="submit" id="viewId" value="Print Order" onclick="ViewOrderDetails()" > <br>
					</div>
					
					<div class="col-customize">
						<input type="submit" id="rejId" value="Reject Order" onclick="RejectOrderDetails()" > <br>
					</div>
																		
					<div class="col-customize">
						<input type="submit" id="authId" value="Authorize Order" onclick="AuthOrderDetails()" > <br>
					</div>
				</div>													
		</div>
		<br><br><br>
		<!-- <p> <a href="IncomeTaxReport.jsp" >Click here </a> for Income Tax Report</p> -->
		
 	
	</center>
</body>
</html>