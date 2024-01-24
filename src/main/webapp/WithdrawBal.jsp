<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
     <% 
     int account_number=Integer.parseInt(request.getParameter("accno"));
     String name=request.getParameter("uname");
     int password=Integer.parseInt(request.getParameter("psw"));
     double w_amount=Double.parseDouble(request.getParameter("amt"));
     double amount;
    try
    {
 	 Class.forName("oracle.jdbc.driver.OracleDriver");
	     Connection con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","sai","welcome");
	     PreparedStatement ps=con.prepareStatement("select * from sdfc_bank where account_number=? and password=?");
	     ps.setInt(1, account_number);
	     ps.setInt(2, password);
	     ResultSet rs=ps.executeQuery();
	  
	   if(rs.next())
	     {
	     	 if(rs.getString(7).equalsIgnoreCase("active"))
	      	   { 
	    	      if(w_amount<rs.getDouble(4))
	    	       {
	    		      amount=rs.getDouble(4)-w_amount;
	    		       PreparedStatement ps2=con.prepareStatement("update sdfc_bank set amount=? where account_number=?");
	    	       	  ps2.setDouble(1, amount);
	    		      ps2.setInt(2, account_number);
	    		      int i=ps2.executeUpdate();
	    	 
	    	          out.println("<table border='1px'>");
	    	          out.println("<tr>");
	    	          out.println("<td>"+" Before Withdraw Account Balance "+"</td>"+"<td>"+" Withdrawl Amount "+"</td>"+"<td>"+" After withdrawl amount  "+"</td>");
	    	          out.println("<tr>");
	    	 
	    	           out.println("<td>"+rs.getDouble(4)+"</td>"+"<td>"+w_amount+"</td>"+"<td>"+amount+"</td>");
	    	            out.println("</tr>");
	    	           out.println("</table>");
	    	         }
	    	       else
	    	          out.println("<h1>"+"INSUFFICIENT BALANCE"+"</h1>");	
	             }
	              else	    	 
	    	        out.println("<h2>"+" YOUR ACCCOUNT IS INACTIVE "+"</h2>");	          
	     }
	       else 
	     	out.println("<h1>"+" ENTER VALID DETAILS "+"</h1>");
	     con.close();
	    
    }
    catch(Exception ex)
    {
 	   out.println("Exception Raised"+ex);
    }
     
     
     %>
</body>
</html>