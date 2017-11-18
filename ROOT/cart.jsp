<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@page import="java.util.*,java.lang.StringBuffer,
    dbController.DatabaseController5" %>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Search Results</title>
    <link rel="stylesheet" type="text/css" href="style.css">
    
  </head>
  
  <body class="cart">
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
      String quantity=request.getParameter("quantity");
      String id=request.getParameter("hidden_id");
      String name=request.getParameter("hidden_name");
      String price=request.getParameter("hidden_price");


      DatabaseController5 dbcontroller = new DatabaseController5();
      // connect to backend database server via the databasecontroller, which
      // is a wrapper class providing necessary methods for this particular
      // application
      dbcontroller.Open();
      String action = request.getParameter("addToCart");
      //int exist=dbcontroller.ExistInCart(id);
      int  qu1=0;
      int  cartStatus =  0;
      int empty=0;
      if(quantity!=null){
      qu1=Integer.parseInt(quantity);
      //out.write("hehehe " + qu1 + " " + name);
      cartStatus =  dbcontroller.checkCart(name,qu1);
      out.write("status is " +cartStatus);
    }else{
      empty=1;
    }

     int getcart=dbcontroller.getCart(name,qu1);
     int st=cartStatus-qu1-getcart;

// out.write("st is " +st);
     
      if(empty==1){
      
      }else if(st<0){
        out.write("<h4> Sorry the quantity you choose is greater than the stock. </h4>");
      }else{
          //out.write("action is " +action);
          if ("Update Cart".equals(action)) {
            dbcontroller.UpdateCart(id,current_user,price,quantity);
            dbcontroller.Commit();
          }else if ("Add to Cart".equals(action)) {
           //int exist=dbcontroller.ExistInCart(id);
            int id1=Integer.parseInt(id);
            out.write(dbcontroller.ExistInCart(id,current_user));
            int exist=dbcontroller.ExistInCart(id,current_user);
            

            if(exist>0){
              dbcontroller.UpdateCart(id,current_user,price,quantity);
              dbcontroller.Commit();
            }else{
              out.write("got here");
              out.write(" test "+id + " "+ name + current_user + price + quantity);
              dbcontroller.InsertIntoCart(id,name,current_user,price,quantity);
            }

          }
      }


      // writing the content on output/response page
      out.write("<h1 style=\"color: #4CAF50;\">Shopping Cart</h1>");
      out.write("<hr/>");

      // stringbuffer to hold final content
      StringBuffer content = new StringBuffer();;
      content.append("<table>");
    
      // asking dbcontroller to list the employee table
      Vector<String> vecResult = dbcontroller.FindAllCarts(current_user); 
      dbcontroller.Close();  
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
            content.append("<td>" + detail[2] + "</td>" );
             content.append("<td>" + detail[3] + "</td>" );

                     content.append("<td> <form action=\"cart.jsp\" method=\"GET\"> <input type=\"text\" name=\"quantity\" value=\"1\" id=\""+detail[0]+"\"/>  <input hidden name=\"hidden_name\" value=\""+detail[0]+"\"/>   <input hidden name=\"hidden_price\" value=\""+detail[2]+"\"/>  <input hidden name=\"hidden_id\" value=\""+detail[0]+"\"/> <input type=\"submit\" name=\"addToCart\" value=\"Update Cart\"/ > </form></td>");
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
