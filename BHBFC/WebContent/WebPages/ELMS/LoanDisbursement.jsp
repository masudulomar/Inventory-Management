<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page session="true" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <link rel="stylesheet" href="/resources/demos/style.css">
  <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<style>

/* Popup container - can be anything you want */
.popup {
  position: relative;
  display: inline-block;
  cursor: pointer;
  -webkit-user-select: none;
  -moz-user-select: none;
  -ms-user-select: none;
  user-select: none;
}

/* The actual popup */
.popup .popuptext {
  visibility: hidden;
  width: 160px;
  background-color: #555;
  color: #fff;
  text-align: center;
  border-radius: 6px;
  padding: 8px 0;
  position: absolute;
  z-index: 1;
  bottom: 125%;
  left: 50%;
  margin-left: -80px;
}

/* Popup arrow */
.popup .popuptext::after {
  content: "";
  position: absolute;
  top: 100%;
  left: 50%;
  margin-left: -5px;
  border-width: 5px;
  border-style: solid;
  border-color: #555 transparent transparent transparent;
}

/* Toggle this class - hide and show the popup */
.popup .show {
  visibility: visible;
  -webkit-animation: fadeIn 1s;
  animation: fadeIn 1s;
}
.popup .hide {
  visibility: hiden;
  -webkit-animation: fadeIn 1s;
  animation: fadeIn 1s;
}

/* Add animation (fade in the popup) */
@-webkit-keyframes fadeIn {
  from {opacity: 0;} 
  to {opacity: 1;}
}

@keyframes fadeIn {
  from {opacity: 0;}
  to {opacity:1 ;}
}

