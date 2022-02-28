<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<style>
body {
  /* background-image: url('../Media/bg6.jpg') ;
  padding: 50px;
  background-repeat: no-repeat;
  background-size: auto ; */
  background-color: #cccccc;
}

.container {
	border-radius: 15px;
	background-color: #85adad;
	padding: 10px;
	align: bottom;
}

.alert {
	padding: 20px;
	background-color: #f44336;
	color: white;
}

.closebtn {
	margin-left: 15px;
	color: white;
	font-weight: bold;
	float: right;
	font-size: 22px;
	line-height: 20px;
	cursor: pointer;
	transition: 0.3s;
}

.closebtn:hover {
	color: black;
}

.alert {
	padding: 20px;
	background-color: #f44336;
	color: white;
}

.closebtn {
	margin-left: 15px;
	color: white;
	font-weight: bold;
	float: right;
	font-size: 22px;
	line-height: 20px;
	cursor: pointer;
	transition: 0.3s;
}

.closebtn:hover {
	color: black;
}
</style>

<script type="text/javascript">

function InitValues(){
	var userRole = "<%= session.getAttribute("USER_ROLE")%>";
	if(userRole=="null"){
		top.location = self.location.href = "../../";
	}
	 if(userRole=="S"){		
		document.getElementById("WelcomeMsg").innerHTML = "Welcome to Office Management System(OMS) of Bangladesh House Building Finance Corporation ";
	}
	 else if(userRole=="K"||userRole=="I"){		
			document.getElementById("WelcomeMsg").innerHTML = "Welcome to Office Management System(OMS) of Bangladesh House Building Finance Corporation ";
		}
	 else if(userRole=="H"||userRole=="T"){		
			document.getElementById("WelcomeMsg").innerHTML = "Welcome to Human Resource Management System(HRM) of Bangladesh House Building Finance Corporation ";
	 }
	 else if(userRole=="G"||userRole=="g"){		
			document.getElementById("WelcomeMsg").innerHTML = "Welcome to  General Accounting System of Bangladesh House Building Finance Corporation ";
	 }
	 else if(userRole=="P"){		
			document.getElementById("WelcomeMsg").innerHTML = "Welcome to Pension Management System(PMS) of Bangladesh House Building Finance Corporation which is specially designed and developed to generate monthly Pension of this corporation as well as festival  bonuses.";
	 } 
	 else if(userRole=="Q" ||userRole=="1"||userRole=="2"||userRole=="3"||userRole=="4"||userRole=="5"||userRole=="6"){		
			document.getElementById("WelcomeMsg").innerHTML = "Welcome to  Management Information System(MIS) of Bangladesh House Building Finance Corporation";
	 } 
}

</script>
</head>
<body onload="InitValues()">
<center><p> <%-- Hello <%= session.getAttribute("USER_NAME")%>,  --%></p></center>
 
 
 <div class="container" style = "position:relative; top:20px;"> 
    <h3 id="WelcomeMsg">Welcome to Payroll Management System(PRMS) of Bangladesh House Building Finance Corporation 
    which is specially designed and developed to generate monthly salary of this corporation as 
    well as festival and incentive bonuses.</h3>
 </div>
 
 <br><br><br><br>
 	<center>
	
		
		<!-- <marquee behavior="scroll" direction="left" scrollamount="3" bgcolor = "cyan" txt-color="coral">Send us instant message at Google Hangouts: query.prms@gmail.com   &nbsp;&nbsp;...Thanks!</marquee> -->
		
		</center>
		
 <!-- <div class="quote-container">

  <i class="pin"></i>
  
  <blockquote class="note yellow">
    Welcome to Payroll Management System(PRMS) of Bangladesh House Building Finance Corporation 
    which is specially designed and developed to generate monthly salary of this corporation as 
    well as festival and incentive bonuses.
    <cite class="author"></cite>
  </blockquote>

</div> -->
</body>
</html>