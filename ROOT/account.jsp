<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@page import="java.util.*,java.lang.StringBuffer,
    dbController.DatabaseController5, dbController.DatabaseController" %>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Account Information</title>
    <link rel="stylesheet" type="text/css" href="style.css">
    
  </head>
  
  <body class="accInfo">
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
     
      //int exist=dbcontroller.ExistInCart(id);


      out.write("<form action='./account.jsp' method='POST'>");
      out.write("<h1 style=\"color: #4CAF50;\">Change Password</h1>");
      out.write( "<label>New password:</label> <input type='password' name='newPW'><br>"); 
      out.write( "<label>Re-enter password:</label> <input type='password' name='passwordchecker'><br>"); 


      out.write("<h1 style=\"color: #4CAF50;\">Update my account Information</h1>");
      out.write( "<label>First Name:</label> <input name='fn'><br>"); 
      out.write( "<label>Last Name:</label> <input name='ln'><br>"); 
      out.write( "<label>Address:</label> <input name='address'><br>"); 
      out.write( "<label>Phone:</label> <input name='phone'><br>"); 
      out.write("<br><button class='menu' id='updateAcc' name='updateAcc' value='updateAcc'>Update Account</button></form>");
      String username = current_user;
      String newPW = request.getParameter("newPW");
      String passwordchecker = request.getParameter("passwordchecker");
      String fn = request.getParameter("fn");
      String ln = request.getParameter("ln");
      String addr = request.getParameter("address");
      String phoneNum = request.getParameter("phone");

  if(request.getParameter("updateAcc") != null){
    if(newPW!="" && passwordchecker!=""){
      if(newPW.equals(passwordchecker)==true){
        dbcontroller.UpdateCustomerPass(username,newPW);
        out.write("<div class='error'>Change password successfully.</div>");
      }else{
        out.write("<div class='error'>Your passwords are not matched.</div>");
      }
    }else{
        out.write("<div class='error'>You insert wrong password at the second time.</div>");
    }

    if(fn!=""){
      dbcontroller.UpdateCustomerFirstName(username,fn);
    }
    if(ln!=""){
      dbcontroller.UpdateCustomerLastName(username,ln);
    }    
    if(addr!=""){
      dbcontroller.UpdateCustomerAddress(username,addr);
    }    
    if(phoneNum!=""){
      dbcontroller.UpdateCustomerPhone(username,phoneNum);
    }

  }

    //out.write("nothing select");
      // writing the content on output/response page
      out.write("<h1 style=\"color: #4CAF50;\">My account</h1>");
      out.write("<hr/>");

      // stringbuffer to hold final content
      StringBuffer content = new StringBuffer();;
      content.append("<table>");
    
      // asking dbcontroller to list the employee table
      Vector<String> vecResult = dbcontroller.Findaccount(current_user); 
      dbcontroller.Close();  
      if (vecResult == null) {
             content.append("Query result is null!");
        }     
 
      content.append("<tr><th><u>ID</u>&nbsp;&nbsp;&nbsp;&nbsp;</th>" + 
          "<th><u>Account Name</u>&nbsp;&nbsp;&nbsp;&nbsp;</th> " + 
           "<th><u>Password</u>&nbsp;&nbsp;&nbsp;&nbsp;</th>" +
          "<th><u>First Name</u>&nbsp;&nbsp;&nbsp;&nbsp;</th>" +
         "<th><u>Last Name</u>&nbsp;&nbsp;&nbsp;&nbsp;</th><th><u>Address</u>&nbsp;&nbsp;&nbsp;&nbsp;</th><th><u>Phone number</u>&nbsp;&nbsp;&nbsp;&nbsp;</th></tr>");
      if (vecResult != null && vecResult.size() > 0) {
        for (int i = 0; i < vecResult.size(); i++) {
            String row = vecResult.get(i);
          String[] detail = row.split("##");
            if (detail.length != 7) {
            //break;
            }
        
          content.append("<tr id=\"tablerow_" + i + "\">");
          content.append("<td class=\"postlist\">" + detail[0] + "</td>");
          content.append("<td>" + detail[1] + "</td>");
          content.append("<td>" + detail[2] + "</td>" );
          content.append("<td>" + detail[3] + "</td>" );
          content.append("<td>" + detail[4] + "</td>" );
          content.append("<td>" + detail[5] + "</td>" );
          content.append("<td>" + detail[6] + "</td>" );
            
 
          content.append("</tr>");
        }
      }
      out.write(content.toString());
    out.write("</table><hr/>");
      // close the dbcontroller and relase all resources occupied by it.


    
      
  %>



  </div>
  
  <br/>
   
    
    <div align="center" style="position: absolute; bottom: 5px;">
      <hr/>
    
    </div>
  </body>
</html>
