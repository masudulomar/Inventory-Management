<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page session="true"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Central Accounting System</title>
<style>
* {
	font-style: normal;
}

table {
	width: 100%;
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
input[type=button] {
	background-color: #4CAF50;
	color: white;
	padding: 12px 20px;
	border: none;
	border-radius: 4px;
	cursor: pointer;
	float: left;
}
input[type=text],select,textarea {	
	color: black;
	padding: 8px 8px;
	border: none;
	border-radius: 1px;
	cursor: pointer;
	float: left;
	
}

input[type=submit]:hover {
	background-color: #45a049;
}

table, th, td {
	border: solid 1px #45a049;
	border-collapse: collapse;
	padding: 4px 8px;
	text-align: center;
	float: center;
}
.gridcontainer{
  background-color: #FAD7A0 ;
}
.container {
background-color: #FAE5D3;
	border-radius: 5px;
	padding: 20px;
}
.containerfooter{
background-color: #FAE5D3
}

.row:after {
	content: "";
	display: table;
	clear: both;
}

.col-15 {
	float: left;
	width: 15%;
	margin-left: 50px;
}

.col-75 {
	float: left;
	width: 40%;
	margin-top: 6px;
}

.col-20 {
	float: left;
	width: 20%;
}

.col-80 {
	float: left;
	width: 47%;
	margin-top: 6px;
}

.colt-20 {
	float: left;
	width: 75%;
}
</style>
<link href="//ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/themes/start/jquery-ui.min.css" rel="stylesheet">
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script src="//ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/jquery-ui.min.js"></script>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<script type="text/javascript">

$( function() {
	 
	  $( "#glcode" ).autocomplete({
	    source: availableTags
	  });
	} );
	
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

var availableTags=[];

var gl_srting="";
var gl_code_search_list=["{}"];
var glcodelist;
function loadgllist(){

	var loggedBranch="<%=session.getAttribute("BranchCode")%>";
		
	clear();		
	SetValue("loggedBranch", loggedBranch,"N");
	SetValue("Class", "AccontingParameterSetup","N");
	SetValue("Method", "FetchGLData","L");	
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
					gl_srting=obj.GL_LIST;					
					 var gl_arrayList = gl_srting.split(',');
					 for(var i = 0; i < gl_arrayList.length; i++) {
						 gl_arrayList[i] = gl_arrayList[i].replace("/^\s*/", "").replace("/^\s*/", "");				
					    var gl_keyValue = gl_arrayList[i].split(':');
					    availableTags.push(gl_keyValue[1]+":"+gl_keyValue[0]);
					 }
				}
		});		
		
}

function reload(){
	removeAllrow();
	document.getElementById("glcode").value = "";
	document.getElementById("Narration").value = "";		
	document.getElementById("Remarks").value = "";
	document.getElementById("chqNumber").value="";
    document.getElementById("cqReference").value="";
    document.getElementById("chqDate").value="";
   // document.getElementById("asonDate").value="";
	//document.getElementById("TransactionAmt").value = "0";
	document.getElementById("TransactionAmtDr").value = "0";
	document.getElementById("TransactionAmtCR").value = "0";
	document.getElementById("officecode").focus();		
}

