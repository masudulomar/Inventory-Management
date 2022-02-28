<!-- ***************************************************************************
|*			Project Name: 	Payroll Management System						  *|
|*			Developer	: 	1. Md. Rubel Talukder							  *|
|*					   		2. Mosharraf Hossain Talukder					  *|
|*					 		------------------------------					  *|
|*					      	ICT Department, HO BHBFC.						  *|
|*		    Supervised By	: 	Md Rokunuzzaman								  *|
|*																			  *|
*****************************************************************************-->
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="shortcut icon" href="../../Media/bhbfc_icon.ico"> 
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<script src='https://kit.fontawesome.com/a076d05399.js'></script>
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Bangladesh House Building Finance Corporation</title>

<style>
.rectangle {  
    background-color: #85adad;
	overflow: auto;
	align: center;
	height: 100;
	width: 60.4%;
}


.header {
    position: relative;
    font-family: sans-serif;
    font-size: 12px;
}

.header > img {
    width: 100%;
}


.navbar {
  background-color: #00b33c;
	overflow: auto;
	align: center;
	height: 40px;
	width: 100%;
}
.header {
    position: relative;
    font-family: sans-serif;
    font-size: 12px;
}

.header > img {
    width: 100%;
}
.navbar a {
  float: left;
	color: #f2f2f2;
	text-align: center;
	padding: 15px;
	text-decoration: none;
	font-size: 14px;
	width: 12%;
}

.navbar a.active {
	background-color: #196619;
	color: coral;
	height: 40px;
}

.navbar a:hover, .dropdown:hover .dropbtn {
  background-color: #196619;
	color: coral;
	height: 40px;
}

.dropdown {
width: 12%;
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

function initValues(){
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
	
}

</script>
</head>
<body onload="initValues()">
	<center>
	
	<div class="header">
    <img src="../../Media/Header.png" alt=""/>
    
	</div>
	
		<div class="navbar" style="height: 100%">
			<div class="topnav" style="height: 100%">
			<a class="active" href="Admin.jsp"><i class="fa fa-fw fa-home" style="font-size: 15px"></i><br>Home</a> 
						
			<div class="dropdown">
				<button class="dropbtn">Entry Pages<i class="fa fa-caret-down"></i>
				</button>
				<div class="dropdown-content">
					<a href="AddEmployee.jsp" target="contents_1"><i class="fa fa-user-plus" style="font-size: 15px"></i>Employee (info)</a>
				</div>
			</div>
			
			<div class="dropdown">
				<button class="dropbtn">Office Order<i class="fa fa-caret-down"></i>
				</button>
				<div class="dropdown-content">
					<a href="UpdateEmployee.jsp" target="contents_1"><i class="fas fa-user-edit" style="font-size: 15px"></i> Transfer & Basic</a>
			       <a href="PfActivation.jsp" target="contents_1"><i class="fas fa-user-edit" style="font-size: 15px"></i> Activation Related</a>
				</div>
			</div>
			
			
			<a href="DownloadAdminReport.jsp" target="contents_1"><i class="fa fa-download" style="font-size: 15px"></i> <br>Report</a>
		</div>
		
			<div class="dropdown">
				<button class="dropbtn">
					Contact Us<i class="fa fa-caret-down"></i>
				</button>
				<div class="dropdown-content">
					<a href="../Help.jsp" target="contents_1"><i class="fa fa-phone-square" ></i> &nbsp; Help</a>
					<a href="../UserFeedback.jsp" target="contents_1"> <i class="fa fa-edit"></i>&nbsp; Feedback</a> 
				</div>
			</div>
			</div>
		<div>
			<iframe height="800px" width="88.2%" src="../Welcome.jsp" name="contents_1" style="border: 1px solid green;"> </iframe>
			<iframe height="800px" width="11.1%" src="../Aside.jsp" name="contents_2" style="border: 1px solid green;"></iframe>
		</div>
	</center>
	<footer>
	<div style="text-align: center;">
            <p>Copyright &#xA9; 2019-20.
              <strong>Design & Developed By ICT Department, <a href="http://www.bhbfc.gov.bd/" target="_blank">BHBFC.</a></strong>
              All Rights Reserved.</p>              
        </div>
    </footer>
</body>
</html>