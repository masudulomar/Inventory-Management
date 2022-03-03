
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
<title>Entry Form</title>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="/resources/demos/style.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<title>Entry Form</title>
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
	var brn_code = "<%= session.getAttribute("BranchCode")%>";
function initValues(){
	document.getElementById("OfficeCode").value = brn_code;
	document.getElementById("LoanCode").value = "";
	document.getElementById("BorrowerName").value="";   //NAME1
	document.getElementById("JointBorrower").value="";  //NAME2
	document.getElementById("FatherName").value="";     //F_NAME
	document.getElementById("HusbandName").value="";    //H_NAME
	document.getElementById("MotherName").value="";     //M_NAME
	document.getElementById("MailingAddress").value=""; //M_ADD1
	document.getElementById("PhoneRes").value="";       //PHONE_RES
	document.getElementById("PhoneOff").value="";       //PHONE_OFF
	document.getElementById("MobileNo").value="";	    //CELL_NO				
	document.getElementById("SiteAddress").value="";    //S_ADD1
	document.getElementById("Email").value="";          //EMAIL
	document.getElementById("ProjCode").value="";       //PROJ_CODE
	document.getElementById("NID1").value="";           //NID1
	document.getElementById("DistrictCode").value="";   //S_DIST_CODE
	document.getElementById("NID2").value="";           //NID2
	document.getElementById("TaxId").value="";      //S_THANA_CODE
	//document.getElementById("Profession").value="";    
	document.getElementById("BankName").value="";    
	document.getElementById("BankAccountNo").value="";    
	document.getElementById("LoanCode").focus();
	   
}

function FetchData(){
		
												
	
		if(document.getElementById("LoanCode").value.toString().length != 13)
		{
			confirm("Loan Code should be 13 digit");
			document.getElementById("LoanCode").focus();
		}
		else
		{	
			clear();
			var string=document.getElementById("LoanCode").value;
			//document.getElementById("LoanCode").value=string.padStart(13, '0');
			SetValue("OfficeCode", document.getElementById("OfficeCode").value,"N");
			SetValue("LoanCode", document.getElementById("LoanCode").value,"N");
			SetValue("Class", "LmsEntryValidation","N");
			SetValue("Method", "FetchLoanData","L");	
			xmlFinal();				
			$.ajax({
				//alert("##");
				  method: "POST",
				  url: "TransactionServlet",
				  data: { DataString: DataMap }
				})
				  .done(function( responseMessage ) {
				    var obj = JSON.parse(responseMessage);
				    if (obj.ERROR_MSG != "") {
						alert(obj.ERROR_MSG);
						document.getElementById("LoanCode").focus();	
					} else {
						if (obj.LOAN_CODE!=null) {
							var c = confirm("Profile already initialized!! Do you Want to Update?");
							if (c == true){
							document.getElementById("BorrowerName").value = obj.NAME1;
							document.getElementById("JointBorrower").value= obj.NAME2;
							document.getElementById("FatherName").value=obj.F_NAME;
							document.getElementById("HusbandName").value=obj.H_NAME;
							document.getElementById("MotherName").value=obj.M_NAME;
							document.getElementById("MailingAddress").value=obj.M_ADD;
							document.getElementById("PhoneRes").value=obj.PHONE_RES;
							document.getElementById("PhoneOff").value=obj.PHONE_OFF;
							document.getElementById("MobileNo").value=obj.CELL_NO;						
							document.getElementById("SiteAddress").value=obj.S_ADD;
							document.getElementById("Email").value=obj.EMAIL;
							document.getElementById("ProjCode").value=obj.PROJ_CODE;
							document.getElementById("NID1").value=obj.NID1;
							document.getElementById("DistrictCode").value=obj.S_DIST_CODE;
							document.getElementById("NID2").value=obj.NID2;
							document.getElementById("ThanaCode").value=obj.S_THANA_CODE;
							document.getElementById("TaxId").value=obj.TIN_NO;
							
							
							document.getElementById("Profession").value=obj.PROFESSION;
							document.getElementById("BankName").value=obj.BANK_NAME;
							document.getElementById("BankAccountNo").value=obj.BANK_ACCOUNT_NO;
							document.getElementById("BorrowerName").focus();
							  }	
						}
						else{
							document.getElementById("BorrowerName").value = "";
							document.getElementById("JointBorrower").value= "";
							document.getElementById("FatherName").value="";
							document.getElementById("HusbandName").value="";
							document.getElementById("MotherName").value="";
							document.getElementById("MailingAddress").value="";
							document.getElementById("PhoneRes").value="";
							document.getElementById("PhoneOff").value="";
							document.getElementById("MobileNo").value="";						
							document.getElementById("SiteAddress").value="";
							document.getElementById("Email").value="";
							document.getElementById("ProjCode").value="";
							document.getElementById("NID1").value="";
							document.getElementById("DistrictCode").value="";
							document.getElementById("NID2").value="";
							document.getElementById("ThanaCode").value="";
							document.getElementById("TaxId").value="";      //S_THANA_CODE
							//document.getElementById("Profession").value="";    
							document.getElementById("BankName").value="";    
							document.getElementById("BankAccountNo").value="";
							document.getElementById("BorrowerName").focus();
						}
						
					}		
			  });		
		}
	
}



