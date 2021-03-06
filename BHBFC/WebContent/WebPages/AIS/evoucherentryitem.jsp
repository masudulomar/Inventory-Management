<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="/resources/demos/style.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>


</head>
<style> 
body {
  /* background-image: url('../../Media/bg9.jpg') ;
  background-repeat: no-repeat;
  background-size: /* 300px 100px   auto ; */
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
	background-color: #339933;
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
	background-color: #FAE5D3;
	padding: 20px;
}

.col-25 {
	float: left;
	width: 40%;
	margin-top: 6px;
}
.col-15{
float: left;
	width: 20%;
	margin-top: 6px;
}
.col-35{
float: left;
	width: 30%;
	margin-top: 6px;
}

.col-75 {
	float: left;
	width: 30%;
	margin-top: 6px;
}
.colt-20 {
	float: left;
	width: 75%;
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

function initValues(){
	loadgitem();
	
	document.getElementById("TransactionAmount").value= "";
	document.getElementById("BranchCode").value="<%= session.getAttribute("BranchCode")%>";
	document.getElementById("TransactionAmount").focus();
}


function loadgitem(){
	clear();	
	var usr_brn ="<%= session.getAttribute("BranchCode")%>";
	SetValue("BranchCode",usr_brn,"N");
	SetValue("Class", "AccontingParameterSetup","N");
	SetValue("Method", "FetchItemData","L");
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
				var item_srting=obj.ITEM_LIST;					
				var select = document.getElementById("itemCode");                  
				 var item_arrayList = item_srting.split(',');
				 for(var i = 0; i < item_arrayList.length; i++) {
					 item_arrayList[i] = item_arrayList[i].replace("/^\s*/", "").replace("/^\s*/", "");							 
					    var item_keyValue = item_arrayList[i].split(':');
					    var option = document.createElement("option");
					    option.value=item_keyValue[0] ;
					    option.text=item_keyValue[1]+": "+item_keyValue[0];	
					    select.add(option, null);				   				   
				 }
			}
	});			
}

function TransactionAmountValidation(event){
	if (event.keyCode == 13 || event.which == 13) {    		   		
		if(document.getElementById("TransactionAmount").value!=""){
			if(isNaN(document.getElementById("TransactionAmount").value)){
				alert("Transaction Amount is not number");
				document.getElementById("TransactionAmount").focus();
			}
			else{
				if(parseFloat(document.getElementById("TransactionAmount").value)<=0.00){
    				alert("Transaction Amount Should be Greater then Zero");
    				document.getElementById("TransactionAmount").focus();
    			}
    			else
    				{
    				document.getElementById("TransactionAmount").value=parseFloat(document.getElementById("TransactionAmount").value).toFixed(2);
    				document.getElementById("ChequeNo").focus();
    			}
			}        			
		}
		else
			{
			  alert("Should not blank");
			  document.getElementById("TransactionAmount").focus();
		}   
	}
}

function CHQNumberValidation(event){
	if (event.keyCode == 13 || event.which == 13) {
		if(document.getElementById("ChequeNo").value!=""){
			document.getElementById("ChequeDate").focus();
		}
		else{
			document.getElementById("ChequeReference").focus();
		}
		
	}
}

function CHQDateValidation(event){
	if (event.keyCode == 13 || event.which == 13) {		
		document.getElementById("ChequeReference").focus();
	}
}

function CHQReferenceValidation(event){
	if (event.keyCode == 13 || event.which == 13) {   
		
		if(document.getElementById("ChequeReference").value==""){
			document.getElementById("ChequeReference").value="N/A";
		}
		document.getElementById("TransactionDate").focus();
	}
}

function TransactionDateValidation(event){
	if (event.keyCode == 13 || event.which == 13) {		
		document.getElementById("Remarks").focus();
	}
}
function RemarksValidation(event){
	if (event.keyCode == 13 || event.which == 13) {	
		document.getElementById("Remarks").value="N/A";
		document.getElementById("Remarks").focus();
	}
}


function ViewTransaction(event){
	
	var usr_brn = "<%= session.getAttribute("BranchCode")%>";	
	var DataString="loggedBranch="+usr_brn+"&ReportType=ViewItemAutoVoucher"+
	"&BranchCode="+document.getElementById("BranchCode").value+
	"&itemCode="+document.getElementById("itemCode").value+
	"&TransactionAmount="+document.getElementById("TransactionAmount").value+
	"&Remarks="+document.getElementById("Remarks").value+
	"&TransactionDate="+document.getElementById("TransactionDate").value;
	
		var xhttp = new XMLHttpRequest();		
		xhttp.open("POST", "TranReportServlet?"+DataString, true);
		
		xhttp.responseType = "blob";
		xhttp.onreadystatechange = function () {
		    if (xhttp.readyState === 4 && xhttp.status === 200) {		    	
		        var filename = "Report_ViewItemAutoVoucher"+".pdf";
		        if (typeof window.chrome !== 'undefined') {
		            // Chrome version
		            var link = document.createElement('a');
		            link.href = window.URL.createObjectURL(xhttp.response);		       
		            window.open(link.href);		            
		            //link.download = "PdfName-" + new Date().getTime() + ".pdf";
		            //link.click();
		        } else if (typeof window.navigator.msSaveBlob !== 'undefined') {
		            // IE version
		            var blob = new Blob([xhttp.response], { type: 'application/pdf' });
		            window.navigator.msSaveBlob(blob, filename);
		           // window.open(window.navigator.msSaveBlob(blob, filename));
		        } else {
		            // Firefox version
		            var file = new File([xhttp.response], filename, { type: 'application/force-download' });
		            window.open(URL.createObjectURL(file));		            
		        }
		    }
		};
		xhttp.send();			
}


