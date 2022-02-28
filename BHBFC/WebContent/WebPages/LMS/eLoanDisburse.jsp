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
<%@ page import = "java.io.*,java.util.*" %>
<%@ page import = "javax.servlet.*,java.text.*" %>
<title>Insert title here</title>

<style>

.datepicker
{ 
    width: 10.5em;
    height: 2.5em;
} 
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
var operation="";
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
	
	document.getElementById("OfficeCode").value = "<%= session.getAttribute("BranchCode")%>";	
	document.getElementById("BorrowerName").value="";
	document.getElementById("LoanCode").value="";
	document.getElementById("NoOfDisburse").value="";
	document.getElementById("IssueDate").value="";
	document.getElementById("DeliveryDate").value="";
	document.getElementById("Amount").value="";
	document.getElementById("ChequeNo").value="";
	document.getElementById("LoanCode").focus();		
}
$(function() {
	$("#IssueDate").datepicker({
		dateFormat : 'dd-M-yy'
	});
});
$(function() {
	$("#DeliveryDate").datepicker({
		dateFormat : 'dd-M-yy'
	});
});

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
								document.getElementById("DisbursementType").focus();
						  }						
					else{
						    alert("Invalid account number");
							document.getElementById("LoanCode").focus();	
					}
					
				}		
		  });												
  }
}

function DisbursementTypeValidation(event){
	if (event.keyCode == 13 || event.which == 13) {
		document.getElementById("NoOfDisburse").focus();
	}
}
function NoOfDisburseValidation(event){
	if (event.keyCode == 13 || event.which == 13) {
		if(document.getElementById("NoOfDisburse").value==""){
			alert("No of Disburse Should Not be Blank");
			document.getElementById("NoOfDisburse").focus();	
		}
		else{
			var string=document.getElementById("LoanCode").value;
			document.getElementById("LoanCode").value=string.padStart(13, '0');
			clear();	
			SetValue("LoanCode", document.getElementById("LoanCode").value,"N");
			SetValue("OfficeCode", document.getElementById("OfficeCode").value,"N");
			SetValue("DisbursementType", document.getElementById("DisbursementType").value,"N");
			SetValue("NoOfDisburse", document.getElementById("NoOfDisburse").value,"N");
			SetValue("Class", "LmsEntryValidation","N");
			SetValue("Method", "FetchLoanDisburseData","L");	
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
						if (obj.NO_OF_DISB!=null) { 
							var r = confirm("Disbursement already Posted !\nDo you want to update?");
							  if (r == true) {
								  operation="update";
								  document.getElementById("DisbursementType").value=obj.DISB_COMP;
								  document.getElementById("IssueDate").value=obj.ISSU_DATE;
								  document.getElementById("DeliveryDate").value=obj.DELV_DATE;
							      document.getElementById("Amount").value=obj.DISB_AMT;
								  document.getElementById("ChequeNo").value=obj.CHEQUE_NO;
								  document.getElementById("IssueDate").focus();													   
							  }  
							  else
								  {
								  operation="insert";
								  	  initValues();
								  }
						}else{
							document.getElementById("IssueDate").value="";
							document.getElementById("DeliveryDate").value="";
							document.getElementById("Amount").value="";
							document.getElementById("ChequeNo").value="";
							document.getElementById("IssueDate").focus();	
						} 
						
					}		
			  });
		}														
  }
}

function IssueDateValidation(event){
	if (event.keyCode == 13 || event.which == 13) {
		if(document.getElementById("IssueDate").value==""){
			alert("Issue date should not Blank!!");
			document.getElementById("IssueDate").focus();
		}
		else{
			document.getElementById("DeliveryDate").focus();
		}
		
	}
}
function DeliveryDateValidation(event){
	if (event.keyCode == 13 || event.which == 13) {
		if(document.getElementById("DeliveryDate").value==""){
			alert("Delivery date should not Blank!!");
			document.getElementById("DeliveryDate").focus();
		}
		else{
			document.getElementById("Amount").focus();
		}
		
	}
}

function AmountValidation(event){
	if (event.keyCode == 13 || event.which == 13) {		
		if(document.getElementById("Amount").value==""){
			alert("Amount Should not be blank");
			document.getElementById("Amount").focus();
		}
		else{			
			if (isNaN(document.getElementById("Amount").value)) {
			    alert("Pay Amount Must be Number !!");
			    document.getElementById("Amount").focus();
			  }
			else{
				document.getElementById("ChequeNo").focus();
			}
		}
		
	}
}



