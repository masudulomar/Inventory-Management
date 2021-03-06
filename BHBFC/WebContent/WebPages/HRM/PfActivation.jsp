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
	width: 20%;
}
.colr-20 {
	float: left;
	width: 35%;
	
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
		document.getElementById("EmployeeId").value="";
		document.getElementById("EmployeeName").value="";
		document.getElementById("CurrentBranch").value="";
		document.getElementById("EmployeeDesig").value="";
		document.getElementById("CurrentBasicPay").value="";
		document.getElementById("branchCheck").value="";
		document.getElementById("NewBranch").value="";
		document.getElementById("basicCheck").value="";
		document.getElementById("NewBasicPay").value="";
		document.getElementById("DesigCheck").value="";
		document.getElementById("NewDesignation").value="";
		document.getElementById("EffectiveDate").value="";
		document.getElementById("BranchName").innerHTML="";
		document.getElementById("EmployeeId").focus();
	}
	
	function EmployeeIdValidation(event) {
		if (event.keyCode == 13 || event.which == 13) {
			clear();
			SetValue("EmployeeId",document.getElementById("EmployeeId").value);
			SetValue("Class","PRMSValidator");
			SetValue("Method","EmployeeIdValidation");
			var xhttp = new XMLHttpRequest();
			xhttp.onreadystatechange = function() {
				if (this.readyState == 4 && this.status == 200) {
					var obj = JSON.parse(this.responseText);
						if (obj.ERROR_MSG != "") {
							alert(obj.ERROR_MSG);
						} else {
							document.getElementById("EmployeeName").value=obj.NAME;
							document.getElementById("CurrentBranch").value=obj.BRANCH_CODE;
							document.getElementById("EmployeeDesig").value=obj.DESIGNATION;
							document.getElementById("CurrentBasicPay").value=obj.BASIC_SAL;							
							document.getElementById("branchCheck").focus();
						}									
				}
			};
			xhttp.open("POST", "HTTPValidator?" + DataMap, true);
			xhttp.send();			
		}
	}
	
	function branchCodeValidation(event) {
		if (event.keyCode == 13 || event.which == 13) {
			
				if (document.getElementById("ActivationType").value == "S" && (document.getElementById("NewBranch").value=="" ||document.getElementById("NewBranch").value==null)) {
					alert("Attached Branch Code should not be null!");
					document.getElementById("NewBranch").focus();
				} else {
					
					clear();
					SetValue("branch_code",document.getElementById("NewBranch").value);
					SetValue("Class","PRMSValidator");
					SetValue("Method","BranchKeyPress");
					
					var xhttp = new XMLHttpRequest();
					xhttp.onreadystatechange = function() {
						if (this.readyState == 4 && this.status == 200) {
							var obj = JSON.parse(this.responseText);
							if (obj.ERROR_MSG != "") {
								alert(obj.ERROR_MSG);
							} else {
								document.getElementById("BranchName").innerHTML=obj.BRN_NAME;
								document.getElementById("EffectiveDate").focus();
							}
						}
					};
					xhttp.open("POST", "HTTPValidator?" + DataMap, true);
					xhttp.send();

				}
		}
	}
	

