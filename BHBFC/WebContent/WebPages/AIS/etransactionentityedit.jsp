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
	width: 15%;
	margin-top: 6px;
}
.col-15{
float: left;
	width: 15%;
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
	var gl_srting="";
	var availableTags=[];
	
	function IsValidDate(myDate) {
	    var filter = /^([012]?\d|3[01])-([Jj][Aa][Nn]|[Ff][Ee][bB]|[Mm][Aa][Rr]|[Aa][Pp][Rr]|[Mm][Aa][Yy]|[Jj][Uu][Nn]|[Jj][u]l|[aA][Uu][gG]|[Ss][eE][pP]|[oO][Cc]|[Nn][oO][Vv]|[Dd][Ee][Cc])-(19|20)\d\d$/
	    return filter.test(myDate);
	}
	$( function() {
		 
		  $( "#glcode" ).autocomplete({
		    source: availableTags
		  });
		} );
	function loadgllist(){

		var loggedBranch="<%=session.getAttribute("BranchCode")%>";
			
		clear();		
		SetValue("loggedBranch", loggedBranch,"N");
		SetValue("Class", "AccontingParameterSetup","N");
		SetValue("Method", "FetchGLData","L");	
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
						 var gl_arrayList = gl_srting.split(',');
						 for(var i = 0; i < gl_arrayList.length; i++) {
							 gl_arrayList[i] = gl_arrayList[i].replace("/^\s*/", "").replace("/^\s*/", "");				
						    var gl_keyValue = gl_arrayList[i].split(':');
						    availableTags.push(gl_keyValue[1]+":"+gl_keyValue[0]);
						 }
					}
			});		
			
	}
	
function initValues(){
	loadgllist();
	var user = "<%= session.getAttribute("User_Id")%>";
	var usr_brn = "<%= session.getAttribute("BranchCode")%>";	
	document.getElementById("BranchCode").value=usr_brn;	
    document.getElementById("glcode").value=""; 
	document.getElementById("TransactionAmount").value="0.00";	
	document.getElementById("cqnumber").value="";	
	document.getElementById("chqdate").value="";	
	document.getElementById("cqReferencenumber").value="";	
	document.getElementById("Narration").value="";	
	document.getElementById("Remarks").value="";
	document.getElementById("TransactionDate").focus();			
}

function FetchData(){
	clear();
	SetValue("BranchCode", document.getElementById("BranchCode").value,"N");
	SetValue("TransactionDate", document.getElementById("TransactionDate").value,"N");
	SetValue("BatchNumber", document.getElementById("BatchNumber").value,"N");
	SetValue("EntitySL", document.getElementById("EntitySL").value,"N");
	SetValue("Class", "AccountingManagement","N");
	SetValue("Method", "FetchBatchData","L");	
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
				if(obj.REJ_KEY==null){
					if (obj.GLCODE!=null) {
						var r = confirm("Data already exists!\nDo you want to update?");
						  if (r == true) {	
							  
							    document.getElementById("glcode").value=obj.GLCODE; 
								document.getElementById("TransactionAmount").value=parseFloat(obj.TRAN_AMOUNT).toFixed(2);								
								if (obj.CHQ_NUMBER!=null) {
									document.getElementById("cqnumber").value=obj.CHQ_NUMBER;
									document.getElementById("chqdate").value=obj.CHQ_DATE;
								}																						
								document.getElementById("cqReferencenumber").value=obj.CHQ_REFERENCE;	
								document.getElementById("Narration").value=obj.NARATION;
								document.getElementById("Remarks").value=obj.REMARKS;
								
								if (obj.AUTH_KEY!=null) {
									document.getElementById("glcode").readOnly = true;
									document.getElementById("cqnumber").focus();
								}
								else{
									document.getElementById("glcode").readOnly = false;
									document.getElementById("glcode").focus();
								}																	
						  }
					}
					else{
						 alert("No Transaction Batch Found !!!");
						  document.getElementById("BatchNumber").focus();
					}					
				}
				else{
					 alert("Transaction Batch is rejected !!");
					  document.getElementById("BatchNumber").focus();
				}

																	
			}
	});		
		
	
}
function GLCodeValidation(event){   	
	if (event.keyCode == 13 || event.which == 13) {   		
		if(document.getElementById("glcode").value!=""){   			   		
			clear();
			SetValue("gldescription", document.getElementById("glcode").value,"N");
			SetValue("Class", "AccontingParameterSetup","N");
			SetValue("Method", "GLCodeValidation","L");	
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
						document.getElementById("glcode").focus();
					} else {				 
						document.getElementById("cqnumber").focus();
					}   						
			}); 
	  }
   }   
	
}
function TransactionDateValidation(event){
	if (event.keyCode == 13 || event.which == 13) {
		var txtTest = document.getElementById('TransactionDate');
	    var isValid = IsValidDate(txtTest.value);
	    if (isValid) {
	    	document.getElementById("BatchNumber").focus();
	    }
	    else {
	        alert('Incorrect format');
	        document.getElementById("TransactionDate").focus();
	    }
	}
}

function BatchValidation(event){
	if (event.keyCode == 13 || event.which == 13) {
		document.getElementById("EntitySL").focus();
	}
}

function EnitiySLValidation(event){
	if (event.keyCode == 13 || event.which == 13) {
		FetchData();
	}
}
function CHQNumberValidation(event){
	if (event.keyCode == 13 || event.which == 13) {
		if(document.getElementById("cqnumber").value!=""){   						
			document.getElementById("chqdate").focus();
		}
		else{
			document.getElementById("Narration").focus();
		}
		
	}
}

