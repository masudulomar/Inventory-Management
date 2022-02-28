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
	background-color: #85adad;
	padding: 20px;
}

.col-15 {
	float: left;
	width: 15%;
}
.colr-15 {
	float: left;
	width: 15%;
	margin-left: 50px;
}
.col-20 {
	float: left;
	width: 27%;
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

.col-90 {
	float: left;
	width: 66.5%;
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

	function initValues() {
		document.getElementById("NothiNo").value="";				
		document.getElementById("NothiNo").focus();
	}
	
	
	
function IsValidDate(myDate) {
    var filter = /^([012]?\d|3[01])-([Jj][Aa][Nn]|[Ff][Ee][bB]|[Mm][Aa][Rr]|[Aa][Pp][Rr]|[Mm][Aa][Yy]|[Jj][Uu][Nn]|[Jj][u]l|[aA][Uu][gG]|[Ss][eE][pP]|[oO][Cc]|[Nn][oO][Vv]|[Dd][Ee][Cc])-(19|20)\d\d$/
    return filter.test(myDate);
}
	
	
	$(function() {
		$("#EffectiveDate").datepicker({
			dateFormat : 'dd-M-yy'
		});
	});
	
	$(function() {
		$("#VoucherDate").datepicker({
			dateFormat : 'dd-M-yy'
		});
	});
	
</script>

</head>
<body onload="initValues()">
	<center>
		<div class="container">
		
             <fieldset> 
                 <legend>Identifier</legend> 
                 
                 <div class="row">
					<div class="col-15">
						<label for="Year">Year</label>
					</div>
					<div class="col-20">
						<input type="text" id="Year" name="Year" onkeypress="EmployeeIdValidation(event)">
					</div>
														
					<div class="colr-15">
							<label for="MonthCode">Month</label>
					</div>
					<div class="colr-20">
						<select id="MonthCode" name="MonthCode"  onkeypress="MonthCodeValidation(event)" style="width: 176px;">
							<option value="1">January</option>
							<option value="2">February</option>
							<option value="3">March</option>
							<option value="4">April</option>
							<option value="5">May</option>
							<option value="6">June</option>
							<option value="7">July</option>
							<option value="8">August</option>
							<option value="9">September</option>
							<option value="10">October</option>
							<option value="11">November</option>
							<option value="12">December</option>
							
						</select>
					</div>
					
				</div>
				<br>
                 
				<div class="row">
					<div class="col-15">
						<label for="EmployeeId">Employee ID</label>
					</div>
					<div class="col-20">
						<input type="text" id="EmployeeId" name="EmployeeId" onkeypress="EmployeeIdValidation(event)">
					</div>
				
					<div class="colr-15">
						<label for="EmployeeName"> Name</label>
					</div>
					<div class="colr-20">
						<input type="text" id="EmployeeName" name="EmployeeName" readonly>
					</div>
				</div>
				
				<div class="row">	
					<div style="width: 15%; float: left; ">
						<label for="LoanTYpe">Loan Type </label>
					</div>				
					<div class="col-20">
						<select id="LoanTYpe" name="LoanTYpe" onkeypress="GenderValidation(event)" style="width: 174px;" >
							<option value="HBL">HBL-HB Advance</option>
							<option value="MOT">MOT-Motorcycle</option>
							<option value="COM">COM-Computer</option>
						</select>
					</div>	
					
					
					<div class="colr-15">
						<label for="SLno"> SL(Modify)</label>
					</div>
					<div class="colr-20">
						<input type="text" id="SLno" name="SLno" readonly>
					</div>
			
				</div>
				
				</fieldset>
				<br>
				
				<fieldset>
				   <legend>Transaction Details</legend> 
				   		
				   		<div class="row">	
					<div style="width: 15%; float: left; ">
						<label for="TransactionType">Transaction Type </label>
					</div>				
					<div class="col-20">
						<select id="TransactionType" name="TransactionType" onkeypress="GenderValidation(event)" style="width: 174px;" >
							<option value="D">DR-Debit</option>
							<option value="C">CR-Credit</option>
						</select>
					</div>	
					
					
					<div class="colr-15">
						<label for="VoucherType">Voucher Type </label>
					</div>
					<div class="colr-20">
						<select id="VoucherType" name="VoucherType" style="width: 175px;">
							<option value="V">V-Voucher</option>
							<option value="S">S-Salary</option>	
							<option value="M">M-Memo</option>				
							<option value="N">N-Normal</option>							
						</select>
					</div>
			
				</div>
				<br>
				   								
				<div class="row">				
					<div class="col-15">
						<label for="RealAmt"> Real Amount</label>
					</div>				
					<div class="col-20">
						<input type="text" id="RealAmt" name="RealAmt" onkeypress="ContactValidation(event)"  >
					
				   </div>
				
					<div class="colr-15">
						<label for="VoucherDate"> Real Date</label>
					</div>				
					<div class="colr-20">
						<input type="text" id="VoucherDate" name="VoucherDate" onkeypress="ContactValidation(event)"  >
					
				   </div>	
				
				</div>	
				
				
				</fieldset>			
				<div>				
				<br>				
				<div class="col-75"></div>
				<div class="row">
					<input type="submit" id="submit" value="Submit" onclick="AddEmployeeInfo(event)" >
				</div>
			 </div>
		</div>
	</center>
</body>
</html>
