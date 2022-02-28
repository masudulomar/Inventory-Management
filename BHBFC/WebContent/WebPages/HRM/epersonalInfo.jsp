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
.colx-15 {
	float: left;
	width: 10%;
}
.colr-15 {
	float: left;
	width: 15%;
	margin-left: 50px;
}
.col-20 {
	float: left;
	width: 21%;
}
.colr-20 {
	float: left;
	width: 21%;
	
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
var emp_joining_date = "";
var emp_dob = "";
var userId="";


function IsValidDate(myDate) {
    var filter = /^([012]?\d|3[01])-([Jj][Aa][Nn]|[Ff][Ee][bB]|[Mm][Aa][Rr]|[Aa][Pp][Rr]|[Mm][Aa][Yy]|[Jj][Uu][Nn]|[Jj][u]l|[aA][Uu][gG]|[Ss][eE][pP]|[oO][Cc]|[Nn][oO][Vv]|[Dd][Ee][Cc])-(19|20)\d\d$/
    return filter.test(myDate);
}
function LoadDesignationList(){

	clear();	
	SetValue("Class", "AccontingParameterSetup","N");
	SetValue("Method", "GetDesignationList","L");
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
				var item_srting=obj.DESIGNATION_LIST;	
				var select = document.getElementById("Designation");                  
				 var item_arrayList = item_srting.split(',');
				 for(var i = 0; i < item_arrayList.length; i++) {
					 item_arrayList[i] = item_arrayList[i].replace("/^\s*/", "").replace("/^\s*/", "");							 
					    var item_keyValue = item_arrayList[i].split(':');
					    var option = document.createElement("option");
					    option.value=item_keyValue[0] ;
					    option.text=item_keyValue[1];	
					    select.add(option, null);				   				   
				 }
			}
	});			
}
function initValues(){
	  LoadBranchList();
	  LoadDesignationList();
	  LoadGradList();
	  LoadDeptList();
	  document.getElementById("EmployeeName").value="";
	  document.getElementById("FatherName").value="";
	  document.getElementById("MotherName").value="";
	  document.getElementById("EmployeeNameB").value="";
	  document.getElementById("FatherNameB").value="";
	  document.getElementById("MotherNameB").value="";	
	  document.getElementById("JoiningDate").value="";
	  document.getElementById("Designation").value="";
	  document.getElementById("BranchCode").value="";
	 // document.getElementById("Quota").value="";
	  document.getElementById("Grade").value="";
	  document.getElementById("DeptCode").value="";
	  document.getElementById("DOB").value="";
	  document.getElementById("contactNo").value="";
	  document.getElementById("TIN").value="";
	  document.getElementById("SeniorityCode").value="";
	  document.getElementById("Address").value="";
	  document.getElementById("email").value="";
	  document.getElementById("ReligionType").value="";			
	  document.getElementById("GenderType").value="";
	  document.getElementById("Rhfactor").value="";
	  document.getElementById("BloodGrp").value="";
	  document.getElementById("homeDist").value="";
	  document.getElementById("NID").value="";
	  document.getElementById("EmergencyContact").value="";
	  document.getElementById("EmergencyPhone").value="";
	  document.getElementById("MaritalStatus").value="";
	  document.getElementById("PassportNo").value="";
	  document.getElementById("PermanentAddress").value="";	
	  document.getElementById("EmployeeId").focus();
	userId="<%= session.getAttribute("User_Id")%>";
}

