<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page session="true" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="/resources/demos/style.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<title>Insert title here</title>

<style>

/* .datepicker
{ 
    width: 10.5em;
    height: 2.5em;
} */
body {
 /*  background-image: url('../../Media/bg6.jpg') ;
  background-repeat: no-repeat;
  background-size:  /* 300px 100px    auto ; */
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

.col-15 {
	float: left;
	width: 25%;
}
.col-20 {
	float: left;
	width: 20%;
}
.colr-15 {
	float: left;
	width: 15%;
	margin-left: 50px;
}
.colr-20 {
	float: left;
	width: 28%;
	
}
.collvl-40 {
	float: left;
	width: 60%;
	
}
.col-25 {
	float: left;
	width: 40%;
}

.col-35{
float: left;
	width: 30%;
	margin-top: 6px;
}

.col-75 {
	float: left;
	width: 50%;
	margin-top: 6px;
}
.col-80 {
	float: left;
	width: 52%;
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
.autocomplete-items {
  position: absolute;
  border: 1px solid #d4d4d4;
  border-bottom: none;
  border-top: none;
  z-index: 99;
  left: 40px;
  right: 0;
  width:300px
}

.autocomplete-items div {
  padding: 10px;
  cursor: pointer;
  background-color: #fff; 
  border-bottom: 1px solid #d4d4d4; 
}

.autocomplete-items div:hover {
  background-color: #e9e9e9; 
}

.autocomplete-active {
  background-color: DodgerBlue !important; 
  color: #ffffff; 
}
.autocomplete-items {
  position: absolute;
  border: 1px solid #d4d4d4;
  border-bottom: none;
  border-top: none;
  z-index: 99;
  top: 100%;
  left: 0;
  right: 0;
}

.autocomplete-items div {
  padding: 10px;
  cursor: pointer;
  background-color: #fff; 
  border-bottom: 1px solid #d4d4d4; 
}

.autocomplete-items div:hover {
  background-color: #e9e9e9; 
}

.autocomplete-active {
  background-color: DodgerBlue !important; 
  color: #ffffff; 
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
var gl_srting="";

function loadgllist(){
	clear();	
	var loggedBranch="<%=session.getAttribute("BranchCode")%>";
	SetValue("loggedBranch", loggedBranch,"N");
	SetValue("Class", "AccontingParameterSetup","N");
	SetValue("Method", "FetchProductMisc","L");	
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
					gl_srting=obj.GL_LIST;					
					var select = document.getElementById("glcode");                  
					 var gl_arrayList = gl_srting.split(',');
					 for(var i = 0; i < gl_arrayList.length; i++) {
						 gl_arrayList[i] = gl_arrayList[i].replace("/^\s*/", "").replace("/^\s*/", "");				
					    var gl_keyValue = gl_arrayList[i].split(':');
					    var option = document.createElement("option");
					    option.value=gl_keyValue[0];
					    option.text=gl_keyValue[1];	
					    select.add(option, null);				   				   
					 }
					
				}
		});		
			
}

function initValues(){	
	loadgllist();
	document.getElementById("BranchCode").value = "<%= session.getAttribute("BranchCode")%>";
	document.getElementById("PrincipalAmt").value="0.00";
	document.getElementById("IntAmt").value="0.00";	
	document.getElementById("PrincipalfalldueAmt").value="0.00";
	document.getElementById("IntfalldueAmt").value="0.00";
	document.getElementById("BranchCode").focus();	
}

