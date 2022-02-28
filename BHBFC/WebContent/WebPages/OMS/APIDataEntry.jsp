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
	width: 20%;
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
/* cause google chrome cant assign fetched data in front end form */

var userId="";

function IsValidDate(myDate) {
    var filter = /^([012]?\d|3[01])-([Jj][Aa][Nn]|[Ff][Ee][bB]|[Mm][Aa][Rr]|[Aa][Pp][Rr]|[Mm][Aa][Yy]|[Jj][Uu][Nn]|[Jj][u]l|[aA][Uu][gG]|[Ss][eE][pP]|[oO][Cc]|[Nn][oO][Vv]|[Dd][Ee][Cc])-(19|20)\d\d$/
    return filter.test(myDate);
}
function initValues(){	
	
	document.getElementById("LoanCode").value = "";
	document.getElementById("OfficeCode").value = "<%= session.getAttribute("BranchCode")%>";	
	document.getElementById("BorrowerName").value="";
	document.getElementById("SiteLocation").value="";
	document.getElementById("Address").value="";
	document.getElementById("FathersName").value="";
	document.getElementById("MailAddress").value="";
	document.getElementById("PhoneNumber").value="";
	document.getElementById("NID").value="";
	document.getElementById("TIN").value="";
	document.getElementById("PhoneNumber").value="";
//	document.getElementById("lnstatus").value="";
	document.getElementById("LoanCode").focus();	
}

function LoanCodeValidation(event){
		if (event.keyCode == 13 || event.which == 13) {
			var string=document.getElementById("LoanCode").value;
			document.getElementById("LoanCode").value=string.padStart(13, '0');
			clear();	
			SetValue("LoanCode", document.getElementById("LoanCode").value,"N");
			SetValue("OfficeCode", document.getElementById("OfficeCode").value,"N");
			SetValue("ProductNature", document.getElementById("ProductNature").value,"N");
			SetValue("Class", "ServiceValidation","N");
			SetValue("Method", "FetchAPIData","L");	
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
						if (obj.BORROWER_NAME!=null) {
							var r = confirm("API Data already exists!\nDo you want to update?");
							  if (r == true) {	
								  	document.getElementById("lnstatus").value=obj.LN_STATUS;
								    document.getElementById("BorrowerName").value=obj.BORROWER_NAME;
								    document.getElementById("FathersName").value=obj.BORROWER_F_NAME;
								    document.getElementById("SiteLocation").value=obj.SITE_LOCATION;
									document.getElementById("Address").value=obj.MAILING_LOCATION;
									document.getElementById("MailAddress").value=obj.MAIL_ID;
									document.getElementById("PhoneNumber").value=obj.MOBILE_NO;
									document.getElementById("NID").value=obj.NID;
									document.getElementById("TIN").value=obj.TIN;
									document.getElementById("BorrowerName").focus();
							  }
						}
						else{
							document.getElementById("BorrowerName").value="";
							document.getElementById("FathersName").value="";
							document.getElementById("SiteLocation").value="";
							document.getElementById("Address").value="";
							document.getElementById("MailAddress").value="";
							document.getElementById("PhoneNumber").value="";
							document.getElementById("NID").value="";
							document.getElementById("TIN").value="";
							document.getElementById("PhoneNumber").value="";
							document.getElementById("BorrowerName").focus();	
						}
						
					}		
			  });												
   }
}

function BorrowerNameValidation(event){
	if (event.keyCode == 13 || event.which == 13) {
		document.getElementById("FathersName").focus();
	}
}

function FathersNameValidation(event){
	if (event.keyCode == 13 || event.which == 13) {
		document.getElementById("NID").focus();
	}
}
function NIDValidation(event){
	if (event.keyCode == 13 || event.which == 13) {
		document.getElementById("TIN").focus();
	}
}
function TINValidation(event){
	if (event.keyCode == 13 || event.which == 13) {
		document.getElementById("SiteLocation").focus();
	}
}
function SiteLocationValidation(event){
	if (event.keyCode == 13 || event.which == 13) {
		document.getElementById("Address").focus();
	}
}
function AddressValidation(event){
	if (event.keyCode == 13 || event.which == 13) {
		document.getElementById("MailAddress").focus();
	}
}


function validateEmail(email) {
	  const re = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
	  return re.test(email);
	}

function EmailIdValidation(event){
	if (event.keyCode == 13 || event.which == 13) {
		 if (validateEmail(document.getElementById("MailAddress").value)) {
			 document.getElementById("PhoneNumber").focus();
			  } else {
			    alert(document.getElementById("MailAddress").value + " is not valid ");
			    document.getElementById("MailAddress").focus();
			  }
	}
}

function PhoneNumberValidation(event){
	if (event.keyCode == 13 || event.which == 13) {
		var phoneno = /^\d{11}$/;
		var inputText=document.getElementById("PhoneNumber").value;
		if((inputText.match(phoneno))){
			document.getElementById("submit").focus();
		}else{
			alert(document.getElementById("PhoneNumber").value + " is not valid ");
		    document.getElementById("PhoneNumber").focus();
		}
	}
}

