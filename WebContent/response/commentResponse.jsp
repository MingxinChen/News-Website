<%@ page language="java" contentType="text/html; charset=utf-8"    pageEncoding="utf-8"%>
<%@ page import="java.sql.*"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.*"%>
<%@page import="java.util.Date"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
</head>
<body>
<%
request.setCharacterEncoding("utf-8");
String words=request.getParameter("words");
Date d=new Date();
String createTime=(new SimpleDateFormat("yyyy-MM-dd")).format(d);
String user=(String)session.getAttribute("username");
if(user==null) user="游客";
/*
还有取User的cookies部分没写！！！！！！！！！
*/

String msg ="";
String connectString = "jdbc:mysql://localhost:3306/test?characterEncoding=utf8&useSSL=true"; 
StringBuilder table=new StringBuilder("");
try{
  Class.forName("com.mysql.jdbc.Driver");
  Connection con=DriverManager.getConnection(connectString, "root", "123456");
  Statement stmt=con.createStatement();
  
  String sql2="insert into comment (aid, type, writer , content, createTime, kudo) values(?,?,?,?,?,?);";
  PreparedStatement ps=con.prepareStatement(sql2);
  ps.setString(1, request.getParameter("aid"));//对sql语句中的第1个参数赋值
  ps.setString(2, request.getParameter("type"));//对sql语句中的第2个参数赋值
  ps.setString(3, user);//对sql语句中的第1个参数赋值
  ps.setString(4, words);//对sql语句中的第2个参数赋值
  ps.setString(5, createTime);//对sql语句中的第3个参数赋值
  ps.setInt(6, 0);//对sql语句中的第4个参数赋值
  int row=ps.executeUpdate();//执行更新操作，返回所影响的行数
  System.out.println(row);
  if(row>0) {
	  response.sendRedirect("../detailPage.jsp?aid="+request.getParameter("aid")+"&type="+request.getParameter("type"));
	  stmt.close();
	  con.close();
  }
}
catch (Exception e){
  System.out.println(e);
  msg = e.getMessage();
}
%>
</body>
</html>