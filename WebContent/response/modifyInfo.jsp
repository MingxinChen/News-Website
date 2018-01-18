<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.*, java.util.*,org.apache.commons.io.*"%>
<%@ page import="org.apache.commons.fileupload.*"%>
<%@ page import="org.apache.commons.fileupload.disk.*"%>
<%@ page import="org.apache.commons.fileupload.servlet.*"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
String email = (String)session.getAttribute("email");

String msg ="";
String connectString = "jdbc:mysql://localhost:3306/test?characterEncoding=utf8&useSSL=true"; 
StringBuilder table=new StringBuilder("");
try{
  Class.forName("com.mysql.jdbc.Driver");
  Connection con=DriverManager.getConnection(connectString, "root", "123456");
  
  boolean isMultipart = ServletFileUpload.isMultipartContent(request);//检查表单中是否包含文件
  if (isMultipart) {
	  out.print("filePath: 123123");
	  System.out.println("filePath: 123123");
	  FileItemFactory factory = new DiskFileItemFactory();
	  ServletFileUpload upload = new ServletFileUpload(factory);
	  List items = upload.parseRequest(request);
	  for (int i = 0; i < items.size(); i++) {
		  out.print("123123");
		  FileItem fi = (FileItem) items.get(i);
		  if (fi.isFormField()) {//如果是表单字段
			  if(fi.getFieldName().equals("changename")){
				  String changename = fi.getString("utf-8");
				  PreparedStatement ps1=con.prepareStatement("update user set username= ? where email = ?;");
				  ps1.setString(1, changename);//对sql语句中的第1个参数赋值
				  ps1.setString(2, email);//对sql语句中的第2个参数赋值
				  int row1=ps1.executeUpdate();//执行更新操作，返回所影响的行数
				  System.out.println(row1);
				  
				  session.setAttribute("username", changename);
			  }
			  else if(fi.getFieldName().equals("changepassword")){
				  String changepassword = fi.getString("utf-8");
				  PreparedStatement ps2=con.prepareStatement("update user set password= ? where email = ?;");
				  ps2.setString(1, changepassword);//对sql语句中的第1个参数赋值
				  ps2.setString(2, email);//对sql语句中的第2个参数赋值
				  int row2=ps2.executeUpdate();//执行更新操作，返回所影响的行数
				  System.out.println(row2);
			  }
		  }
		  else {
			  out.print("123");
			  DiskFileItem dfi = (DiskFileItem) fi;
			  if (!dfi.getName().trim().equals("")) {//getName()返回文件名称或空串
				  String fileName=application.getRealPath("/file")+ System.getProperty("file.separator")+ FilenameUtils.getName(dfi.getName());
				  System.out.println("filePath: " + new File(fileName).getAbsolutePath());
				  dfi.write(new File(fileName));
				  
				  String path="./file/"+FilenameUtils.getName(dfi.getName());
				  PreparedStatement ps=con.prepareStatement("update user set header = ? where email = ?;");
				  ps.setString(1, path);//对sql语句中的第1个参数赋值
				  ps.setString(2, email);//对sql语句中的第2个参数赋值
				  int row=ps.executeUpdate();//执行更新操作，返回所影响的行数
				  System.out.println(row);
				  
				  session.setAttribute("header", path);
			  }
		  }
	  } //for
  } //if
  
  //out.print(request.getAttribute("file2"));
  //System.out.println(request.getAttribute("upload_file"));
  response.sendRedirect("../infoPage.jsp");
  con.close();
}
catch (Exception e){
  System.out.println(e);
  msg = e.getMessage();
  out.print(msg);
}
%>
</body>
</html>