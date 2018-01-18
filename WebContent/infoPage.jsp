<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
String role=(String)session.getAttribute("role");
String email=(String)session.getAttribute("email");
String name=(String)session.getAttribute("username");
String resume="haven't give anything";
String returnMessage="";
String headURL=(String)session.getAttribute("header");
String password="";

String msg ="";
String connectString = "jdbc:mysql://localhost:3306/test?characterEncoding=utf8&useSSL=true"; 
StringBuilder table=new StringBuilder("");
try{
  Class.forName("com.mysql.jdbc.Driver");
  Connection con=DriverManager.getConnection(connectString, "root", "123456");
  Statement stmt=con.createStatement();
  PreparedStatement ps1=con.prepareStatement("select * from user where email = ?;");
  ps1.setString(1, email);//对sql语句中的第1个参数赋值
  ResultSet res=ps1.executeQuery();//执行更新操作，返回所影响的行数
  if(res.next()) {
	  name=res.getString("username");
	  headURL=res.getString("header");
	  password=res.getString("password");
  }
  stmt.close();
  con.close();
}
catch (Exception e){
  msg = e.getMessage();
}
%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>个人信息.Stock.com</title>
        <link rel="stylesheet" type="text/css" href="css/main_header.css"/>
        <link rel="stylesheet" type="text/css" href="css/infoPage.css"/>
        <link rel="stylesheet" type="text/css" href="css/style.css"/> 
        <link rel="stylesheet" type="text/css" href="css/log_reg_window.css"/>
        <script type="text/javascript" src="js/jquery.js"></script> 
        <script type="text/javascript" src="js/cropbox.js"></script>
           
    </head>
    
    <body onload="begin()">
    	     <% if(role==null||"".equals(role)){%>
    		<jsp:include page="header/Header.jsp"/>
    		<%} %>
    		<% if(role!=null&&"editor".equals(role)) {%>	
    			<jsp:include page="header/HeaderForEditor.jsp"/>
    		<%} %>
    		<% if(role!=null&&"user".equals(role)) {%>	
    			<jsp:include page="header/HeaderForUser.jsp"/>
    		<%} %>
        
        <!--        正文部分-->
        <div class="desk">
        <form name="fileupload" action="response/modifyInfo.jsp" method="post" enctype="multipart/form-data">
            <div class="headPic">
                <div class="container">
                    <div class="imageBox">
                      <div class="thumbBox"></div>
                      <div class="spinner" style="display: none">Loading...</div>
                    </div>
                    <div class="action"> 
                      <div class="new-contentarea tc"> 
                        <a href="" class="upload-img"><label for="upload-file">上传图像</label></a>
                        <input type="file" class="" name="upload-file" id="upload-file"/>
                        <!-- <input type="file" class="" name="upload-file" id="upload-file"/> -->
                      </div>
                      <input type="button" id="btnCrop"  class="Btnsty_peyton" value="裁切">
                      <input type="button" id="btnZoomIn" class="Btnsty_peyton" value="+"  >
                      <input type="button" id="btnZoomOut" class="Btnsty_peyton" value="-" >
                      
                    </div>
                    <div class="cropped">
                    	<img src=<%= headURL %> align="absmiddle" style="width:64px;height:64px;margin-top:4px;border-radius:100%;box-shadow:0px 0px 12px #7E7E7E;">
                    	<p>64px*64px</p>
                    	<img src=<%= headURL %> align="absmiddle" style="width:128px;height:128px;margin-top:4px;border-radius:100%;box-shadow:0px 0px 12px #7E7E7E;">
                    	<p>128px*128px</p>
                    	<img src=<%= headURL %> align="absmiddle" style="width:180px;height:180px;margin-top:4px;border-radius:100%;box-shadow:0px 0px 12px #7E7E7E;">
                    	<p>180px*180px</p>
                    </div>
                </div>
            </div>
            
	        <div class="information">
		    	<div id="errorAlert"><%= returnMessage %></div>
		        <label>昵称</label><input type="text" name="changename" id="name" value=<%= name %>><br/>
		        <label>权限</label><input type="text" name="changerole" id="role" value=<%= role %> disabled="true"><br/>
		        <label>邮箱</label><input type="email" name="changeemail" id="email" value=<%= email %> disabled="true"><br/>
		        <label>密码</label><input type="password" name="changepassword" id="password" value=<%= password %>><br/>
		        <label>简介</label><textarea type="text" name="changeresume" id="resume"><%= resume %></textarea><br/>
	            <div class="save-button"><input type="submit" name="submit1" value="保存修改"/></div>
	            <div class="cancel-button"><input type="button" onclick="self.location='infoPage.jsp';" name="submit2" value="取消修改"/></div>
	    	</div>
        </form>
        </div>
        <script type="text/javascript">
            $(window).load(function() {
                var options =
                {
                    thumbBox: '.thumbBox',
                    spinner: '.spinner',
                    imgSrc: 'picture/head.jpg'
                }
                var cropper = $('.imageBox').cropbox(options);
                $('#upload-file').on('change', function(){
                    var reader = new FileReader();
                    console.log("change");
                    reader.onload = function(e) {
                        options.imgSrc = e.target.result;
                        cropper = $('.imageBox').cropbox(options);
                    }
                    reader.readAsDataURL(this.files[0]);
                    console.log(this.files[0].name);
                    //document.getElementById('header').value=document.getElementById('upload-file').value;
                    //console.log(document.getElementById('header').value);
                    //this.files = [];
                    console.log("change1");
                })
                $('#btnCrop').on('click', function(){
                    var img = cropper.getDataURL();
                    $('.cropped').html('');
                    $('.cropped').append('<img src="'+img+'" align="absmiddle" style="width:64px;margin-top:4px;border-radius:64px;box-shadow:0px 0px 12px #7E7E7E;" ><p>64px*64px</p>');
                    $('.cropped').append('<img src="'+img+'" align="absmiddle" style="width:128px;margin-top:4px;border-radius:128px;box-shadow:0px 0px 12px #7E7E7E;"><p>128px*128px</p>');
                    $('.cropped').append('<img src="'+img+'" align="absmiddle" style="width:180px;margin-top:4px;border-radius:180px;box-shadow:0px 0px 12px #7E7E7E;"><p>180px*180px</p>');
                	console.log(img);
                })
                $('#btnZoomIn').on('click', function(){
                    cropper.zoomIn();
                })
                $('#btnZoomOut').on('click', function(){
                    cropper.zoomOut();
                })
            });
        </script>
    </body>
</html>