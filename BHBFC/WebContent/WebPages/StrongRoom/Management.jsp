
<html>
  <head>
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
			  
		
    <style media="only screen">
        html, body {
            height: 100%;
            width: 100%;
            margin: 0;
            box-sizing: border-box;
            -webkit-overflow-scrolling: touch;
        }

        html {
            position: absolute;
            top: 0;
            left: 0;
            padding: 0;
            overflow: auto;
        }

        body {
            padding: 1rem;
            overflow: auto;
        }
    </style>
    <script src="https://unpkg.com/ag-charts-community@2.0.0/dist/ag-charts-community.min.js"></script>
    </head>  
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
   
</style>  
 
 <script type="text/javascript">
 
 function InitValues()
 {
	 agCharts.AgChart.create(options);
	 var x="<%= session.getAttribute("BRN_NAME")%>";	 
	 document.getElementById("User").innerHTML=x;
 }
 
 
 </script>
 </head>
 
  <body onload="InitValues()">
    <!-- Simple header with scrollable tabs. -->
    
	<div class="rectangle" style="align: center">			
			<table>
			
				<tr>
					<td	><img src="../../Media/bhbfc_icon.ico" width="100" height="100"></td>
					<td> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
					<td> <h3 style="color:green; font-family:impact">Bangladesh House Building Finance Corporation</h3> </td>
					<td> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
					<td><img src="../../Media/m.png" width="100" height="100"></td>
				</tr>
			</table>	
			
		</div>
		
    <div class="mdl-layout mdl-js-layout mdl-layout--fixed-header" style=" padding-right: 50px; clolor=:green;">
    
      <header class="mdl-layout__header" style="clolor=:green;">
      
        <div class="mdl-layout__header-row">
          <span class="mdl-layout-title">Strong Room Management</span>
        </div>        
        <div class="mdl-layout__tab-bar mdl-js-ripple-effect" style=" clolor=:green;">
          <a href="#scroll-tab-1" class="mdl-layout__tab is-active">Home</a>
          <a href="#scroll-tab-2" class="mdl-layout__tab">Searching File</a>
          <a href="Pichart.jsp" class="mdl-layout__tab">Reporting </a>
          <a href="#scroll-tab-4" class="mdl-layout__tab">Pending Issue</a>          
        </div>
      </header>
      <div class="mdl-layout__drawer">
        <span class="mdl-layout-title">Profile</span>        
        <p id="User"> Branch User</p>
        <p> Branch Details</p>
		<div class="material-icons mdl-badge mdl-badge--overlap" data-badge="10">account_box</div>
		<div class="material-icons mdl-badge mdl-badge--overlap" data-badge="4">account_box</div>        
      </div>
      <main class="mdl-layout__content">
      
        <section class="mdl-layout__tab-panel is-active" id="scroll-tab-1">
             <!-- Expandable Textfield -->			
			 <script src="CommonAgGrid.js"></script>
			 <script src="PichartJs.js"></script>
			 <div id="myChart" ></div>
			 
			    
        </section>
        <section class="mdl-layout__tab-panel" id="scroll-tab-2">
          <div class="page-content">	
          
          
          
           <form action="#">
			  <div class="mdl-textfield mdl-js-textfield mdl-textfield--expandable">
			    <label class="mdl-button mdl-js-button mdl-button--icon" for="sample6">
			      <i class="material-icons">search</i>
			    </label>
			    
			  </div>
			  
			  <div class="mdl-textfield mdl-js-textfield">
				  <input class="mdl-textfield__input" type="text" pattern="[0-9]*" id="phone">
				  <label class="mdl-textfield__label" for="phone">Loan Case</label>
				  <span class="mdl-textfield__error">Digits only</span>
				</div>
			  
			</form>
          			
		
		
  
		
		
		</div>
        </section>
        <section class="mdl-layout__tab-panel" id="scroll-tab-3">
          <div class="page-content">
          <!-- Your content goes here -->
          </div>
        </section>
        
        <section class="mdl-layout__tab-panel" id="scroll-tab-4">
          <div class="page-content">
          <div class="row">
          <div id="myGrid" class="ag-theme-alpine"></div> 
         
         </div>  
                
          </div>
        </section>
                    
        <section class="mdl-layout__tab-panel" id="scroll-tab-6">
          <div class="page-content">
                    
          </div>
        </section>

      </main>
    </div>
  </body>
</html>