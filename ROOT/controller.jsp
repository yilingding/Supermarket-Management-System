
<%@page import="java.util.*,java.lang.StringBuffer,
    dbController.DatabaseController" %>
<%
  	request.setCharacterEncoding("utf-8");
 	response.setContentType("text/html;charset=utf-8");

	// if(request.getParameter("action").equals("goToregister")){ //jump to register site
	// 	response.sendRedirect("./register.jsp"); 
	// }else 
	if(request.getParameter("action")!=null){
		if(request.getParameter("action").equals("back")){
			response.sendRedirect("./index.jsp");
		}
		if(request.getParameter("action").equals("backToIndex")){
			String usertype = (String)session.getAttribute("usertype"); 
			if(usertype.equals("employee")){
				response.sendRedirect("./employeeIndex.jsp");
			}
			if(usertype.equals("manager")){
				response.sendRedirect("./managerIndex.jsp");
			}			
		}
		if(request.getParameter("action").equals("logout")){ 
			//end session
			response.sendRedirect("./index.jsp");
		}
		if(request.getParameter("action").equals("store_stock")){
			response.sendRedirect("./StoreStock.jsp");
		}	
		if(request.getParameter("action").equals("check_out")){
			//checkout page
			response.sendRedirect("./mancheckout.jsp");
		}	
		if(request.getParameter("action").equals("view_online_order")){
			response.sendRedirect("./onlineorder.jsp");
		}
		if(request.getParameter("action").equals("view_instore_order")){
			response.sendRedirect("./instoreorder.jsp");
		}	
		if(request.getParameter("action").equals("view_supply_order")){
			response.sendRedirect("./ViewSOrder.jsp");
		}	
		if(request.getParameter("action").equals("place_supply_order")){
			response.sendRedirect("./PlaceSOrder.jsp"); //have problem
		}
		if(request.getParameter("action").equals("manage_user")){
			response.sendRedirect("./manageUser.jsp");
		}	
	}

	
%>








