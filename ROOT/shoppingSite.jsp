<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@page import="java.util.*,java.lang.StringBuffer,
dbController.DatabaseController5" %>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <title>Search Results</title>
  <link rel="stylesheet" type="text/css" href="style.css">

</head>
<body class="shoppingSite">

  <button onClick="parent.location='shoppingSite.jsp'">Online Store</button>
  <button onClick="parent.location='empcheckout.jsp'">Check out</button>
  <button onClick="parent.location='cart.jsp'">View my cart</button>
  <button onClick="parent.location='order.jsp'">View history order</button>
  <button onClick="parent.location='account.jsp'">My Account Information</button>
  <button onClick="parent.location='index.jsp'">Log out</button>

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

   DatabaseController5 dbcontroller = new DatabaseController5();
  		// connect to backend database server via the databasecontroller, which
  		// is a wrapper class providing necessary methods for this particular
  		// application
   dbcontroller.Open();

  		// writing the content on output/response page
   out.write("<h1 style=\"color: #4CAF50;\">All Products</h1>");
   out.write("<hr/>");

  		// stringbuffer to hold final content
   StringBuffer content = new StringBuffer();;
   content.append("<table>");

  		// asking dbcontroller to list the employee table
   Vector<String> vecResult = dbcontroller.FindAllProducts();   
   if (vecResult == null) {
   content.append("Query result is null!");
 } 		

 content.append("<tr><th><u>Barcode</u>&nbsp;&nbsp;&nbsp;&nbsp;</th>" + 
  "<th><u>Name of Product</u>&nbsp;&nbsp;&nbsp;&nbsp;</th> " + 
  "<th><u>Price</u>&nbsp;&nbsp;&nbsp;&nbsp;</th>" +
  "<th><u>Quantity</u>&nbsp;&nbsp;&nbsp;&nbsp;</th><th><u>Insert the Quantity you want</u></th></tr>");

  if (vecResult != null && vecResult.size() > 0) {
  for (int i = 0; i < vecResult.size(); i++) {
  String row = vecResult.get(i);
  String[] detail = row.split("##");
  if (detail.length != 4) {
        		//break;
         }

         content.append(
         "<tr id=\"tablerow_" + i + "\">");
         content.append(
         "<td class=\"postlist\">" +
         detail[0] + "</td>");
         content.append(
         "<td>" + detail[1] + "</td>");
         content.append("<td>" + detail[2] + "</td>" + "<td> &nbsp;&nbsp;" + detail[3] + "</td>");

         content.append("<td> <form action=\"cart.jsp\" method=\"GET\"> <input type=\"text\" name=\"quantity\" value=\"1\" id=\""+detail[1]+"\"/> <input hidden name=\"hidden_id\" value=\""+detail[0]+"\"/> <input hidden name=\"hidden_name\" value=\""+detail[1]+"\"/>   <input hidden name=\"hidden_price\" value=\""+detail[2]+"\"/>  <input type=\"submit\" name=\"addToCart\" value=\"Add to Cart\"/ > </form></td>");
         content.append("</tr>");
       }
     }
     out.write(content.toString());
     out.write("</table><hr/>");
  		// close the dbcontroller and relase all resources occupied by it.


     dbcontroller.Close();
     %>




     <script type="text/javascript">
     function updateCart(number){
      var quantity=document.getElementById(number).value;
      alert(quantity);

      out.write("hehe");

    }
    </script>
  </div>

  <br/>


  <div align="center" style="position: absolute; bottom: 5px;">
    <hr/>
    
  </div>
</body>
</html>