function CHQDateValidation(event){
	if (event.keyCode == 13 || event.which == 13) {
		document.getElementById("cqReferencenumber").focus();
	}
}

function CHQReferenceValidation(event){
	if (event.keyCode == 13 || event.which == 13) {    		
		document.getElementById("Narration").focus();
	}
}

function VatidateNaration(event){
	if (event.keyCode == 13 || event.which == 13) {    		
		document.getElementById("Remarks").focus();
	}
}

$(function() {
	$("#TransactionDate").datepicker({
		dateFormat : 'dd-M-yy'
	});
});

$(function() {
	$("#chqdate").datepicker({
		dateFormat : 'dd-M-yy'
	});
});


function UpdateTransactionBatch(){
	
	var r = confirm("Do youConfirm to update the Transaction ?");
	  if (r == true) {	
		    clear();
		    var User_Id ="<%= session.getAttribute("User_Id")%>";
		    var usr_brn ="<%= session.getAttribute("BranchCode")%>";			    
		    SetValue("loggedBranch",usr_brn,"N");
		    SetValue("User_Id",User_Id,"N");
			SetValue("BranchCode", document.getElementById("BranchCode").value,"N");
			SetValue("TransactionDate", document.getElementById("TransactionDate").value,"N");
			SetValue("BatchNumber", document.getElementById("BatchNumber").value,"N");
			SetValue("EntitySL", document.getElementById("EntitySL").value,"N");		
			SetValue("glcode", document.getElementById("glcode").value,"N");
			SetValue("chqdate", document.getElementById("chqdate").value,"N");
			SetValue("cqnumber", document.getElementById("cqnumber").value,"N");
			SetValue("cqReferencenumber", document.getElementById("cqReferencenumber").value,"N");
			SetValue("Narration", document.getElementById("Narration").value,"N");
			
			SetValue("Remarks", document.getElementById("Remarks").value,"N");
			SetValue("Class", "AccountingManagement","N");
			SetValue("Method", "VoucherEntityEdit","L");	
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

</script>
</head>
<body onload="initValues()">
		<center>		
		<div class="container">
		<fieldset>	
		   <legend>Transaction Details</legend> 			
				<div class="row">
					<div class="col-15">
						<label for="BranchCode">Branch Code</label>
					</div>
					<div class="col-15">
						<input type="text" id="BranchCode" name="BranchCode" readonly>
					</div>
					
					<div class="col-15">
						<label for="TransactionDate">Tran. Date</label>
					</div>
					<div class="col-15">
						<input type="text" id="TransactionDate" name="TransactionDate" onkeypress="TransactionDateValidation(event)" >
					</div>
					
					<div class="col-15">
						<label for="BatchNumber">Batch Number</label>
					</div>
					<div class="col-15">
						<input type="text" id="BatchNumber" name="BatchNumber" onkeypress="BatchValidation(event)">
					</div>
					
				</div>
								
				
				<div class="row">
				
				  <div class="col-15">
						<label for="EntitySL">Entity Serial</label>
					</div>
					<div class="col-15">
						<input type="text" id="EntitySL" name="EntitySL"  onkeypress="EnitiySLValidation(event)" >
					</div>
					
					
					<div class="col-15">
						<label for="fetchEntity"></label>
					</div>
					<div class="col-15">
						<input type="submit" id="fetchEntity" value="Fetch Entity" onclick="FetchData()" > <br>
					</div>
					
				</div>
				</fieldset>
				
				<fieldset>
				<div class="row">
				
				  <div class="col-15">
						<label for="glcode">GL Head</label>
					</div>
					<div class="col-75">
						<input type="text" id="glcode" name="glcode" onkeypress="GLCodeValidation(event)">
					</div>
				
			
				 <div class="col-15">
						<label for="TransactionAmount">Tran. Amount</label>
					</div>
					<div class="col-15">
						<input type="text" id="TransactionAmount" name="TransactionAmount" readonly >
					</div>	
					
					</div>
				<div class="row">	
					 <div class="col-15">
						<label for="cqnumber">CQ. Number</label>
					</div>
					<div class="col-15">
						<input type="text" id="cqnumber" name="cqnumber"  onkeypress="CHQNumberValidation(event)">
					</div>
					
				 <div class="col-15">
						<label for="chqdate">CQ. Date</label>
					</div>
					<div class="col-15">
						<input type="text" id="chqdate" name="chqdate"  onkeypress="CHQDateValidation(event)">
					</div>	
					
				</div>
				<div class="row">		
					 <div class="col-15">
						<label for="cqReferencenumber">CQ. Referance</label>
					</div>
					<div class="col-15">
						<input type="text" id="cqReferencenumber" name="cqReferencenumber" onkeypress="CHQReferenceValidation(event)" >
					</div>
					
				 <div class="col-15">
						<label for="Narration">Narration</label>
					</div>
					<div class="col-75">
						<input type="text" id="Narration" name="Narration"   onkeypress="VatidateNaration(event)" >
					</div>	
										
				</div>
				
				
				<div class="row">
					<div class="col-15">
						<label for="Remarks"> Remarks</label>
					</div>
					<div class="col-75">
						<textarea id="Remarks" name="Remarks" rows="2" cols="80"
							></textarea>
					</div>
			
				</div>
				
				</fieldset>
				
				
				<div class="row">
					<div class="col-25">
						<label for="report_download"></label>
					</div>
					<div class="col-75">
						<input type="submit" id="report_download" value="Update Batch" onclick="UpdateTransactionBatch()" > <br>
					</div>
					
				</div>													
		</div>
		<br><br><br>
		<!-- <p> <a href="IncomeTaxReport.jsp" >Click here </a> for Income Tax Report</p> -->
		
 	
	</center>
</body>
</html>