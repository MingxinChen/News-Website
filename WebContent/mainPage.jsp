<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*,java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
class ArticleList{
	String theme_title = "当月主题";
	String theme_host = "主持人";
	String theme_summary = "主题简介";
	Article top;
	Article[] list1 = new Article[7];
	Article[] list2 = new Article[15];
	ArticleList(){
		String msg ="";
		String connectString = "jdbc:mysql://localhost:3306/test?characterEncoding=utf8&useSSL=true"; 
		StringBuilder table=new StringBuilder("");
		try{
			  Class.forName("com.mysql.jdbc.Driver");
			  Connection con=DriverManager.getConnection(connectString, "root", "123456");
			  Statement stmt=con.createStatement();
			  
			  ResultSet rs1=stmt.executeQuery("SELECT MAX(themeId)  as maxId FROM theme;");
			  int themeId=0;
			  if(rs1.next()) themeId=rs1.getInt("maxId");
			  
			  ResultSet rs2=stmt.executeQuery("SELECT *  FROM theme WHERE themeId = " + themeId+";");
			  if(rs2.next()) {
				  theme_title=rs2.getString("title");
				  theme_host=rs2.getString("writer");
				  theme_summary=rs2.getString("content");
			  }
			  
			  ResultSet rs3=stmt.executeQuery("SELECT * FROM news where groupId = 2 order by aid desc LIMIT 0 , 10 ;");
			  int i=0;
			  while(rs3.next()) {
				  String summary = rs3.getString("content");
				  int beginIndex=summary.indexOf("<p>");
				  int endIndex=summary.indexOf("</p>");
				  summary=summary.substring(beginIndex+3,endIndex);
				  if(summary.length()>100) summary=summary.substring(0,100);
				  Article a = new Article(rs3.getString("title"), summary, rs3.getString("aid"));
				  list2[i]=a;
				  i++;
			  }
			  
			  ResultSet rs4=stmt.executeQuery("SELECT * FROM commentary WHERE themeId = "+themeId + " ORDER BY aid DESC LIMIT 0 , 5 ;");
			  while(rs4.next()) {
				  String summary = rs4.getString("content");
				  int beginIndex=summary.indexOf("<p>");
				  int endIndex=summary.indexOf("</p>");
				  summary=summary.substring(beginIndex+3,endIndex);
				  if(summary.length()>100) summary=summary.substring(0,100);
				  Article a = new Article(rs4.getString("title"), summary, rs4.getString("aid"));
				  list2[i]=a;
				  i++;
			  }
			  
			  ResultSet rs5=stmt.executeQuery("SELECT * FROM news WHERE groupId = 0;");
			  if(rs5.next()) {
				  String summary = rs5.getString("content");
				  int beginIndex=summary.indexOf("<p>");
				  int endIndex=summary.indexOf("</p>");
				  summary=summary.substring(beginIndex+3,endIndex);
				  if(summary.length()>100) summary=summary.substring(0,100);
				  top=new Article(rs5.getString("title"), summary, rs5.getString("aid"));
			  }
			  
			  ResultSet rs6=stmt.executeQuery("SELECT * FROM news WHERE groupId = 1;");
			  i=0;
			  while(rs6.next()) {
				  Article a = new Article(rs6.getString("title"), "", rs6.getString("aid"));
				  list1[i]=a;
				  i++;
			  }
			  
			  rs1.close();
			  rs2.close();
			  rs3.close();
			  rs4.close();
			  rs5.close();
			  rs6.close();
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
		"pic16.jpg","pic17.jpg","pic18.jpg","pic19.jpg","pic20.jpg","pic21.jpg", "pic22.jpg"};
String picturePath="picture/";
String backgroundImage="picture/mainPic.jpg";
String adbackground="picture/adver.jpeg";

String[] stockCode={"sh600000", "sh600004", "sh600006", "sh600007", "sh600008", "sh600009", 
		"sh600010", "sh600011", "sh600012", "sh600015", "sh600016", "sh600017", "sh600018", 
		"sh600019", "sh600020", "sh600021", "sh600022", "sh600023", "sh600026", "sh600027",
		"sh600010", "sh600011", "sh600012", "sh600015", "sh600016", "sh600017", "sh600018",
		"sh600029", "sh600030", "sh600031", "sh600033", "sh600035", "sh600036", "sh600037",
		"sh600038", "sh600039", "sh600048", "sh600050", "sh600051", "sh600017", "sh600052" };

ArticleList articleList = new ArticleList();
%>
<html>
    <head>
        <meta charset="utf-8">
        <title>Stock.com</title>
        <link rel="stylesheet" type="text/css" href="css/main_header.css"/>
        <link rel="stylesheet" type="text/css" href="css/mainPage.css"/>
    </head>
    
    <body>
    
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
        <div class="main-content">
        
            <!--        头条-->
            <div class="main-stock-data">
                <div class="stock-window">
                	<div>
                		<%for(int i=0;i<stockCode.length;i++){ %>
		        			<script type="text/javascript" src=<%out.print("http://hq.sinajs.cn/list=" + stockCode[i]); %> charset="gb2312"></script>
							<script type="text/javascript">var elements=<%out.print("hq_str_" + stockCode[i]); %>.split(",");</script>
							<span><script type="text/javascript">document.write(elements[0]);</script></span>
							<span><script type="text/javascript">document.write(elements[3]);</script></span>
							<span><script type="text/javascript">document.write(elements[4]);</script></span>
							<span><script type="text/javascript">document.write(elements[5]+" | ");</script></span>
		        		<%} %>
                	</div>
                </div>
                
                <div class="picture-news-big" style="background-image: url(picture/topNews.jpg);">
                	<div class="shadow-title">
                		<div>
                			<h1><a href="detailPage.jsp?aid=<%out.print(articleList.top.articleId);%>&type=news" target="_blank"><%out.print(articleList.top.articleTitle);%></a></h1>
                			<p><%out.print(articleList.top.articleSummary);%>……</p>
                		</div>
                	</div>
                </div>
                
                <div class="stock-window-news">
                	<div>
		                <%for(int i=0;i<articleList.list1.length;i++){ %>
		                    <div>
		                        <img src=<% out.print(picturePath+pictureURL[(i+16)%pictureURL.length]); %> width="200px" height="150px;"><br/>
			                    <a href="detailPage.jsp?aid=<%out.print(articleList.list1[i].articleId);%>&type=news" target="_blank"><%out.print(articleList.list1[i].articleTitle);%></a>
		                    </div>
		                <%} %>
	                </div>
                </div>
            </div>
 			
            <!--        主体-->
            <div class="main-left">
                <!--        新闻头条-->
                <div class="main-top-news">
                    <h1>今日头条</h1>
                    <%for(int i=0;i<articleList.list2.length&&i<5;i++){ %>
                    		<div class="sub-news">
                        		<div class="sub-news-picture"><img src=<% out.print(picturePath+pictureURL[i%pictureURL.length]); %> width="110px" height="80px;"></div>
                        		<div class="sub-news-content">
                            		<div>
										<a href="detailPage.jsp?aid=<%out.print(articleList.list2[i].articleId);%>&type=news" target="_blank">
											<%out.print(articleList.list2[i].articleTitle);%>
										</a>
									</div>
                            		<div><%out.print(articleList.list2[i].articleSummary); %></div>
                        		</div>
                    		</div>
                    <%} %>
                    <div class="more-content"><a href="newsPage.jsp">更多 ></a></div>
                </div>
                
                <!--        实时新闻-->
                <div class="main-latest-news">
                    <h1>实时新闻</h1>
                    <%for(int i=5;i<articleList.list2.length&&i<10;i++){ %>
                    		<div class="sub-news">
                        		<div class="sub-news-picture"><img src=<% out.print(picturePath+pictureURL[(i+1)%pictureURL.length]); %> width="110px" height="80px;"></div>
                        		<div class="sub-news-content">
                            		<div>
										<a href="detailPage.jsp?aid=<%out.print(articleList.list2[i].articleId);%>&type=news" target="_blank">
											<%out.print(articleList.list2[i].articleTitle);%>
										</a>
									</div>
                            		<div><%out.print(articleList.list2[i].articleSummary); %></div>
                            	</div>
                    		</div>
                    <%} %>
                    <div class="more-content"><a href="newsPage.jsp">更多 ></a></div>
                </div>
                
                <!--        专栏文章-->
                <div class="column">
                    <h1>专栏文章</h1>
                    <%for(int i=10;i<articleList.list2.length&&i<15;i++){ %>
                    		<div class="sub-news">
                        		<div class="sub-news-picture"><img src=<% out.print(picturePath+pictureURL[(i+11)%pictureURL.length]); %> width="110px" height="80px;"></div>
                        		<div class="sub-news-content">
                            		<div>
										<a href="detailPage.jsp?aid=<%out.print(articleList.list2[i].articleId);%>&type=commentary" target="_blank">
											<%out.print(articleList.list2[i].articleTitle);%>
										</a>
									</div>
                            		<div><%out.print(articleList.list2[i].articleSummary); %></div>
                        		</div>
                    		</div>
                    <%} %>
                    <div class="more-content"><a href="commentaryPage.jsp">更多 ></a></div>
                </div>
            </div>

            <!--侧边栏        -->
            <div class="main-right">
                <!--        当月主题-->
                <div class="main-theme" style="background-image: url(<%= backgroundImage%>)">
                    <div>
                        <h1><a href="listPage.jsp">当月主题</a></h1>
                        <p><%out.print(articleList.theme_title); %></p>
                        <hr/>
                        <p><%out.print(articleList.theme_summary); %></p>
                    </div>
                </div>
                
                <!--        广告-->
                <div class="advertise" style="background-image: url(<%= adbackground%>)">
                    <h1>广告</h1>
                </div>
                
                <!--        热门作者-->
                <div class="column-writer">
                    <h1><a href="writerPage.jsp">热门作者</a></h1>
                    <div class="sub-column-writer">
                        <p><img src="picture/writer1.jpg">邓卫平</p>
                        <p><img src="picture/writer2.jpg">刘俊郁</p>
                        <p><img src="picture/writer3.jpg">金晓</p>
                    </div>
                </div>  
            </div>
        </div>
        
        <div class="footer">
            <div>
                <ul>
                    <li>相关功能</li>
                </ul>
                <ul>
                    <li>新闻订阅</li>
                    <li>市场分析</li>
                    <li>股评追踪</li>
                </ul>
            </div>
            <div>
                <ul>
                    <li>责任说明</li>
                </ul>
                <ul>
                    <li>专栏文章不代表本网站立场</li>
                    <li>股市有风险，投资需谨慎</li>
                </ul>
            </div>
            <div>
                <ul>
                    <li>网站设计</li>
                </ul>
                <ul>
                    <li>14348008 陈铭昕</li>
                    <li>14348032 胡彩芹</li>
                </ul>
            </div>
        </div>
    </body>
</html>