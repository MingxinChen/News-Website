<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
class User{
	String username;
	String role;
	String header;
	User(){
		username="MCC";
		role="editor";
		header="./picture/writer3.jpg";
	}
}
User user = new User();
user.header=(String)session.getAttribute("header");
user.role=(String)session.getAttribute("role");
user.username=(String)session.getAttribute("username");
%>
<html>
    <head>
        <link rel="stylesheet" type="text/css" href="main_header.css"/>
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
                                <li class="active"><a href="dataPage.jsp" target="_blank" class="nav-link-subsec">实时行情</a></li>
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
                                <!-- <li><a href="writerPage.jsp" target="_blank" class="nav-link-subsec">撰稿人</a></li>-->
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
                                <!-- <li><a href="themePage.jsp" target="_blank" class="nav-link-subsec">往期回顾</a></li> -->
                            </ul>
                        </div>
                    </div>
                </li>
<!--                管理员的账号管理-->
                <li class="nav-item active" id="nav-item-5">
                    <a href="infoPage.jsp" target="_blank" class="nav-link-sec">管理</a>
                    <div class="subnav" id="subnav-5">
                        <div class="subnav-inset">
                            <ul class="subnav-list">
                                <li class="active"><a href="writePage.jsp" target="_blank" class="nav-link-subsec">发布</a></li>
                                <li><a href="managePageForNews.jsp" target="_blank" class="nav-link-subsec">新闻管理</a></li>
                                <li><a href="managePageForCommentary.jsp" target="_blank" class="nav-link-subsec">专栏管理</a></li>
                                <li class="active"><a href="infoPage.jsp" target="_blank" class="nav-link-subsec">个人信息</a></li>
                                <li class="headerBlock"><img src="<%out.print(user.header);%>"><%out.print(user.username);%></li>
                            </ul>
                        </div>
                    </div>
                </li>
            </ul>
        </nav>
        </div>
        
        
    </body>
</html>