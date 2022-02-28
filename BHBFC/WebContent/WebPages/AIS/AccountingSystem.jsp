<!-- ***************************************************************************
|*			Project Name: 	Payroll Management System						  *|
|*			Developer	: 	1. Mosharraf Hossain Talukder	       		      *|
|*					   							  							  *|
|*					 		------------------------------					  *|
|*					      	ICT Department, HO BHBFC.						  *|
|*		                                         							  *|
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
<title>Bangladesh House Building Finance Corporation</title>

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
	else if(userRole!="S"){
		LogOut();	
	}
}

</script>
<style>
.header {
    position: relative;
    font-family: sans-serif;
    font-size: 12px;
}

.header > img {
    width: 100%;
}


.rectangle {  
    background-color: #FAE5D3;
	overflow: auto;
	align: left;
	height: 80;
	width: 100%;
}
.topnav {
	overflow: hidden;
	background-color: #004d4d;
	overflow: auto;
	align: center;
	width: 100%;
}

.topnav a {
	float: left;
	color: #ffffff;
	text-align: center;
	padding: 14px 16px;
	text-decoration: none;
	font-size: 15px;
	width: 10%;
}

.topnav a:hover {
	background-color: #004d4d;
	color: white;
}

.topnav a.active {
	background-color: #004d4d;
	color: white;
}
.navbar a:hover, .dropdown:hover .dropbtn {
  background-color: #004d4d;
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
  background-color: #004d4d;
  min-width: 150px;
  z-index: 1;
}

.dropdown-content a {
  float: none;
  color: white;
  padding: 12px 16px;
  text-decoration: none;
  display: block;
  text-align: left;
  min-width: 180px;
}

.dropdown-content a:hover {
  background-color: #004d4d;
  height: 20px;
}

.dropdown:hover .dropdown-content {
  display: block;
}
</style>
</head>
<body onload="InitValues()">
	<center>
	 <!--Ref: ERA Info Tech
	 URL: 
	  -->
<div class="header">
    <img src="../../Media/Header.png" alt=""/>
    
</div>
		 
		 
		<div class="topnav" style="align: center">
			   <a class="active" href="AccountingSystem.jsp"><i class="fa fa-fw fa-home" ></i>Home</a> 
			   
		
			   
			   
			<div class="dropdown">
				<button class="dropbtn">Setup Entry <i class="fa fa-caret-down"></i></button>
				<div class="dropdown-content">									
					    <a href="ebranchwiseitemcreation.jsp" target="contents_1"><i class="fa fa-user-plus" ></i> Item Creation Entry </a>
						<a href="ebranchglcreation.jsp" target="contents_1"><i class="fa fa-user-plus" ></i> GL Creation </a>
						<!-- <a href="eglopeningbalance.jsp" target="contents_1"><i class="fa fa-user-plus" ></i>GL Opening Balance </a> -->
						
					</div>
		  </div>
				   
			   
			   
			<div class="dropdown">
				<button class="dropbtn">Transaction Entry <i class="fa fa-caret-down"></i></button>
				<div class="dropdown-content">									
					<a href="evoucherentryformselect.jsp" target="contents_1"><i class="fa fa-user-plus" ></i> Head Wise Entry [Select]</a>																			   
					<a href="evoucherentryformsearch.jsp" target="contents_1"><i class="fa fa-user-plus" ></i> Head Wise Entry [Search]</a>	
				    <a href="etransactionentityedit.jsp" target="contents_1"><i class="fa fa-user-plus" ></i> Transaction Entity Edit</a> 									
					<a href="evoucherentryitem.jsp" target="contents_1"><i class="fa fa-user-plus" ></i> Item Wise Entry </a>	 		
					<!-- <a href="specialTransaction.jsp" target="contents_1"><i class="fa fa-user-plus" ></i> Auto Posting[PRMS] </a> -->
					
				</div>
			</div>
		    	
			<a  href="etransactionvalidation.jsp" target="contents_1"><i class="fa fa-user-plus" ></i>Entry Validation </a>
			
			<div class="dropdown">
				<button class="dropbtn">Report Module <i class="fa fa-caret-down"></i></button>
				<div class="dropdown-content">	
												
					<a href="rvoucherprintmodule.jsp" target="contents_1"><i class="fa fa-download" ></i> Voucher Print  </a>
					<a href="rcashbookprint.jsp" target="contents_1"><i class="fa fa-download" ></i> Cash Book </a>	
					<a href="rglstatementprint.jsp" target="contents_1"><i class="fa fa-download" ></i> GL Statement </a>	
					<a href="rinterbranchreconcilation.jsp" target="contents_1"><i class="fa fa-download" ></i>  Reconciliation </a>
					<a href="rinterbranchGap.jsp" target="contents_1"><i class="fa fa-download" ></i>  Inter Office Balance Difference </a>			
									
					<a href="rglregisterprint.jsp" target="contents_1"><i class="fa fa-download" ></i> GL Register </a>
					<a href="rfinancialstatement.jsp" target="contents_1"><i class="fa fa-download" ></i> Financial Statement </a>
								
				</div>
			</div>
			
				<div class="dropdown">
				<button class="dropbtn">Final Report <i class="fa fa-caret-down"></i></button>
				<div class="dropdown-content">	
				    <a href="rglregisterprintfinal.jsp" target="contents_1"><i class="fa fa-download" ></i> GL Register</a>								
					<a href="rfinancialstatementfinal.jsp" target="contents_1"><i class="fa fa-download" ></i> Financial Statement</a>			
				</div>
			   </div>
			
			<div class="dropdown">
				<button class="dropbtn">Consolidated Report <i class="fa fa-caret-down"></i></button>
				<div class="dropdown-content">		
				     <a href="eloanrecoverypage.jsp" target="contents_1"><i class="fa fa-user-plus" ></i> Loan Recovery </a>
					 <a href="eloanrecoverable.jsp" target="contents_1"><i class="fa fa-user-plus" ></i> Loan Recoverable </a>							
					<a href="rfinancialconsolidatedreport.jsp" target="contents_1"> <i class="fa fa-download"></i> Financial Statement</a>	
					<a href="rbranchofficestmt.jsp" target="contents_1"><i class="fa fa-download" ></i> Branch Office Statement </a>	
					<a href="rhoecoveryreportpage.jsp" target="contents_1"><i class="fa fa-download" ></i> Recovery & Recoverable  </a>			
				</div>
			</div>
			
			
		<a href="rchartofaccounts.jsp" target="contents_1"> <i class="fa fa-download"></i> Chart of Accounts </a>						
				
		</div>
		<div>
			<iframe height="800px" width="89.4%" src="../Welcome.jsp" name="contents_1" frameBorder="0" style="border: 1px solid green;"> </iframe>
			<iframe height="800px" width="10%" src="../Aside.jsp" name="contents_2" style="border: 1px solid green;"></iframe>
		</div>
		
	</center>
	<footer>
	<div style="text-align: center;">
            <p>Copyright &#xA9; 2020-2021.
              <strong>Design & Developed By ICT Department, <a href="http://www.bhbfc.gov.bd/" target="_blank">BHBFC.</a></strong>
              All Rights Reserved.</p>              
        </div>
    </footer>
    
</body>
</html>