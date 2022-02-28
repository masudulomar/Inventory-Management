<html>
  <head>
    <script src="https://code.getmdl.io/1.3.0/material.min.js"></script>
    <link rel="stylesheet" href="https://code.getmdl.io/1.3.0/material.indigo-pink.min.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">   
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>	
    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<link rel="stylesheet" href="/resources/demos/style.css">
	<link rel="stylesheet" href="https://unpkg.com/ag-grid-community/dist/styles/ag-grid.css">
  	<link rel="stylesheet" href="https://unpkg.com/ag-grid-community/dist/styles/ag-theme-alpine.css">
	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>	
	
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
   
   <script type="text/javascript">
   document.querySelector('#p3').addEventListener('mdl-componentupgraded', function() {
	    this.MaterialProgress.setProgress(33);
	    this.MaterialProgress.setBuffer(87);
	  });
   </script>
  </head>
  <body>
    <!-- Simple header with scrollable tabs. -->
    
	<div class="rectangle" style="align: center">			
			<table>
			
				<tr>
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
          <a href="#scroll-tab-2" class="mdl-layout__tab">Searching</a>
          <a href="#scroll-tab-3" class="mdl-layout__tab">New File</a>
          <a href="#scroll-tab-4" class="mdl-layout__tab">File Documents</a>
          <a href="#scroll-tab-5" class="mdl-layout__tab">File Status</a>
          <a href="#scroll-tab-6" class="mdl-layout__tab">Reporting</a>
          <a href="#scroll-tab-7" class="mdl-layout__tab">Request</a>          
         <a href="#scroll-tab-8" class="mdl-layout__tab">Miscellaneous</a>
          
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
          <div class="page-content">
           <fieldset >
		    <legend> Notice Board</legend>
		    <p></p>
		    </fieldset>
          
          

           <div id="p3" class="mdl-progress mdl-js-progress"></div>

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
        <section class="mdl-layout__tab-panel" id="scroll-tab-3">
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
		    <legend> Detalis Information</legend>	
		      <div class="row">
		         <div class="input-field col s3">
		          <i class="material-icons prefix">account_box</i>
		          <input id="BorrowerName" type="text" class="validate">
		          <label for="BorrowerName">Borrower  Name</label>
		        </div>	
		        
		        <div class="input-field col s3">
		          <i class="material-icons prefix">account_balance</i>
		          <input id="BorrowerName" type="text" class="validate">
		          <label for="BorrowerName">Sanction  Amount</label>
		        </div>
		        
		         <div class="input-field col s3">
		          <i class="material-icons prefix">account_balance</i>
		          <input id="BorrowerName" type="text" class="validate">
		          <label for="BorrowerName">Disburse Amount </label>
		        </div>
		        
		        <script type="text/javascript">
				
		        $(document).ready(function(){
		            $('.datepicker').datepicker();
		          });
		        
		        </script>
		        <div class="input-field col s3">
		          <i class="material-icons prefix">email</i>
		          <input type="text" class="datepicker">
		          <label for="icon_prefix">Open Date  </label>
		        </div>
		      		        
		                
		      </div>
		      
		      <div class="row">
		         
		         <div class="input-field col s3">
		          <i class="material-icons prefix">mode_edit</i>
		          <input id="icon_prefix" type="text" class="validate">
		          <label for="icon_prefix">TIN   </label>
		        </div>
		        	
		        <div class="input-field col s3">
		          <i class="material-icons prefix">mode_edit</i>
		          <input id="icon_prefix" type="text" class="validate">
		          <label for="icon_prefix">Borrower Email  </label>
		        </div>
		      		        
		        <div class="input-field col s3">
		          <i class="material-icons prefix">contact_phone</i>
		          <input id="icon_telephone" type="tel" class="validate" pattern="[0-9]*" data-length="12">
		          <label for="icon_telephone">Borrower Mobile</label>
		        </div>
		        	
		        <div class="input-field col s3">
		          <i class="material-icons prefix">mode_edit</i>
		          <input id="NID" type="text" class="validate">
		          <label for="NID">NID  </label>
		        </div>
		        		        
		      </div>
		      
		      <script type="text/javascript">
		      $(document).ready(function() {
		    	    $('input#input_text, textarea#textarea2').characterCounter();
		    	  });
		      </script>
		      <div class="row">
		         
		         <div class="input-field col s6">
		          <i class="material-icons prefix">mode_edit</i>
		          
		          <textarea id="textarea2" class="materialize-textarea" data-length="120"></textarea>
                  <label for="textarea2">Borrower Address</label>
		          		        
		        </div>
		        	
		        <div class="input-field col s6">
		          <i class="material-icons prefix">mode_edit</i>
		          
		          <textarea id="textarea3" class="materialize-textarea" data-length="120"></textarea>
                  <label for="textarea3">Site Address</label>

		        </div>
		        
		      </div>
		      		      		      
		      </fieldset>
		       
		    </form>
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
		      	
		 <fieldset >
		    <legend> Document Information</legend>	
		     <div class="row">
			         <div class="input-field col s2">
			         	<label>
					        <input type="checkbox" class="filled-in"  />
					        <span>Rehan Dolil</span>
					      </label>
			         </div>		         
			         <div class="input-field col s4">
			          <i class="material-icons prefix">mode_edit</i>		          
			          <textarea id="textarea3" class="materialize-textarea" data-length="120"></textarea>
		                 <label for="textarea3">Description</label>
			        </div>		         
			         <div class="input-field col s5">
				         <div class="file-field input-field">
						      <div class="btn">
						        <span>File</span>
						        <input type="file" multiple>
						      </div>
						      <div class="file-path-wrapper">
						        <input class="file-path validate" type="text" placeholder="Upload one or more files">
						      </div>
					    </div>		         
			        </div>
		       </div>	
				
				<div class="row">
			         <div class="input-field col s2">
			         	<label>
					        <input type="checkbox" class="filled-in"  />
					        <span>Record Dolil</span>
					      </label>
			         </div>		         
			         <div class="input-field col s4">
			          <i class="material-icons prefix">mode_edit</i>		          
			          <textarea id="textarea3" class="materialize-textarea" data-length="120"></textarea>
		                 <label for="textarea3">Description</label>
			        </div>		         
			         <div class="input-field col s5">
				         <div class="file-field input-field">
						      <div class="btn">
						        <span>File</span>
						        <input type="file" multiple>
						      </div>
						      <div class="file-path-wrapper">
						        <input class="file-path validate" type="text" placeholder="Upload one or more files">
						      </div>
					    </div>		         
			        </div>
		       </div>	
		       
		       
		       <div class="row">
			         <div class="input-field col s2">
			         	<label>
					        <input type="checkbox" class="filled-in"  />
					        <span>Mul Dolil</span>
					      </label>
			         </div>		         
			         <div class="input-field col s4">
			          <i class="material-icons prefix">mode_edit</i>		          
			          <textarea id="textarea3" class="materialize-textarea" data-length="120"></textarea>
		                 <label for="textarea3">Description</label>
			        </div>		         
			         <div class="input-field col s5">
				         <div class="file-field input-field">
						      <div class="btn">
						        <span>File</span>
						        <input type="file" multiple>
						      </div>
						      <div class="file-path-wrapper">
						        <input class="file-path validate" type="text" placeholder="Upload one or more files">
						      </div>
					    </div>		         
			        </div>
		       </div>	
		       
		       <div class="row">
			         <div class="input-field col s2">
			         	<label>
					        <input type="checkbox" class="filled-in"  />
					        <span>Rajuk Plan</span>
					      </label>
			         </div>		         
			         <div class="input-field col s4">
			          <i class="material-icons prefix">mode_edit</i>		          
			          <textarea id="textarea3" class="materialize-textarea" data-length="120"></textarea>
		                 <label for="textarea3">Description</label>
			        </div>		         
			         <div class="input-field col s5">
				         <div class="file-field input-field">
						      <div class="btn">
						        <span>File</span>
						        <input type="file" multiple>
						      </div>
						      <div class="file-path-wrapper">
						        <input class="file-path validate" type="text" placeholder="Upload one or more files">
						      </div>
					    </div>		         
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
           <script type="text/javascript">
           
           var columnDefs = [
        	   {headerName: "Office Name", field: "officeCode"},
        	   {headerName: "Loan Case No", field: "LoanCase"},
        	   {headerName: "Borrower Name", field: "BorrowerName"},
        	   {headerName: "Issue Type",  field: "IssueType" ,filter: 'agMultiColumnFilter'},
        	   {headerName: "Description", field: "IssueDetails"},        	   
        	   {headerName: "Status", field: "IssueStatus", filter: 'agMultiColumnFilter'},
        	   {headerName: "Issue Date", field: "IssueDate"}
        	 ];
        	     
        	 // specify the data
        	 var rowData = [
        	   {officeCode: "Jatrabari",LoanCase:"1000452130008", BorrowerName:"Abdul Karim", IssueType: "Withdraw",  IssueDetails: "Orginal Deed withdral for loan purpose",IssueDate:"10/10/2020",IssueStatus:"Pending"},
        	   {officeCode: "Jatrabari",LoanCase:"1000452130002", BorrowerName:"Abdul Rahim", IssueType: "Submitting", IssueDetails: "Orginal Deed Attachment",              IssueDate:"10/10/2020",IssueStatus:"Pending"},       	   
        	   {officeCode: "Jatrabari",LoanCase:"1000452130001", BorrowerName:"Mr Karim", IssueType: "Withdraw",  IssueDetails: "Orginal Deed withdral for loan purpose",   IssueDate:"10/10/2020",IssueStatus:"Sucess"}
        	   ];
        	     
        	 // let the grid know which columns and what data to use
        	 var gridOptions = {
        	   columnDefs: columnDefs ,  
        	   rowSelection: 'multiple',
        	  /* rowData: rowData,*/
        	   defaultColDef: {
        		    minWidth: 150,
        		    resizable: true,
        		    floatingFilter: true,
        		    menuTabs: ['filterMenuTab'],
        		  }
        	 };

        	 // setup the grid after the page has finished loading
        	 document.addEventListener('DOMContentLoaded', function() {
        	     var gridDiv = document.querySelector('#myGrid');
        	     new agGrid.Grid(gridDiv, gridOptions);
        	     gridOptions.api.setRowData(rowData);
        	 });
        	 
        	 function getSelectedRows() {
          	    var selectedNodes = gridOptions.api.getSelectedNodes()
          	    var selectedData = selectedNodes.map( function(node) { return node.data })
          	    var selectedDataStringPresentation = selectedData.map( function(node) { return '\n--------------------------\n'+node.officeCode 
          	    	+ '\n' + node.LoanCase +"\n\n\n\n"+node.IssueDetails+"\n\n\n\n\n\n\n\n                      The End"}).join(', ')
          	    alert('Issue Details: ' + selectedDataStringPresentation);
          	}      
           
           </script>
           <script src="https://unpkg.com/ag-grid-community/dist/ag-grid-community.min.js"></script>
			<script src="https://unpkg.com/@ag-grid-enterprise/all-modules@24.1.0/dist/ag-grid-enterprise.min.js"></script>
			
			      <button onclick="getSelectedRows()" style="align:center">View Details</button>
			
			      <div id="myGrid" style="height: 500px; width:1300px;" class="ag-theme-alpine"></div>

          </div>
        </section>
        <section class="mdl-layout__tab-panel" id="scroll-tab-6">
          <div class="page-content"><!-- Reporting -->
          
          <div class="row">
		    <form class="col s12">
		    <fieldset >
		    <legend> Identifier</legend>
		      <h5>List of all reports</h5>
		     </fieldset>	
		     
		     <fieldset >
		          <legend> Reporting Details</legend>		          
		               <div class="row">
		               <div class="input-field col s3">
		               </div>
								<div class="input-field col s3">
									<select class="browser-default">
										<option value="" disabled selected>Choose your option</option>
										<option value="1">List of Pending Issue</option>
										<option value="2">List of Withdrawal</option>
										<option value="3">List of Submitting Document</option>
										<option value="4">List of Loan case</option>
									</select>
								</div>
						</div>		
							<div class="row">
								<div class="input-field col s3"></div>

								<div class="input-field col s4">
									<button class="btn waves-effect waves-light">
										Download <i class="material-icons right">send</i>
									</button>
								</div>
							</div>
		          		          
		    </fieldset>  
		      			    		    
		    </form>
		    </div>
          
          
          </div>
        </section>
        <section class="mdl-layout__tab-panel" id="scroll-tab-7">
               <!-- Requesting -->
          <div class="page-content">
          
          
          <div class="row">
		    <form class="col s12">
		    <fieldset >
		    <legend> Identifier</legend>
		      
		     </fieldset>	
		     
		     <fieldset >
		          <legend> Request Details</legend>
		          
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
		          
		          
		          		      <script type="text/javascript">
		      $(document).ready(function() {
		    	    $('input#input_text, textarea#textarea2').characterCounter();
		    	  });
		      </script>
		      
							<div class="row">

								<div class="input-field col s3">
									<select class="browser-default">
										<option value="" disabled selected>Activity Types</option>
										<option value="1">Withdrawal</option>
										<option value="2">Submitting</option>
										<option value="3">Viewing</option>
										<option value="4">Photocopy</option>
									</select>
								</div>
								
								<div class="input-field col s3">
									<select class="browser-default">
										<option value="" disabled selected>Document Types</option>
										<option value="1">Rehan Dolil</option>
										<option value="2">Record Dolil</option>
										<option value="3">Rajuk Plan</option>
										<option value="4">Mul Dolil</option>
									</select>
								</div>
								

								<div class="input-field col s6">
									<i class="material-icons prefix">mode_edit</i>

									<textarea id="textarea2" class="materialize-textarea"
										data-length="120"></textarea>
									<label for="textarea2">Issue Description</label>
								</div>
							</div>

							<div class="row">
								<div class="input-field col s4"></div>

								<div class="input-field col s4">
									<button class="btn waves-effect waves-light">
										Upload <i class="material-icons right">send</i>
									</button>
								</div>
							</div>

						</fieldset>  
		      			    		    
		    </form>
		    </div>
                    
			</div>
        </section>
      </main>
    </div>
  </body>
</html>