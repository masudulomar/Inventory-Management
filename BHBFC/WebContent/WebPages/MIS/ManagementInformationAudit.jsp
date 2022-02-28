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
    background-color: #FAE5D3;
	overflow: auto;
	align: center;
	height: 100;
	width: 100%;
}



.navbar {
  background-color: #004d4d;
	overflow: auto;
	align: center;
	height: 35px;
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
	color: #ffffff;
	text-align: center;
	padding: 15px;
	text-decoration: none;
	font-size: 14px;
	width: 10.2%;
}

.navbar a.active {
	background-color: #004d4d;
	color: coral;
	height: 40px;
}

.navbar a:hover, .dropdown:hover .dropbtn {
  background-color: #004d4d;
	color: coral;
	height: 40px;
}

.dropdown {
  float: Left;
  overflow: hidden;
  width: 16%;
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
  background-color: #004d4d;
  min-width:150px;
  z-index: 1;
}

.dropdown-content a {
  float: none;
  color: white;
  padding: 12px 16px;
  text-decoration: none;
  display: block;
  text-align: left;
  min-width: 150px;
}

.dropdown-content a:hover {
  background-color: #004d4d;
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
	else if(userRole=="A"){
		LogOut();	
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
			<a class="active" href="ManagementInformationAudit.jsp"><i class="fa fa-fw fa-home" style="font-size: 15px"></i>Home</a> 
											
			<div class="dropdown">
				<button class="dropbtn"> Data Correction  <i class="fa fa-caret-down"></i>
				</button>
				<div class="dropdown-content">								
					<a href="MISAuditObjectionHO.jsp" target="contents_1"><i class="fa fa-plus-circle" style="font-size: 15px"></i>Disposal of Audit Objection</a>
				</div>
			</div>
			
			<div class="dropdown">
				<button class="dropbtn">Report Module <i class="fa fa-caret-down"></i></button>
				<div class="dropdown-content">	
				<a href="AchivementData.jsp" target="contents_1"><i class="fa fa-download" style="font-size: 15px"></i> Achievement Data</a>
					<a href="BranchWiseReporting.jsp" target="contents_1"><i class="fa fa-download" style="font-size: 15px"></i> Branch Wise Report</a>								
					<a href="ZoneWiseReporting.jsp" target="contents_1"><i class="fa fa-download" style="font-size: 15px"></i> Zone Wise Report</a>	
					<a href="SummaryReportItemWise.jsp" target="contents_1"><i class="fa fa-download" style="font-size: 15px"></i> Summary Report</a>  
					<a href="PerformanceSummary.jsp" target="contents_1"><i class="fa fa-download" style="font-size: 15px"></i> Top 10 Summary</a> 
					<!-- <a href="ConsolidateReporting.jsp" target="contents_1"><i class="fa fa-download" style="font-size: 15px"></i> Consolidate Report</a> --> 
					  																	
				</div>
			</div>		
									
			<div class="dropdown">
				<button class="dropbtn">
					Contact Us<i class="fa fa-caret-down"></i>
				</button>
				<div class="dropdown-content">
					<a href="../Help.jsp" target="contents_1"><i class="fa fa-phone-square" ></i> &nbsp; Help</a>					
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
            <p>Copyright &#xA9; 2020-21.
              <strong>Design & Developed By Mosharraf Hossain Talukder (ICT Department), <a href="http://www.bhbfc.gov.bd/" target="_blank">BHBFC.</a></strong>
              All Rights Reserved.</p>              
        </div>
    </footer>
</body>
</html>