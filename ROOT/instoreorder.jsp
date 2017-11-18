<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@page import="java.util.*,java.lang.StringBuffer,
dbController.DatabaseController5" %>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <title>Search Results</title>
  <link rel="stylesheet" type="text/css" href="style.css">
</head>

<body class="instoreorder">
  <form action="./controller.jsp" method="POST">
    <button class="menu" name="action" value="backToIndex">back to previous page</button>
  </form>
  <div id="searchresult" align="center" >
    <%
    request.setCharacterEncoding("utf-8");
    response.setContentType("text/html;charset=utf-8");
    

    DatabaseController5 dbcontroller = new DatabaseController5();
      // connect to backend database server via the databasecontroller, which
      // is a wrapper class providing necessary methods for this particular
      // application
    dbcontroller.Open();
    
      //int exist=dbcontroller.ExistInCart(id);
    


      // writing the content on output/response page
    out.write("<h1 style=\"color: #4CAF50;\">View all in store order</h1>");
    out.write("<hr/>");

      // stringbuffer to hold final content
    StringBuffer content = new StringBuffer();;
    content.append("<table>");
    
      // asking dbcontroller to list the employee table
    Vector<String> vecResult = dbcontroller.FindStoreOrders();   
    if (vecResult == null) {
    content.append("Query result is null!");
  }     
  
  content.append("<tr><th><u>Order Number</u>&nbsp;&nbsp;&nbsp;&nbsp;</th>" + 
    "<th><u>AccountName</u>&nbsp;&nbsp;&nbsp;&nbsp;</th><th><u>Name of Product</u>&nbsp;&nbsp;&nbsp;&nbsp;</th> " + 
    "<th><u>Quantity</u>&nbsp;&nbsp;&nbsp;&nbsp;</th>" +
    "<th><u>Price</u>&nbsp;&nbsp;&nbsp;&nbsp;</th><th><u>Purchase Date</u></th><th><u>Type</u>&nbsp;&nbsp;&nbsp;&nbsp;</th></tr>");
  
    if (vecResult != null && vecResult.size() > 0) {
    for (int i = 0; i < vecResult.size(); i++) {
    String row = vecResult.get(i);
    String[] detail = row.split("##");
    if (detail.length != 8) {
            //break;
          }
          
          content.append(
          "<tr id=\"tablerow_" + i + "\">");
          content.append(
          "<td class=\"postlist\">" +
          detail[0] + "</td>");
          content.append(
          "<td>" + detail[1] + "</td>");
          content.append("<td>" + detail[2] + "</td>" );
          content.append("<td>" + detail[3] + "</td>" );
          content.append("<td>" + detail[4] + "</td>" );
          content.append("<td>" + detail[5] + "</td>" );
          content.append("<td>" + detail[7] + "</td>" );
          
          
          content.append("</tr>");
        }
      }
      out.write(content.toString());
      out.write("</table><hr/>");
      // close the dbcontroller and relase all resources occupied by it.
      dbcontroller.Close();

      
      
      %>



    </div>
    
    <br/>
    
    
    <div align="center" style="position: absolute; bottom: 5px;">
      <hr/>
      
    </div>
  </body>
  </html>
