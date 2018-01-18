<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*,java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
class Article{
	String articleTitle;
	String articleContent;
	String articleWriter;
	String articleTime;
	Comment[] commentList=null;
	Article(String type, String aid) {
	    String msg ="";
		String connectString = "jdbc:mysql://localhost:3306/test?characterEncoding=utf8&useSSL=true"; 
		StringBuilder table=new StringBuilder("");
	    try{
			  Class.forName("com.mysql.jdbc.Driver");
			  Connection con=DriverManager.getConnection(connectString, "root", "123456");
			  Statement stmt=con.createStatement();
			  ResultSet rs1=stmt.executeQuery("SELECT * FROM "+type+" WHERE aid = "+aid);
			  while(rs1.next()) {
				  articleContent = rs1.getString("content");
				  articleWriter=rs1.getString("writer");
				  articleTitle=rs1.getString("title");
				  articleTime=rs1.getString("createTime");
			  }
			  System.out.println(articleWriter + "  " + articleTitle);
			  
			  ResultSet rs2=stmt.executeQuery("SELECT count(*) as num FROM comment where type = '"+type+"' and aid = " +aid + ";");
			  int count=0;
			  if(rs2.next()) count=rs2.getInt("num");
			  System.out.print(count+" ");
			  commentList = new Comment[count];
			  ResultSet rs3=stmt.executeQuery("SELECT * FROM comment where type = '"+type+"' and aid = " +aid + ";");
			  int i=0;
			  while(rs3.next()){				 
				  Comment c = new Comment(rs3.getString("writer"), rs3.getString("content"), rs3.getString("createTime"), rs3.getInt("kudo"));
				//  if(c.user==null) c.user="游客";
				  commentList[i]=c;
				  i++;
			  }
			  
			  rs1.close();
			  rs2.close();
			  rs3.close();
			  stmt.close();
			  con.close();
		}
		catch (Exception e){
			  System.out.println(e);
			  msg = e.getMessage();
		}
	}
	
	class Comment{
		String user;
		String words;
		String time;
		int kudo;
		Comment(String u, String w, String t, int k){
			user=u; words=w; time=t; kudo=k;
		}
	}
}
String backgroundImage="picture/mainPic.jpg";

String type=request.getParameter("type");
String aid=request.getParameter("aid");
System.out.println(aid + "  " + type);
Article article=new Article(type, aid);
System.out.print(article.commentList.length);
%>
<html>
    <head>
        <title><%out.print(article.articleTitle); %>Stock.com</title>
        <link rel="stylesheet" type="text/css" href="css/main_header.css"/>
        <link rel="stylesheet" type="text/css" href="css/log_reg_window.css"/>
        <link rel="stylesheet" type="text/css" href="css/detailPage.css"/>
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
        <div class="picture" style="background-image:url(<%= backgroundImage%>)">
            <div class="article-title">
                <div class="article-link"><a href="dataPage.jsp">实时行情</a></div>
                <p id="article-title-title"><%out.print(article.articleTitle);%></p>
                <hr width="70%">
                <p id="article-title-writer"><%out.print(article.articleWriter);%></p>
            </div>
        </div>
        
        <div class="article">
        	<p><img src="picture/begin.png"/></p>
        	<div><span class="update"><%out.print(article.articleTime); %></span></div>
        	<div><%out.print(article.articleContent);%></div>
        	
        	<div class=comment>
        		<form name="comment" action="response/commentResponse.jsp?aid=<%out.print(aid);%>&type=<%out.print(type);%>" method="post">
	        		<textarea id="commentText" name="words"></textarea>
	        		<input class="button-confirm" src="picture/reply2.png" type="image" name="confirm" value="评论" title="评论"/>
	        		<a onclick="clean()" title="清除"><img class="button-clean" src="picture/clean.png"/></a>
	        	</form>
	        	<br/>
	        	<%for(int i=0;i<article.commentList.length;i++){%>
	        	<div>
	        		<p class='username'><%out.print(article.commentList[i].user);%></p>
	        		<p class='words'><%out.print(article.commentList[i].words);%></p>
	        		<p class='time'><%out.print(article.commentList[i].time);%>
		        		<span class="button">
		        			<a onclick="reply('<%out.print(article.commentList[i].user);%>')"><img src="picture/reply2.png" title="回复"/></a>
		        			<a id="comment-a<%out.print(i);%>" onclick="kudo(<%out.print(i);%>, <%out.print(article.commentList[i].kudo);%>)">
		        				<img id="comment-img<%out.print(i);%>" src="picture/like2.png" title="点赞"/>
		        				<span id="comment-kudo<%out.print(i);%>"><%out.print(article.commentList[i].kudo);%></span>
		        			</a>
		        		</span>
	        		</p>
	        	</div>
	        	<%} %>
	        </div>
        </div>
    </body>
    <script>
    function clean(){
    	var textarea=document.getElementById("commentText");
    	textarea.innerHTML="";
    	console.log(textarea);
    }
    function reply(user){
    	var textarea=document.getElementById("commentText");
    	textarea.innerHTML="@"+user+": ";
    }
    function kudo(i, x){
    	var span=document.getElementById("comment-kudo"+i);
    	span.innerHTML=x+1;
    	span.style.color="#990033";
    	var img=document.getElementById("comment-img"+i);
    	img.src="picture/dislike2.png";
    	var a=document.getElementById("comment-a"+i);
    	a.onclick=function(){unkudo(i, x+1)};
    }
    function unkudo(i, x){
    	
    	var span=document.getElementById("comment-kudo"+i);
    	span.innerHTML=x-1;
    	span.style.color="#565656";
    	var img=document.getElementById("comment-img"+i);
    	img.src="picture/like2.png";
    	var a=document.getElementById("comment-a"+i);
    	a.onclick=function(){kudo(i, x-1)};
    }
    </script>

</html>