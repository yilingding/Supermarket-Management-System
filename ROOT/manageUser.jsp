<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@page import="java.util.*,java.lang.StringBuffer,
dbController.DatabaseController" %>
<html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>User List</title>
	<link rel="stylesheet" type="text/css" href="./style.css">
	</head>
	
	<body class="manageUser">
		<h1>User List</h1>
		<div class="current_Info">
      	<p> Today is:  
	      	<script> document.write(new Date().toLocaleDateString()); </script>
	    </p>
	      <%
	      String name=(String)session.getAttribute("username");  
	      out.print("Hello, " + name);
	      %>
	    </div>
	    <br>
	    <form action="./controller.jsp" method="POST">
			<button class="menu" name="action" value="back">Log Out</button>
			<button class="menu" name="action" value="backToIndex">back to previous page</button>
		</form>

		<div class="addUser">
		<h2>Add User</h2>
		<hr>
		<form action="./manageUser.jsp" method="POST">
			<label>Username: </label>
			<input type="text" name="username" placeholder="Please Enter Username (required)" required>
			<br>

			<label>Password: </label>
			<input type="password" name="password" placeholder="Please Enter Password (required)" required>
			<br>

			<label>First Name: </label>
			<input name="first_name" placeholder="">
			<br>

			<label>Last Name: </label>
			<input name="last_name" placeholder="">
			<br>

			<label>Address: </label>
			<input name="address" placeholder="">
			<br>			
			
			<label>Phone: </label>
			<input type="text" name="phone" placeholder="(###)###-####">
			<br>
			<select name="user_type">
				<option value="customer">Customer</option>
				<option value="employee">Employee</option>
				<option value="manager">Manager</option>
			</select>
			<br>
			<br>
			<!-- <input id="addUBtn" type="submit" name="add" value="Add User"> -->
			<button class="menu" id="add" name="add" value="add">Add User</button>
		</form>
		<br>

		<h2>Update Users' Information</h2>
		<hr>
		<form action="./manageUser.jsp" method="POST">
			Choose a valid id you want to update.
			<br>
			<label></label>
			<input type="text" name="id">
			<br>
			
			<label>Username: </label>
			<input type="text" name="un" placeholder="Please Enter Username" >
			<br>

			<label>Password: </label>
			<input type="password" name="pass" placeholder="Please Enter Password">
			<br>

			<label>First Name: </label>
			<input name="fn" placeholder="">
			<br>

			<label>Last Name: </label>
			<input name="ln" placeholder="">
			<br>

			<label>Address: </label>
			<input name="addr" placeholder="">
			<br>			
			
			<label>Phone: </label>
			<input type="text" name="ph" placeholder="(###)###-####">
			<br>
			<select name="ut">
				<option value="customer">Customer</option>
				<option value="employee">Employee</option>
				<option value="manager">Manager</option>
			</select>
			<br>
			<br>
			<!-- <input id="addUBtn" type="submit" name="add" value="Add User"> -->
			<button class="menu" id="updateBTN" name="updateBTN" value="updateBTN">Update</button>
		</form>
	</div>
	
	<%
	request.setCharacterEncoding("utf-8");
	response.setContentType("text/html;charset=utf-8");

	String username = request.getParameter("username");
	String password = request.getParameter("password");
	String user_type = request.getParameter("user_type");
	String first_name = request.getParameter("first_name");
	String last_name = request.getParameter("last_name");
	String address = request.getParameter("address");
	String phone = request.getParameter("phone");

    String target = request.getParameter("id");
    String pass = request.getParameter("pass");
    String un = request.getParameter("un");
    String fn = request.getParameter("fn");
    String ln = request.getParameter("ln");
    String addr = request.getParameter("addr");
    String ph = request.getParameter("ph");
    String ut = request.getParameter("ut");
	
	DatabaseController dbcontroller = new DatabaseController();
	dbcontroller.Open();

	if(request.getParameter("updateBTN")!=null){	
	if(target==""){
		out.write("<div class='error'>Pleae insert a id.</div>");
	}else if((dbcontroller.IsVaildID1(target))==false){
		out.write("<div class='error'>Please insert a number.</div>");
	}else if((dbcontroller.IsVaildID2(target))!=1){
		out.write("<div class='error'>Your input is not existing, re-enter please.</div>");
	}else{
		int id = Integer.parseInt(target);
		if(request.getParameter("pass")!=""){
      	dbcontroller.UpdateCustomerPW(id,pass);
	    }
		if(request.getParameter("un")!=""){
      	dbcontroller.UpdateCustomerUsername(id,un);
	    }
	  	if(request.getParameter("fn")!=""){
      	dbcontroller.UpdateCustomerFirstName(id,fn);
	    }
	    if(request.getParameter("ln")!=""){
	      dbcontroller.UpdateCustomerLastName(id,ln);
	    }    
	    if(request.getParameter("addr")!=""){
	      dbcontroller.UpdateCustomerAddress(id,addr);
	    }    
	    if(request.getParameter("ph")!=""){
	      dbcontroller.UpdateCustomerPhone(id,ph);
	    }
	    if(request.getParameter("ut")!=""){
	      dbcontroller.UpdateUsertype(id,ut);
	    }

	}	
		
	}

	if(request.getParameter("removeBTN") != null){
		String temp = request.getParameter("hidden_id");
		if((dbcontroller.isManager(temp))==true){
			out.write("You cannot delete user who is manager");
		}else{          	
			if((dbcontroller.RemoveUser(temp))==1){
				//out.write("success");
				//you can add
			}else{
				out.write("remove failed");
			}
		}
	}else{
		//out.write("nothing select");
	}


	if(request.getParameter("add") != null){
		if((dbcontroller.CheckUser(username))==false){ //can insert this name
			if((dbcontroller.AddUser(username, password, user_type, first_name, last_name, address, phone))==1){
				out.write("<div class='info'>Insert a new account successfully</div>");
			}else{
				out.write("fail to insert");
			}
		}else{
			out.write("Account existed, change your information");
		}
	}else{
		//out.write("nothing select");
	}
      //String username = current_user;
      //String password = request.getParameter("password");
	out.write("<h1>All Users</h1>");
	out.write("<hr/>");

	StringBuffer content = new StringBuffer();
	content.append("<table>");

	Vector<String> vecResult = dbcontroller.FindAllProducts();   
	if (vecResult == null) {
		content.append("Query result is null!");
	} 		

	content.append("<tr><th><u>User ID</u>&nbsp;&nbsp;&nbsp;&nbsp;</th>" + 
		"<th><u>User Name</u>&nbsp;&nbsp;&nbsp;&nbsp;</th> " + 
		"<th><u>Password</u>&nbsp;&nbsp;&nbsp;&nbsp;</th>" +
		"<th><u>User Type</u>&nbsp;&nbsp;&nbsp;&nbsp;</th>" +		
		"<th><u>First Name</u>&nbsp;&nbsp;&nbsp;&nbsp;</th>" +		
		"<th><u>Last Name</u>&nbsp;&nbsp;&nbsp;&nbsp;</th>" +		
		"<th><u>Address</u>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>" +		
		"<th><u>Phone</u></th>" +
		"<th><u>Action</u>&nbsp;&nbsp;&nbsp;&nbsp;</th></tr>");

	if (vecResult != null && vecResult.size() > 0) {
		for (int i = 0; i < vecResult.size(); i++) {
			String row = vecResult.get(i);
			String[] detail = row.split("##");
			if (detail.length != 8) {
				out.write("length is wrong");
			}

			content.append("<tr id=\"tablerow_" + i + "\">");
			content.append("<td class=\"postlist\">" + detail[0] + "</td>");
			content.append("<td>" + detail[1] + "</td>");
			content.append("<td>" + detail[2] + "</td>");
			content.append("<td>" + detail[3] + "</td>");
			content.append("<td>" + detail[4] + "</td>");
			content.append("<td>" + detail[5] + "</td>");
			content.append("<td>&nbsp;&nbsp;&nbsp;&nbsp;" + detail[6] + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>");
			content.append("<td>&nbsp;&nbsp;&nbsp;&nbsp;" + detail[7] + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>");

			content.append("<td><form action='./manageUser.jsp' method='post'><input hidden name='hidden_id' value='"+detail[0]+"'><input type='submit' name='removeBTN' value='remove'></td></form></td>");
			content.append("</tr>");
		}
	}	
	out.write(content.toString());
	out.write("</table><hr/>");

	dbcontroller.Close();
	%>
	<footer></footer>

	</body>
</html>