function initValues(){			
		createTable();
		loadgllist();
		document.getElementById("officecode").value = "<%=session.getAttribute("BranchCode")%>";
		document.getElementById("glcode").value = "";
		document.getElementById("Narration").value = "";		
		document.getElementById("Remarks").value = "";
		document.getElementById("chqNumber").value="";
        document.getElementById("cqReference").value="";
        document.getElementById("chqDate").value="";
        document.getElementById("asonDate").value="";
		//document.getElementById("TransactionAmt").value = "0";
		document.getElementById("TransactionAmtDr").value = "0";
		document.getElementById("TransactionAmtCR").value = "0";
		document.getElementById("glcode").focus();		
	} 	
	
	 var drcrlist=[	
		{value:"D",	label:"Debit"},
		{value:"C",	label:"Credit"}
	];
	 
	$(function() {
		
		$("#DrCrType").autocomplete({
			source: drcrlist
		}).autocomplete("widget").addClass("fixed-height");
		
	});


    var arrHead = new Array();	
    arrHead = ['Activity', 'GL Head', 'Cr Amount', 'Dr Amount','Narration','CQ Info'];

    // first create TABLE structure with the headers. 
    function createTable() {
        var tranTable = document.createElement('table');
        tranTable.setAttribute('id', 'tranTable'); // table id.

        var tr = tranTable.insertRow(-1);
        for (var h = 0; h < arrHead.length; h++) {
            var th = document.createElement('th'); // create table headers
            th.innerHTML = arrHead[h];
            tr.appendChild(th);
        }

        var div = document.getElementById('gridContainer');
        div.appendChild(tranTable);  // add the TABLE to the container.
    }
    
    function clearTable(){
    	var empTab = document.getElementById('tranTable');              
    	
    	for (row = 1; row < empTab.rows.length - 1; row++) {  
    		empTab.deleteRow(oButton.parentNode.parentNode.row);
    	}
    		
            // button -> td -> tr.        
    }

    // delete TABLE row function.
    
    
    function removeAllrow(){
    	var myTab = document.getElementById('tranTable');    	
    	for (row = 1; row < myTab.rows.length - 1; row++) {   		
   		myTab.deleteRow(row);
    	}
    }
    
    function removeRow(oButton) {
        //var empTab = document.getElementById('tranTable');              
     //   empTab.deleteRow(oButton.parentNode.parentNode.rowIndex); // button -> td -> tr.
     
     var myTab = document.getElementById('tranTable');
    	var arrValues = new Array();
    	var dataGrid="";
    	var transactionString=new Array();
    	var loggedBranch= "<%=session.getAttribute("BranchCode")%>";
    	// loop through each row of the table.
    	for (row = 1; row < myTab.rows.length - 1; row++) {  
    		if  (oButton.parentNode.parentNode.rowIndex==row){
    			for (c = 0; c < myTab.rows[row].cells.length; c++) { 		    		        			
        			var arrValuesv = new Array();
        			var element = myTab.rows.item(row).cells[c];								
        			if (element.childNodes[0].getAttribute('type') == 'text') {    				
        				//arrValues.push("'"+c+":" + element.childNodes[0].value + "'");
        				dataGrid=dataGrid+"id"+c+":"+element.childNodes[0].value;
        				
        				if(c==3){
        					document.getElementById("TransactionAmtDr").value=parseFloat(parseFloat(document.getElementById("TransactionAmtDr").value)-parseFloat(element.childNodes[0].value)).toFixed(2);
        				}
        				if(c==2){
        					document.getElementById("TransactionAmtCR").value=parseFloat(parseFloat(document.getElementById("TransactionAmtCR").value)-parseFloat(element.childNodes[0].value)).toFixed(2);
        				}        				
        				
        			}
        		}	
    		}
    		   				
    	}
    	myTab.deleteRow(oButton.parentNode.parentNode.rowIndex);
     
    }
    
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

    function refreshValues(){
    	document.getElementById("DrCrType").value="";
    	document.getElementById("glcode").value = "";
    	document.getElementById("chqNumber").value="";
        document.getElementById("cqReference").value="";
        document.getElementById("chqDate").value="";
    	document.getElementById("TransactionAmt").value = "0";
    	document.getElementById("Narration").value = "";   	
    	document.getElementById("glcode").focus();
    }

    function OfficeCodeValidation(event){
    	if (event.keyCode == 13 || event.which == 13) {
    		if(document.getElementById("officecode").value==""){
    			document.getElementById("Remarks").focus();     
    		}
    		else
    			{
    			  document.getElementById("glcode").focus();
    		}   		
    	}
    }
    
    function upperCase(a){
        setTimeout(function(){
            a.value = a.value.toUpperCase();
        }, 1);
    }
    
    function GLCodeValidation(event){   	
    	if (event.keyCode == 13 || event.which == 13) {   		
    		if(document.getElementById("glcode").value!=""){   			   		
    			clear();
    			SetValue("gldescription", document.getElementById("glcode").value,"N");
    			SetValue("Class", "AccontingParameterSetup","N");
    			SetValue("Method", "GLCodeValidation","L");	
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
    						document.getElementById("glcode").focus();
    					} else {				 
    						document.getElementById("DrCrType").focus();
    					}   						
    			}); 
    	  }
       }   
    	
    }
    function DrCrTypeValidation(event){
    	if (event.keyCode == 13 || event.which == 13) {
    		if(document.getElementById("DrCrType").value!=""){    			
    			if(document.getElementById("DrCrType").value=="D"||document.getElementById("DrCrType").value=="C"){
    				document.getElementById("TransactionAmt").focus();   				
    			}
    			else{
    				alert("Invalid Character!!!\n Please enter D=>Debit,C=>Credit");
      			    document.getElementById("DrCrType").focus();
    			}   			
    		}
    		else
    			{
    			  alert("DR/CR Should not Black");
    			  document.getElementById("DrCrType").focus();
    		}       		   		
    	}
    }
    function TransactionAmountValidation(event){
    	if (event.keyCode == 13 || event.which == 13) {
    		
    		if (document.getElementById("glcode").value==""||document.getElementById("DrCrType").value=="" ){
    			
    			if (document.getElementById("glcode").value==""){
    				 alert("GL code should not be blank");       			 
    				document.getElementById("glcode").focus();
    			}    			
    			else if (document.getElementById("DrCrType").value==""){
   				    alert("DR/CR Should not Black");       			 
   				  document.getElementById("DrCrType").focus();
   			   }		
    			
    		}
    		else{   			
	    			if(document.getElementById("TransactionAmt").value!=""){
	        			if(isNaN(document.getElementById("TransactionAmt").value)){
	        				alert("Transaction Amount is not number");
	        				document.getElementById("TransactionAmt").focus();
	        			}
	        			else{
	        				if(parseFloat(document.getElementById("TransactionAmt").value)<=0.00){
	            				alert("Transaction Amount Should be Greater then Zero");
	            				document.getElementById("TransactionAmt").focus();
	            			}
	            			else
	            				{
	            				document.getElementById("TransactionAmt").value=parseFloat(document.getElementById("TransactionAmt").value).toFixed(2);
	            				document.getElementById("chqNumber").focus();
	            			}
	        			}        			
	        		}
	        		else
	        			{
	        			  alert("Should not blank");
	        			  document.getElementById("TransactionAmt").focus();
	        		}  
        		
    		}   		
    	}
    }

    function TransationTypeValidation(event){
    	if (event.keyCode == 13 || event.which == 13) {
    		document.getElementById("chqNumber").focus();
    	}
    }
    function CHQNumberValidation(event){
    	if (event.keyCode == 13 || event.which == 13) {
    		if(document.getElementById("chqNumber").value!=""){   			
    			document.getElementById("chqDate").value=document.getElementById("asonDate").value;
    			document.getElementById("chqDate").focus();
    		}
    		else{
    			document.getElementById("Narration").focus();
    		}
    		
    	}
    }
    
    function CHQDateValidation(event){
    	if (event.keyCode == 13 || event.which == 13) {
    		document.getElementById("cqReference").focus();
    	}
    }
    
    function CHQReferenceValidation(event){
    	if (event.keyCode == 13 || event.which == 13) {    		
    		document.getElementById("Narration").focus();
    	}
    }
    
    function addTransaction() {
        var empTab = document.getElementById('tranTable');

        var rowCnt = empTab.rows.length;   // table row count.
        var tr = empTab.insertRow(rowCnt); // the table row.
        tr = empTab.insertRow(rowCnt);

        for (var c = 0; c < arrHead.length; c++) {
            var td = document.createElement('td'); // table definition.
            td = tr.insertCell(c);

            if (c == 0) {      // the first column.
                // add a button in every new row in the first column.
                var button = document.createElement('input');

                // set input attributes.
                button.setAttribute('type', 'button');
                button.setAttribute('value', 'Remove');

                // add button's 'onclick' event.
                button.setAttribute('onclick', 'removeRow(this)');

                td.appendChild(button);
            }
            else {
                // 2nd, 3rd and 4th column, will have textbox.
               
                if (c==1){
                	  var ele = document.createElement('input');
                      ele.setAttribute('type', 'text');
               	      ele.setAttribute('value', document.getElementById("glcode").value);
               	      ele.setAttribute("readonly", true);
               	      td.appendChild(ele);
               }  
                if(c==2){
                	 var ele = document.createElement('input');
                     ele.setAttribute('type', 'text');
                     ele.setAttribute("readonly", true);
                	  if( document.getElementById("DrCrType").value=="C") {
                		  ele.setAttribute('value', document.getElementById("TransactionAmt").value);               		 
                	  }
                	  else{
                		  ele.setAttribute('value', "0");
                	  }
                		  
                	  td.appendChild(ele);
                }
                if (c==3){
                	               	
                	 var ele = document.createElement('input');
                     ele.setAttribute('type', 'text');
                     ele.setAttribute("readonly", true);
                	if( document.getElementById("DrCrType").value=="D") {
                		ele.setAttribute('value', document.getElementById("TransactionAmt").value);
                	}
                	else{
                		 ele.setAttribute('value', "0");
                	}                		
                	td.appendChild(ele);	
                }                                               
                if (c==4){
                	 var ele = document.createElement('input');
                     ele.setAttribute('type', 'text');
                  	 ele.setAttribute('value', document.getElementById("Narration").value);
                  	td.appendChild(ele);
                  } 
                if (c==5){
               	 var ele = document.createElement('input');
                     ele.setAttribute('type', 'text');
                     ele.setAttribute("readonly", true);
                     
                     if(document.getElementById("chqNumber").value=="")document.getElementById("chqNumber").value="N/A";
                     if(document.getElementById("cqReference").value=="")document.getElementById("cqReference").value="N/A";
                     if(document.getElementById("chqDate").value=="")document.getElementById("chqDate").value="N/A";
                     
                 	 ele.setAttribute('value', "CQ:"+document.getElementById("chqNumber").value+"!RF:"+document.getElementById("cqReference").value+"!CD:"+document.getElementById("chqDate").value);
                 	 td.appendChild(ele);
                 }  
            }
        }
    }
    
    
    function SingleNaration(event){
    	if (event.keyCode == 13 || event.which == 13) {  
    		if(document.getElementById("Narration").value==""){
    			document.getElementById("Narration").value="N/A";
    		}
    		if (parseFloat(document.getElementById("TransactionAmt").value)>0){
    			
    			if(document.getElementById("glcode").value!=""){   			   		
        			clear();
        			SetValue("gldescription", document.getElementById("glcode").value,"N");
        			SetValue("Class", "AccontingParameterSetup","N");
        			SetValue("Method", "GLCodeValidation","L");	
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
        						document.getElementById("glcode").focus();
        					} else {
        						       						
        						if(document.getElementById("DrCrType").value==""){
        		    				alert("Transaction DR/CR Type Must be Selected");
        		    				document.getElementById("DrCrType").focus();
        		    				
        		    			}
        		    			else{
        		    				
        		        			addTransaction();    		
        		            		if(document.getElementById("DrCrType").value=="D"){
        		            			document.getElementById("TransactionAmtDr").value=parseFloat(parseFloat(document.getElementById("TransactionAmtDr").value)
        		        				+parseFloat(document.getElementById("TransactionAmt").value)).toFixed(2);
        		            		}
        		            		else{
        		            			document.getElementById("TransactionAmtCR").value=parseFloat(parseFloat(document.getElementById("TransactionAmtCR").value)
        		        				+parseFloat(document.getElementById("TransactionAmt").value)).toFixed(2);
        		            		}    		    		
        		            		refreshValues(); 
        		    			}       		
        						
        					}   						
        			}); 
        	    }

    		}
    		else{
    			alert("Transaction Amount Must  be  Greater then Zero !!");
    			document.getElementById("Narration").focus();
    		}
    		
    	}
    }

    function submitTransaction() {
    	
   	 var c = confirm("Are you sure ?");
	  if (c == true) {
		  if(document.getElementById("asonDate").value==""){
	    		alert("Transaction Date is mendatory!!");
	    		document.getElementById("asonDate").focus();
	    	}
	    	else
	    		{
	    		var myTab = document.getElementById('tranTable');
	        	var arrValues = new Array();
	        	var arrValuesv = new Array();
	        	var dataGrid="";
	        	var dataclause="";
	        	var transactionString=new Array();
	        	var loggedBranch= "<%=session.getAttribute("BranchCode")%>";
	        	// loop through each row of the table.
	        	for (row = 1; row < myTab.rows.length - 1; row++) {
	        		// loop through each cell in a row.			
	        		dataclause="loggedBranch<cell>"+loggedBranch+"<clause>"+"BranchCode<cell>"+document.getElementById("officecode").value+"<clause>";
	        		
	        		for (c = 0; c < myTab.rows[row].cells.length; c++) {
	        			var arrValuesv = new Array();
	        			var element = myTab.rows.item(row).cells[c];								
	        			if (element.childNodes[0].getAttribute('type') == 'text') {    				
	        				dataclause=dataclause+"id"+c+"<cell>"+element.childNodes[0].value;
	        				if(c==5 && row != myTab.rows.length - 1) {						
	        					dataclause+="<sentance>";											
	        				}
	        				if(c>=1 && c<=4){
	        					dataclause+="<clause>";
	        				}
	        				
	        			}
	        		}
	        		dataGrid=dataGrid+dataclause;
	        		dataclause="";
	        	}   	
	        	
	        	
	        	
	        	var User_Id="<%=session.getAttribute("User_Id")%>";    	    	
	        	if(document.getElementById("TransactionAmtDr").value!=document.getElementById("TransactionAmtCR").value){
	        		alert("Total Debit & Credit Amount Must Be Equal");
	        		document.getElementById("TransactionAmtCR").focus();
	        	}
	        	else
	        		{
	        		
	        		clear();        	
	            	      	
	            	if(document.getElementById("Remarks").value==""){
	            		SetValue("Remarks", "N/A","N");
	            	}
	            	else{
	            		SetValue("Remarks", document.getElementById("Remarks").value,"N");
	            	}
	            	SetValue("TransactionType",document.getElementById("TransactionType").value,"N");  	            	
	            	SetValue("TransactionAmtDr", document.getElementById("TransactionAmtDr").value,"N");
	            	SetValue("TransactionAmtCR", document.getElementById("TransactionAmtCR").value,"N");
	            	SetValue("asonDate", document.getElementById("asonDate").value,"N");
	            	SetValue("User_Id", User_Id,"N");
	            	SetValue("gridData", dataGrid,"N");  
	            	SetValue("loggedBranch", loggedBranch,"N");
	            	SetValue("Class", "AccountingManagement","N");
	    			SetValue("Method", "VoucherEntryMethod","L");	
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
          				alert(obj.BATCH_NO);             				
          				 reload();
          			}		
	      		    });	
	            	
	        		}    	    	
	    	}  
	  }    	    	  	    	
    }
      
    $(function() {
    	$("#asonDate").datepicker({
    		dateFormat : 'dd-M-yy'
    	});
    });
    
    $(function() {
    	$("#chqDate").datepicker({
    		dateFormat : 'dd-M-yy'
    	});
    }); 
   
    function upperCase(a){
        setTimeout(function(){
            a.value = a.value.toUpperCase();
        }, 1);
    }
    