function EmployeeIdValidation(event){	
	if (event.keyCode == 13 || event.which == 13) {		
		var usr_brn = "<%= session.getAttribute("BranchCode")%>";
		clear();
		SetValue("UserBranchCode",usr_brn,"N");
		SetValue("EmployeeId",document.getElementById("EmployeeId").value,"N");
		SetValue("Class","AdminOperation","N");
		SetValue("Method","FetchEmplpyeeData","L");
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

						if (obj.EMP_NAME!=null) {
							var r = confirm("Employee already exists!\nDo you want to update?");
							  if (r == true) {						  
								  document.getElementById("EmployeeName").value=obj.EMP_NAME;
								  document.getElementById("FatherName").value=obj.FATHERS_NAME;
								  document.getElementById("MotherName").value=obj.MOTHERS_NAME;								  
								  document.getElementById("EmployeeNameB").value=obj.NAMEBANGLA;
								  document.getElementById("FatherNameB").value=obj.FATHERSNAMEBANGLA;
								  document.getElementById("MotherNameB").value=obj.MOTHERSNAMEBANGLA;								  
								  document.getElementById("JoiningDate").value=obj.JOINING_DATE;
								  document.getElementById("Designation").value=obj.JOINING_DESIG;
								  document.getElementById("BranchCode").value=obj.JOINING_OFFICE;
								  document.getElementById("Quota").value=obj.JOINING_QUOTA;								
								  document.getElementById("Grade").value=obj.JOINING_GRADE;
								  document.getElementById("DeptCode").value=obj.JOINING_DEPT;
								  document.getElementById("DOB").value=obj.DOB;
								  document.getElementById("contactNo").value=obj.CONTACT_NO;
								  document.getElementById("TIN").value=obj.TIN_NO;
								  document.getElementById("SeniorityCode").value=obj.SENIORITY_CODE;
								  document.getElementById("Address").value=obj.ADDRESS;
								  document.getElementById("email").value=obj.EMAIL;
								  document.getElementById("ReligionType").value=obj.RELIGION;				
								  document.getElementById("GenderType").value=obj.GENDER;
								  document.getElementById("Rhfactor").value=obj.RHFACTOR;
								  document.getElementById("BloodGrp").value=obj.BLOOD_GRP;
								  document.getElementById("homeDist").value=obj.HOME_DISTRICT;
								  document.getElementById("NID").value=obj.NID;
								  document.getElementById("EmergencyContact").value=obj.EMERGENCY_CONTACT;
								  document.getElementById("EmergencyPhone").value=obj.EMERGENCY_PHONE;
								  document.getElementById("MaritalStatus").value=obj.MARITAL_STATUS;
								  document.getElementById("PassportNo").value=obj.PASSPORT_NUMBER;
								  document.getElementById("PermanentAddress").value=obj.PERMANENT_ADDRESS;
								  document.getElementById("EmployeeName").focus();
									
							  } else {
								  initValues();							 
							  }	
						}
						else{
							initValues();	
							document.getElementById("EmployeeName").focus();		
						}
					
					}		
 		    });	
	}		
}

function EmployeeNameValidation(event){
	if (event.keyCode == 13 || event.which == 13) {
		document.getElementById("BranchCode").focus();
	}
}
function BranchCodeValidation(event){
	if (event.keyCode == 13 || event.which == 13) {		
	if (document.getElementById("BranchCode").value != "") {
		clear();
		SetValue("branch_code",document.getElementById("BranchCode").value);
		SetValue("Class","PRMSValidator");
		SetValue("Method","BranchKeyPress");
		var xhttp = new XMLHttpRequest();
		xhttp.onreadystatechange = function() {
			if (this.readyState == 4 && this.status == 200) {
				var obj = JSON.parse(this.responseText);
				if (obj.ERROR_MSG != "") {
					alert(obj.ERROR_MSG);
				} else {
					if (obj.ERROR_MSG != "") {
						alert(obj.ERROR_MSG);
					} else {						
						document.getElementById("Designation").focus();
					}					
				}
			}
		};
		xhttp.open("POST", "HTTPValidator?" + DataMap, true);
		xhttp.send();
	}
	else{
		alert("Branch Code Should not be null!");
		document.getElementById("Designation").focus();
	}
 }
}

function DesignationValidation(event){
	if (event.keyCode == 13 || event.which == 13) {
		document.getElementById("JoiningDate").focus();
	}
}
function JoiningDateValidation(event){
	if (event.keyCode == 13 || event.which == 13) {
		var txtTest = document.getElementById('JoiningDate');
	    var isValid = IsValidDate(txtTest.value);
	    if (isValid) {
	    	document.getElementById("DeptCode").focus();
	    }
	    else {
	        alert('Incorrect format');
	        document.getElementById("JoiningDate").focus();
	    }
	}
}