function UpdateAPIData(event)
{	
	 var c = confirm("Are you sure ?");
	  if (c == true) {
		  var User_Id="<%=session.getAttribute("User_Id")%>";	
		 var branchName= "<%= session.getAttribute("BRN_NAME")%>";	
		    clear();			    
		    SetValue("User_Id", User_Id,"N");
			SetValue("LoanCode", document.getElementById("LoanCode").value,"N");
			SetValue("OfficeCode", document.getElementById("OfficeCode").value,"N");
			SetValue("ProductNature", document.getElementById("ProductNature").value,"N");			
			SetValue("MailAddress", document.getElementById("MailAddress").value,"N");
			SetValue("PhoneNumber", document.getElementById("PhoneNumber").value,"N");						
			SetValue("lnstatus", document.getElementById("lnstatus").value,"N");
			SetValue("BorrowerName", document.getElementById("BorrowerName").value,"N");
			SetValue("FathersName", document.getElementById("FathersName").value,"N");
			SetValue("SiteLocation", document.getElementById("SiteLocation").value,"N");
			SetValue("branchName", branchName,"N");
			SetValue("Address", document.getElementById("Address").value,"N");				
			SetValue("NID", document.getElementById("NID").value,"N");
			SetValue("TIN", document.getElementById("TIN").value,"N");	
			SetValue("Class","ServiceValidation","N");
			SetValue("Method","UpdateAPIData","L");
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

$(function() {
	$("#entyDate").datepicker({
		dateFormat : 'dd-M-yy'
	});
});

</script>

</head>
<body onload="initValues()">
	<center>
	<label>API Loan Account Entry List for SBL</label>
		<div class="container">
		   	
		      <fieldset>
		      <legend>Borrower Loan Case </legend> 
		      
		       <div class="row">
					<div class="col-15">
						<label for="OfficeCode">Office Code</label>
					</div>
					<div class="col-20">
						<input type="text" id="OfficeCode" name="OfficeCode" onkeypress="OfficeCodeValidation(event)" >
					</div>	
										
					 <div class="col-15">
						<label for="ProductNature">Product Nature</label>
					</div>
					<div class="col-20">
						<select id="ProductNature" name="ProductNature"   style="width: 240px;">						   
							<option value="OLD">OLD</option>
							<option value="EMI">EMI</option>
							<option value="ISF">ISF</option>
							<option value="OCR">OCR</option>
							<option value="GOV">GOV</option>
							<option value="MON">Monzil</option>
						</select>
					</div>																								
				 </div>		
		      
		       <div class="row">
					<div class="col-15">
						<label for="LoanCode">Loan Code[13 digit]</label>
					</div>
					<div class="col-20">
						<input type="text" id="LoanCode" name="LoanCode" onkeypress="LoanCodeValidation(event)">
					</div>
					 <div class="col-75">
						<label>NB: Please Enter after giving 13 digit LOAN CODE !!!</label>
					</div>														
				 </div>	
				
				 
				 	      				
				</fieldset>	
					
				<fieldset>	
				<legend>Borrower Details </legend>
															
				 
				 <div class="row">
					<div class="col-15">
						<label for="BorrowerName">Borrower Name</label>
					</div>
					<div class="col-20">
						<input type="text" id="BorrowerName" name="BorrowerName" onkeypress="BorrowerNameValidation(event)">
					</div>
					
					<div class="col-15">
						<label for="FathersName">Father's Name</label>
					</div>
					<div class="col-20">
						<input type="text" id="FathersName" name="FathersName"  onkeypress="FathersNameValidation(event)">
					</div>										
				 </div>	

				 <div class="row">
				     <div class="col-15">
						<label for="lnstatus">Status</label>
					</div>
					<div class="col-20">
						<select id="lnstatus" name="lnstatus"   style="width: 242px;">						   
							<option value="Y">Y-Active</option>
							<option value="N">N-Inactive</option>
							<option value="D">D-Drop</option>							
						</select>
					</div>		
				 
				 
				 </div>
				 				 
				 <div class="row">
					<div class="col-15">
						<label for="NID">NID</label>
					</div>
					<div class="col-20">
						<input type="text" id="NID" name="NID" onkeypress="NIDValidation(event)">
					</div>
					
					<div class="col-15">
						<label for="TIN">TIN</label>
					</div>
					<div class="col-20">
						<input type="text" id="TIN" name="TIN"  onkeypress="TINValidation(event)">
					</div>										
				 </div>	
				
				 <div class="row">
					<div class="col-15">
						<label for="SiteLocation">Site Location</label>
					</div>
					<div class="col-20">
						<textarea id="SiteLocation" name="SiteLocation" rows="2" cols="40" onkeypress="SiteLocationValidation(event)" ></textarea>
					</div>
					
					<div class="col-15">
						<label for="Address">Address</label>
					</div>
					<div class="col-20">
						<textarea id="Address" name="Address" rows="2" cols="40"  onkeypress="AddressValidation(event)"></textarea>
					</div>										
				 </div>	
				
				<div class="row">
					<div class="col-15">
						<label for="MailAddress">Email ID:</label>
					</div>
					<div class="col-20">
						<input type="text" id="MailAddress" name="MailAddress" onkeypress="EmailIdValidation(event)">
					</div>
					
					<div class="col-15">
						<label for="PhoneNumber">Phone Number</label>
					</div>
					<div class="col-20">
						<input type="text" id="PhoneNumber" name="PhoneNumber"  onkeypress="PhoneNumberValidation(event)">
					</div>										
				 </div>	
			
				</fieldset>	
																	
				<div>				
				<br>				
				<div class="col-75"></div>
				<div class="row">
					<input type="submit" id="submit" value="Submit" onclick="UpdateAPIData(event)" >
				</div>
			 </div>
			</div>
	</center>
</body>
</html>