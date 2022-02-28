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

input[type=text], select, textarea {
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

.gridcontainer {
	background-color: #FAD7A0;
}

.container {
	background-color: #85adad;
	border-radius: 5px;
	padding: 20px;
}

.containerfooter {
	background-color: #85adad
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
<link
	href="//ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/themes/start/jquery-ui.min.css"
	rel="stylesheet">
<script
	src="//ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script
	src="//ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/jquery-ui.min.js"></script>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<script type="text/javascript">


	var DataMap = "";
	function SetValue(key, value, itemsl) {
		if (itemsl == 'L') {
			var Node = '"' + key + '"' + ":" + '"' + value + '"';
		} else {
			var Node = '"' + key + '"' + ":" + '"' + value + '"' + ",";
		}
		DataMap = DataMap + Node;
	}
	function clear() {
		DataMap = "";
	}
	function xmlFinal() {
		DataMap = "{" + DataMap + "}";
	}

	function reload() {
		
		document.getElementById("EmpID").value="";
    	document.getElementById("EmpName").value = "";  
    	document.getElementById("BranchCode").value = ""; 
    	document.getElementById("Designation").value = "";
    	document.getElementById("orderDate").value = "";
    	document.getElementById("OfficeOrderNo").value = "";
    	document.getElementById("EmpID").focus();
		removeAllrow();
	}

	function initValues() {		
		createTable();
		document.getElementById("EmpID").value="";
    	document.getElementById("EmpName").value = "";  
    	document.getElementById("BranchCode").value = ""; 
    	document.getElementById("Designation").value = "";
    	document.getElementById("orderDate").value = "";
    	document.getElementById("OfficeOrderNo").value = "";
		document.getElementById("EmpID").focus();
	}

	var arrHead = new Array();
	arrHead = [ 'Activity', 'PF No & Name','Effective Date', 'Designation', 'Current Basic ',
			'New Basic ' ];

	// first create TABLE structure with the headers. 
	function createTable() {
		var TransferTable = document.createElement('table');
		TransferTable.setAttribute('id', 'TransferTable'); // table id.

		var tr = TransferTable.insertRow(-1);
		for (var h = 0; h < arrHead.length; h++) {
			var th = document.createElement('th'); // create table headers
			th.innerHTML = arrHead[h];
			tr.appendChild(th);
		}

		var div = document.getElementById('gridContainer');
		div.appendChild(TransferTable); // add the TABLE to the container.
	}

	function clearTable() {
		var empTab = document.getElementById('TransferTable');

		for (row = 1; row < empTab.rows.length - 1; row++) {
			empTab.deleteRow(oButton.parentNode.parentNode.row);
		}

		// button -> td -> tr.        
	}

	// delete TABLE row function.

	function removeAllrow() {
		var myTab = document.getElementById('TransferTable');
		for (row = 1; row < myTab.rows.length - 1; row++) {
			myTab.deleteRow(row);
		}
	}

	function removeRow(oButton) {
		
		var myTab = document.getElementById('TransferTable');
		var arrValues = new Array();
		var dataGrid = "";
		var transactionString = new Array();
		var loggedBranch = "<%=session.getAttribute("BranchCode")%>";
    	// loop through each row of the table.
    	for (row = 1; row < myTab.rows.length - 1; row++) {  
    		if  (oButton.parentNode.parentNode.rowIndex==row){
    			for (c = 0; c < myTab.rows[row].cells.length; c++) { 		    		        			
        			var arrValuesv = new Array();
        			var element = myTab.rows.item(row).cells[c];								
        			if (element.childNodes[0].getAttribute('type') == 'text') {    				
        				//arrValues.push("'"+c+":" + element.childNodes[0].value + "'");
        				dataGrid=dataGrid+"id"+c+":"+element.childNodes[0].value;
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
    	 document.getElementById("EmpName").value="";
		 document.getElementById("BranchCode").value = ""; 
		 document.getElementById("EffectiveDate").value = "";			 
	     document.getElementById("Designation").value = "";
	     document.getElementById("CurrentBasic").value = 0; 
	     document.getElementById("NewBasic").value = 0;
	     document.getElementById("EmpID").value = "";
    	 document.getElementById("orderDate").value = "";
    	 document.getElementById("OfficeOrderNo").value = "";
    	 document.getElementById("Remarks").value="";
    	 document.getElementById("EmpID").focus();
    }
  
    
    function EmployeeIdValidation(event){	
    	if (event.keyCode == 13 || event.which == 13) {		
    		var usr_brn = "<%= session.getAttribute("BranchCode")%>";
    		clear();
    		SetValue("UserBranchCode",usr_brn,"N");
    		SetValue("EmployeeId",document.getElementById("EmpID").value,"N");
    		SetValue("Class","AdminOperation","N");
    		SetValue("Method","FetchOrderRelatedData","L");
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
    						 document.getElementById("EmpName").value=obj.EMP_NAME;
    						 document.getElementById("BranchCode").value = obj.BRANCH_NAME; 
    					     document.getElementById("Designation").value = obj.DESIGNATION;
    					     document.getElementById("CurrentBasic").value = obj.NEW_BASIC; 
    					     document.getElementById("NewBasic").value = 0;
    						 document.getElementById("NewBasic").focus();    						 
    					}   						    						
     		    });	
    	}		
    }
   
    function NewBasicValidation(event){	
    	if (event.keyCode == 13 || event.which == 13) {	
    		document.getElementById("EffectiveDate").focus();  
    	}
    }
    
    function EffectiveDateValidation(event){	
    	if (event.keyCode == 13 || event.which == 13) {	
    		AddToList(event);
    	}
    }
    
    function addTransaction() {
        var empTab = document.getElementById('TransferTable');
        var rowCnt = empTab.rows.length;   // table row count.
        var tr = empTab.insertRow(rowCnt); // the table row.
        tr = empTab.insertRow(rowCnt);

        for (var c = 0; c < arrHead.length; c++) {
            var td = document.createElement('td'); // table definition.
            td = tr.insertCell(c);

            if (c == 0) {      // the first column.
                // add a button in every new row in the first column.
                var button = document.createElement('input');
                button.setAttribute('type', 'button');
                button.setAttribute('value', 'Remove');
                button.setAttribute('onclick', 'removeRow(this)');
                td.appendChild(button);
            }
            else {
                // 2nd, 3rd and 4th column, will have textbox.
               
                if (c==1){
                	  var ele = document.createElement('input');
                      ele.setAttribute('type', 'text');
               	      ele.setAttribute('value', document.getElementById("EmpID").value +"#"+document.getElementById("EmpName").value);
               	      ele.setAttribute("readonly", true);
               	      td.appendChild(ele);
               }  
                if(c==2){
                	 var ele = document.createElement('input');
                     ele.setAttribute('type', 'text');
              	      ele.setAttribute('value', document.getElementById("EffectiveDate").value);
              	      ele.setAttribute("readonly", true);
              	      td.appendChild(ele);
                }
                if (c==3){
                	               	
                	 var ele = document.createElement('input');
                     ele.setAttribute('type', 'text');
              	      ele.setAttribute('value', document.getElementById("Designation").value);
              	      ele.setAttribute("readonly", true);
              	      td.appendChild(ele);
                }                                               
                if (c==4){
                	 var ele = document.createElement('input');
                     ele.setAttribute('type', 'text');
                  	 ele.setAttribute('value', document.getElementById("CurrentBasic").value);
                  	 ele.setAttribute("readonly", true);
                  	td.appendChild(ele);
                  } 
                
                
                if (c==5){
                	 var ele = document.createElement('input');
                     ele.setAttribute('type', 'text');
                  	 ele.setAttribute('value', document.getElementById("NewBasic").value);
                  	 ele.setAttribute("readonly", true);
                  	 td.appendChild(ele);
                 }  
            }
        }
    }
    
    
    function AddToList(event){
    	
    	if(document.getElementById("EmpName").value=="" ||document.getElementById("EffectiveDate").value==""||document.getElementById("Designation").value=="" 
			 ||document.getElementById("CurrentBasic").value==""
				 ||document.getElementById("NewBasic").value==""){
			alert("Please Fill up all the information !!");
		}
	 	else
	 		{
	 		 addTransaction();
	 		 document.getElementById("EmpName").value="";
			 document.getElementById("BranchCode").value = ""; 
			 document.getElementById("EffectiveDate").value = "";			 
		     document.getElementById("Designation").value = "";
		     document.getElementById("CurrentBasic").value = 0; 
		     document.getElementById("NewBasic").value = 0;
		     document.getElementById("EmpID").value = "";
	 		 document.getElementById("EmpID").focus();       		
	 	}   
    	
    	
    }

    function submitTransaction() {
    	
      var c = confirm("Are you sure ?");
   	  if (c == true) {		  
   		 if (document.getElementById("OfficeOrderNo").value==""|| document.getElementById("orderDate").value==""){
   			 alert("Office Order and Order Date Cannot be blank!!")
   			 document.getElementById("OfficeOrderNo").focus();
   		 }else
   			 {

   		  		var myTab = document.getElementById('TransferTable');
   		      	var arrValues = new Array();
   		      	var arrValuesv = new Array();
   		      	var dataGrid="";
   		      	var dataclause="";
   		      	var transactionString=new Array();
   		      	var loggedBranch= "<%=session.getAttribute("BranchCode")%>";
   		      	// loop through each row of the table.
   		      	for (row = 1; row < myTab.rows.length - 1; row++) {
   		      		// loop through each cell in a row.			
   		      		dataclause="";
   		      		
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
   		      	
   		      	clear();        	          	      	         
   		      	SetValue("OfficeOrderNo", document.getElementById("OfficeOrderNo").value,"N");
   		      	SetValue("orderDate", document.getElementById("orderDate").value,"N");
   		      	SetValue("Remarks", document.getElementById("Remarks").value,"N");
   		      	SetValue("User_Id", User_Id,"N");
   		      	SetValue("gridData", dataGrid,"N");  
   		      	SetValue("loggedBranch", loggedBranch,"N");
   		      	SetValue("Class", "AdminOperation","N");
   				SetValue("Method", "SalaryIncrementPosting","L");	
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
   						 reload();
   					}		
   				  });				 
   		}		 
   	  }    	    	  	    	
    }
    
    $(function() {
    	$("#orderDate").datepicker({
    		dateFormat : 'dd-M-yy'
    	});
    });
    
    $(function() {
    	$("#EffectiveDate").datepicker({
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
					<label for="EmpID">PF No </label>
				</div>

				<div class="col-20">
					<input type="text" id="EmpID" onkeypress="EmployeeIdValidation(event)">
				</div>

				<div class="col-15">
					<label for="EmpName"> Name</label>
				</div>
				<div class="col-20">
					<input type="text" id="EmpName" name="EmpName" readonly>
				</div>
			</div>


			<div class="row">
				<div class="col-15">
					<label for="BranchCode">Current Branch</label>
				</div>

				<div class="col-20">
					<input type="text" id="BranchCode" name="BranchCode" readonly>
				</div>

				<div class="col-15">
					<label for="Designation">Designation </label>
				</div>

				<div class="col-20">
					<input type="text" id="Designation" name="Designation" readonly>
				</div>
			</div>
			<div class="row">
				<div class="col-15">
					<label for="CurrentBasic">Current Basic</label>
				</div>

				<div class="col-20">
					<input type="text" id="CurrentBasic" name="CurrentBasic" readonly>
				</div>
				
				
				<div class="col-15">
					<label for="NewBasic">New Basic</label>
				</div>


				<div class="col-20">
					<input type="text" id="NewBasic" name="NewBasic" onkeypress="NewBasicValidation(event)">
				</div>
				

			</div>	
			
			
			<div class="row">
				<div class="col-15">
					<label for="EffectiveDate">Effective Date</label>
				</div>

				<div class="col-20">
					<input type="text" id="EffectiveDate" name="EffectiveDate" onkeypress="EffectiveDateValidation(event)">
				</div>
				
				
			</div>	
			

			<div class="row">
				<div class="col-75"></div>
				<div class="row">
					<input type="submit" id="submit" value="Add to List"
						onclick="AddToList()">
				</div>
			</div>

		</div>

		<div class="gridcontainer">

			<fieldset>
				<legend>List</legend>
				<div id="gridContainer"></div>
			</fieldset>

		</div>

		<div class="containerfooter">
			<br>

			<div class="row">
				<div class="col-15">
					<label for="orderDate">Order Date</label>
				</div>
				<div class="col-20">
					<input type="text" id="orderDate" value=""
						onkeypress="OrderDateValidation(event)">
				</div>

				<div class="col-15">
					<label for="OfficeOrderNo"> Office Order No</label>
				</div>
				<div class="col-20">
					<input type="text" id="OfficeOrderNo" name="OfficeOrderNo" onkeypress="OrderNoValidation(event)"></input>
				</div>

			</div>
			<div class="row">
			
			    
					<div class="col-15">
						<label for="Remarks"> Remarks</label>
					</div>
					<div class="col-20">
						<textarea id="Remarks" name="Remarks" rows="2" cols="45"
							></textarea>
					</div>
			
				</div>
			<br>

		</div>

	</fieldset>
	<p id='output'></p>
	<div class="col-75"></div>
	<div class="row">
		<input type="submit" id="submit" value="Save The Order"
			onclick="submitTransaction()">
	</div>

</body>


</html>