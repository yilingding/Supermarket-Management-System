<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@page import="java.util.*,java.lang.StringBuffer,
dbController.DatabaseControllerZ" %>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <title>Place Supply Order</title>
  <link rel="stylesheet" type="text/css" href="style.css">
</head>

<body class="placeSOrder">
  <h1>Place Instore Order</h1>
	<%
    String current_user=(String)session.getAttribute("username");  
    out.print("Hello, "+ current_user);
  %>
<!--  
  <form action="./controller.jsp" method="POST">
       <button class="menu" name="action" value="back">Log Out</button> 
      <button class="menu" name="action" value="backToIndex">back to previous page</button>
  </form>
-->
	<div id="searchresult" align="center" >
		<form action="instoreconfirm.jsp" id="getQty" method="GET">
      <%
      request.setCharacterEncoding("utf-8");
      response.setContentType("text/html;charset=utf-8");

      DatabaseControllerZ dbcontroller = new DatabaseControllerZ();
  		// connect to backend database server via the databasecontroller, which
  		// is a wrapper class providing necessary methods for this particular
  		// application
      dbcontroller.Open();

      String username=current_user;
      dbcontroller.setUser(username);
  		// writing the content on output/response page

      out.write("<hr/>");

  		// stringbuffer to hold final content
      StringBuffer content = new StringBuffer();
      content.append("<table>");
	  double total=0;
	  String info="";

    	Vector<String> vecResult = dbcontroller.FindAllCarts();  
    	
    	if (vecResult == null) {
      		content.append("Query result is null!");
		} 

        content.append("<tr><th><u>Barcode</u>&nbsp;&nbsp;&nbsp;&nbsp;</th>" + 
          "<th><u>Name of Product</u>&nbsp;&nbsp;&nbsp;&nbsp;</th> " + 
          "<th><u>Price</u>&nbsp;&nbsp;&nbsp;&nbsp;</th>" +
          "<th><u>Quantity</u>&nbsp;&nbsp;&nbsp;&nbsp;</th></tr>");
		String action = request.getParameter("checkout");
		if ("Confirm".equals(action)) {
		out.write("check out");
			if (vecResult != null && vecResult.size() > 0) {
    			int max=dbcontroller.getNextSupplyOrderNum();
    			if(max==-1){
      				out.write("error");
    			}else{
      				for (int i = 0; i < vecResult.size(); i++) {
      					String row = vecResult.get(i);
      					String[] detail = row.split("##");
        				if (detail.length != 4) {
          					break;
        				}
          				total+=(Double.parseDouble(detail[3]))*Double.parseDouble(detail[3]);
            			dbcontroller.placeInstoreOrder(""+max, detail[1], detail[2], detail[3]);
            			//out.write(dbcontroller.getQuery());
            			info="Thank you for shopping with us! Order number is "+max;
        				}
      			}
    		}
		}
		else{
		  out.write("here");
          if (vecResult != null && vecResult.size() > 0) {
          	for (int i = 0; i < vecResult.size(); i++) {
          		String row = vecResult.get(i);
          		String[] detail = row.split("##");
          		if (detail.length != 4) {
         			break;
       	 		}
			
        	content.append(
        	"<tr id=\"tablerow_" + i + "\">");
        	content.append(
        	"<td class=\"postlist\">" +
        	detail[0] + "</td>");
        	content.append(
        	"<td>" + detail[1] + "</td>");
        	content.append(
        	"<td> &nbsp;&nbsp;" + detail[2] + "</td>" +
        	"<td> &nbsp;&nbsp;" + detail[3] + "</td>");
        	content.append("</tr>");
        	total+=(Double.parseDouble(detail[3]))*(Double.parseDouble(detail[2]));
      		}
    	  }
    	out.write(content.toString());
    	out.write("</table><hr/>");
    }
  		// close the dbcontroller and relase all resources occupied by it.
    dbcontroller.Close();
    out.write("<h4 >Total Price:"+total+"</h4>");
    out.write("<h4 >"+info+"</h4>");
    %>
    <br/>
    <input type="submit" value="Confirm" name="checkout">
  </form>

<form action="mancheckout.jsp" method="GET">
	<input type="submit" name="back" value="back" >
</form>

  <br/>

</div>

</div>
</body>
</html>