function DeptCodeValidation(event){
	if (event.keyCode == 13 || event.which == 13) {
		document.getElementById("GenderType").focus();
	}
}
function GenderValidation(event){
	if (event.keyCode == 13 || event.which == 13) {
		document.getElementById("BloodGrp").focus();
	}
}
function BloodGrpValidation(event){
	if (event.keyCode == 13 || event.which == 13) {
		document.getElementById("Rhfactor").focus();
	}
}
function RhfactorValidation(event){
	if (event.keyCode == 13 || event.which == 13) {
		document.getElementById("DOB").focus();
	}
}
function DOBValidation(event){
	if (event.keyCode == 13 || event.which == 13) {
		var txtTest = document.getElementById('DOB');
	    var isValid = IsValidDate(txtTest.value);
	    if (isValid) {
	    	document.getElementById("contactNo").focus();
	    }
	    else {
	        alert('Incorrect format');
	        document.getElementById("DOB").focus();
	    }
	}
}
function ContactValidation(event){
	if (event.keyCode == 13 || event.which == 13) {
		document.getElementById("TIN").focus();
	}
}
function TINValidation(event){
	if (event.keyCode == 13 || event.which == 13) {				
		document.getElementById("email").focus();
	}
}
function EmailValidation(event){
	if (event.keyCode == 13 || event.which == 13) {		
		var email = document.getElementById('email');
	    var filter = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
	    if (!filter.test(email.value)) {
	    	alert('Please provide a valid email address');
	    }
	    else{
	    	document.getElementById("homeDist").focus();
	    }
	}
}

function  HomeDistValidation(event){
	if (event.keyCode == 13 || event.which == 13) {
		document.getElementById("NID").focus();
	}
}
function  NIDValidation(event){
	if (event.keyCode == 13 || event.which == 13) {
		document.getElementById("SeniorityCode").focus();
	}
}

function SeniorityCodeValidation(event){
	if (event.keyCode == 13 || event.which == 13) {
		document.getElementById("Address").focus();
	}
}
function AddressValidation(event){
	if (event.keyCode == 13 || event.which == 13) {
		document.getElementById("HighestDegree").focus();
	}
}
function HighestDegreeValidation(event){
	if (event.keyCode == 13 || event.which == 13) {
		document.getElementById("submit").focus();
	}
}

$(function() {
	$("#JoiningDate").datepicker({
		dateFormat : 'dd-M-yy'
	});
});

$(function() {
	$("#DOB").datepicker({
		dateFormat : 'dd-M-yy'
	});
});

