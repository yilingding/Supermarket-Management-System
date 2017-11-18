<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@page import="java.util.*,java.lang.StringBuffer,
    dbController.DatabaseController" %>
<html>
  <head>
    <title>Checker</title>
  </head>
  <body>
  		<%

		DatabaseController dbcontroller = new DatabaseController();
  		dbcontroller.Open(); 
  		Integer value = new Integer(dbcontroller.InsertUser(request.getParameter("username"), request.getParameter("password"), request.getParameter("user_type")));
  		if (value == null) {
            out.write("Query result is null!");
        } 	
		if (dbcontroller.InsertUser(request.getParameter("username"), request.getParameter("password"), request.getParameter("user_type"))==1){
			out.write("insert Successfully");
		}
		dbcontroller.Close();
		
	    %>
  </body>
</html>