</script>
</head>
<body onload="initValues()">
<fieldset>
	<div class="container">
	
	
			<div class="row">
				<div class="col-15">
					<label for="officecode">Branch Code</label>
				</div>
				<div class="col-20">
					<input type="text" id="officecode" value=""
						onkeypress="OfficeCodeValidation(event)" readonly>
				</div>	
												
				<div class="col-15">
					<label for="asonDate">Transaction Date</label>
				</div>
				<div class="col-20">
					<input type="text" id="asonDate" name="asonDate" >
				</div>
	
								
			</div>
			
			
			<div class="row">
									  
				  <div class="col-15">
					<label for="glcode">GL Head </label>
				</div>
				  
				  <div class="col-20">
					<input type="text"  id="glcode"  style="width: 450px;" onkeypress="GLCodeValidation(event)">
				</div>	
				  
			
			</div>
		
		
			<div class="row">						
			<div class="col-15">
					<label for="DrCrType">Dr/Cr Type </label>
				</div>
				<div class="col-20">
					<input type="text"  id="DrCrType"   onkeypress="DrCrTypeValidation(event)" placeholder="Enter D=>Debit,C=>Credit" onkeydown="upperCase(this)">
				</div>							
			</div>
								
			<div class="row">
				
				<div class="col-15">
					<label for="TransactionAmt"> Amount</label>
				</div>
				<div class="col-20">
					<input type="text" id="TransactionAmt" value=""
						onkeypress="TransactionAmountValidation(event)">
				</div>				

			</div>
			
			<div class="row">
							
				<div class="col-15">
					<label for="chqNumber"> CQ. No</label>
				</div>
				<div class="col-20">
					<input type="text" id="chqNumber" value=""
						onkeypress="CHQNumberValidation(event)">
				</div>
				
			 <div class="col-15">
					<label for="chqDate">CQ. Date</label>
				</div>
				<div class="col-20">
					<input type="text" id="chqDate" onkeypress="CHQDateValidation(event)">
				</div>				
			</div>
			
			
			<div class="row">				
				<div class="col-15">
					<label for="cqReference">Reference Name</label>
				</div>
				<div class="col-20">
					<input type="text" id="cqReference" name="cqReference"
						onkeypress="CHQReferenceValidation(event)">
				</div>
				<div class="col-15">
					<label for="Narration">Narration</label>
				</div>
				
				<div class="col-20">
					<textarea id="Narration" name="Narration" rows="1" cols="50"
						onkeypress="SingleNaration(event)"></textarea>
				</div>								
			</div>	
