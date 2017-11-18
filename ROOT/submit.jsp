<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@page import="java.util.*,java.lang.StringBuffer,
dbController.DatabaseController5" %>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <title>Check out</title>
  <link rel="stylesheet" type="text/css" href="style.css">

</head>

<body class="submit">
  <button onClick="parent.location='shoppingSite.jsp'">Go Back To Online Store</button>
  <button onClick="parent.location='checkout.jsp'">Check out</button>
  <button onClick="parent.location='cart.jsp'">cart</button>
  <button onClick="parent.location='order.jsp'">View placed order detail</button>
  <button onClick="parent.location='index.jsp'">Logout</button>


  <div class="current_Info">
    <p> Today is:  <script> document.write(new Date().toLocaleDateString()); </script> </p>
  <%
    String current_user=(String)session.getAttribute("username");  
    out.print("Hello, "+ current_user);
  %>
  </div>
  <div id="searchresult" align="center" >
    <%
    request.setCharacterEncoding("utf-8");
    response.setContentType("text/html;charset=utf-8");

    String payment=request.getParameter("payment");
    String date=request.getParameter("date");
    DatabaseController5 dbcontroller = new DatabaseController5();
      // connect to backend database server via the databasecontroller, which
      // is a wrapper class providing necessary methods for this particular
      // application
    dbcontroller.Open();

    out.write("<div class=\"checkout\">");
      // stringbuffer to hold final content
    StringBuffer content = new StringBuffer();;

    int orderNumber=dbcontroller.FindOrderNumber();
    out.write("<h1> Your order number is "+orderNumber+"</h1>");
      // asking dbcontroller to list the employee table
    Vector<String> vecResult = dbcontroller.FindAllCarts(current_user); 
    
    if (vecResult == null) {
    content.append("Query result is null!");
  }     

  double total=0;
  if (vecResult != null && vecResult.size() > 0) {
  for (int i = 0; i < vecResult.size(); i++) {
  String row = vecResult.get(i);
  String[] detail = row.split("##");
  if (detail.length != 4) {
            //break;
          }

          double temp=Double.parseDouble(detail[2])*Integer.parseInt(detail[3]);
          dbcontroller.InsertIntoOrderList(orderNumber,detail[1],current_user,detail[2],detail[3],temp,date);
          int quantity=Integer.parseInt(detail[3]);
          dbcontroller.updateQuantity(detail[1],quantity);

//dbcontroller.InsertIntoOrderList(1,"st", 'yiling', "50", "5",250);

total=total+Double.parseDouble(detail[2])*Integer.parseInt(detail[3]);

}
}
   

out.write("</div >");   
out.write("<h1> You order has been placed</h1>");
out.write("<hr/>");
out.write("<h2>Your order has just been placed through "+payment+" and you could pick up on: "+date+"</h2>");
out.write("<hr/>");

dbcontroller.clearMycart(current_user);
dbcontroller.Close();  
      // close the dbcontroller and relase all resources occupied by it.




%>



</div>

<br/>


<div align="center" style="position: absolute; bottom: 5px;">
  <hr/>

</div>
</body>
</html>
