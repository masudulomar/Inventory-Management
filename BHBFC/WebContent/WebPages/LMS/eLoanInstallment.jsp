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

<title>ELoanInstalllment Page</title>

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

var User_Id="<%=session.getAttribute("User_Id")%>"

function IsValidDate(myDate) {
    var filter = /^([012]?\d|3[01])-([Jj][Aa][Nn]|[Ff][Ee][bB]|[Mm][Aa][Rr]|[Aa][Pp][Rr]|[Mm][Aa][Yy]|[Jj][Uu][Nn]|[Jj][u]l|[aA][Uu][gG]|[Ss][eE][pP]|[oO][Cc]|[Nn][oO][Vv]|[Dd][Ee][Cc])-(19|20)\d\d$/
    return filter.test(myDate);
}

function fetchData(){
			var branchCode ="<%= session.getAttribute("BranchCode")%>";
		    clear();	
			SetValue("LoggedBranch", branchCode,"N");
			SetValue("Class", "LmsEntryValidation","N");
			SetValue("Method", "FetchBankInfo","L");
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
						var item_srting=obj.BANK_LIST;	
						var select = document.getElementById("BankCode");                  
						 var item_arrayList = item_srting.split('#');
						 for(var i = 0; i < item_arrayList.length; i++) {
							// item_arrayList[i] = item_arrayList[i].replace("/^\s*/", "").replace("/^\s*/", "");							 
							    var item_keyValue = item_arrayList[i].split(':');
							    var option = document.createElement("option");
							    option.value=item_keyValue[0] ;
							    option.text=item_keyValue[1];	
							    select.add(option, null);				   				   
						 }
					}
			});		  
	 			
}

function initValues(){	
	fetchData();
	
	document.getElementById("OfficeCode").value = "<%= session.getAttribute("BranchCode")%>";
	document.getElementById("BorrowerName").value="";
	document.getElementById("BankName").value="";
	document.getElementById("LoanCode").value = "";
	document.getElementById("MemoNo").value="";
	document.getElementById("PayDate").value="";
	document.getElementById("PayAmount").value="";
	document.getElementById("LoanCode").focus();	
}

function LoanCodeValidation(event){
			if (event.keyCode == 13 || event.which == 13) {
			clear();
			var string=document.getElementById("LoanCode").value;
			document.getElementById("LoanCode").value=string.padStart(13, '0');
			SetValue("OfficeCode", document.getElementById("OfficeCode").value,"N");
			SetValue("LoanCode", document.getElementById("LoanCode").value,"N");
			SetValue("Class", "LmsEntryValidation","N");
			SetValue("Method", "FetchBorrowerName","L");	
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
						document.getElementById("LoanCode").focus();	
					} else {
						if (obj.NAME1!=null) {
								    document.getElementById("BorrowerName").value=obj.NAME1;								    
									document.getElementById("PayDate").focus();
							  }						
						else{
							    alert("Invalid account number");
								document.getElementById("LoanCode").focus();	
						}
						
					}		
			  });												
   }
}
function MemoNoValidation(event){
	 clear();
		if (event.keyCode == 13 || event.which == 13) {
			
			if(document.getElementById("MemoNo").value==""){
				alert("Memo No should not be blank!!");
				document.getElementById("MemoNo").focus();
			}else{

				SetValue("OfficeCode", "<%= session.getAttribute("BranchCode")%>","N");
				SetValue("LoanCode", document.getElementById("LoanCode").value,"N");
				SetValue("MemoNo", document.getElementById("MemoNo").value,"N");
				SetValue("PayDate", document.getElementById("PayDate").value,"N");			
				SetValue("Class", "LmsEntryValidation","N");
				SetValue("Method", "FetchinstallmentData","L");	
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
							
							document.getElementById("BankCode").focus();	
						} else {
							if (obj.MEMO_NO!=null) {
									
								 var c = confirm("Memo Already Exist !! Do you Want to Update?");
								  if (c == true) {
									  document.getElementById("MemoNo").value=obj.MEMO_NO;
									    document.getElementById("PayDate").value=obj.PAY_DATE;
									    document.getElementById("BankCode").value=obj.BANK;
										document.getElementById("PayAmount").value=obj.PAY_AMT;
										document.getElementById("Purpose").value=obj.PURPOSE;
										document.getElementById("Idcp").value=obj.IDCP;
										document.getElementById("BankCode").focus();
								  }
								  else{
									  document.getElementById("MemoNo").focus();	
								  }
							}
							else{
								document.getElementById("PayAmount").value="";
								document.getElementById("BankCode").focus();	
							}
							
						}		
				  });	
			}
			
														
   }
}