/* .datepicker
{ 
    width: 10.5em;
    height: 2.5em;
} */

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
	$(document).on('keydown', 'input[pattern]', function(e){
	  var input = $(this);
	  var oldVal = input.val();
	  var regex = new RegExp(input.attr('pattern'), 'g');

	  setTimeout(function(){
	    var newVal = input.val();
	    if(!regex.test(newVal)){
	      input.val(oldVal); 
	    }
	  }, 0);
	});
	
	$(function() {
		$("#DisbDate").datepicker({
			dateFormat : 'dd-M-yy'
		});
	});

	var DataMap = "";
	function SetValue(key, value) {
		var Node = key + "*" + value;
		if (DataMap != "") {
			DataMap = DataMap + "$" + Node;
		} else {
			DataMap = "data=" + Node;
		}
	}
	function clear() {
		DataMap = "";
	}

	function initValues() {
		document.getElementById("EmployeeId").value = "";
		document.getElementById("EmployeeName").value = "";
		document.getElementById("LoanType").value = "";
		document.getElementById("DisbDate").value = "";
		document.getElementById("DisbAmt").value = "";
		document.getElementById("IntRate").value = "";
		document.getElementById("EmployeeId").focus();
	}

	function EmployeeIdValidation(event) {
		if (event.keyCode == 13 || event.which == 13) {
			clear();
			SetValue("EmployeeId", document.getElementById("EmployeeId").value);
			SetValue("Class", "FinanceOperation");
			SetValue("Method", "FetchEmpData");

			var xhttp = new XMLHttpRequest();
			xhttp.onreadystatechange = function() {

				if (this.readyState == 4 && this.status == 200) {
					var obj = JSON.parse(this.responseText);
					if (obj.ERROR_MSG != "") {
						alert(obj.ERROR_MSG);
					} else {
						document.getElementById("EmployeeName").value = obj.EMP_NAME;
						document.getElementById("LoanType").focus();
					}
				}
			};
			xhttp.open("POST", "HTTPValidator?" + DataMap, true);
			xhttp.send();
		}
	}
	
	var loan_type;
	function LoanTypeValidation(event) {
		loan_type = document.getElementById("LoanType").value;
		if (event.keyCode == 13 || event.which == 13) {
			if(document.getElementById("LoanType").value == ""){
				alert("Please Enter:\n1 for HB Loan\n2 for Motorcycle Loan\n3 for Computer Loan");
				document.getElementById("LoanType").focus();
			}
			else{
				if(document.getElementById("LoanType").value == 1){
					document.getElementById("LoanType").value = "HB Loan";
					document.getElementById("DisbDate").focus();
				}
				else if(document.getElementById("LoanType").value == 2){
					document.getElementById("LoanType").value = "Motorcycle Loan";
					document.getElementById("DisbDate").focus();
					
				}
				else if(document.getElementById("LoanType").value == 3){
					document.getElementById("LoanType").value = "Computer Loan";
					document.getElementById("DisbDate").focus();
				}
				else {
					alert("Please Enter:\n1 for HB Loan\n2 for Motorcycle Loan\n3 for Computer Loan");
					document.getElementById("LoanType").focus();
				}
			}
		}
	}
	
	function DisbDateValidation(event) {
		if (event.keyCode == 13 || event.which == 13) {
			document.getElementById("DisbAmt").focus();
		}
	}
	
	function DisbAmtValidation(event) {
		var popup = document.getElementById("myPopup");
		popup.classList.toggle("hide");
		if(document.getElementById("DisbAmt") != ""){
			popup.classList.toggle("show");
		}
		else {
			popup.classList.toggle("hide");
		}
		if (event.keyCode == 13 || event.which == 13) {
			
			if(document.getElementById("DisbAmt").value == ""){
				alert("Amount shouldn't null!");
				document.getElementById("DisbAmt").focus();
			}
			else{
				popup.classList.toggle("hide");
				document.getElementById("IntRate").value = "5";
				document.getElementById("IntRate").focus();
			}
		}
	}

	function PopUpAmtToWord(event) {
		var popup = document.getElementById("myPopup");
			popup.classList.toggle("show");
	}
	
	function convertNumberToWords(amount) {
	    var words = new Array();
	    words[0] = '';
	    words[1] = 'One';
	    words[2] = 'Two';
	    words[3] = 'Three';
	    words[4] = 'Four';
	    words[5] = 'Five';
	    words[6] = 'Six';
	    words[7] = 'Seven';
	    words[8] = 'Eight';
	    words[9] = 'Nine';
	    words[10] = 'Ten';
	    words[11] = 'Eleven';
	    words[12] = 'Twelve';
	    words[13] = 'Thirteen';
	    words[14] = 'Fourteen';
	    words[15] = 'Fifteen';
	    words[16] = 'Sixteen';
	    words[17] = 'Seventeen';
	    words[18] = 'Eighteen';
	    words[19] = 'Nineteen';
	    words[20] = 'Twenty';
	    words[30] = 'Thirty';
	    words[40] = 'Forty';
	    words[50] = 'Fifty';
	    words[60] = 'Sixty';
	    words[70] = 'Seventy';
	    words[80] = 'Eighty';
	    words[90] = 'Ninety';
	    amount = amount.toString();
	    var atemp = amount.split(".");
	    var number = atemp[0].split(",").join("");
	    var n_length = number.length;
	    var words_string = "";
	    if (n_length <= 9) {
	        var n_array = new Array(0, 0, 0, 0, 0, 0, 0, 0, 0);
	        var received_n_array = new Array();
	        for (var i = 0; i < n_length; i++) {
	            received_n_array[i] = number.substr(i, 1);
	        }
	        for (var i = 9 - n_length, j = 0; i < 9; i++, j++) {
	            n_array[i] = received_n_array[j];
	        }
	        for (var i = 0, j = 1; i < 9; i++, j++) {
	            if (i == 0 || i == 2 || i == 4 || i == 7) {
	                if (n_array[i] == 1) {
	                    n_array[j] = 10 + parseInt(n_array[j]);
	                    n_array[i] = 0;
	                }
	            }
	        }
	        value = "";
	        for (var i = 0; i < 9; i++) {
	            if (i == 0 || i == 2 || i == 4 || i == 7) {
	                value = n_array[i] * 10;
	            } else {
	                value = n_array[i];
	            }
	            if (value != 0) {
	                words_string += words[value] + " ";
	            }
	            if ((i == 1 && value != 0) || (i == 0 && value != 0 && n_array[i + 1] == 0)) {
	                words_string += "Crores ";
	            }
	            if ((i == 3 && value != 0) || (i == 2 && value != 0 && n_array[i + 1] == 0)) {
	                words_string += "Lakhs ";
	            }
	            if ((i == 5 && value != 0) || (i == 4 && value != 0 && n_array[i + 1] == 0)) {
	                words_string += "Thousand ";
	            }
	            if (i == 6 && value != 0 && (n_array[i + 1] != 0 && n_array[i + 2] != 0)) {
	                words_string += "Hundred and ";
	            } else if (i == 6 && value != 0) {
	                words_string += "Hundred ";
	            }
	        }
	        words_string = words_string.split("  ").join(" ");
	    }
	    return words_string;
	}
	
	function IntRateValidation(event) {
		if (event.keyCode == 13 || event.which == 13) {
			if(document.getElementById("IntRate").value == ""){
				alert("Interest rate shouldn't null!");
				document.getElementById("IntRate").focus();
			}
			else{
				document.getElementById("submit").focus();
			}
		}
	}
	
	function SaveLoanData(event) {
		var userId= "<%= session.getAttribute("User_Id")%>";
		clear();
		SetValue("EntdBy",userId);
		SetValue("EmployeeId",document.getElementById("EmployeeId").value);
		SetValue("LoanType",loan_type);
		SetValue("DisbDate",document.getElementById("DisbDate").value);
		SetValue("DisbAmt",document.getElementById("DisbAmt").value);
		SetValue("IntRate",document.getElementById("IntRate").value);
		SetValue("Class","FinanceOperation");
		SetValue("Method","SaveLoanData");
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
	<h2>Loan Disbursement Form</h2>
		<div class="container">
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
						<label for="LoanType">Loan Type</label>
					</div>
					<div class="col-20">
						<input type="text" id="LoanType" onkeypress="LoanTypeValidation(event)" >
					</div>
					
					<div class="colr-15">
						<label for="DisbDate">Disbursement Date </label>
					</div>				
					<div class="colr-20">
						<input type="text" id="DisbDate" value="" onkeypress="DisbDateValidation(event)" >
					</div>
				</div>
				
				<div class="row">
					<div class="col-15">
						<label for="DisbAmt">Disburse Amount</label>
					</div>
					<div class="col-20">
					    <div class="popup">
							<span class="popuptext" id="myPopup"></span>
						</div>
						<input type="text" id="DisbAmt" pattern="^\d*(\.\d{0,2})?$" onkeypress="DisbAmtValidation(event)"  onkeyup="myPopup.innerHTML=convertNumberToWords(this.value)"  onfocus="PopUpAmtToWord()" onclick="PopUpAmtToWord()" >
					</div>
					
					<div class="colr-15">
						<label for="IntRate">Interest Rate </label>
					</div>				
					<div class="colr-20">
						<input type="text" id="IntRate" pattern="^\d*(\.\d{0,2})?$" value="" onkeypress="IntRateValidation(event)">
					</div>
				</div>
				
				<br>				
				<div class="col-75"></div>
				<div class="row">
					<input type="submit" id="submit" value="Submit" onclick="SaveLoanData(event)" >
				</div>
		</div>
	</center>
</body>
</html>