function AddEmployeeInfo(event)
{	
	 var c = confirm("Are you sure ?");
	  if (c == true) {
		  clear();
			SetValue("EntdBy",userId);
			SetValue("EmployeeId",document.getElementById("EmployeeId").value,"N");
			SetValue("EmployeeName",document.getElementById("EmployeeName").value	 ,"N");
			SetValue("EmployeeNameB",document.getElementById("EmployeeNameB").value	 ,"N");
			SetValue("FatherName",document.getElementById("FatherName").value      ,"N");
			SetValue("FatherNameB",document.getElementById("FatherNameB").value      ,"N");
			SetValue("MotherName",document.getElementById("MotherName").value      ,"N");
			SetValue("MotherNameB",document.getElementById("MotherNameB").value      ,"N");
			SetValue("JoiningDate",document.getElementById("JoiningDate").value     ,"N");			
			SetValue("Designation",document.getElementById("Designation").value     ,"N");
			SetValue("BranchCode",document.getElementById("BranchCode").value      ,"N");
			SetValue("Quota",document.getElementById("Quota").value           ,"N");
			SetValue("Scale",""          ,"N");
			SetValue("Grade",document.getElementById("Grade").value           ,"N");
			SetValue("DeptCode",document.getElementById("DeptCode").value        ,"N");
			SetValue("DOB",document.getElementById("DOB").value             ,"N");
			SetValue("contactNo",document.getElementById("contactNo").value       ,"N");
			SetValue("TIN",document.getElementById("TIN").value             ,"N");
			SetValue("SeniorityCode",document.getElementById("SeniorityCode").value   ,"N");
			SetValue("Address",document.getElementById("Address").value         ,"N");
			SetValue("email",document.getElementById("email").value           ,"N");
			SetValue("ReligionType",document.getElementById("ReligionType").value	, "N");
			SetValue("GenderType",document.getElementById("GenderType").value      ,"N");
			SetValue("Rhfactor",document.getElementById("Rhfactor").value        ,"N");
			SetValue("BloodGrp",document.getElementById("BloodGrp").value        ,"N");
			SetValue("homeDist",document.getElementById("homeDist").value        ,"N");
			SetValue("NID",document.getElementById("NID").value             ,"N");
			SetValue("EmergencyContact",document.getElementById("EmergencyContact").value,"N");
			SetValue("EmergencyPhone",document.getElementById("EmergencyPhone").value  ,"N");
			SetValue("MaritalStatus",document.getElementById("MaritalStatus").value   ,"N");
			SetValue("PassportNo",document.getElementById("PassportNo").value      ,"N");
			SetValue("PermanentAddress",document.getElementById("PermanentAddress").value,"N");
			SetValue("Class","AdminOperation","N");
			SetValue("Method","SaveNewEmployee","L");
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
	
				
}
function LoadDesignationList(){

	clear();	
	SetValue("Class", "AccontingParameterSetup","N");
	SetValue("Method", "GetDesignationList","L");
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
				var item_srting=obj.DESIGNATION_LIST;	
				var select = document.getElementById("Designation");                  
				 var item_arrayList = item_srting.split(',');
				 for(var i = 0; i < item_arrayList.length; i++) {
					 item_arrayList[i] = item_arrayList[i].replace("/^\s*/", "").replace("/^\s*/", "");							 
					    var item_keyValue = item_arrayList[i].split(':');
					    var option = document.createElement("option");
					    option.value=item_keyValue[0];
					    option.text=item_keyValue[1];	
					    select.add(option, null);				   				   
				 }
			}
	});			
}
function LoadDeptList(){

	clear();	
	SetValue("Class", "AccontingParameterSetup","N");
	SetValue("Method", "GetDepartmentList","L");
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
				var item_srting=obj.DEPT_LIST;	
				var select = document.getElementById("DeptCode");                  
				 var item_arrayList = item_srting.split('@');
				 for(var i = 0; i < item_arrayList.length; i++) {
					 item_arrayList[i] = item_arrayList[i].replace("/^\s*/", "").replace("/^\s*/", "");							 
					    var item_keyValue = item_arrayList[i].split(':');
					    var option = document.createElement("option");
					    option.value=item_keyValue[0] ;
					    option.text=item_keyValue[1];	
					    select.add(option, null);				   				   
				 }
			}
	});			
} 

function LoadGradList(){
	clear();	
	SetValue("Class", "AccontingParameterSetup","N");
	SetValue("Method", "GetGradeList","L");
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
				var item_srting=obj.SCALE_LIST;	
				var select = document.getElementById("Grade");                  
				 var item_arrayList = item_srting.split(',');
				 for(var i = 0; i < item_arrayList.length; i++) {
					 item_arrayList[i] = item_arrayList[i].replace("/^\s*/", "").replace("/^\s*/", "");							 
					    var item_keyValue = item_arrayList[i].split(':');
					    var option = document.createElement("option");
					    option.value=item_keyValue[0] ;
					    option.text=item_keyValue[1];	
					    select.add(option, null);				   				   
				 }
			}
	});			
} 
function LoadBranchList(){

	clear();	
	SetValue("Class", "AccontingParameterSetup","N");
	SetValue("Method", "GetBranchList","L");
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
				var item_srting=obj.BRANCH_LIST;	
				var select = document.getElementById("BranchCode");                  
				 var item_arrayList = item_srting.split(',');
				 for(var i = 0; i < item_arrayList.length; i++) {
					 item_arrayList[i] = item_arrayList[i].replace("/^\s*/", "").replace("/^\s*/", "");							 
					    var item_keyValue = item_arrayList[i].split(':');
					    var option = document.createElement("option");
					    option.value=item_keyValue[0];
					    option.text=item_keyValue[1];	
					    select.add(option, null);				   				   
				 }
			}
	});			
}
</script>

