<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@page import="java.util.*,java.lang.StringBuffer,
    dbController.DatabaseController5" %>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Check out</title>
    <link rel="stylesheet" type="text/css" href="style.css">

  </head>
  
  <body class="empcheckout">
    <h1>Check Out</h1>
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
    
      dbcontroller.Open();

      // writing the content on output/response page

      out.write("<hr/>");
      out.write("<div class='checkout'>");
      // stringbuffer to hold final content
      StringBuffer content = new StringBuffer();;
     
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


        total=total+Double.parseDouble(detail[2])*Integer.parseInt(detail[3]);
         
        }
      }
  content.append("<form action=\"submit.jsp\" method=\"GET\"> ");

  content.append( "<label>Payment Method</label> <select name=\"payment\"> <option value=\"credit\"> Credit Card</option> <option value=\"debit\"> Debit Card</option> <option value=\"debit\"> Pay money at store</option><option value=\"check\">Paypal</option>  </select><br>");  
  content.append( "<label>Select your pickup date:</label> <input type=\"date\" name=\"date\" required=\"required\"><br><br>");   
  content.append( "<label>You can update your information in 'View account Information'.</label><br>"); 


  content.append("<input type=\"submit\" name=\"submit\" value=\"Submit\"/ > </form>");
      
  out.write(content.toString());
  out.write("</div >");   
  out.write("<hr/>");
  dbcontroller.Close();  
      // close the dbcontroller and relase all resources occupied by it.

  out.write("<h4 >Total Price:"+total+"</h4>");
      out.write("<h4 > Please notice that you must choose the date after today's date, otherwise, even the order has been placed, it will be ignored.</h4>");
  %>
  </div>
  
  <br/>
   
    <div align="center" style="position: absolute; bottom: 5px;">
      <hr/>
   
    </div>
  </body>
</html>
