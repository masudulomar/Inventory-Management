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
.colt-20 {
	float: left;
	width: 79%;
	
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
	var userId="";
	function initValues() {
		document.getElementById("NothiNo").value="";
		document.getElementById("EmployeeName").value="";
	    document.getElementById("ComputerDed").value=0;
		document.getElementById("MotorDed").value=0;	
		document.getElementById("HBDed").value=0;	
		document.getElementById("Revenue").value=0;	
		document.getElementById("OthersDed").value=0;							
		document.getElementById("Remarks").value="N/A";
		userId="<%= session.getAttribute("User_Id")%>";
		document.getElementById("NothiNo").focus();
	}		
	
	function NothiValidation(event){
		if (event.keyCode == 13 || event.which == 13) {
		clear();
		SetValue("NothiNo", document.getElementById("NothiNo").value);
		SetValue("Class", "PensionValidation");
		SetValue("Method","FetchPensionCalculationData");	
		var xhttp = new XMLHttpRequest();
		xhttp.onreadystatechange = function() {
			if (this.readyState == 4 && this.status == 200) {
				var obj = JSON.parse(this.responseText);
				if (obj.ERROR_MSG != "") {
					alert(obj.ERROR_MSG);
				} else {	
					    document.getElementById("EmployeeName").value=obj.EMP_NAME;			
					    document.getElementById("ComputerDed").value=obj.COM_DED;
						document.getElementById("MotorDed").value=obj.MOT_DED;	
						document.getElementById("HBDed").value=obj.HB_DED;	
						document.getElementById("Revenue").value=obj.REVINUE;	
						document.getElementById("OthersDed").value=obj.OTHERS_DED;							
						document.getElementById("Remarks").value=obj.REMRKS_OTHER_DED;		
					    document.getElementById("HBDed").focus();					
				}															
			}
		};
		
		xhttp.open("POST", "HTTPValidator?" + DataMap, true);
		xhttp.send();					

		}
	}

	function HBValidation(event){
		if (event.keyCode == 13 || event.which == 13) {
			document.getElementById("MotorDed").focus();				
		}						
    }
	function MotorValidation(event){
		if (event.keyCode == 13 || event.which == 13) {
			document.getElementById("ComputerDed").focus();				
		}						
    }
	function ComputerValidation(event){
		if (event.keyCode == 13 || event.which == 13) {
			document.getElementById("Revenue").focus();				
		}						
 	}
	function RevenueValidation(event){
		if (event.keyCode == 13 || event.which == 13) {
			document.getElementById("OthersDed").focus();				
		}						
    }
	function OthersDedValidation(event){
		if (event.keyCode == 13 || event.which == 13) {
			document.getElementById("Remarks").focus();				
		}						
    }
	function RemarksValidation(event){
		if (event.keyCode == 13 || event.which == 13) {
			document.getElementById("submit").focus();				
		}						
    }
	function AddDeductionData(event){
		    clear();
			SetValue("User_Id",userId);		
			SetValue("NothiNo",document.getElementById("NothiNo").value);
			SetValue("ComputerDed",document.getElementById("ComputerDed").value);
			SetValue("MotorDed",document.getElementById("MotorDed").value);				
			SetValue("HBDed",document.getElementById("HBDed").value);
			SetValue("Revenue",document.getElementById("Revenue").value);	
			SetValue("OthersDed",document.getElementById("OthersDed").value);			
			SetValue("Remarks",document.getElementById("Remarks").value);			
			SetValue("Class","PensionValidation");
			SetValue("Method","AddPenDeductionData");
			
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
	
</script>

</head>
<body onload="initValues()">
	<center>
	<h5>[Pensioner Deduction Update]</h5>
		<div class="container">
		
             <fieldset> 
                 <legend>Identifier</legend> 
                 
				<div class="row">
					<div class="col-15">
						<label for="NothiNo">Nothi No</label>
					</div>
					<div class="col-20">
						<input type="text" id="NothiNo" name="NothiNo" onkeypress="NothiValidation(event)">
					</div>
				
					<div class="colr-15">
						<label for="EmployeeName"> Name</label>
					</div>
					<div class="colr-20">
						<input type="text" id="EmployeeName" name="EmployeeName" readonly>
					</div>
				</div>
				
				</fieldset>
				<br>
				
				<fieldset>
				   <legend>Deduction Details</legend> 
				   
				  <div class="row">
				 
					<div class="col-15">
						<label for="HBDed"> HB Ded </label>
					</div>				
					<div class="col-20">
						<input type="text" id="HBDed" name="HBDed" onkeypress="HBValidation(event)"  >
					
				   </div>
				
					<div class="colr-15">
						<label for="MotorDed"> Motor</label>
					</div>				
					<div class="colr-20">
						<input type="text" id="MotorDed" name="MotorDed" onkeypress="MotorValidation(event)"  >					
				   </div>					
				</div>	 
				   
				   <br>
				<div class="row">
				
					<div class="col-15">
						<label for="ComputerDed"> Computer/G. Loan</label>
					</div>				
					<div class="col-20">
						<input type="text" id="ComputerDed" name="ComputerDed" onkeypress="ComputerValidation(event)"  >
					
				   </div>
				
				<div class="colr-15">
						<label for="Revenue"> Revenue</label>
				</div>				
					<div class="colr-20">
						<input type="text" id="Revenue" name="Revenue" onkeypress="RevenueValidation(event)"  >
					
				   </div>					
				</div>	
												
				<div class="row">				
					<div class="col-15">
						<label for="OthersDed"> Others Ded</label>
					</div>				
					<div class="col-20">
						<input type="text" id="OthersDed" name="OthersDed" onkeypress="OthersDedValidation(event)"  >					
				   </div>														
				</div>	
								
				<div class="row">											
					<div class="col-15">
						<label for="Remarks"> Remarks</label>
					</div>				
					<div class="colt-20">
					<textarea id="Remarks" name="Remarks" rows="8" cols="50" onkeypress="RemarksValidation(event)" ></textarea>
				   </div>	
				
				</div>	
				
				</fieldset>			
				<div>				
				<br>				
				<div class="col-75"></div>
				<div class="row">
					<input type="submit" id="submit" value="Submit" onclick="AddDeductionData(event)" >
				</div>
			 </div>
		</div>
	</center>
</body>
</html>