function LoanCodeValidation(event){
	clear();
	if (event.keyCode == 13 || event.which == 13) 
	{
		if(document.getElementById("LoanCode").value.toString().length != 13)
		{
			confirm("Loan Code should be 13 digit");
			document.getElementById("LoanCode").focus();
		}
		else
		{	
			document.getElementById("ProductNature").focus();
		}
	}
}

function BorrowerNameValidation(event){
	if (event.keyCode == 13 || event.which == 13) {
		document.getElementById("JointBorrower").focus();
	}
}
function JointBorrowerValidation(event){
	if (event.keyCode == 13 || event.which == 13) {
		document.getElementById("FatherName").focus();
	}
}
function FatherNameValidation(event){
	if (event.keyCode == 13 || event.which == 13) {
		document.getElementById("MotherName").focus();
	}
}
function HusbandNameValidation(event){
	if (event.keyCode == 13 || event.which == 13) {
		document.getElementById("MobileNo").focus();
	}
}
function MotherNameValidation(event){
	if (event.keyCode == 13 || event.which == 13) {
		document.getElementById("HusbandName").focus();
	}
}
function MailingAddressValidation(event){
	if (event.keyCode == 13 || event.which == 13) {
		document.getElementById("SiteAddress").focus();
	}
}
function SiteAddressValidation(event){
	if (event.keyCode == 13 || event.which == 13) {
		document.getElementById("submit").focus();
	}
}
function DistrictCodeValidation(event){
	if (event.keyCode == 13 || event.which == 13) {
		document.getElementById("ThanaCode").focus();
	}
}
function ThanaCodeValidation(event){
	if (event.keyCode == 13 || event.which == 13) {
		document.getElementById("TaxId").focus();
		
	}
}
function TaxIdValidation(event){
	if(event.keycode == 13 || event.which == 13){
		if(document.getElementById("TaxId")==""){
			document.getElementById("TaxId").focus();
		}else{
			document.getElementById("Profession").focus();
		}
	}
}



function ProfessionValidation(event){
	if(event.keycode == 13 || event.which == 13){
		if(document.getElementById("Profession")==""){
			document.getElementById("Profession").focus();
		}else{
			document.getElementById("BankName").focus();
		}
	}
}

function BankNameValidation(event){
	if(event.keycode == 13 || event.which == 13){
		if(document.getElementById("BankName").value==""){
			document.getElementById("BankName").focus();
		}else{
			document.getElementById("BankAccountNo").focus();
		}
		
	}
}

function BankAccountNoValidation(event){
	if(event.keycode == 13 || event.which == 13){
		if(document.getElementById("BankAccountNo")==""){
			document.getElementById("BankAccountNo").focus();
		}else{
			document.getElementById("MailingAddress").focus();
		}
	}
}
function PhoneResValidation(event){
	if (event.keyCode == 13 || event.which == 13) {
		document.getElementById("PhoneOff").focus();
	}
}
function PhoneOffValidation(event){
	if (event.keyCode == 13 || event.which == 13) {
		document.getElementById("NID1").focus();
	}
}
function MobileNoValidation(event)
{
	if (event.keyCode == 13 || event.which == 13) 
	{
		if(document.getElementById("MobileNo").value.toString().length != 11)
		{
			confirm("Mobile Number should be 11 digit");
			document.getElementById("MobileNo").focus();
		}
		else
		{
			document.getElementById("PhoneRes").focus();
		}
	}
}