function refresh(){
	document.getElementById("PrincipalAmt").value="0.00";
	document.getElementById("IntAmt").value="0.00";
	document.getElementById("PrincipalfalldueAmt").value="0.00";
	document.getElementById("IntfalldueAmt").value="0.00";
}
function fethData(){
	clear();
	SetValue("BranchCode", document.getElementById("BranchCode").value,"N");
	SetValue("FinanYear", document.getElementById("FinanYear").value,"N");
	SetValue("glcode", document.getElementById("glcode").value,"N");
	SetValue("Class", "AccountingManagement","N");
	SetValue("Method", "FetchLoanRecoverableData","L");	
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
				initValues();
			} else {				
				if (obj.PRINCIPAL_OD_AMT!=null) {
					var r = confirm("Data already exists!\nDo you want to update?");
					  if (r == true) {		
						    document.getElementById("PrincipalAmt").value=parseFloat(obj.PRINCIPAL_OD_AMT).toFixed(2); 
							document.getElementById("IntAmt").value=parseFloat(obj.INTEREST_OD_AMT).toFixed(2);							
							document.getElementById("PrincipalfalldueAmt").value=parseFloat(obj.PRINCIPAL_FD_AMT).toFixed(2);
							document.getElementById("IntfalldueAmt").value=parseFloat(obj.INTEREST_FD_AMT).toFixed(2);							
							document.getElementById("PrincipalAmt").focus();									
					  }
				}
				else{
					document.getElementById("PrincipalAmt").value="0.00";
					document.getElementById("IntAmt").value="0.00";
					document.getElementById("PrincipalfalldueAmt").value="0.00";
					document.getElementById("IntfalldueAmt").value="0.00";
					document.getElementById("PrincipalAmt").focus();
				}																		
			}
	});		
	
	
	
}
function UpdateLoanData(event)
{	 
	clear();	
	var loggedBranch="<%=session.getAttribute("BranchCode")%>";
	SetValue("BranchCode", document.getElementById("BranchCode").value,"N");
	SetValue("FinanYear", document.getElementById("FinanYear").value,"N");
	SetValue("glcode", document.getElementById("glcode").value,"N");
	SetValue("PrincipalAmt", document.getElementById("PrincipalAmt").value,"N");
	SetValue("IntAmt", document.getElementById("IntAmt").value,"N");	
	SetValue("PrincipalfalldueAmt", document.getElementById("PrincipalfalldueAmt").value,"N");
	SetValue("IntfalldueAmt", document.getElementById("IntfalldueAmt").value,"N");		
	SetValue("Class", "AccountingManagement","N");
	SetValue("Method", "addLoanRecoverableData","L");	
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
				if (obj.ERROR_MSG != "") {
					alert(obj.ERROR_MSG);
				} else {
					alert(obj.SUCCESS);
					refresh()();
				}					
			}
	});		
								 				
}

</script>

</head>
<body onload="initValues()">
	<center>
	<h1> Loan Recoverable Data Entry</h1>
		<div class="container">
		     
		      <fieldset>
		      <legend>Loan Identifier </legend> 
		      
		       <div class="row">
					<div class="col-15">
						<label for="BranchCode">Branch Code</label>
					</div>
					<div class="col-20">
						<input type="text" id="BranchCode" name="BranchCode" readonly >
					</div>	
					 <div class="col-15">
						<label for="FinanYear">Financial Year</label>
					</div>
					<div class="col-20">
						<select id="FinanYear" name="FinanYear"   style="width: 248px;">				
							<option value="2020-2021">2020-2021</option>	
							<option value="2021-2022">2021-2022</option>
						</select>
					</div>			
																																						
				 </div>				      
		       	
				 
				 <div class="row">
				<div class="col-15">
					<label for="glcode">Product </label>
				</div>
				<div class="col-20">
					<select id="glcode" name="glcode"  style="width: 248px;">						
				</select>
			</div>		
			
					
			</div>	
			
			 <div class="row">
			 <div class="col-75"></div>
			<div class="col-75">
			<input type="submit" id="fetchData" value="Fetch Data" onclick="fethData(event)" >
			</div>
			</div>
     				
				</fieldset>	
					
				<fieldset>	
				
				<legend>Loan Related Data </legend>
																			 										
				<div class="row">
					<div class="col-15">
						<label for="PrincipalAmt">Principal Amount(Overdue)</label>
					</div>
					<div class="col-20">
						<input type="text" id="PrincipalAmt" name="PrincipalAmt" >
					</div>	
					
					<div class="col-15">
						<label for="IntAmt">Interest Amount(Overdue)</label>
					</div>
					<div class="col-20">
						<input type="text" id="IntAmt" name="IntAmt" >
					</div>																				
				 </div>	
				 
				 
				 
				 <div class="row">
					<div class="col-15">
						<label for="PrincipalfalldueAmt">Principal Amount(Fall Due)</label>
					</div>
					<div class="col-20">
						<input type="text" id="PrincipalfalldueAmt" name="PrincipalfalldueAmt" >
					</div>	
					
					<div class="col-15">
						<label for="IntfalldueAmt">Interest Amount(Fall Due)</label>
					</div>
					<div class="col-20">
						<input type="text" id="IntfalldueAmt" name="IntfalldueAmt" >
					</div>																				
				 </div>	
				 
				 							
				</fieldset>	
																	
				<div>				
				<br>				
				<div class="col-75"></div>
				<div class="row">
					<input type="submit" id="submit" value="Submit" onclick="UpdateLoanData(event)" >
				</div>
			 </div>
			</div>
	</center>
</body>
</html>