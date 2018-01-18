<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
String[] writers=null;
String msg ="";
String connectString = "jdbc:mysql://localhost:3306/test?characterEncoding=utf8&useSSL=true"; 
StringBuilder table=new StringBuilder("");
try{
	  Class.forName("com.mysql.jdbc.Driver");
	  Connection con=DriverManager.getConnection(connectString, "root", "123456");
	  Statement stmt=con.createStatement();
	  
	  int wcount=0;
	  ResultSet rs1=stmt.executeQuery("SELECT COUNT(writer) as wcount FROM commentary;");
	  if(rs1.next()) wcount=rs1.getInt("wcount");
	  writers=new String[wcount];
	  
	  ResultSet rs2=stmt.executeQuery("SELECT DISTINCT (writer) FROM commentary order by aid desc;");
	  int i=0;
	  while(rs2.next()) {
		  writers[i]=rs2.getString("writer");
		  i++;
	  }
	  rs1.close();
	  rs2.close();
	  stmt.close();
	  con.close();
}
catch (Exception e){
	  System.out.println(e);
	  msg = e.getMessage();
}
%>
<html lang="en-US">
	<head>
    <meta charset="UTF-8">
    <title>撰稿人.Stock.com</title>
	</head>
	<body>
		<h1>专栏作家列表</h1>
		<p>正在完善中……</p>
		<ul>
		<%for(int i=0;i<writers.length;i++){ 
			out.print("<li>"+writers[i]+"</li>");
		} %>
		</ul>
	</body>
</html>