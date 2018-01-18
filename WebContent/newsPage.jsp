<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="java.util.*,java.sql.*"%>
<%
class ArticleList{
	Article[] list= new Article[20];
	ArticleList(int pageNum){
		String msg ="";
		String connectString = "jdbc:mysql://localhost:3306/test?characterEncoding=utf8&useSSL=true"; 
		StringBuilder table=new StringBuilder("");
		try{
			  Class.forName("com.mysql.jdbc.Driver");
			  Connection con=DriverManager.getConnection(connectString, "root", "123456");
			  Statement stmt=con.createStatement();
			  
			  String begin=(pageNum*20)+"";
			  String end=(pageNum*20+20)+"";
			  ResultSet rs=stmt.executeQuery("SELECT * FROM news  order by aid desc LIMIT "+begin+" , " + end+ ";");
			  int i=0;
			  while(rs.next()) {
				  String summary = rs.getString("content");
				  int beginIndex=summary.indexOf("<p>");
				  int endIndex=summary.indexOf("</p>");
				  summary=summary.substring(beginIndex+3,endIndex);
				  if(summary.length()>100) summary=summary.substring(0,100);
				  Article a = new Article(rs.getString("title"), summary, rs.getString("aid"));
				  System.out.println(rs.getString("title") + "  " + summary + " " + rs.getString("aid"));
				  list[i]=a;
				  i++;
			  }
			  rs.close();
			  stmt.close();
			  con.close();
			}
			catch (Exception e){
			  System.out.println(e);
			  msg = e.getMessage();
			}
	}
	class Article{
		String articleTitle;
		String articleSummary;
		String articleId;
		Article(String articleTitle, String articleSummary, String articleId) {
		    this.articleTitle = articleTitle;
		    this.articleSummary = articleSummary;
		    this.articleId = articleId;
		}
	}
}

String[] pictureURL={"pic1.jpg","pic2.png","pic3.jpg","pic4.jpg","pic5.jpg","pic6.gif","pic7.jpg","pic8.jpg","pic9.png"};
String picturePath="picture/";
String backgroundImage="picture/mainPic.jpg";

String pageString=request.getParameter("page");
int pageNum=0;
if(pageString!=null) pageNum=Integer.parseInt(pageString);
ArticleList articleList = new ArticleList(pageNum);
%>
<html>
    <head>
        <title>新闻热点.Stock.com</title>
        <link rel="stylesheet" type="text/css" href="css/main_header.css"/>
        <link rel="stylesheet" type="text/css" href="css/log_reg_window.css"/>
        <link rel="stylesheet" type="text/css" href="css/newsPage.css"/>
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
        <div class="picture" style="background-image:url(<%out.print(backgroundImage);%>);">
            <div class="article-title">
                <div class="article-link"><a href="dataPage.jsp">实时行情</a></div>
                <p id="article-title-title" style="margin-left: 170px;">新闻 · 热点</p>
                <hr width="70%">
                <p id="article-title-writer">Stock 当月股评</p>
            </div>
        </div>
        <div class="article-list" id="article_list">
			<%for(int i=0;i<articleList.list.length;i++){ %>
			<%if(articleList.list[i]!=null){ %>
			<div class="sub-news">
				<div class="sub-news-picture"><img src=<% out.print(picturePath+pictureURL[(i)%pictureURL.length]); %> width="110px" height="80px"></div>
				<div class="sub-news-content">
					<div>
						<a href="detailPage.jsp?aid=<%out.print(articleList.list[i].articleId);%>&type=news" target="_blank">
							<%out.print(articleList.list[i].articleTitle);%>
						</a>
					</div>
					<div><%out.print(articleList.list[i].articleSummary);%></div>
				</div>
			</div>
			<%} %>
			<%} %>
			<div><a href="newsPage.jsp?page=<%out.print(pageNum+1);%>">更多></a></div>
        </div>
    </body>
</html>