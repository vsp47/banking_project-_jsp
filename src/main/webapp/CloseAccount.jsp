<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
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
String status="inactive";

try
{
	Class.forName("oracle.jdbc.driver.OracleDriver");
     Connection con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","sai","welcome");
     PreparedStatement ps=con.prepareStatement("select * from sdfc_bank where account_number=? and password=? ");
     ps.setInt(1, account_number);
     ps.setInt(2, password);
     
    
     ResultSet rs=ps.executeQuery();
    
       if(rs.next())
      {	 
    	
    	 PreparedStatement ps2=con.prepareStatement("update sdfc_bank set status=? where account_number=? and password=?");
    	 ps2.setString(1, status);
    	 ps2.setInt(2, account_number);
    	 ps2.setInt(3, password);
    	 int i=ps2.executeUpdate();
    	 
    	 out.println("<h1>"+" Welcome "+name+" your account number "+account_number+" has closed "+"</h1>");
       }
    
}
catch(Exception ex)
{
	out.println("Exception Raised"+ex);
}

%>
</body>
</html>