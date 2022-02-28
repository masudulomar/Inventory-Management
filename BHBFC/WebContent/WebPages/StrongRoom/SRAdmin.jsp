<html lang="en">
  <head>
   <script>var __basePath = './';</script>
    <script src="https://unpkg.com/ag-grid-community/dist/ag-grid-community.min.js"></script>
    <script src="https://unpkg.com/ag-grid-community/dist/ag-grid-community.min.js"> </script>
    <script src="https://unpkg.com/@ag-grid-enterprise/all-modules@24.0.0/dist/ag-grid-enterprise.min.js"></script>
    <script src="https://unpkg.com/ag-charts-community@2.0.0/dist/ag-charts-community.min.js"></script>
    <script src="https://code.getmdl.io/1.3.0/material.min.js"></script>
    <link rel="stylesheet" href="https://code.getmdl.io/1.3.0/material.indigo-pink.min.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">   
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>	
    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<link rel="stylesheet" href="/resources/demos/style.css">
	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>	
	<script src="https://unpkg.com/ag-grid-community/dist/ag-grid-community.min.noStyle.js"></script>
    <link rel="stylesheet" href="https://unpkg.com/ag-grid-community/dist/styles/ag-grid.css">
    <link rel="stylesheet" href="https://unpkg.com/ag-grid-community/dist/styles/ag-theme-alpine.css">
    
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/1.12.1/jquery.min.js"></script>
   	<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
   	<script src="https://unpkg.com/@ag-grid-community/all-modules@24.0.0/dist/ag-grid-community.min.js"></script>
   	<script src="https://unpkg.com/@ag-grid-community/all-modules@24.0.0/dist/ag-grid-community.min.js"></script>
   	<script src="authScript.js"></script>    	
	<link rel="stylesheet" href="Authstyle.css">
	
   <style type="text/css">
   .rectangle {  
    background-color: #0000;
	overflow: auto;
	align: center;
	
}
body {
  padding: 20px;
  background: #fafafa;
  position: relative;
}
   fieldset {
  border: #006600 1px solid;
}


   </style>
   		<script src="https://unpkg.com/@ag-grid-enterprise/all-modules@24.1.0/dist/ag-grid-enterprise.min.js"></script>
         <script type="text/javascript">
         
        
         </script>
   <script type="text/javascript">
   document.querySelector('#p3').addEventListener('mdl-componentupgraded', function() {
	    this.MaterialProgress.setProgress(33);
	    this.MaterialProgress.setBuffer(87);
	  });
   </script>
  </head>
  <body onload="DoView()">
    <!-- Simple header with scrollable tabs. -->
    
	<div class="rectangle" style="align: center">			
			<table>
			
				<tr><!-- <td	><img src="../../Media/bhbfc_icon.ico" width="100" height="100"></td>
					<td> <h3 style="color:green; font-family:impact">Bangladesh House Building Finance Corporation</h3> </td>
					<td><td	><img src="../../Media/m.png" width="100" height="100"></td></td> -->
					<td	><img src="../../Media/bhbfc_icon.ico" width="80" height="80"></td>
					<td> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
					<td> <h5 style="color:green; font-family:impact">Bangladesh House Building Finance Corporation</h5> </td>
					<td> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
					<td><img src="../../Media/m.png" width="80" height="80"></td>
				</tr>
			</table>	
			
		</div>
		
    <div class="mdl-layout mdl-js-layout mdl-layout--fixed-header" style=" padding-right: 50px; clolor=:green;">
    
      <header class="mdl-layout__header" style="clolor=:green;">
      
        <div class="mdl-layout__header-row">
          <!-- Title -->
          <span class="mdl-layout-title">Strong Room Management System</span>
        </div>
        <!-- Tabs -->
        <div class="mdl-layout__tab-bar mdl-js-ripple-effect" style=" clolor=:green;">
          <a href="#scroll-tab-1" class="mdl-layout__tab is-active">Home</a>
          <a href="#scroll-tab-2" class="mdl-layout__tab">Searching File</a>
          <a href="#scroll-tab-3" class="mdl-layout__tab">FIle Dash board</a>
          <a href="#scroll-tab-4" class="mdl-layout__tab">Reporting</a>
          <a href="#scroll-tab-5" class="mdl-layout__tab">Authorization</a>         
          <a href="#scroll-tab-6" class="mdl-layout__tab">Miscellaneous</a>
          
        </div>
      </header>
      <div class="mdl-layout__drawer">
        <span class="mdl-layout-title">Profile</span>        
        <p> Branch User</p>
        <p> Branch Details</p>
        <!-- Number badge on icon -->
		<div class="material-icons mdl-badge mdl-badge--overlap" data-badge="10">account_box</div>
			<!-- Icon badge on icon -->
		<div class="material-icons mdl-badge mdl-badge--overlap" data-badge="4">account_box</div>
        
      </div>
      <main class="mdl-layout__content">
        <section class="mdl-layout__tab-panel is-active" id="scroll-tab-1">
          <div class="page-content"><!-- Your content goes here -->


          </div>
        </section>
        <section class="mdl-layout__tab-panel" id="scroll-tab-2">
          <div class="page-content">
			<div class="row">
		    <form class="col s12">
		    <fieldset >
		    <legend> Identifier</legend>
		      <div class="row">

		        <div class="input-field col s3">
		          <i class="material-icons prefix">add_location</i>
		          <input id="LocCode" type="text" class="validate">
		          <label for="LocCode">Location Code  </label>
		        </div>		        		        
		        <div class="input-field col s3">
		          <i class="material-icons prefix">account_circle</i>
		          <input id="AccountNo" type="text" class="validate">
		          <label for="AccountNo">Borrower Account  </label>
		        </div>	
		        
		        <div class="input-field col s3">
		          <i class="material-icons prefix">add_box</i>
		          <input id="Product" type="text" class="validate">
		          <label for="Product">Product  </label>
		        </div>		        		        
		        <div class="input-field col s3">
		          <i class="material-icons prefix">add_box</i>
		          <input id="Type" type="text" class="validate">
		          <label for="Type">Type  </label>
		        </div>	       
		      </div>
		     </fieldset>	
		     
		     <fieldset >
		          <legend> View Details</legend>
		    </fieldset>  
		      			    		    
		    </form>
		    </div>
	
		</div>
        </section>
        <section class="mdl-layout__tab-panel" id="scroll-tab-3" onload="DoView()">
          <div class="page-content">
 		<script type="text/javascript">
 		
 		var gridOptions;
 		var columnDefs;
 		var rowData;
 		function DoView(){ 			
 			 columnDefs = [
 	     	   {headerName: "Office Name", field: "officeCode"},
 	     	   {headerName: "Loan Case No", field: "LoanCase"},
 	     	   {headerName: "Borrower Name", field: "BorrowerName"},
 	     	   {headerName: "Issue Type",  field: "IssueType"},
 	     	   {headerName: "Description", field: "IssueDetails"},        	   
 	     	   {headerName: "Status", field: "IssueStatus"},
 	     	   {headerName: "Issue Date", field: "IssueDate"}
 	     	 ];
 			  rowData = [
 		     	   {officeCode: "Jatrabari",LoanCase:"1000452130008", BorrowerName:"Abdul Karim", IssueType: "Withdraw",  IssueDetails: "Orginal Deed withdral for loan purpose",IssueDate:"10/10/2020",IssueStatus:"Pending"},
 		     	   {officeCode: "Jatrabari",LoanCase:"1000452130002", BorrowerName:"Abdul Rahim", IssueType: "Submitting", IssueDetails: "Orginal Deed Attachment",              IssueDate:"10/10/2020",IssueStatus:"Pending"},       	   
 		     	   {officeCode: "Uttara",LoanCase:"1000452130001", BorrowerName:"Mr Karim", IssueType: "Withdraw",  IssueDetails: "Orginal Deed withdral for loan purpose",IssueDate:"10/10/2020",IssueStatus:"Sucess"},
 		     	   {officeCode: "Feni",LoanCase:"1000452130011", BorrowerName:"Mr Rahim", IssueType: "Withdraw",  IssueDetails: "Orginal Deed withdral for loan purpose",IssueDate:"10/10/2020",IssueStatus:"Sucess"}

 		    ];
 			
 			  gridOptions = {
 			     	   columnDefs: columnDefs , 
 			     	   rowSelection: 'multiple',
 			     	  autoGroupColumnDef: {
 			     		    headerName: 'Branch Group',
 			     		    field: 'officeCode',
 			     		    width: 200 ,    
 			     		   
 			     		  },
 			     	   defaultColDef: {     		   
 			     		    width: 180,
 			     		  }
 			     	 };  
 	     	     var gridDiv = document.querySelector('#myGrid');
 	     	     new agGrid.Grid(gridDiv, gridOptions);
 	     	     gridOptions.api.setRowData(rowData); 	 
 		}
 		     
 		 function getSelectedRows() {
      	    var selectedNodes = gridOptions.api.getSelectedNodes()
      	    var selectedData = selectedNodes.map( function(node) { return node.data })
      	    var selectedDataStringPresentation = selectedData.map( function(node) { return '\n-----------------------------------------\n'+node.officeCode + '\n' + node.LoanCase +"\n\n\n\n"+node.IssueDetails}).join(', ')
      	    alert('Issue Details: ' + selectedDataStringPresentation);
      	}  			
   		function clearData() {
   			var gridOptions={};
   	 		var columnDefs=[];
   			  gridOptions.api.setRowData([]);
   			}
   		

 		</script>
 
         <div class="row">
         <center>
         <button onclick="getSelectedRows()">View Details</button><button onclick="clearData()">Clear Data</button>
         </center>
          <div id="myGrid" style="height: 500px; width:1300px;" class="ag-theme-alpine"></div>          
         </div>  
                             
          </div>
        </section>
        
        <section class="mdl-layout__tab-panel" id="scroll-tab-4">
          <div class="page-content">
           <!-- Document Information -->
           <div class="row">
		    <form class="col s12">
		    <fieldset >
		    <legend> Identifier</legend>
		      <div class="row">

		        <div class="input-field col s3">
		          <i class="material-icons prefix">add_location</i>
		          <input id="LocCode" type="text" class="validate">
		          <label for="LocCode">Location Code  </label>
		        </div>		        		        
		        <div class="input-field col s3">
		          <i class="material-icons prefix">account_circle</i>
		          <input id="AccountNo" type="text" class="validate">
		          <label for="AccountNo">Borrower Account  </label>
		        </div>	
		        
		         <div class="input-field col s3">
		          <i class="material-icons prefix">add_box</i>
		          <input id="Product" type="text" class="validate">
		          <label for="Product">Product  </label>
		        </div>		        		        
		        <div class="input-field col s3">
		          <i class="material-icons prefix">add_box</i>
		          <input id="Type" type="text" class="validate">
		          <label for="Type">Type  </label>
		        </div>	
		                
		      </div>
		      	</fieldset>	    
		      	
		 
		       
		    </form>
		  </div>
           

          
          </div>
        </section>
        
        
        <section class="mdl-layout__tab-panel" id="scroll-tab-5">
          <div class="page-content">
          <!-- Pending Issue -->
          
	          
	             <div class="row">
			    <form class="col s12">
			    <fieldset >
			    <legend> Identifier</legend>
			      <div class="row">
	
			        <div class="input-field col s3">
			          <i class="material-icons prefix">add_location</i>
			          <input id="LocCode" type="text" class="validate">
			          <label for="LocCode">Location Code  </label>
			        </div>		        		        
			        <div class="input-field col s3">
			          <i class="material-icons prefix">account_circle</i>
			          <input id="AccountNo" type="text" class="validate">
			          <label for="AccountNo">Borrower Account  </label>
			        </div>	
			        
			         <div class="input-field col s3">
			          <i class="material-icons prefix">add_box</i>
			          <input id="Product" type="text" class="validate">
			          <label for="Product">Product  </label>
			        </div>		        		        
			        <div class="input-field col s3">
			          <i class="material-icons prefix">add_box</i>
			          <input id="Type" type="text" class="validate">
			          <label for="Type">Type  </label>
			        </div>	
			                
			      </div>
			      	</fieldset>	    

			    </form>
			  </div>
        <script type="text/javascript">
      	 function doAuthView(){
      		 columnDefs = [
   	     	   {headerName: "Office Name", field: "officeCode"},
   	     	   {headerName: "Loan Case No", field: "LoanCase"},
   	     	   {headerName: "Borrower Name", field: "BorrowerName"},
   	     	   {headerName: "Issue Type",  field: "IssueType"},
   	     	   {headerName: "Description", field: "IssueDetails"}        	   
   	     	 ];
      		 rowData = [
             	   {officeCode: "Jatrabari",LoanCase:"1000452130008", BorrowerName:"Abdul Karim", IssueType: "Withdraw",  IssueDetails: "Orginal Deed withdral for loan purpose",IssueDate:"10/10/2020",IssueStatus:"Pending"}      	  
             	   ];
      		 gridOptions = {
                	   columnDefs: columnDefs , 
                	   rowSelection: 'multiple',
                	  autoGroupColumnDef: {
                		    headerName: 'Branch Group',
                		    field: 'officeCode',
                		    width: 250 ,    
                		   
                		  },
                	   defaultColDef: {     		   
                		    width: 250,
                		  }
                	 };
      		
      		var gridDiv = document.querySelector('#myGrid2');
       	     new agGrid.Grid(gridDiv, gridOptions);
       	     gridOptions.api.setRowData(rowData);      	          		
      	 }
      	      	    	
      	function Authoziration(){
      		 var selectedNodes = gridOptions.api.getSelectedNodes()
        	    var selectedData = selectedNodes.map( function(node) { return node.data })
       	    var selectedDataStringPresentation = selectedData.map( function(node) { return '\n'+node.officeCode + '\n' + node.LoanCase +"\n\n\n\n"+node.IssueDetails}).join(', ')
        	    
        	    var r = confirm("\n\n"+selectedDataStringPresentation+"\n Are you sure?");
 				if (r == true) {
 				  txt = "You pressed OK!";
 				} else {
 				  txt = "You pressed Cancel!";
 				}       	           	  
      	}
      	     
          
          </script>
          <div class="row">
		         <center>
		         <button onclick="doAuthView()">Fetch Details</button>
		         </center>
	         </div>
          
			  <div class="row">	
	           <div id="myGrid2" style="height: 150px; width:1300px;" class="ag-theme-alpine"></div>          
	         </div> 
	         
	         <div class="row">
		         <center>
		         <button onclick="getSelectedRows()">View Details</button><button onclick="Authoziration()">Authorization</button>
		         </center>
	         </div>           
		   </div> 
          
          
        </section>
        <section class="mdl-layout__tab-panel" id="scroll-tab-6">
          <div class="page-content"><!-- Reporting -->
          
          <div class="row">
		    <form class="col s12">
		    <fieldset >
		    <legend> Identifier</legend>
		      <div class="row">

		        <div class="input-field col s3">
		          <i class="material-icons prefix">add_location</i>
		          <input id="LocCode" type="text" class="validate">
		          <label for="LocCode">Location Code  </label>
		        </div>		        		        
		        <div class="input-field col s3">
		          <i class="material-icons prefix">account_circle</i>
		          <input id="AccountNo" type="text" class="validate">
		          <label for="AccountNo">Borrower Account  </label>
		        </div>	
		        
		        <div class="input-field col s3">
		          <i class="material-icons prefix">add_box</i>
		          <input id="Product" type="text" class="validate">
		          <label for="Product">Product  </label>
		        </div>		        		        
		        <div class="input-field col s3">
		          <i class="material-icons prefix">add_box</i>
		          <input id="Type" type="text" class="validate">
		          <label for="Type">Type  </label>
		        </div>	       
		      </div>
		     </fieldset>	
		     
		     <fieldset >
		          <legend> Reporting Details</legend>
		    </fieldset>  
		      			    		    
		    </form>
		    </div>
          
          
          </div>
        </section>
        
      </main>
    </div>
  </body>
</html>