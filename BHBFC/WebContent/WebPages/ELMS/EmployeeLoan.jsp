<!-- ***************************************************************************
|*			Project Name: 	Employee Loan Management System						  *|
|*			Developer	: 	1. Md. Rubel Talukder							  *|
|*					   		2. Mosharraf Hossain Talukder					  *|
|*					 		------------------------------					  *|
|*					      	ICT Department, HO BHBFC.						  *|
|*		    Supervised By	: 	Md Rokunuzzaman								  *|
|*																			  *|
*****************************************************************************-->
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page session="true" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="shortcut icon" href="../../Media/bhbfc_icon.ico"> 
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Accounts Home</title>

<style>
.rectangle {  
    background-color: #85adad;
	overflow: auto;
	align: center;
	height: 60;
	width: 60.4%;
}
.topnav {
	background-color: #00b33c;
	overflow: auto;
	align: center;
	height: 40px;
	width: 60.4%;
}

.topnav a {
	float: left;
	color: #f2f2f2;
	text-align: center;
	padding: 15px;
	text-decoration: none;
	font-size: 15px;
	width: 12.9%;
}

.topnav a:hover {
	background-color: #196619;
	color: white;
	height: 40px;
}

.topnav a.active {
	background-color: #196619;
	color: white;
	height: 40px;
}
.navbar a:hover, .dropdown:hover .dropbtn {
  background-color: #196619;
	color: coral;
	height: 40px;
}

.dropdown {
  float: left;
  overflow: hidden;
}

.dropdown .dropbtn {
  font-size: 16px;  
  border: none;
  outline: none;
  color: white;
  padding: 18px 16px;
  background-color: inherit;
  font-family: inherit;
}

.dropdown-content {
  display: none;
  position: absolute;
  background-color: #00b33c;
  min-width: 120px;
  z-index: 1;
}

.dropdown-content a {
  float: none;
  color: black;
  padding: 12px 16px;
  text-decoration: none;
  display: block;
  text-align: left;
  min-width: 89px;
}

.dropdown-content a:hover {
  background-color: #196619;
  height: 20px;
}

.dropdown:hover .dropdown-content {
  display: block;
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
function InitValues(){
	Redirect();
}

function LogOut()
{
	clear();
	SetValue("Class","LoginValidation");
	SetValue("Method","LogOut");
	
	var xhttp = new XMLHttpRequest();
	xhttp.onreadystatechange = function() {
		if (this.readyState == 4 && this.status == 200) {						
			top.location = self.location.href = "../../";
		}
	};
	xhttp.open("POST", "HTTPValidator?" + DataMap, true);
	xhttp.send();
		
}
function Redirect(){
	var userRole = "<%= session.getAttribute("USER_ROLE")%>";
	if(userRole=="null"){
		top.location = self.location.href = "../../";
	}
	else if(userRole=="F" ||userRole=="P"||userRole=="M"){
		LogOut();	
	}
}

</script>
</head>
	<body onload="InitValues()">
		<center>
			<div class="rectangle" style="align: center">
			<table>
				<tr>
					<td><img src="../../Media/bhbfc_icon.ico" width="100" height="80"></td>
					<td><h1 style="color:maroon; font-family:Georgia"><center>ELMS [HB,Computer,Motor,PF]</center></h1>
					<h1 style="color:green; font-family:impact"><center>Bangladesh House Building Finance Corporation</center></h1></td>
				</tr>
			</table>
			
		</div>
			<div class="topnav" style="height: 100%">
			<a class="active" href="EmployeeLoan.jsp"><i class="fa fa-fw fa-home" style="font-size: 15px"></i><br>Home</a> 
									
			<div class="dropdown">
				<button class="dropbtn">Loan Entry<i class="fa fa-caret-down"></i> </button>
				<div class="dropdown-content">
					<a href="LoanDisbursement.jsp" target="contents_1"><i class="fa fa-plus-circle" ></i>Disburse</a>
					<a href="LoanRealization.jsp" target="contents_1"> <i class="fa fa-plus-circle"></i>Realization</a> 
				</div>
			</div>
			
			
			<a href="PfRealization.jsp" target="contents_1"><i class="fa fa-plus-circle" style="font-size: 15px"></i><br> PF Entry</a>
			<a href="EmployeeLoanReport.jsp" target="contents_1"><i class="fa fa-download" style="font-size: 15px"></i> <br> Report</a>
			<a href="../ResetPassword.jsp" target="contents_1"> <i class="fa fa-cog fa-spin" style="font-size: 15px"></i><br> Reset Password</a>				
			<a href="../Help.jsp" target="contents_1"><i class="fa fa-phone-square" style="font-size: 15px"></i> <br>Help</a>
		</div> 
			<div>
				<iframe height="450px" width="48.7%" src="../Welcome.jsp" name="contents_1" style="border: 1px solid green;"> </iframe>
				<iframe height="450px" width="11.1%" src="../Aside.jsp" name="contents_2" style="border: 1px solid green;"></iframe>
			</div>
		</center>
		<footer>
			<div style="text-align: center;">
	            <p>Copyright &#xA9; 2019.
	              <strong>Design & Developed By ICT Department, <a href="http://www.bhbfc.gov.bd/" target="_blank">BHBFC.</a></strong>
	              All Rights Reserved.</p>              
	        </div>
	    </footer>
	</body>
</html>