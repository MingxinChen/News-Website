<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*,java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
String[] ids=request.getParameterValues("deleteId");
if(request.getParameter("type").equals("commentary")){
	String msg ="";
	String connectString = "jdbc:mysql://localhost:3306/test?characterEncoding=utf8&useSSL=true"; 
	StringBuilder table=new StringBuilder("");
	try{
		  Class.forName("com.mysql.jdbc.Driver");
		  Connection con=DriverManager.getConnection(connectString, "root", "123456");
		  Statement stmt=con.createStatement();
		  for(String id : ids){
			  int row=stmt.executeUpdate("delete from commentary where aid = " + id + ";");
		  }
		  stmt.close();
		  con.close();
		}
		catch (Exception e){
		  System.out.println(e);
		  msg = e.getMessage();
		}
	response.sendRedirect("../managePageForCommentary.jsp");
}
else if(request.getParameter("type").equals("news")){
	String msg ="";
	String connectString = "jdbc:mysql://localhost:3306/test?characterEncoding=utf8&useSSL=true"; 
	StringBuilder table=new StringBuilder("");
	try{
		  Class.forName("com.mysql.jdbc.Driver");
		  Connection con=DriverManager.getConnection(connectString, "root", "123456");
		  Statement stmt=con.createStatement();
		  for(String id : ids){
			  int row=stmt.executeUpdate("delete from news where aid = " + id + ";");
		  }
		  stmt.close();
		  con.close();
		}
		catch (Exception e){
		  System.out.println(e);
		  msg = e.getMessage();
		}
	response.sendRedirect("../managePageForNews.jsp");
}
%>
</body>
</html>