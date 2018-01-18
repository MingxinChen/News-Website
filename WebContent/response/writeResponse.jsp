<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
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
String title=request.getParameter("title");
String writer=request.getParameter("writer");
String type=request.getParameter("type");
String contentHTML=request.getParameter("content");
String groupId=request.getParameter("groupId");
Date d=new Date();
String createTime=(new SimpleDateFormat("yyyy-MM-dd")).format(d);
int beginIndex=contentHTML.indexOf("<body");
int endIndex=contentHTML.indexOf("</body>");
String content=contentHTML.substring(beginIndex+7, endIndex);

String msg ="";
String connectString = "jdbc:mysql://localhost:3306/test?characterEncoding=utf8&useSSL=true"; 
StringBuilder table=new StringBuilder("");
try{
  Class.forName("com.mysql.jdbc.Driver");
  Connection con=DriverManager.getConnection(connectString, "root", "123456");
  Statement stmt=con.createStatement();
  String sql1="select max(aid) as maxId from "+type;
  ResultSet rs=stmt.executeQuery(sql1);
  int aid=0;
  if(rs.next()){
	  aid = rs.getInt("maxId") + 1;
  }
  
  System.out.println(title);
  System.out.println(writer);
  System.out.println(content);
  System.out.println(aid);
  System.out.print(createTime);
  
  String sql2="";
  if(type.equals("news")) {
	  sql2="insert into news ( title , writer, content, aid, createTime, groupId) values(?,?,?,?,?,?);";
  }
  if(type.equals("commentary")) {
	  sql2="insert into commentary ( title , writer, content, aid, createTime, themeId) values(?,?,?,?,?,?);";
  }
  PreparedStatement ps=con.prepareStatement(sql2);
  ps.setString(1, title);//对sql语句中的第1个参数赋值
  ps.setString(2, writer);//对sql语句中的第2个参数赋值
  ps.setString(3, content);//对sql语句中的第3个参数赋值
  ps.setInt(4, aid);//对sql语句中的第4个参数赋值
  ps.setString(5, createTime);//对sql语句中的第5个参数赋值
  ps.setString(6, groupId);//对sql语句中的第6个参数赋值
  int row=ps.executeUpdate();//执行更新操作，返回所影响的行数
  System.out.println(row);
  if(row>0) {
	  response.sendRedirect("../writePage.jsp");
	  stmt.close();
	  con.close();
  }
}
catch (Exception e){
  System.out.println(e);
  msg = e.getMessage();
  out.print(msg);
}
%>
</body>
</html>