function BankCodeValidation(event){
	if (event.keyCode == 13 || event.which == 13) {
		clear();
		SetValue("BankCode", document.getElementById("BankCode").value,"N");
		SetValue("Class", "LmsEntryValidation","N");
		SetValue("Method", "FetchBankName","L");	
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
					document.getElementById("BankCode").focus();	
				} else {
					if (obj.BK_DESC!=null) {
						document.getElementById("BankName").value=obj.BK_DESC;	
						document.getElementById("PayAmount").focus();
					}
					else
						{
							alert("Invalid Bank Code!!");					
							document.getElementById("BankCode").focus();	
						}					
				}		
		  });														
	}
}
function PayDateValidation(event){
	if (event.keyCode == 13 || event.which == 13) {		
		document.getElementById("MemoNo").focus();
	}
}

function PayAmountValidation(event){
	if (event.keyCode == 13 || event.which == 13) {
		if(document.getElementById("PayAmount").value==""){
			 alert("Pay Amount Should not be blank !!");
			    document.getElementById("PayAmount").focus();
		}else{
			if (isNaN(document.getElementById("PayAmount").value)) {
			    alert("Pay Amount Must be Number !!");
			    document.getElementById("PayAmount").focus();
			  }
			else{
				document.getElementById("Idcp").focus();
			}
		}
	}
			
}
function IdcpValidation(event){
	if (event.keyCode == 13 || event.which == 13) {
		document.getElementById("Purpose").focus();
		
	}
}
function PurposeValidation(event){
	if (event.keyCode == 13 || event.which == 13) {
		document.getElementById("submit").focus();
	}
}

function DateValidation(){
	    clear();
		SetValue("PayDate", document.getElementById("PayDate").value,"N");	
		SetValue("Class","LmsEntryValidation","N");
		SetValue("Method","PaymentDateValidation","L");
		xmlFinal();       	
	 	$.ajax({
			  method: "POST",
			  url: "TransactionServlet",
			  data: { DataString: DataMap }
			})
			  .done(function( responseMessage ) {
			    var obj = JSON.parse(responseMessage);
			  if (obj.ERROR_MSG != "") {
					return false;
				} else {
					return true;
				}		
		 });		
}


function InsertUpdateMemoData(event)
{	
	 var c = confirm("Are you sure ?");
	  if (c == true) {		
				 var branchName= "<%= session.getAttribute("BRN_NAME")%>";
				 var User_Id="<%=session.getAttribute("User_Id")%>";	
				
			if (document.getElementById("MemoNo").value==""||document.getElementById("PayDate").value=="") {
				if(document.getElementById("MemoNo").value==""){
					 alert("Memo Number Should not be Blank !!");
					 document.getElementById("MemoNo").focus();
				}
				else if(document.getElementById("PayDate").value==""){
					 alert("Payment Date Should not be Blank !!");
					 document.getElementById("PayDate").focus();
				}   
			}
			else
				{
				clear();
				SetValue("LoanCode", document.getElementById("LoanCode").value,"N");
				SetValue("OfficeCode", document.getElementById("OfficeCode").value,"N");
				SetValue("BankCode", document.getElementById("BankCode").value,"N");			
				SetValue("MemoNo", document.getElementById("MemoNo").value,"N");
				SetValue("PayDate", document.getElementById("PayDate").value,"N");	
				SetValue("PayAmount", document.getElementById("PayAmount").value,"N");		
				SetValue("Purpose", document.getElementById("Purpose").value,"N");
				SetValue("User_Id", User_Id,"N");
				SetValue("Idcp", document.getElementById("Idcp").value,"N");
				SetValue("Class","LmsEntryValidation","N");
				SetValue("Method","InsertUpdateMemoData","L");
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
					}		
	  		    });	
			}						
	  }					
}

