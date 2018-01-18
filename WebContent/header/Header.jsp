<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <link rel="stylesheet" type="text/css" href="../css/main_header.css"/>
    </head>
    <body id="list-Page-Body">
        <div class="header">
        <div class="main-logo"><a href="mainPage.jsp">Stock</a></div>
        <nav>
            <ul class="horizontal-list nav-list">
                <li class="nav-item active" id="nav-item-1">
                    <a href="dataPage.jsp" class="nav-link-sec">行情</a>
                    <div class="subnav" id="subnav-1">
                        <div class="subnav-inset">
                            <ul class="subnav-list">
                                <li class="active"><a href="dataPage.jsp" class="nav-link-subsec">实时行情</a></li>
                                <li><a href="http://finance.sina.com.cn/data/" target="_blank" class="nav-link-subsec">新浪股票系统</a></li>
                                
                            </ul>
                            
                        </div>
                    </div>
                </li>
                <li class="nav-item active" id="nav-item-2">
                    <a href="newsPage.jsp" class="nav-link-sec">新闻</a>
                    <div class="subnav" id="subnav-2">
                        <div class="subnav-inset">
                            <ul class="subnav-list">
                                <li class="active"><a href="newsPage.jsp" class="nav-link-subsec">今日头条</a></li>
                                <li><a href="newsPage.jsp" class="nav-link-subsec">实时新闻</a></li>
                            </ul>
                        </div>
                    </div>
                </li>
                <li class="nav-item active" id="nav-item-3">
                    <a href="commentaryPage.jsp" class="nav-link-sec">专栏</a>
                    <div class="subnav" id="subnav-3">
                        <div class="subnav-inset">
                            <ul class="subnav-list">
                                <li class="active"><a href="commentaryPage.jsp" class="nav-link-subsec">全部文章</a></li>
                                <li><a href="commentaryPage.jsp" class="nav-link-subsec">指数分析</a></li>
                                <li><a href="commentaryPage.jsp" class="nav-link-subsec">个股分析</a></li>
                            </ul>
                            <ul class="subnav-list">
                                <!-- <li><a href="writerPage.jsp" class="nav-link-subsec">撰稿人</a></li> -->
                            </ul>
                        </div>
                    </div>
                </li>
                <li class="nav-item active" id="nav-item-4">
                    <a href="listPage.jsp" class="nav-link-sec">当月主题</a>
                    <div class="subnav" id="subnav-4">
                        <div class="subnav-inset">
                            <ul class="subnav-list">
                                <li class="active"><a href="listPage.jsp" class="nav-link-subsec">主题文章</a></li>
                                <!-- <li><a href="themePage.jsp" class="nav-link-subsec">往期回顾</a></li> -->
                            </ul>
                        </div>
                    </div>
                </li>
                <li class="nav-item active" id="nav-item-5">
                    <a onclick="login()" class="nav-link-sec">登录</a>
                    <div class="subnav" id="subnav-5">
                        <div class="subnav-inset">
                            <ul class="subnav-list">
                                <li class="active"><a onclick="login()" class="nav-link-subsec">登录</a></li>
                                <li><a onclick="register()" class="nav-link-subsec">注册</a></li>
                            </ul>
                        </div>
                    </div>
                </li>
            </ul>
        </nav>
        </div>
        
        <div class="log_reg_shadow" id="log_reg_shadow">
        	<div class="welcome">
        		<p>欢迎加入《当月股评》！</p>
        		<p>新闻·热点，股评·预测，名家·专栏</p>
        		<p>坚持客观、中道、理性、建设性前提下批评性立场，融汇贯通海内外同品质媒体精华，以专业的网络新闻采编团队和强大的国际国内专家阵容，向希望一览海内外重大财经新闻并寻求真相的访问者，提供全方位的新闻、分析、评论与可信赖的信息源。</p>
        	</div>
        	<div class="login" id="login">
        		<form name="form_log" id="form_log" method="post" action="ServletTest/loginServlet">
        			<table>
        				<tr>
        					<td><img src="picture/email2.png" width="40px;"></td>
        					<td colspan="2"><input type="email" name="email" id="log_email" oninput="testEmail('log_email', 'pic_log_email')"><img id="pic_log_email" width="20px;"/></td>
        				</tr>
        				<tr>
        					<td><img src="picture/password2.png" width="30px;"></td>
        					<td colspan="2"><input type="password" name="password" id="log_password" oninput="testPassword('log_password', 'pic_log_password')"><img id="pic_log_password" width="20px;"/></td>
        				</tr>
        				<tr>
        					<td>
        					<td><input class="input-button" type="submit" name="login" value="登录" onclick="toLogin()"/></td>
        					<td><input class="input-button" type="button" name="cancel" value="取消" onclick="noLoginRegister()"/></td>
        				</tr>
        				<tr class="lastRow">
        					<td colspan="3"><a href="#" onclick="register()">注册</a>&nbsp;<a href="">忘记密码？</a></td>
        				</tr>
        			</table>
        		</form>
        	</div>
        	<div class="register" id="register">
        		<form name="form_reg" id="form_reg" action="ServletTest/registerServlet" method="post">
        			<table>
        				<tr>
        					<td><img src="picture/email2.png" width="40px;"/></td>
        					<td colspan="2"><input type="email" name="email" id="reg_email" oninput="testEmail('reg_email', 'pic_reg_email')"><img id="pic_reg_email" width="20px;"/></td>
        				</tr>
        				<tr>
        					<td><img src="picture/username2.png" width="40px;"/></td>
        					<td colspan="2"><input type="text" name="username" id="reg_username" onchange="testUsername('reg_username', 'pic_reg_username')"><img id="pic_reg_username" width="20px;"/></td>
        				</tr>
        				<tr>
        					<td><img src="picture/password2.png" width="30px;"/></td>
        					<td colspan="2"><input type="password" name="password" id="reg_password" onchange="testPassword('reg_password', 'pic_reg_password')"><img id="pic_reg_password" width="20px;"/></td>
        				</tr>
        				<tr>
        					<td></td>
        					<td><input class="input-button" type="submit" name="register" value="注册"/></td>
        					<td><input class="input-button" type="button" name="cancel" value="取消" onclick="noLoginRegister()"/></td>
        				</tr>
        				<input type="hidden" value="" name="bio"/>
        				<input type="hidden" value="" name="headimage"/>
        			</table>
        		</form>
        	</div>
        </div>
        
        
    </body>
    <script>
    	function login(){
    		document.getElementById("log_reg_shadow").style.visibility="visible";
    		document.getElementById("login").style.visibility="visible";
    		document.getElementById("register").style.visibility="hidden";
    	}
    	function register(){
    		document.getElementById("log_reg_shadow").style.visibility="visible";
    		document.getElementById("register").style.visibility="visible";
    		document.getElementById("login").style.visibility="hidden";
    	}
    	function noLoginRegister(){
    		document.getElementById("log_reg_shadow").style.visibility="hidden";
    		document.getElementById("register").style.visibility="hidden";
    		document.getElementById("login").style.visibility="hidden";
    	}
    	function testEmail(email, pic) {
    		var email=document.getElementById(email);
    		var test = /^[A-Za-z\d]+([-_.][A-Za-z\d]+)*@([A-Za-z\d]+[-.])+[A-Za-z\d]{2,4}$/;
    		if(!test.test(email.value))
    		{
    			document.getElementById(pic).src="picture/no.png";
    		}else{
    			document.getElementById(pic).src="picture/ok.png";
    		}
    	}
		function testUsername(username, pic) {
			var username=document.getElementById(username);
    		var test = /^.{1,50}/;
    		if(!test.test(username.value))
    		{
    			document.getElementById(pic).src="picture/no.png";
    		}else{
    			document.getElementById(pic).src="picture/ok.png";
    		}
    	}
		function testPassword(password, pic) {
			var password=document.getElementById(password);
    		var test = /^.{1,50}/;
    		if(!test.test(password.value))
    		{
    			document.getElementById(pic).src="picture/no.png";
    		}else{
    			document.getElementById(pic).src="picture/ok.png";
    		}
    	}
    </script>
</html>