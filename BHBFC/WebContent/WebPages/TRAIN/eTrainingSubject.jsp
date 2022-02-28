<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page session="true" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="/resources/demos/style.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script src="//ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/jquery-ui.min.js"></script>



<title>Insert title here</title>

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
.col-20 {
	float: left;
	width: 16%;
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
	
	LoadTarget();
	document.getElementById("ParentTrainingCode").value = "";
	document.getElementById("TrainingCode").value = "";
	document.getElementById("TrainingNameEng").value = "";
	document.getElementById("StartDate").value = "";
	document.getElementById("TrainingRemarks").value = "";
	document.getElementById("TrainingCode").focus();
	
	userId="<%= session.getAttribute("User_Id")%>";
}


function TrainingCodeValidation(event){
	if (event.keyCode == 13 || event.which == 13) {
	clear();
	SetValue("TrainingCode", document.getElementById("TrainingCode").value,"N");
	SetValue("Class","AccontingParameterSetup","N");
	SetValue("Method","FetchTrainingSubject","L");
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
				if (obj.SUBJECT_DESC!=null) {
					var r = confirm("Target already exists!\nDo you want to update?");
					  if (r == true) {	
						    document.getElementById("TrainingNameEng").value = obj.SUBJECT_DESC;
							document.getElementById("TrainingNameBan").value = obj.SUBJECT_DESC_BAN;
							document.getElementById("TrainingRemarks").value = obj.REMATKS;														
							document.getElementById("TrainingNameEng").focus();	
					  }
				}
				else{
					    document.getElementById("TrainingNameEng").value = "";
						document.getElementById("TrainingNameBan").value =  "";
						document.getElementById("TrainingRemarks").value =  "";											
						document.getElementById("TrainingNameEng").focus();	
				}
				
			}		
	  });						
	}
}

function TrainingNameEngValidation(event){
	if (event.keyCode == 13 || event.which == 13) {
		document.getElementById("StartDate").focus();		
	}
}


function RemarksValidation(event){			
if (event.keyCode == 13 || event.which == 13) {
	  document.getElementById("submit").focus();
	}
}


function TRainingCreation(event)
{			
		clear();
		SetValue("TrainingCode",document.getElementById("TrainingCode").value,"N");
		SetValue("TrainingNameEng",document.getElementById("TrainingNameEng").value,"N");
		SetValue("TrainingNameBan",document.getElementById("TrainingNameBan").value,"N");		
		SetValue("TrainingRemarks",document.getElementById("TrainingRemarks").value,"N");						
		SetValue("Class","AccontingParameterSetup","N");
		SetValue("Method","AddTrainingSubject","L");
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


</script>

</head>
<body onload="initValues()">
	<center>
		<div class="container">
		   		
		    <fieldset>
		      <legend>Training Identifier</legend> 

		       <div class="row">
					<div class="col-15">
						<label for="TrainingCode">Subject Code</label>
					</div>
					<div class="col-20">
						<input type="text" id="TrainingCode" name="TrainingCode" onkeypress="TrainingCodeValidation(event)">
					</div>
			    </div>		
				<div class="row">	
					<div class="col-15">
						<label for="TrainingNameEng">Training Subject</label>
					</div>
					<div class="col-80">
						<input type="text" id="TrainingNameEng" name="TrainingNameEng" onkeypress="TrainingNameEngValidation(event)" >
					</div>																				
				 </div>		      				
								
				<div class="row">				
					<div class="col-15">
						<label for="TrainingNameBan">ট্রেইনিং নাম :</label>
					</div>
					<div class="col-80">
						<input type="text" id="TrainingNameBan" name="TrainingNameBan" onkeypress="TrainingNameEngValidation(event)" >
					</div>																				
				 </div>		      				
				
				<div class="row">	
						
					  <div class="col-15">
							<label for="TrainingRemarks">Remarks </label>
						</div>
						<div class="col-80">
							<input type="text" id="TrainingRemarks" name="TrainingRemarks" onkeypress="RemarksValidation(event)">
						</div>
															
					</div>
				</fieldset>	
																	
				<div>				
				<br>				
				<div class="col-75"></div>
				<div class="row">
					<input type="submit" id="submit" value="Submit" onclick="TRainingCreation(event)" >
				</div>
			 </div>
			</div>
	</center>
</body>
</html>