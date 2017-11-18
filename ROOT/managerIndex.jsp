<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
  <%@page import="java.util.*,java.lang.StringBuffer,
    dbController.DatabaseController" %>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>ManagerIndex</title>
    <link rel="stylesheet" type="text/css" href="style.css">
  </head>
  
  <body class='managerIndex'>
    <h1>Manager Selection</h1>
    <div class="current_Info">
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
        <button class="login" name="action" value="logout">Logout</button>
      </form>

      <form action="./controller.jsp" method="POST">
        <button class="menu" name="action" value="store_stock">Store Stock</button>
        <button class="menu" name="action" value="check_out">Check Out</button>
        <button class="menu" name="action" value="view_online_order">View Online Order</button>
        <button class="menu" name="action" value="view_instore_order">View Instore Order</button>
        <button class="menu" name="action" value="view_supply_order">View Supply Order</button>
        <button class="menu" name="action" value="place_supply_order">Place Supply Order</button>
        <button class="menu" name="action" value="manage_user">Manage User</button>
      </form>
    </div>   
  </body>
</html>
