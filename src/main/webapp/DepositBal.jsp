<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>DepositForm</title>
<style>
   h1{
      border:1px;
      background-color:skyblue;
      border-radius:10px;
      width:50%;
      text-align:center;
      align:justify;
   }
</style>
</head>
<body>
<% 
    	 int account_number=Integer.parseInt(request.getParameter("accno"));
         String name=request.getParameter("uname");
         int password=Integer.parseInt(request.getParameter("psw"));
         double d_amount=Double.parseDouble(request.getParameter("amt"));
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
    	    	 amount=d_amount+rs.getDouble(4);
    	    	 PreparedStatement ps2=con.prepareStatement("update sdfc_bank set amount=? where account_number=?");
    	    	 ps2.setDouble(1, amount);
    	    	 ps2.setInt(2, account_number);
    	
    	    	 int i=ps2.executeUpdate();
    	         
    	         out.println("<table border='2px' align='center'>");
    	         out.println("<tr>");
    	         out.println("<td>"+"Before Deposit acc_bal "+"</td>"+"<td>"+rs.getDouble(4)+"</td>");
    	         out.println("</tr>");
    	         out.println("<tr>");
    	         out.println("<td>"+" Deposit amount "+"</td>"+"<td>"+d_amount+"</td>");
    	         out.println("</tr>");
    	         out.println("<tr>");
    	         out.println("<td>"+" After Deposit amount "+"</td>"+"<td>"+amount+"</td>");
    	         out.println("</table");
    	     }
    	     else
    	    	 out.println("<h1>"+"Enter valid Details"+"</h1>");
         } 
         catch(Exception ex)
         {
        	 out.println(ex);
         }
%>
</body>
</html>