</div>


<div class="gridcontainer">
 
		<fieldset>
			<legend>Transaction Grid</legend>

			<div id="gridContainer"></div>
			
<br>
			<div class="row">
			<div class="col-15">
					<label for="TransactionAmtCR"> Total Credit</label>
				</div>
				<div class="col-20">
					<input type="text" id="TransactionAmtCR" value=""
						onkeypress="TransactionAmountValidation(event)" readonly>
				</div>
			
				<div class="col-15">
					<label for="TransactionAmtDr">Total Debit</label>
				</div>
				<div class="col-20">

					<input type="text" id="TransactionAmtDr" 
						onkeypress="TransactionAmtDrValidation(event)" readonly>
				</div>
			</div>

		</fieldset>
	
</div>
<div class="containerfooter">
<br>
	<div class="row">

		<div class="col-15">
			<label for="TransactionType">Transaction</label>
		</div>
		<div class="col-20">
			<select id="TransactionType" name="TransactionType"
				onkeypress="TransationTypeValidation(event)" style="width: 172px;">
				<option value="V">V-Voucher</option>
				<option value="A">A-Advice</option>
				<option value="T">T-Transfer</option>
				<option value="B">B-Budget</option>
			</select>
		</div>
		
	
	</div>
	
	
	<div class="row">
		<div class="col-15">
			<label for="Remarks"> Remarks</label>
		</div>
		<div class="colt-20">
			<textarea id="Remarks" name="Remarks" rows="2" cols="80"
				></textarea>
		</div>

	</div>
	<br>
			
</div>

</fieldset>
	<p id='output'></p>
	<div class="col-75"></div>
	<div class="row">
		<input type="submit" id="submit" value="Save Transaction"
			onclick="submitTransaction()">
	</div>

</body>


</html>