function ChequeNoValidation(event){
	if (event.keyCode == 13 || event.which == 13) {
		if(document.getElementById("ChequeNo").value==""){
			alert("Cheque No. Should not be Blank!!");
			document.getElementById("ChequeNo").focus();
		}
		else{
			document.getElementById("submit").focus();
		}		
	}
}
function DateValidation(){
    clear();
	SetValue("PayDate", document.getElementById("DeliveryDate").value,"N");	
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

function UpdateLoanDisburseData(event)
{	
	 var c = confirm("Are you sure ?");
	  if (c == true) {		  		  
		  if (document.getElementById("NoOfDisburse").value==""
				  ||document.getElementById("IssueDate").value==""
				  ||document.getElementById("DeliveryDate").value==""
				  ||document.getElementById("ChequeNo").value==""
				  ||document.getElementById("Amount").value=="")  {
			  
				if(document.getElementById("NoOfDisburse").value==""){
					 alert("No of Disburse Should not be Blank !!");
					 document.getElementById("NoOfDisburse").focus();
				}
				else if(document.getElementById("IssueDate").value==""){
					 alert("Issue Date  Should not be Blank !!");
					 document.getElementById("IssueDate").focus();
				} 
				else if(document.getElementById("DeliveryDate").value==""){
					 alert("Delivery Date  Should not be Blank !!");
					 document.getElementById("DeliveryDate").focus();
				} 
				
				else if(document.getElementById("Amount").value==""){
					 alert("Disburse Amount not be Blank !!");
					 document.getElementById("Amount").focus();
				} 
				
				else if(document.getElementById("ChequeNo").value==""){
					 alert("ChequeNo  Should not be Blank !!");
					 document.getElementById("ChequeNo").focus();
				} 
			}
			else
				{

		 		var UserID= "<%= session.getAttribute("User_Id")%>";
		 		clear();			    
				SetValue("LoanCode", document.getElementById("LoanCode").value,"N");
				SetValue("OfficeCode", document.getElementById("OfficeCode").value,"N");
				SetValue("User_Id", UserID,"N");
				SetValue("DisbursementType", document.getElementById("DisbursementType").value,"N");			
				SetValue("NoOfDisburse", document.getElementById("NoOfDisburse").value,"N");
				SetValue("IssueDate", document.getElementById("IssueDate").value,"N");						
				SetValue("DeliveryDate", document.getElementById("DeliveryDate").value,"N");			
				SetValue("Amount", document.getElementById("Amount").value,"N");
				SetValue("ChequeNo", document.getElementById("ChequeNo").value,"N");
				SetValue("Class","LmsEntryValidation","N");
				SetValue("Method","UpdateLoanDisburseData","L");
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
}


</script>

</head>
<body onload="initValues()">
	<center>
	<label>Loan Disburse Entry</label>
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
										
					<div class="col-15">
						<label for="BorrowerName">Name</label>
					</div>
					<div class="col-20">
						<input type="text" id="BorrowerName" name="BorrowerName"   readonly style="width: 320px;" >
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
				<legend>Disbursement Details </legend>
															
				 
				 <div class="row">
				     <div class="col-15">
						<label for="DisbursementType">Disbursement Type</label>
					</div>
					<div class="col-20">
						<select id="DisbursementType" name="DisbursementType"   style="width: 242px;">	
						    <option value="I">Incomplete</option>					   
							<option value="C">Complete</option>
						</select>
					</div>		
					
					<div class="col-15">
						<label for="NoOfDisburse">No. of Disburse</label>
					</div>
					<div class="col-20">
						<input type="text" id="NoOfDisburse" name="NoOfDisburse"  onkeypress="NoOfDisburseValidation(event)">
					</div>										
				 </div>	


				 				 
				 <div class="row">
					<div class="col-15">
						<label for="IssueDate">Issue Date</label>
					</div>
					<div class="col-20">
						<input type="text" id="IssueDate" name="IssueDate" onkeypress="IssueDateValidation(event)">
					</div>
					
					<div class="col-15">
						<label for="DeliveryDate">Delivery Date</label>
					</div>
					<div class="col-20">
						<input type="text" id="DeliveryDate" name="DeliveryDate"  onkeypress="DeliveryDateValidation(event)">
					</div>										
				 </div>	
				
				 <div class="row">
					<div class="col-15">
						<label for="Amount">Amount</label>
					</div>
					<div class="col-20">
						<input type="text" id="Amount" name="Amount" onkeypress="AmountValidation(event)" ></input>
					</div>
					
					<div class="col-15">
						<label for="ChequeNo">Cheque No</label>
					</div>
					<div class="col-20">
						<input type="text" id="ChequeNo" name="ChequeNo"  onkeypress="ChequeNoValidation(event)"></input>
					</div>										
				 </div>	
				

			
				</fieldset>	
																	
				<div>				
				<br>				
				<div class="col-75"></div>
				<div class="row">
					<input type="submit" id="submit" value="Submit" onclick="UpdateLoanDisburseData(event)" >
				</div>
			 </div>
			</div>
	</center>
</body>
</html>