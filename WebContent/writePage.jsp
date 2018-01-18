<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en-US">
<head>
    <meta charset="UTF-8">
        <title>发布.Stock.com</title>
        <link rel="stylesheet" type="text/css" href="css/main_header.css"/>
        <link rel="stylesheet" type="text/css" href="css/log_reg_window.css"/>
        <link rel="stylesheet" type="text/css" href="css/writePage.css"/> 
        <!-- <script type="text/javascript" src="js/writePage.js"></script> -->
    </head>
    
    <body>
        <jsp:include page="header/HeaderForEditor.jsp"/>
        
        <div class="desk">
        	<form name="form1" action="response/writeResponse.jsp" method="post">
        		<label>标&nbsp&nbsp题</label><input class="input1" type="text" name="title" id="title" value="不超过30个字符"><br/>
        		<label>作&nbsp&nbsp者</label><input class="input1" type="text" name="writer" id="writer"><span id="writer_message"></span><br/>
        		<label>类&nbsp&nbsp型</label><input class="input2" type="radio" name="type" checked="checked" value="news">新闻热点<input class="input2" type="radio" name="type" value="commentary">专题文章<br/>
        		<label>分&nbsp&nbsp组</label><input class="input2" type="radio" name="groupId" checked="checked" value="0">头条<input class="input2" type="radio" name="groupId" value="1">子头条<input class="input2" type="radio" name="groupId" value="2">普通新闻<input class="input2" type="radio" name="groupId" value="0">当月主题<input class="input2" type="radio" name="groupId" value="1">普通专栏<br/>
        		<textarea id="container" name="content">输入正文...</textarea>
        		<!-- <input type="text" name="article" id="article" style="visibility: hidden"/> -->
        		<!-- <script id="container" name="content" type="text/plain">输入正文...</script> -->
	        	<script type="text/javascript" src="ueditor/ueditor.config.js"></script>
	    		<script type="text/javascript" src="ueditor/ueditor.all.js"></script>
	    		<script type="text/javascript">
	    			var ue = UE.getEditor('container');
	    		</script>
	        	<div class="save-button"><input type="submit" value="确认发布"/></div>
		        <div class="cancel-button" onclick="quit()"><input type="button" value="取消发布"/></div>
        	</form>
    	</div>
    </body>
    <script>
	    function quit(){
	    	document.getElementById('title').value="";
	    	document.getElementById('writer').value="";
	        ue.setContent('输入正文...');
	    }
    </script>
</html>