function IsValidDate(myDate) {
    var filter = /^([012]?\d|3[01])-([Jj][Aa][Nn]|[Ff][Ee][bB]|[Mm][Aa][Rr]|[Aa][Pp][Rr]|[Mm][Aa][Yy]|[Jj][Uu][Nn]|[Jj][u]l|[aA][Uu][gG]|[Ss][eE][pP]|[oO][Cc]|[Nn][oO][Vv]|[Dd][Ee][Cc])-(19|20)\d\d$/
    return filter.test(myDate);
}
	

	
	
	function EffectiveDateValidation(event) {
		if (event.keyCode == 13 || event.which == 13) {
			var txtTest = document.getElementById('EffectiveDate');
		    var isValid = IsValidDate(txtTest.value);
		    if (isValid) {
		    	document.getElementById("submit").focus();
		    }
		    else {
		        alert('Incorrect format');
		        document.getElementById("EffectiveDate").focus();
		    }						
		}
	}
	function PfActivationIMethod(event) {
		 var c = confirm("Are you sure ?");
		  if (c == true) {
				if(document.getElementById("NewBranch").value=="")document.getElementById("NewBranch").value = "NA";
				clear();
				SetValue("EmployeeId",document.getElementById("EmployeeId").value);
				SetValue("ActivationType",document.getElementById("ActivationType").value);
				SetValue("AttachedBranch",document.getElementById("NewBranch").value);
				SetValue("effective_date",document.getElementById("EffectiveDate").value);
				SetValue("Class","AdminOperation");
				SetValue("Method","PfActivationIMethod");
				
			  var xhttp = new XMLHttpRequest();
				xhttp.onreadystatechange = function() {
					if (this.readyState == 4 && this.status == 200) {
						var obj = JSON.parse(this.responseText);
						if (obj.ERROR_MSG != "") {
							alert(obj.ERROR_MSG);
						} else {
							alert(obj.SUCCESS);
							initValues();
						}
					}
				};			

				xhttp.open("POST", "HTTPValidator?" + DataMap, true);
				xhttp.send();
		  }
		  else{
			  	document.getElementById("submit").focus();
		}
		
	}
	
	$(function() {
		$("#EffectiveDate").datepicker({
			dateFormat : 'dd-M-yy'
		});
	});
	
</script>

</head>
<body onload="initValues()">
	<center>
	<h3>[Active,In Active, Suspension,Transfer]</h3>
		<div class="container">
		
             <fieldset>
				<div class="row">
					<div class="col-15">
						<label for="EmployeeId">Employee ID</label>
					</div>
					<div class="col-20">
						<input type="text" id="EmployeeId" name="EmployeeId" onkeypress="EmployeeIdValidation(event)">
					</div>
				
					<div class="colr-15">
						<label for="EmployeeName">Employee Name</label>
					</div>
					<div class="colr-20">
						<input type="text" id="EmployeeName" name="EmployeeName" readonly>
					</div>
				</div>

				<div class="row">
					<div class="col-15">
						<label for="CurrentBranch">Current Branch</label>
					</div>
					<div class="col-20">
						<input type="text" id="CurrentBranch" name="CurrentBranch" readonly>
					</div>
					<div class="colr-15">
						<label for="EmployeeDesig">Employee Designation</label>
					</div>
					<div class="colr-20">
						<input type="text" id="EmployeeDesig" name="EmployeeDesig" readonly>
					</div>
				</div>				
				</fieldset>
																
			<fieldset>	
						
				<div class="row">
					<div class="col-25">
						<label for="ActivationType">Activation Type</label>
					</div>
					<div class="col-75">
						<select id="ActivationType" name="ActivationType"  maxlength="45" onkeypress="ActivationTypeValidator(event)">
							<option value="Y">Y-Salary Active</option>
							<option value="N">N-Salary In Active</option>
							<option value="S">S-Suspension</option>	
							<option value="T">T-Transfer</option>	
							<option value="QY">QY-Quarter</option>
							<option value="QN">QN-Non Quarter</option>						
						</select>
					</div>
				</div>
				
				<div class="row">
					<div class="col-25">
						 Office (If Suspension/Transfer) 
					</div>
					<div class="col-15">		
						<input id="NewBranch" type="text" name="NewBranch" maxlength="20" onkeypress="branchCodeValidation(event)" placeholder="Office Code">
				    </div>
				    <div class="col-35">		
						<p id="BranchName"></p>
					</div>
				</div>
				
				<div class="row">
					<div class="col-25">
						<label for="EffectiveDate">Effective Date</label>
					</div>
					<div class="col-75">
						<input  type="text" id="EffectiveDate" value="" onkeypress="EffectiveDateValidation(event)"  maxlength="45" >
					</div>
				</div>				
			</fieldset>
			
				<div class="col-75"></div>
				<div class="row">
					<input type="submit" id="submit" value="Submit" onclick="PfActivationIMethod(event)" >
				</div>
		</div>
	</center>
</body>
</html>
