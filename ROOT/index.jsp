<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@page import="java.util.*,java.lang.StringBuffer,
    dbController.DatabaseController" %>
<html>
  <head>
    <title>Super Market Index</title>
    <link rel="stylesheet" type="text/css" href="style.css">
  </head>
  <body class="index">
  	<!-- This page can be seem as log in page To do : delte login.jsp you have had-->
  	<div class="createNew">
  		<form action="./register.jsp" method="POST">
	    	<input type="submit" value="Go To register a new account!">
	    </form>
  	</div>

	<div class="mainContent">
	  	<h1>Welcome to our Supermart</h1>
	    <form action="./index.jsp" method="POST">
			<label>Username</label>
			<input type="text" name="username" placeholder="Please Enter Username">
			<br>
			<label>Password</label>
			<input type="password" name="password" placeholder="Please Enter Password">
			<br>

			<button class="menu" id="login" name="loginbtn" value="login">Login</button>
			<br>
	    </form>
	</div>

	<div class="result">
	<%
		request.setCharacterEncoding("utf-8");
 	 	response.setContentType("text/html;charset=utf-8");
		
		String username = request.getParameter("username");
		String password = request.getParameter("password");

		// out.write(username + "<br>");
		// out.write(password + "<br>");
		// out.write(request.getParameter("loginbtn"));

		DatabaseController dbcontroller = new DatabaseController();
		dbcontroller.Open();

		//To do: consider if user refresh the page
		String current_username=request.getParameter("username");  
		if(request.getParameter("loginbtn") != null){
			if((dbcontroller.HaveAccount(username, password))==true){
				if(dbcontroller.GetUserType(username) == 0){
					session.setAttribute("usertype","customer");
					session.setAttribute("username",current_username);
					response.sendRedirect("./shoppingSite.jsp");
				}else if(dbcontroller.GetUserType(username) == 1){
					// out.write("go to employee page");
					session.setAttribute("usertype","employee");
					session.setAttribute("username",current_username);  
					response.sendRedirect("./employeeIndex.jsp");
				}else if(dbcontroller.GetUserType(username) == 2){
					// out.write("go to manager page");
					session.setAttribute("usertype","manager"); 
					session.setAttribute("username",current_username);
					response.sendRedirect("./managerIndex.jsp");
				}else if(dbcontroller.GetUserType(username) == 3){
					out.write("cannot reach the usertype");
				}else{
					out.write("Error");
				}		
			}else{
				out.write("<div class='error'>Wrong password or username. Please re-enter or register a new account :)</div>");
			}	
		}
		dbcontroller.Close();
	%>
	</div>
  </body>
</html>
