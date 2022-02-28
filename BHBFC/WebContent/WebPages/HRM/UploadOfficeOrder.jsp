<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Office Management System</title>
    </head>
 <style>
    input[type=submit] {
	background-color: #4CAF50;
	color: white;
	padding: 12px 20px;
	border: none;
	border-radius: 4px;
	cursor: pointer;
	float: center;
	
	
}
input[type=file] {
	background-color: #ccffcc;
	color: black;
	padding: 12px 20px;
	border: none;
	border-radius: 4px;
	cursor: pointer;
	float: center;	
}
    
 input[type=text] {
	background-color: #ccffcc;
	color: black;
	padding: 12px 20px;
	border: none;
	border-radius: 4px;
	cursor: pointer;
	float: center;
	
	
}   
    </style>
  
    <body> 
    <center>
        <div>
        <fieldset>
            <h3> Upload Office order in HRM System </h3>
            
            <h6> PDF file name format::= [OfficeOrderNo].pdf </h6>
            
            <form action="FileUploadHandler" method="post" enctype="multipart/form-data">      
                <label for="file">Open File  </label> 
       			<input type="file" name="file" />
             		<br><br>
            
             <input type="submit" value="upload" />
            </form> 
		</fieldset>        
        </div>
       </center>
    </body>
</html>