</head>
<body onload="initValues()">
	<center>
		<div class="container">
		   <fieldset>
		
				<div class="row">
					<div class="col-15">
						<label for="EmployeeId">Employee ID</label>
					</div>
					<div class="col-20">
						<input type="text" id="EmployeeId" name="EmployeeId" onkeypress="EmployeeIdValidation(event)">
					</div>														
				 </div>
				 
				 
				 <div class="row">
					<div class="col-15">
						<label for="EmployeeName">Name</label>
					</div>
					<div class="col-20">
						<input type="text" id="EmployeeName" name="EmployeeName" onkeypress="EmployeeNameValidation(event)">
					</div>
					
					<div class="colr-15">
						<label for="EmployeeNameB"> নাম  </label>
					</div>
					<div class="colr-20">
						<input type="text" id="EmployeeNameB" name="EmployeeNameB" onkeypress="EmployeeNameValidation(event)" >
					</div>										
				 </div>
				 
				 
				 <div class="row">
					<div class="col-15">
						<label for="FatherName">Father's Name</label>
					</div>
					<div class="col-20">
						<input type="text" id="FatherName" name="FatherName" onkeypress="EmployeeIdValidation(event)">
					</div>
					
					<div class="colr-15">
						<label for="FatherNameB">পিতার নাম </label>
					</div>
					<div class="colr-20">
						<input type="text" id="FatherNameB" name="FatherNameB" onkeypress="EmployeeNameValidation(event)" >
					</div>										
				 </div>
				 
				  <div class="row">
					<div class="col-15">
						<label for="MotherName">Mother's Name</label>
					</div>
					<div class="col-20">
						<input type="text" id="MotherName" name="MotherName" onkeypress="EmployeeIdValidation(event)">
					</div>
					
					<div class="colr-15">
						<label for="MotherNameB">মাতার নাম </label>
					</div>
					<div class="colr-20">
						<input type="text" id="MotherNameB" name="MotherNameB" onkeypress="EmployeeNameValidation(event)" >
					</div>										
				 </div>
				 
				 
		</fieldset>
				<fieldset>
				<legend>Joining Info</legend>				
				<div class="row">
					
					
					<div class="col-15">
						<label for="BranchCode">Posting Branch</label>
					</div>
					<div class="col-20">
					<select id="BranchCode" name="BranchCode" style="width: 254px;">						
					</select>
				   </div>
					
					
					<div class="colr-15">
					<label for="Designation">Designation </label>
					</div>
	
					<div class="colr-20">
						<select id="Designation" name="newDesignation" style="width: 254px;">						
					</select>
					</div>
					
					
				</div>
				<div class="row">

					<div class="col-15">
						<label for="Quota">Joining Quota</label>
					</div>
					<div class="col-20">
						<select id="Quota" name="Quota"  onkeypress="QuotaValidation(event)" style="width: 254px;">														
							<option value="0">Merit</option>	
							<option value="1">Freedom Fighter</option>
							<option value="3">Others</option>
						</select>
					</div>
					
					
					<div class="colr-15">
						<label for="DeptCode">Department Name</label>
					</div>
					<div class="colr-20">
					<select id="DeptCode" name="DeptCode" style="width: 254px;">						
					</select>
				    </div>				  
				  </div>	
				
				
				<div class="row">
				
					   <div class="col-15">
							<label for="Grade">Joining Grade </label>
						</div>
						<div class="col-20">
							<select id="Grade" name="Grade" style="width: 254px;">						
							</select>
						</div>
										
					
					<div class="colr-15">
						<label for="JoiningDate">Joining Date</label>
					</div>
					<div class="colr-20">
						<input  type="text" id="JoiningDate" value="" onkeypress="JoiningDateValidation(event)" >
					</div>
					
					
					
				</div>	
								
			</fieldset>
			<fieldset>
				<div class="row">	
					<div style="width: 15%; float: left; ">
						<label for="GenderType">Gender </label>
					</div>				
					<div class="col-20">
						<select id="GenderType" name="GenderType" onkeypress="GenderValidation(event)" style="width: 254px;" >
							<option value="M">M-Male</option>
							<option value="F">F-Female</option>
						</select>
					</div>	
				
					<div class="colr-15">
						<label for="BloodGrp">Blood Group</label>
					</div>
								
					<div class="colx-15">
						<select id="BloodGrp" name="BloodGrp" onkeypress="BloodGrpValidation(event)" style="width: 135px;">
							<option value="A">A</option>
							<option value="B">B</option>
							<option value="AB">AB</option>
							<option value="O">O</option>
						</select>
					</div>				
					<div class="colx-15">
						<select id="Rhfactor" name="Rhfactor" onkeypress="RhfactorValidation(event)" style="width: 145px;">
							<option value="positive">Positive</option>
							<option value="negative">Negative</option>							
						</select>
					</div>				
				</div>
								
				<div class="row">
					<div class="col-15">
						<label for="DOB">Date of Birth</label>
					</div>
					<div class="col-20">
						<input  type="text" id="DOB" value="" onkeypress="DOBValidation(event)" >
					</div>
					
					<div class="colr-15">
						<label for="contactNo"> Contact No</label>
					</div>
					<div class="colr-20">
						<input type="text" id="contactNo" name="contactNo" onkeypress="ContactValidation(event)"  >
					</div>	
				</div>	
				
				
				<div class="row">
					<div class="col-15">
						<label for="TIN">TIN No.</label>
					</div>
					<div class="col-20">
						<input type="text" id="TIN" value="" onkeypress="TINValidation(event)" >
					</div>
					
					<div class="colr-15">
						<label for="email"> Email</label>
					</div>
					<div class="colr-20">
						<input type="text" id="email" name="email" onkeypress="EmailValidation(event)">
					</div>	
				</div>	
				
				
				<div class="row">
					<div class="col-15">
						<label for="homeDist"> Home District</label>
					</div>
					<div class="col-20">
						<input type="text" id="homeDist" name="homeDist" onkeypress="HomeDistValidation(event)">
					</div>	
				
					<div class="colr-15">
						<label for="NID">NID No</label>
					</div>
					<div class="colr-20">
						<input type="text" id="NID" value="" onkeypress="NIDValidation(event)" >
					</div>										
				</div>	
							
				
				<div class="row">
					<div class="col-15">
						<label for="SeniorityCode">Seniority  Code</label>
					</div>
					<div class="col-20">
						<input type="text" id="SeniorityCode" value="" onkeypress="SeniorityCodeValidation(event)" >
					</div>
					
					<div class="colr-15">
						<label for="EmergencyContact"> Emergency Contact</label>
					</div>
					<div class="colr-20">
					<input type="text" id="EmergencyContact" value="" onkeypress="EmergencyContact(event)" >
					</div>	
				</div>	
				
				<div class="row">
					<div class="col-15">
						<label for="ReligionType">Religion </label>
					</div>
					<div class="col-20">
						<select id="ReligionType" name="ReligionType" style="width: 254px;">
							<option value="M">Muslim</option>
							<option value="H">Hindu</option>
							<option value="B">Buddhist</option>		
							<option value="C">Christian</option>							
						</select>
					</div>
					
					<div class="colr-15">
						<label for="EmergencyPhone">Emergency Phone </label>
					</div>
					<div class="colr-20">
						<input type ="text" id="EmergencyPhone" name="EmergencyPhone"  onkeypress="EmergencyPhoneValidation(event)" >												
					</div>																
				</div>	
				
				
				
				<div class="row">
					<div class="col-15">
						<label for="MaritalStatus">Marital Status </label>
					</div>
					<div class="col-20">
						<select id="MaritalStatus" name="MaritalStatus" style="width: 254px;">
							<option value="Y">Married</option>
							<option value="N">Un-Married</option>		
						</select>
					</div>
					
					<div class="colr-15">
						<label for="PassportNo">Passport Number </label>
					</div>
					<div class="colr-20">
						<input type ="text" id="PassportNo" name="PassportNo"  onkeypress="PassportNoValidation(event)" >												
					</div>																
				</div>	
				
				 <div class="row">
					<div class="col-15">
						<label for="Address">Present Address</label>
					</div>
					<div class="col-20">
						 <input type ="text" id="Address" name="Address"  onkeypress="PresentAddressValidation(event)" >	
					</div>
					
					<div class="colr-15">
						<label for="PermanentAddress">Permanent Address</label>
					</div>
					<div class="colr-20">
					      <input type ="text" id="PermanentAddress" name="PermanentAddress"  onkeypress="PermanentAddressValidation(event)" >	
					</div>										
				 </div>	
				
				</fieldset>
								
				<br>				
				<div class="col-75"></div>
				<div class="row">
					<input type="submit" id="submit" value="Submit" onclick="AddEmployeeInfo(event)" >
				</div>
		</div>
	</center>
</body>
</html>