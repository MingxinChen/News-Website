<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
String[] stockCode={"sh600000", "sh600004", "sh600006", "sh600007", "sh600008", "sh600009", 
		"sh600010", "sh600011", "sh600012", "sh600015", "sh600016", "sh600017", "sh600018", 
		"sh600019", "sh600020", "sh600021", "sh600022", "sh600023", "sh600026", "sh600027",
		"sh600010", "sh600011", "sh600012", "sh600015", "sh600016", "sh600017", "sh600018",
		"sh600029", "sh600030", "sh600031", "sh600033", "sh600035", "sh600036", "sh600037",
		"sh600038", "sh600039", "sh600048", "sh600050", "sh600051", "sh600017", "sh600052" };
String backgroundImage="picture/mainPic.jpg";
%>
<html>
    <head>
        <title>行情数据.Stock.com</title>
        <link rel="stylesheet" type="text/css" href="css/main_header.css"/>
        <link rel="stylesheet" type="text/css" href="css/log_reg_window.css"/>
        <link rel="stylesheet" type="text/css" href="css/dataPage.css"/>
    </head>
    
    <body id="list-Page-Body">
       <% String role=(String)session.getAttribute("role");%>
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
        <div class="picture" style="background-image:url(<%=backgroundImage%>);">
            <div class="article-title">
                <div class="article-link"><a href="newsPage.jsp">新闻热点</a></div>
                <p id="article-title-title">行情 · 数据</p>
                <hr width="70%">
                <p id="article-title-writer">数据来源：新浪财经</p>
            </div>
        </div>
        
        <div class="hucaiqindebaikuang"></div>
        
        <div class="data-container">
        	 <table class="table-head"> 
        		<tr>
        			<td>代码</td>
        			<td>名称</td>
        			<td>最新价</td>
        			<td>昨收</td>
        			<td>今开</td>
        			<td>最高</td>
        			<td>最低</td>
        		</tr>
        	</table>
         	<table class="table-data"> 
    			<%for(int i=0;i<stockCode.length;i++){ %>
        		<tr>
        			<script type="text/javascript" src=<%out.print("http://hq.sinajs.cn/list=" + stockCode[i]); %> charset="gb2312"></script>
					<script type="text/javascript">var elements=<%out.print("hq_str_" + stockCode[i]); %>.split(",");</script>
					<td><% out.print(stockCode[i]);%></td>
					<td><script type="text/javascript">document.write(elements[0]);</script></td>
					<td><script type="text/javascript">document.write(elements[3]);</script></td>
					<td><script type="text/javascript">document.write(elements[2]);</script></td>
					<td><script type="text/javascript">document.write(elements[1]);</script></td>
					<td><script type="text/javascript">document.write(elements[4]);</script></td>
					<td><script type="text/javascript">document.write(elements[5]);</script></td>
				</tr>
        		<%} %>
        	</table>
        </div>
        
        	<table class="typeBlock">
        		<tr><td><a>指数</a></td></tr>
        		<tr><td><a>上证指数</a></td></tr>
        		<tr><td><a>深证成指</a></td></tr>
        		<tr><td><a>沪深300</a></td></tr>
        		<tr><td><a>全部A股</a></td></tr>
        		<tr><td><a>中小板</a></td></tr>
        		<tr><td><a>创业板</a></td></tr>
        		<tr><td><a>概念板块</a></td></tr>
        	</table>
    </body>
</html>