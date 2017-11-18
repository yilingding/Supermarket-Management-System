<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
	<%@page import="java.util.*,java.lang.StringBuffer,
    dbController.DatabaseControllerZ" %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Employee</title>
		
		<style>
            body {
                background-image:url("background.jpeg"); 
                background-size: cover;
                padding-left: 50px;
            }
			button {
                background-color: #4CAF50;
                border: none;
                width: 180px;
                height: 80px;
                color: white;
                padding: 15px 32px;
                text-align: center;
                text-decoration: none;
                display: inline-block;
                font-size: 16px;
                margin: 4px 2px;
                cursor: pointer;
			}
			
			p {
				font-size: 26px;
				font-family:'Verdana';
                color: #f0f8ff;
			}
		</style>
	</head>
	
	<body>
        <div align="left" style="position: absolute; top 5px;">
        	<br/>
            <p> Today is:  
            <script> document.write(new Date().toLocaleDateString()); </script>
            <button type="button" style="margin-left: 300px; width: 150px;
                height: 50px;" id="logout" onclick="window.location.href='LogOut.jsp'">Log Out</button>
            </p>
    	   <p>Welcome 
    	   <%
  			request.setCharacterEncoding("utf-8");
 	 		response.setContentType("text/html;charset=utf-8");

  			DatabaseControllerZ dbcontroller = new DatabaseControllerZ();
  			// connect to backend database server via the databasecontroller, which
  			// is a wrapper class providing necessary methods for this particular
  			// application
  			dbcontroller.Open();

  			// writing the content on output/response page
  			String username=""+"luye";
  			out.write(username+"!");
  			out.write("<br/>");
  			out.write("Your account type is: ");
  			dbcontroller.setUser(username);
  			String accountType=dbcontroller.getUserType();
  			if(accountType.equals("customer")){
  				out.write("User");
  			}
  			else if(accountType.equals("employee")){
  				out.write("Employee");%>
  			<br/> 
    	    Please select the options you want: </p>
            <br/>
            <button type="button" id="storestock" onclick="window.location.href='StoreStock.jsp'">Store Stock</button>
            <br/>
            <br/>
            <br/>
            <button type="button" id="checkout" onclick="window.location.href='CheckOut.jsp'">Check Out</button>
            <br/>
            <br/>
            <br/>
    		<button type="button" id="onlineorder" onclick="window.location.href='OnlineOrder.jsp'">View Online Order</button>
            <br/>
            <br/>
            <br/>
    
  			<%} 
  			else if(accountType.equals("manager")){
  				out.write("Manager");%>
  			<br/> 
    	   Please select the options you want: </p>
            <br/>
            <button type="button" id="storestock" onclick="window.location.href='StoreStock.jsp'">Store Stock</button>
            <button type="button" style="margin-left:100px;" id="viewsorder" onclick="window.location.href='ViewSOrder.jsp'">View Supply Order</button>
            <br/>
            <br/>
            <br/>
            <button type="button" id="checkout" onclick="window.location.href='CheckOut.jsp'">Check Out</button>
            <button type="button" style="margin-left:100px;" id="placesorder" onclick="window.location.href='PlaceSOrder.jsp'">Place Supply Order</button>
            <br/>
            <br/>
            <br/>
    		<button type="button" id="onlineorder" onclick="window.location.href='OnlineOrder.jsp'">View Online Order</button>
    		<button type="button" style="margin-left:100px;" id="manageuser" onclick="window.location.href='ManageUser.jsp'">Manage User</button>
            <br/>
            <br/>
            <br/>            
  			<%}
  			else {
  				out.write("Unknown type");
  			}
  			
  			// close the dbcontroller and relase all resources occupied by it.
  			dbcontroller.Close();
		   %>
		</div>
	<br/>
    
    <div align="center" style="position: absolute; bottom: 5px;">

	</body>
</html>
