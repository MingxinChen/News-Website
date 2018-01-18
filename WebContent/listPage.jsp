<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*,java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
class ArticleList{
	String theme_title = "当月主题";
	String theme_host = "主持人";
	Article[] list = new Article[20];
	ArticleList(int pageNum){
		String msg ="";
		String connectString = "jdbc:mysql://localhost:3306/test?characterEncoding=utf8&useSSL=true"; 
		StringBuilder table=new StringBuilder("");
		try{
			  Class.forName("com.mysql.jdbc.Driver");
			  Connection con=DriverManager.getConnection(connectString, "root", "123456");
			  Statement stmt=con.createStatement();
			  ResultSet rs1=stmt.executeQuery("SELECT MAX(themeId) as maxId FROM theme;");
			  int themeId=0;
			  if(rs1.next()) themeId=rs1.getInt("maxId");
			  System.out.print(themeId);
			  
			  ResultSet rs2=stmt.executeQuery("SELECT *  FROM theme WHERE themeId = " + themeId + ";");
			  if(rs2.next()) {
				  theme_title=rs2.getString("title");
				  theme_host=rs2.getString("writer");
			  }
			  
			  String begin=(pageNum*20)+"";
			  String end=(pageNum*20+20)+"";
			  ResultSet rs3=stmt.executeQuery("SELECT * FROM commentary WHERE themeId = "+themeId +" order by aid desc LIMIT "+begin+" , "+end+";");
			  int i=0;
			  while(rs3.next()) {
				  String summary = rs3.getString("content");
				  int beginIndex=summary.indexOf("<p>");
				  int endIndex=summary.indexOf("</p>");
				  summary=summary.substring(beginIndex+3,endIndex);
				  if(summary.length()>100) summary=summary.substring(0,100);
				  Article a = new Article(rs3.getString("title"), summary, rs3.getString("aid"));
				  System.out.println(rs3.getString("title") + "  " + summary + " " + rs3.getString("aid"));
				  list[i]=a;
				  i++;
			  }
			  rs1.close();
			  rs2.close();
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

String[] pictureURL={
		"pic1.jpg","pic2.png","pic3.jpg","pic4.jpg","pic5.jpg",
		"pic6.gif","pic7.jpg","pic8.jpg","pic9.png","pic10.jpg",
		"pic11.jpg","pic12.jpg","pic13.jpg","pic14.jpg","pic15.jpg",
		"pic16.jpg","pic17.jpg","pic18.jpg","pic19.jpg","pic20.jpg","pic21.jpg"};
String picturePath="picture/";
String backgroundImage="picture/mainPic.jpg";

String pageString=request.getParameter("page");
int pageNum=0;
if(pageString!=null) pageNum=Integer.parseInt(pageString);
ArticleList articleList = new ArticleList(pageNum);
%>
<html>
    <head>
        <title>当月主题.Stock.com</title>
        <link rel="stylesheet" type="text/css" href="css/main_header.css"/>
        <link rel="stylesheet" type="text/css" href="css/log_reg_window.css"/>
        <link rel="stylesheet" type="text/css" href="css/listPage.css"/>
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
        <div class="picture" style="background-image:url(<%= backgroundImage%>);">
            <div class="article-title">
                <div class="article-link"><a href="#">当月主题</a></div>
                <p id="article-title-title"><%= articleList.theme_title%></p>
                <hr width="70%">
                <p id="article-title-writer">主持人：<%= articleList.theme_host%></p>
            </div>
        </div>
        <div class="article-list" id="article_list">
			<%for(int i=0;i<articleList.list.length;i++){ %>
			<%if(articleList.list[i]!=null){ %>
			<div class="sub-news">
				<div class="sub-news-picture"><img src=<% out.print(picturePath+pictureURL[(i)%pictureURL.length]); %> width="110px" height="80px"></div>
				<div class="sub-news-content">
					<div>
						<a href="detailPage.jsp?aid=<%out.print(articleList.list[i].articleId);%>&type=commentary" target="_blank">
							<%out.print(articleList.list[i].articleTitle);%>
						</a>
					</div>
					<div><%out.print(articleList.list[i].articleSummary);%></div>
				</div>
			</div>
			<%} %>
			<%} %>
			<div><a href="listPage.jsp?page=<%out.print(pageNum+1);%>">更多></a></div>
        </div>
    </body>
    <script>
    
    </script>
</html>