function MakeTransaction(event)
{
	 var c = confirm("Are you sure ?");
	  if (c == true) {
		    clear();		    		    
		    var User_Id ="<%= session.getAttribute("User_Id")%>";
		    var usr_brn ="<%= session.getAttribute("BranchCode")%>";			    
		    SetValue("loggedBranch",usr_brn,"N");
		    SetValue("User_Id",User_Id,"N");
		    SetValue("BranchCode",document.getElementById("BranchCode").value,"N");
		    SetValue("itemCode",document.getElementById("itemCode").value,"N");
		    SetValue("ChequeNo",document.getElementById("ChequeNo").value,"N");
		    SetValue("ChequeDate",document.getElementById("ChequeDate").value,"N");
		    SetValue("ChequeReference",document.getElementById("ChequeReference").value,"N");
		    SetValue("TransactionAmount",document.getElementById("TransactionAmount").value,"N");
		    SetValue("TransactionDate",document.getElementById("TransactionDate").value,"N");
		    SetValue("Remarks",document.getElementById("Remarks").value,"N");		    
			SetValue("Class","AccountingManagement","N");
			SetValue("Method","ItemWiseVoucherPosting","L");
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
			
			
	  } else {
		  document.getElementById("eventViewTransaction").focus();
	  }	
}


$(function() {
	$("#ChequeDate").datepicker({
		dateFormat : 'dd-M-yy'
	});
});

$(function() {
	$("#TransactionDate").datepicker({
		dateFormat : 'dd-M-yy'
	});
});

</script>
<body onload="initValues()">
	<center>
	
	<h2>[Item Wise Transaction Pages]</h2>
	<div class="container">
	
				<div class="row">
					<div class="col-15">
						<label for="BranchCode">Branch Code</label>
					</div>
					<div class="col-15">
						<input type="text" id="BranchCode" name="BranchCode" readonly>
					</div>
				</div>
	
	            <div class="row">
					<div class="col-15">
						<label for="">Transaction Item</label>
					</div>
					<div class="col-25">
					<select id="itemCode" name="itemCode">
						
					</select>
				</div>
				</div>
	
				<div class="row">
					<div class="col-15">
						<label for="TransactionAmount">Transaction Amount</label>
					</div>
					<div class="col-15">
						<input type="text" id="TransactionAmount" name="TransactionAmount" onkeypress="TransactionAmountValidation(event)">
					</div>
				</div>
				
				<div class="row">
					<div class="col-15">
						<label for="ChequeNo">CQ. No</label>
					</div>
					<div class="col-15">
						<input type="text" id="ChequeNo" name="ChequeNo" onkeypress="CHQNumberValidation(event)">
					</div>
					
					<div class="row">
					<div class="col-15">
						<label for="ChequeDate">CQ. Date</label>
					</div>
					<div class="col-15">
						<input type="text" id="ChequeDate" name="ChequeDate"  onkeypress="CHQDateValidation(event)">
					</div>
				</div>					
				</div>
								
				
				<div class="row">
					<div class="col-15">
						<label for="ChequeReference">CQ. Reference</label>
					</div>
					<div class="col-15">
						<input type="text" id="ChequeReference" name="ChequeReference" onkeypress="CHQReferenceValidation(event)">
					</div>
					
					<div class="col-15">
						<label for="TransactionDate">Transaction Date</label>
					</div>
					<div class="col-15">
						<input type="text" id="TransactionDate" name="TransactionDate" onkeypress="TransactionDateValidation(event)">
					</div>					
				</div>
				

				<div class="row">

				<div class="col-15">
					<label for="Remarks"> Remarks</label>
				</div>
				<div class="colt-20">
					<textarea id="Remarks" name="Remarks" rows="3" cols="50"
						onkeypress="RemarksValidation(event)"></textarea>
				</div>
		
			   </div>

				<br>
				
				<div class="row">
				<div class="col-75"></div>
				<div class="col-15">
					<input type="submit" id="eventViewTransaction" value="View Transaction" onclick="ViewTransaction(event)" > 
				</div>
				<div class="col-15">
					<input type="submit" id="eventTransaction" value="Make Transaction" onclick="MakeTransaction(event)" > 
				</div>									
				</div>
				
				
				
									
	</div>
	</center>
</body>
</html>