function EmailValidation(event){
	if (event.keyCode == 13 || event.which == 13) {
		//if(1)
		if(document.getElementById("Email").value.toString().indexOf('@')==-1 || document.getElementById("Email").value.toString().indexOf('@')==0 || document.getElementById("Email").value.toString().indexOf('@')+1==document.getElementById("Email").value.toString().length)
		{
			//confirm(document.getElementById("Email").value.toString().indexOf('@'));
			confirm("Email Address in not valid");
			document.getElementById("Email").focus();
		}
		else
		{
			document.getElementById("NID2").focus();
		}
	}
}
function ProductNatureValidation(event){
	if (event.keyCode == 13 || event.which == 13) {
		document.getElementById("FetchInfo").focus();
	}
}
function ProjCodeValidation(event){
	if (event.keyCode == 13 || event.which == 13) {
		document.getElementById("DistrictCode").focus();
	}
}
function NID1Validation(event){
	if (event.keyCode == 13 || event.which == 13) {
		document.getElementById("Email").focus();
	}
}
function NID2Validation(event){
	if (event.keyCode == 13 || event.which == 13) {
		document.getElementById("ProjCode").focus();
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
			SetValue("BorrowerName",document.getElementById("BorrowerName").value,"N");
			SetValue("JointBorrower",document.getElementById("JointBorrower").value,"N");
			SetValue("FatherName",document.getElementById("FatherName").value,"N");
			SetValue("HusbandName",document.getElementById("HusbandName").value,"N");
			SetValue("MotherName",document.getElementById("MotherName").value,"N");
			SetValue("MailingAddress",document.getElementById("MailingAddress").value,"N");
			
			SetValue("PhoneRes",document.getElementById("PhoneRes").value,"N");
			SetValue("PhoneOff",document.getElementById("PhoneOff").value,"N");
			SetValue("MobileNo",document.getElementById("MobileNo").value,"N");
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

</script>
</head>
<body onload="initValues()">
	<center>
	<label>Borrower Basic Information</label>
		<div class="container">

		<fieldset>
		<legend>Borrower Loan Case </legend> 
			<div class="row">
				<div class="col-15">
					<label for="OfficeCode">Office Code</label>
				</div>
				<div class="col-20">
					<input type="text" id="OfficeCode" name="OfficeCode" readonly>
				</div>
				<div class="colr-15">
					<label for="LoanCode">Loan Code</label>
				</div>
				<div class="colr-20">
					<input type="text" id="LoanCode" name="LoanCode" onkeypress="LoanCodeValidation(event)">
				</div>	
			</div>
				
			<div class="row">
				<div class="col-15">
							<label for="ProductNature">Product Nature</label>
					</div>
					<div class="col-20" style="width: 185px;">
						<select id="ProductNature" name="ProductNature" >							
							<option value="OLD">BHBFC-Deferred</option>
							<option value="EMI">BHBFC-EMI</option>
							<option value="ISF">Project-ISF </option>
							<option value="OCR">Project-OCR </option>
							<option value="GOV">BHBFC-GOV </option>
							<option value="MON">Project-MON </option>
						</select>
					</div>
					
					<div class="colr-15">
						<input type="submit" id="fetchInfo" value="Fetch Information" onclick="FetchData()" > <br>
					</div>
			</div>
			<input type="hidden" name="User" id="User"></input>	
			 
		</fieldset>
		
		
		<fieldset>
		<legend>Borrower Details </legend>	
			<div class="row">
				<div class="col-15">
					<label for="BorrowerName">Borrower Name: </label>
				</div>
				<div class="col-20">
					<input type="text" id="BorrowerName" name="BorrowerName"  onkeypress="BorrowerNameValidation(event)">
				</div>
				<div class="colr-15">
					<label for="JointBorrower">Joint borrower: </label>
				</div>
				<div class="colr-20">
					<input type="text" id="JointBorrower" name="JointBorrower"  onkeypress="JointBorrowerValidation(event)" >
				</div>	
			</div>
				
					
			<div class="row">
				<div class="col-15">
					<label for="FatherName">Father Name: </label>
				</div>
				<div class="col-20">
					<input type="text" id="FatherName" name="FatherName"   onkeypress="FatherNameValidation(event)" >
				</div>
				<div class="colr-15">
					<label for="MotherName">Mother Name: </label>
				</div>
				<div class="colr-20">
					<input type="text" id="MotherName" name="MotherName"  onkeypress="MotherNameValidation(event)">
				</div>
			</div>
				
			<div class="row">
				<div class="col-15">
					<label for="HusbandName">Husband Name: </label>
				</div>
				<div class="col-20">
					<input type="text" id="HusbandName" name="HusbandName"  onkeypress="HusbandNameValidation(event)" >
				</div>
				<div class="colr-15">
					<label for="MobileNo">Mobile no: </label>
				</div>
				<div class="colr-20">
					<input type="text" id="MobileNo" name="MobileNo"  onkeypress="MobileNoValidation(event)">
				</div>											
			 </div>	
				
			
			
			<div class="row">		
				<div class="col-15">
					<label for="PhoneRes">Phone (Res): </label>
				</div>
				<div class="col-20">
					<input type="text" id="PhoneRes" name="PhoneRes"  onkeypress="PhoneResValidation(event)">
				</div>							
				<div class="colr-15">
					<label for="PhoneOff">Phone (Off): </label>
				</div>
				<div class="colr-20">
					<input type="text" id="PhoneOff" name="PhoneOff"  onkeypress="PhoneOffValidation(event)">
				</div>
			</div>
			
			<div class="row">	
				<div class="col-15">
					<label for="NID1">NID1: </label>
				</div>
				<div class="col-20">
					<input type="text" id="NID1" name="NID1"  onkeypress="NID1Validation(event)">
				</div>
				<div class="colr-15">
					<label for="Email">Email: </label>
				</div>
				<div class="colr-20">
					<input type="text" id="Email" name="Email"  onkeypress="EmailValidation(event)">
				</div>									
				
			</div>
			
			<div class="row">
				<div class="col-15">
					<label for="NID2">NID2: </label>
				</div>
				<div class="col-20">
					<input type="text" id="NID2" name="NID2"  onkeypress="NID2Validation(event)">
				</div>	
				<div class="colr-15">
					<label for="ProjCode">Proj code: </label>
				</div>
				<%/*
				<div class="col-1">
					<input type="text" id="ProjName" name="ProjName"  onkeypress="ProjValidation(event)">
				</div>
				*/%>
				<div class="colr-20">
					<input type="text" id="ProjCode" name="ProjCode"  onkeypress="ProjCodeValidation(event)">
				</div>
				
			</div>
			
			<div class="row">									
				<div class="col-15">
					<label for="DistrictCode">District Code: </label>
				</div>
				<div class="col-20">
					<input type="text" id="DistrictCode" name="DistrictCode"   onkeypress="DistrictCodeValidation(event)">
				</div>	
				<div class="colr-15">
					<label for="ThanaCode">Thana Code: </label>
				</div>
				<%/*
				<div class="col-3">
					<input type="text" id="ThanaName" name="ThanaName"   onkeypress="ThanaNameValidation(event)">
				</div>	
				*/%>
				<div class="colr-20">
					<input type="text" id="ThanaCode" name="ThanaCode"   onkeypress="ThanaCodeValidation(event)">
				</div>	
				
			</div>
			<div class="row">
				<div class="col-15">
					<label for="TaxId">TAX ID No. (TIN):</label>
				</div>
				<div class="col-20">
					<input type="text" id="TaxId" name="TaxId" onkeypress="TaxIdValidation(event)" >
				</div>
				<div class="colr-15">
					<label for="Profession">Profession:</label>
				</div>
				<div class="colr-20">
					<select name="Profession" id="Profession" onkeypress="ProfessionValidation(event)">
					  <option value="private" selected>Private Employee</option>
					  <option value="govt" >Govt. Employee</option>
					  <option value="business" >Businessman</option>
					  <option value="others" >Others</option>
					</select>
				</div>											
			 </div>
			<div class="row">
				<div class="col-15">
					<label for="BankName">Bank Name:</label>
				</div>
				<div class="col-20">
					<input type="text" id="BankName" name="BankName" onkeypress="BankNameValidation(event)" >
				</div>
				<div class="colr-15">
					<label for="BankAccountNo">Bank Account No:</label>
				</div>
				<div class="colr-20">
					<input type="text" id="BankAccountNo" name="BankAccountNo" onkeypress="BankAccountNoValidation(event)" >
				</div>
															
			 </div>
			<div class="row">
				<div class="col-15">
					<label for="MailingAddress">Mailing address: </label>
				</div>
				<div class="col-20">
					<textarea id="MailingAddress" name="MailingAddress" rows="2" cols="40"  onkeypress="MailingAddressValidation(event)"></textarea>
				</div>										
				<div class="colr-15">
						<label for="SiteAddress">Site address: </label>
					</div>
					<div class="colr-20">
						<textarea id="SiteAddress" name="SiteAddress" rows="2" cols="40" onkeypress="SiteAddressValidation(event)"></textarea>
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
