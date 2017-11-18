<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
  <%@page import="java.util.*,java.lang.StringBuffer,
    dbController.DatabaseController" %>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>EmployeeIndex</title>
    <link rel="stylesheet" type="text/css" href="./style.css">
  </head>
  
  <body class="employeeIndex">
    <h1>Employee Selection</h1>
    <div class="information">
      <p> Today is:  
      <script> document.write(new Date().toLocaleDateString()); </script>
      </p>
      <%
      String name=(String)session.getAttribute("username");  
      out.print("Hello, "+name);
      %>
    </div>
    <br>

    <div class="selection">
      
      <form action="./controller.jsp" method="POST">
        <button class="menu" name="action" value="back">Log Out</button>
      </form>

      <form action="./controller.jsp" method="POST">
        <button class="menu" name="action" value="store_stock">Store Stock</button>
        <button class="menu" name="action" value="check_out">Check Out</button>
        <button class="menu" name="action" value="view_online_order">View Onine Order</button>
        <button class="menu" name="action" value="view_instore_order">View Instore Order</button>
      </form>
    </div>   
  </body>
</html>