
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
<title>Buy Product Form</title>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="/resources/demos/style.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<title>Inventory Management</title>
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
	width: 20%;
}
.col-20 {
	float: left;
	width: 20%;
}

.coll-20 {
	float: left;
	width: 60.2%;
}

.cols-20 {
	float: left;
	width: 7%;
}
.colr-15 {
	float: left;
	width: 12%;
	margin-left: 50px;
}

.colrr-15 {
	float: left;
	width: 7%;
	margin-left: 30px;
}
.colr-20 {
	float: left;
	width: 23.7%;
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
	var brn_code = "<%= session.getAttribute("BranchCode")%>";
function initValues(){
	
	document.getElementById("ItemProduct").value="";   //
	document.getElementById("PurchaseDate").value="";  //
	document.getElementById("NumberOfItems").value=""; //
	document.getElementById("Price").value="";         //
	document.getElementById("SerialFrom").value="";    //
	document.getElementById("SerialTo").value="";	   //
	document.getElementById("Remarks").value="";       //

}


function ItemProductValidation(event){
	if (event.keyCode == 13 || event.which == 13) {
		document.getElementById("PurchaseDate").focus();
	}
}

/*
 function ItemProductValidation(event){   	
    	if (event.keyCode == 13 || event.which == 13) {   		
    		if(document.getElementById("ItemProduct").value!=""){   			   		
    			clear();
    			SetValue("itemProductdescription", document.getElementById("ItemProduct").value,"N");
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
    						document.getElementById("DrCrType").focus();
    					}   						
    			}); 
    	  }
       }   
    	
    } 
 
 */

function PurchaseDateValidation(event){
	if (event.keyCode == 13 || event.which == 13) {
		document.getElementById("NumberOfItems").focus();
	}
}
function NumberOfItemsValidation(event){
	if (event.keyCode == 13 || event.which == 13) {
		document.getElementById("Price").focus();
	}
}
function SerialFromValidation(event){
	if (event.keyCode == 13 || event.which == 13) {
		document.getElementById("SerialTo").focus();
	}
}
function PriceValidation(event){
	if (event.keyCode == 13 || event.which == 13) {
		document.getElementById("SerialFrom").focus();
	}
}


function RemarksValidation(event){
	if (event.keyCode == 13 || event.which == 13) {
		document.getElementById("PhoneOff").focus();
	}
}

function SerialToValidation(event)
{
	if (event.keyCode == 13 || event.which == 13) 
	{
			document.getElementById("Remarks").focus();
	}
}


function InsertUpdateLoanDataFunc(event)
{	
	 var c = confirm("Are you sure ?");
	  if (c == true) {
		  LoanCodeValidation(event);
		 var branchName= "<%= session.getAttribute("BRN_NAME")%>";
		 var User_Id="<%=session.getAttribute("User_Id")%>";
		 var office_code = "<%= session.getAttribute("BranchCode")%>";
		    clear();
		    SetValue("OfficeCode",office_code,"N");
			SetValue("LoanCode",document.getElementById("LoanCode").value,"N");
			SetValue("ProductNature",document.getElementById("ProductNature").value,"N");
			SetValue("ItemProduct",document.getElementById("ItemProduct").value,"N");
			SetValue("PurchaseDate",document.getElementById("PurchaseDate").value,"N");
			SetValue("NumberOfItems",document.getElementById("NumberOfItems").value,"N");
			SetValue("SerialFrom",document.getElementById("SerialFrom").value,"N");
			SetValue("Price",document.getElementById("Price").value,"N");
			SetValue("MailingAddress",document.getElementById("MailingAddress").value,"N");
			
			SetValue("Remarks",document.getElementById("Remarks").value,"N");
			SetValue("PhoneOff",document.getElementById("PhoneOff").value,"N");
			SetValue("SerialTo",document.getElementById("SerialTo").value,"N");
			SetValue("SiteAddress",document.getElementById("SiteAddress").value,"N");
			SetValue("Email",document.getElementById("Email").value,"N");
			SetValue("ProjCode",document.getElementById("ProjCode").value,"N");
			SetValue("NID1",document.getElementById("NID1").value,"N");
			SetValue("DistrictCode",document.getElementById("DistrictCode").value,"N");
			SetValue("NID2",document.getElementById("NID2").value,"N");
			SetValue("ThanaCode",document.getElementById("ThanaCode").value,"N");
			SetValue("TaxId",document.getElementById("TaxId").value,"N");
			SetValue("Profession",document.getElementById("Profession").value,"N");
			SetValue("BankName",document.getElementById("BankName").value,"N");
			SetValue("BankAccountNo",document.getElementById("BankAccountNo").value,"N");
			SetValue("User",User_Id,"N");
			SetValue("Class","LmsEntryValidation","N");
			SetValue("Method","InsertUpdateLoanData","L");
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
					//initValues();
				} else {
					alert(obj.SUCCESS);
					clear();
					initValues();
					//document.getElementById("BankCode").focus();	
					
				}		
  		    });											
	   }					
}

$(function() {
	$("#PurchaseDate").datepicker({
		dateFormat : 'dd-M-yy'
	});
});

</script>
</head>
<body onload="initValues()">
	<center>
	<label>Buy Entry Page</label>
		<div class="container">

		
		<fieldset>
		<legend>Entry </legend>	
			
			<div class="row">
				<div class="col-15">
					<label for="ItemProduct">Item Product: </label>
				</div>
				<div class="coll-20">
					<select id="ItemProduct" name="ItemProduct"  onkeypress="ItemProductValidation(event)" style="width: 688px;">
					</select>
				</div>
			</div>
			
			
			<div class="row">
				<div class="col-15">
					<label for="PurchaseDate">Purchase Date: </label>
				</div>
				<div class="col-20">
					<input type="text" id="PurchaseDate" name="PurchaseDate">
				</div>	

				<div class="colr-15">
					<label for="NumberOfItems">Number of Items: </label>
				</div>
				<div class="colr-20">
					<input type="text" id="NumberOfItems" name="NumberOfItems"   onkeypress="NumberOfItemsValidation(event)" >
				</div>
			</div>
			<div class="row">
				<div class="col-15">
					<label for="Price">Price: </label>
				</div>
				<div class="col-20">
					<input type="text" id="Price" name="Price"  onkeypress="PriceValidation(event)">
				</div>

				<div class="colr-15">
					<label for="SerialFrom">Serial From: </label>
				</div>
				<div class="cols-20">
					<input type="text" id="SerialFrom" name="SerialFrom"  onkeypress="SerialFromValidation(event)" >
				</div>
				<div class="colrr-15">
					<label for="SerialTo">Serial To: </label>
				</div>
				<div class="cols-20">
					<input type="text" id="SerialTo" name="SerialTo"  onkeypress="SerialToValidation(event)">
				</div>											
			 </div>	
				
			
			
			<div class="row">		
				<div class="col-15">
					<label for="Remarks">Remarks: </label>
				</div>
				<div class="coll-20">
					<textarea id="Remarks" name="Remarks" rows="2" cols="80"></textarea>
					<%-- 
					<input type="text" id="Remarks" name="Remarks"  onkeypress="RemarksValidation(event)">
					or
					<textarea id="Remarks" name="Remarks" rows="2" cols="80"></textarea>
					--%>
				</div>							
			</div>

			
										
		</fieldset>			  			  			  															

			<div>				
				<br>				
				<div class="col-75"></div>
				<div class="row">
					<input type="submit" id="submit" value="Submit" onclick="InsertUpdateLoanDataFunc(event)">
				</div>
			 </div>
		</div>
	</center>
</body>
</html>
