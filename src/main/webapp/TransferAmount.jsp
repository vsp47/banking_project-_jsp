<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Transfer Balance</title>
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
    int target_acc=Integer.parseInt(request.getParameter("tar_acc"));
    double amount=Double.parseDouble(request.getParameter("amt"));
    double sen_bal=0.0,tar_bal=0.0;
    int i;
    double amount1=0.0,amount2=0.0;
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
	       {  
	    	 sen_bal=rs.getDouble(4);
	    	 
	       }
	     	 PreparedStatement ps2=con.prepareStatement("select * from sdfc_bank where account_number=? and password=? ");
	         ps2.setInt(1, account_number);
	         ps2.setInt(2, password);
	         ResultSet rs2=ps2.executeQuery();
	         
	         if(rs2.next())
	         {
	        	tar_bal=rs.getDouble(4); 
	         }
	         if(sen_bal>amount)
	         { 
	            amount1=sen_bal-amount;
	          
	           PreparedStatement ps3=con.prepareStatement("update sdfc_bank set amount=? where account_number=? and password=?");
	           ps3.setDouble(1, amount1);
	           ps3.setInt(2, account_number);
	           ps3.setInt(3, password);
	            i=ps3.executeUpdate();
	           
	          
	            amount2=tar_bal+amount;
	           
	           PreparedStatement ps4=con.prepareStatement("update sdfc_bank set amount=? where account_number=? ");
	           ps4.setDouble(1, amount2);
	           ps4.setInt(2,target_acc );
	           i=ps4.executeUpdate();
	         
	           
	         out.println("<table border='2px' align='center'>");
  	         out.println("<tr>");
  	         out.println("<td>"+" Sender account balance "+"</td>"+"<td>"+sen_bal+"</td>");
  	         out.println("</tr>");
  	         out.println("<tr>");
  	         out.println("<td>"+" Transfer Amount "+"</td>"+"<td>"+amount+"</td>");
  	         out.println("</tr>");
  	         out.println("<tr>");
  	         out.println("<td>"+" Traget Account Balnce "+"</td>"+"<td>"+tar_bal+"</td>");
  	         out.println("</tr>");
  	         out.println("<tr>");
	         out.println("<td>"+" After Transfer Target Account Balance "+"</td>"+"<td>"+amount2+"</td>");
	         out.println("</tr>");
	         out.println("<tr>");
  	         out.println("<td>"+" After Transfer Sender Account Balnce "+"</td>"+"<td>"+amount1+"</td>");
  	         out.println("</tr>");
  	         out.println("</table>");
	         }
	         else
	        	 out.println("<h1>"+"INSUFFICINET BALANCE"+"</h1>");
	     }   
	     else 
	     {
	    	 out.println("</h1>"+"ENTER VALID DETAILS"+"</h1>");
	     }	       	      
    }
    catch(Exception ex)
    {
    	out.println("Exception Raised "+ex);
    }
%>
</body>
</html>