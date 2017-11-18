<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@page import="java.util.*,java.lang.StringBuffer,
    dbController.DatabaseControllerZ" %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>View Supply Order</title>
    <link rel="stylesheet" type="text/css" href="style.css">

	</head>
	
	<body class="viewSOrder">
	
	<div id="searchresult" align="center" >
	<form method="POST" action="ViewSOrder.jsp">
         <%
  		request.setCharacterEncoding("utf-8");
 	 	response.setContentType("text/html;charset=utf-8");

  		DatabaseControllerZ dbcontroller = new DatabaseControllerZ();
  		// connect to backend database server via the databasecontroller, which
  		// is a wrapper class providing necessary methods for this particular
  		// application
  		dbcontroller.Open();
		
  		// writing the content on output/response page
  		out.write("<h1 style=\"color: #4CAF50;\">View Supply Order</h1>");
  		out.write("<hr/>");
		
  		// stringbuffer to hold final content
  		StringBuffer content = new StringBuffer();
  		
  		content.append("<table>");
		content.append("<tr><th><u>Order Number</u>&nbsp;&nbsp;&nbsp;&nbsp;</th>" + 
		"<th><u>Transaction Date</u>&nbsp;&nbsp;&nbsp;&nbsp;</th> " + 
		"<th><u>Product Name</u>&nbsp;&nbsp;&nbsp;&nbsp;</th>" +
   		"<th><u>User Name</u>&nbsp;&nbsp;&nbsp;&nbsp;</th>"
   		+"<th><u>Quantity</u>&nbsp;&nbsp;&nbsp;&nbsp;</th></tr>");
   		
   		Vector<String> vecResult2 = dbcontroller.getAllXactDate();
   		content.append("<tr><th></th>" + "<th><select name='xact'>");
   		if (vecResult2 != null && vecResult2.size() > 0) {
   			content.append("<option value='none' selected></option>");
    		for (int i = 0; i < vecResult2.size(); i++) {
      			String row = vecResult2.get(i);
      			content.append("<option value=\""+row+"\">"+row+"</option>");
      		}
      	}
      	content.append("</select>");
      	
      	Vector<String> vecResult3 = dbcontroller.getAllProNum();
      	content.append("</th>" + "<th><select name='pronum'>");
   		
   		if (vecResult3 != null && vecResult3.size() > 0) {
   			content.append("<option value='none' selected></option>");
    		for (int i = 0; i < vecResult3.size(); i++) {
      			String row = vecResult3.get(i);
      			content.append("<option value=\""+row+"\">"+row+"</option>");
      		}
      	}
      	content.append("</select>");
      	
      	Vector<String> vecResult4 = dbcontroller.getAllUserId();
      	content.append("</th>" + "<th><select name='userid'>");
   		
   		if (vecResult4 != null && vecResult4.size() > 0) {
   			content.append("<option value='none' selected></option>");
    		for (int i = 0; i < vecResult4.size(); i++) {
      			String row = vecResult4.get(i);
      			content.append("<option value='"+row+"'>"+row+"</option>");
      		}
      	}
   
   		content.append("<select/></th> " + "<th></th></tr>");
   		String temp2;
   		String temp3;
   		String temp4;
   			if (request.getParameter("xact")==null){
   				 temp2="none";
   			}
   			else{
   				temp2=request.getParameter("xact");
   			}
   			if (request.getParameter("pronum")==null){
   				 temp3="none";
   			}else{
   				temp3=request.getParameter("pronum");
   			}
   			if (request.getParameter("userid")==null){
   				 temp4="none";
   			}else{
   				temp4=request.getParameter("userid");
   			}
   			

		Vector<String> vecResult=new Vector<String>();
  		if (temp2.equals("none")&& temp3.equals("none") && temp4.equals("none")){
    		//asking dbcontroller to list the supply order table
  			 vecResult= dbcontroller.getAllSupplyOrder();
    	}
   		else{
  			vecResult = dbcontroller.getSupplyOrderFilter(temp2, temp3, temp4);
  			//out.write(dbcontroller.getQuery());
   		}
  		
  		 if (vecResult != null && vecResult.size() > 0) {
    		for (int i = 0; i < vecResult.size(); i++) {
      			String row = vecResult.get(i);
     		 	String[] detail = row.split("##");
      			if (detail.length != 5) {
        		break;
      			}
     	 	
     	 		content.append(
          			"<tr id=\"tablerow_" + i + "\">");
      			content.append(
          			"<td class=\"postlist\">" +
          			detail[0] + "</td>");
      			content.append(
          			"<td>" + detail[1] + "</td>");
      			content.append("<td> &nbsp;&nbsp&nbsp;&nbsp;"+ detail[2] + "</td>" +
                     "<td> &nbsp;&nbsp;" + detail[3] + "</td>");
            	content.append("<td> &nbsp;&nbsp;" + detail[4] + "</td>");
				content.append("</tr>");
    		}
   		}
  		out.write(content.toString());
		out.write("</table><hr/>");
		
		content.append("</form>");
  		// close the dbcontroller and relase all resources occupied by it.
  		dbcontroller.Close();
	%>
	<input type="submit" value="Submit">
	 </form> 
	</div>
	
	<br/>

  <form action="./controller.jsp" method="POST">
      <!-- <button class="menu" name="action" value="back">Log Out</button> -->
      <button class="menu" name="action" value="backToIndex">back to previous page</button>
  </form>
    
    <div align="center" style="position: absolute; bottom: 5px;">
    	
    </div>
	</body>
</html>