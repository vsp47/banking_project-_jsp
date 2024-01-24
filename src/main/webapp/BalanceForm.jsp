<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<style>
   h2{
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
<table class="c1">
     <%
        int account_number=Integer.parseInt(request.getParameter("accno"));
        String name=request.getParameter("uname");
        int password=Integer.parseInt(request.getParameter("psw"));
     
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
  	    	out.println("<table border='1px' align='center'>");
  	    	out.println("<tr>");
  	    	out.println("<td>"+" Account Number "+"</td>"+"<td>"+" Name "+"</td>"+"<td>"+" Amount "+"</td>"+"<td>"+" Address "+"</td>");
  	    	out.println("</tr>");
  	    	out.println("<tr>");
  	    	out.println("<td>"+rs.getInt(1)+"</td>"+"<td>"+rs.getString(2)+"</td>"+"<td>"+rs.getString(4)+"</td>"+"<td>"+rs.getString(5));
  	    	out.println("</tr>");
  	    	out.println("</table>");
  	     }
  	     else	    	 
  	    	 out.println("<h2>"+"ENTER VALID DETAILS"+"</h2>");
  	     con.close();
       }
       catch(Exception ex)
       {
    	   out.println("Exception Raised"+ex);
       }
     %>
   </table>
</body>
</html>