<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@page import="java.util.*,java.lang.StringBuffer,
    dbController.DatabaseController" %>
<html>
  <head>
  	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Register</title>
    <link rel="stylesheet" type="text/css" href="style.css">
  </head>
  <body class="register">

	<div class="mainContent">
	  	<h1>Register</h1>
	    <form action="./register.jsp" method="POST">
			<label>Username:</label>
			<input type="text" name="username" placeholder="Please Enter Username" required>
			<br>

			<label>Password:</label>
			<input type="password" name="password" placeholder="Please Enter Password" required>

			<br>
	<!-- 		<select name="user_type">
				<option value="customer">Customer</option>
				<option value="employee">Employee</option>
				<option value="manager">Manager</option>
			</select>
			<br> -->
			<button class="menu" name="registerbtn" value="register">register</button>
	    </form>
	    <form action="./controller.jsp" method="POST">
			<button class="menu" name="action" value="back">Back</button>
	    </form>
	</div>
		<%
		request.setCharacterEncoding("utf-8");
 	 	response.setContentType("text/html;charset=utf-8");
		
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String user_type = "customer";

		// out.write(username + "<br>");
		// out.write(password + "<br>");
		// out.write(user_type + "<br>");
		// out.write(request.getParameter("registerbtn"));

		DatabaseController dbcontroller = new DatabaseController();
		dbcontroller.Open();

		//To do: consider if user refresh the page
		if(request.getParameter("registerbtn") != null){
			if((dbcontroller.CheckUser(username))==false){ //can insert this name
				if((dbcontroller.InsertUser(username, password, user_type))==1){
	  				out.write("<div class='info'>You create a account successfully. Go back to log in!</div>");
	  				//to do: probably jump to corresponding shopping page???
	  			}else{
	  				out.write("fail to insert");
	  			}
	  		}else{
	  			out.write("<div class='error'>Account existed, change username or give up.</div>");
	  		}
		}


 		// this is a test to see whether you can insert into table or not
  // 		out.write("<h1 style=\"color: #4CAF50;\">All Employee</h1>");
  // 		out.write("<hr/>");

  // 		// stringbuffer to hold final content
  // 		StringBuffer content = new StringBuffer();
  // 		content.append("<table>");
		
  // 		// asking dbcontroller to list the employee table
  // 		Vector<String> vecResult = dbcontroller.FindAllProducts();   
  // 		if (vecResult == null) {
  //            content.append("Query result is null!");
  //       } 		

		// content.append("<tr><th><u>Barcode</u>&nbsp;&nbsp;&nbsp;&nbsp;</th>" + 
		// "<th><u>Name of Product</u>&nbsp;&nbsp;&nbsp;&nbsp;</th> " + 
		// "<th><u>Price</u>&nbsp;&nbsp;&nbsp;&nbsp;</th>" +
  //  		"<th><u>Quantity</u>&nbsp;&nbsp;&nbsp;&nbsp;</th></tr>");
  
  // 		if (vecResult != null && vecResult.size() > 0) {
  //   		for (int i = 0; i < vecResult.size(); i++) {
  //     			String row = vecResult.get(i);
  //    		 	String[] detail = row.split("##");
  //     			if (detail.length != 4) {
  //       		//break;
  //     			}
     	 	
  //    	 		content.append(
  //         			"<tr id=\"tablerow_" + i + "\">");
  //     			content.append(
  //         			"<td class=\"postlist\">" +
  //         			detail[0] + "</td>");
  //     			content.append(
  //         			"<td>" + detail[1] + "</td>");
  //     			content.append("<td>" + detail[2] + "</td>" +
  //                    "<td> &nbsp;&nbsp;" + detail[3] + "</td>");
  //     			content.append("</tr>");
  //   		}
  // 		}	
  // 		out.write(content.toString());
		// out.write("</table><hr/>");
  		// close the dbcontroller and relase all resources occupied by it.

  		dbcontroller.Close();

		%>
	</div>


  </body>
</html>