$(function() {
	$("#PayDate").datepicker({
		dateFormat : 'dd-M-yy'
	});
});

</script>

</head>
<body onload="initValues()">
	<center>
	<label>Loan installment Entry List</label>
		<div class="container">
		   	
		      <fieldset>
		      <legend>Borrower Loan Case </legend> 
		      
		       <div class="row">
					<div class="col-15">
						<label for="OfficeCode">Office Code</label>
					</div>
					<div class="col-20">
						<input type="text" id="OfficeCode" name="OfficeCode" >
					</div>	
					<div class="col-15">
						<label for="BorrowerName">Borrower Name</label>
					</div>
					<div class="col-20">
						<input type="text" id="BorrowerName" name="BorrowerName" readonly style="width: 320px;" >
					</div>
					
					<input type="hidden" name="User" id="User"></input>		
																								
				 </div>		
		      
		       <div class="row">
						<div class="col-15">
						<label for="LoanCode">Loan Code[13 digit]</label>
					</div>
					<div class="col-20">
						<input type="text" id="LoanCode" name="LoanCode" onkeypress="LoanCodeValidation(event)">
					</div>
					 <div class="col-75">
						<label> NB: Please Enter after giving 13 digit LOAN CODE !!!</label>
					</div>			
				 </div>	
				
				 
				 	      				
				</fieldset>	
					
				<fieldset>	
				<legend>Installment Details </legend>
															
				 
				 <div class="row">
				 <div class="col-15">
						<label for="PayDate">Pay Date</label>
					</div>
					<div class="col-20">
						<input type="text" id="PayDate" name="PayDate"  onkeypress="PayDateValidation(event)">
					</div>	
					<div class="col-15">
						<label for="MemoNo">Memo/Cheque No</label>
					</div>
					<div class="col-20">
						<input type="text" id="MemoNo" name="MemoNo" onkeypress="MemoNoValidation(event)">
					</div>
					
														
				 </div>	
				 <div class="row">
					<div class="col-15">
						<label for="BankCode">Bank Code</label>
					</div>
					<div class="col-20">
					<select id="BankCode" name="BankCode" style="width: 400px;" ></select>
					</div>
													
				 </div>	
					
				 <div class="row">
				 <div class="col-15">
						<label for="PayAmount">Pay Amount</label>
					</div>
					<div class="col-20">
						<input type="text" id="PayAmount" name="PayAmount"  onkeypress="PayAmountValidation(event)">
					</div>
				     <div class="col-15">
						<label for="Idcp">IDCP</label>
					</div>
					<div class="col-20">
						<select id="Idcp" name="Idcp"  >	
						    <option value="N" selected>No</option>										   
							<option value="Y">Yes</option>									
						</select>
					</div>		
				 
				 
				 </div>
							 
				 <div class="row">
					<div class="col-15">
						<label for="Purpose">Purpose</label>
					</div>
					<div class="col-20">
						<select id="Purpose" name="Purpose"  onkeypress="PurposeValidation(event)">						   
							<option value="M" selected>MEMO </option>						
						</select>
						<!-- <textarea id="Purpose" name="Purpose" rows="2" cols="40" onkeypress="PurposeValidation(event)" ></textarea> -->
					</div>
					<!--  <div class="col-20">
						<input type="text" id="Purpose" name="Purpose" onkeypress="NIDValidation(event)">
					</div>-->
														
				 </div>	
													
			
				</fieldset>	
																	
				<div>				
				<br>				
				<div class="col-75"></div>
				<div class="row">
					<input type="submit" id="submit" value="Submit" onclick="InsertUpdateMemoData(event)" >
				</div>
			 </div>
			</div>
	</center>
</body>
</html>