
 <%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<body>
<%
   
   int account_number=Integer.parseInt(request.getParameter("accno"));
   String name=request.getParameter("uname");
   int password=Integer.parseInt(request.getParameter("psw"));
   int confirm_password=Integer.parseInt(request.getParameter("con_psw"));
   double amount=Double.parseDouble(request.getParameter("amt"));
   String address=request.getParameter("addr");
   long mobile_number=Long.parseLong(request.getParameter("mno"));
   int i;
   String status="active";
 
   try {
	   
	   Class.forName("oracle.jdbc.driver.OracleDriver");
	   Connection con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","sai","welcome");
	   PreparedStatement ps=con.prepareStatement("insert into sdfc_bank values (?,?,?,?,?,?,?)");
	   
	   ps.setInt(1, account_number);
	   ps.setString(2, name);
	   ps.setInt(3, password);
	   ps.setDouble(4, amount);
	   ps.setString(5, address);
	   ps.setLong(6, mobile_number);
	   ps.setString(7, status);
	   
	    if(password==confirm_password)
	    { 	
	   i=ps.executeUpdate();
	  out.println("<h1>"+" Account opened sucessfully"+"</h1>");
	    }
	    else 
	    	out.println("Invalid Password");
	  con.close();
   }
   catch(Exception ex)
   {
	   out.println("Exception Raised"+ex);
   }
   
%>
</body>
</html>