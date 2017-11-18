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
  <h1>Place Supply Order</h1>
	<%
    String current_user=(String)session.getAttribute("username");  
    out.print("Hello, "+ current_user);
  %>
  
  <form action="./controller.jsp" method="POST">
      <!-- <button class="menu" name="action" value="back">Log Out</button> -->
      <button class="menu" name="action" value="backToIndex">back to previous page</button>
  </form>
	<div id="searchresult" align="center" >
		<form action="PlaceSOrder.jsp" id="getQty" method="GET">
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


  		// asking dbcontroller to list the employee table
      Vector<String> vecResult = dbcontroller.FindAllProducts();   

      if (vecResult == null) {
      content.append("Query result is null!");
    } 		

    if (vecResult != null && vecResult.size() > 0) {
    int max=dbcontroller.getNextSupplyOrderNum();
    if(max==-1){
      out.write("error");
    }else{
      for (int i = 0; i < vecResult.size(); i++) {
      String row = vecResult.get(i);
      String[] detail = row.split("##");
        if (detail.length != 5) {
          break;
        }
        int pronum=Integer.parseInt(detail[0]);
        String temp=request.getParameter(""+pronum);
        if (temp!=null){
        int quan=Integer.parseInt(temp);
          if (quan>0){
            dbcontroller.placeSupplyOrder(""+max,""+detail[1],detail[3],""+quan);
                      //out.write(dbcontroller.getQuery());
          }
        }
      }
    }
    }

    vecResult = dbcontroller.FindAllProducts();  

        content.append("<tr><th><u>Barcode</u>&nbsp;&nbsp;&nbsp;&nbsp;</th>" + 
          "<th><u>Name of Product</u>&nbsp;&nbsp;&nbsp;&nbsp;</th> " + 
          "<th><u>Image</u>&nbsp;&nbsp;&nbsp;&nbsp;</th> " + 
          "<th><u>Price</u>&nbsp;&nbsp;&nbsp;&nbsp;</th>" +
          "<th><u>Quantity</u>&nbsp;&nbsp;&nbsp;&nbsp;</th>"+
          "<th><u>No. of Supply Items</u>&nbsp;&nbsp;&nbsp;&nbsp;</th></tr>");

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
        content.append("<td><img src=./images/" + detail[2] + " height=50 width=80></img></td>" +
        "<td> &nbsp;&nbsp;" + detail[3] + "</td>" +
        "<td> &nbsp;&nbsp;" + detail[4] + "</td>");
        content.append("<td>" + "<input name=\""+detail[0]+"\" onkeypress=\"return isNumberKey(event)\" type=\"text\" value=0>"+"</td>");
        content.append("</tr>");
      }
    }
    out.write(content.toString());
    out.write("</table><hr/>");
  		// close the dbcontroller and relase all resources occupied by it.
    dbcontroller.Close();
    %>
    <br/>
    <input type="submit" value="Submit">
  </form>

  <br/>

</div>

</div>
</body>
</html>