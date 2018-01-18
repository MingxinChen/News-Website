<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*,java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
class ArticleList{
	Article[] list;
	int articleCount=0;
	ArticleList(){
		String msg ="";
		String connectString = "jdbc:mysql://localhost:3306/test?characterEncoding=utf8&useSSL=true"; 
		StringBuilder table=new StringBuilder("");
		try{
			  Class.forName("com.mysql.jdbc.Driver");
			  Connection con=DriverManager.getConnection(connectString, "root", "123456");
			  Statement stmt=con.createStatement();
			  
			  ResultSet rs1=stmt.executeQuery("SELECT COUNT(*) as acount FROM commentary;");
			  if(rs1.next()) articleCount=rs1.getInt("acount");
			  list=new Article[articleCount];
			  
			  ResultSet rs2=stmt.executeQuery("SELECT * FROM commentary order by aid desc;");
			  int i=0;
			  while(rs2.next()) {
				  int aid=rs2.getInt("aid");
				  String createTime=rs2.getString("createTime");
				  String title=rs2.getString("title");
				  String writer=rs2.getString("writer");
				  Article a=new Article(aid, title, createTime, writer);
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
		int articleId;
		String articleTitle;
		String articleTime;
		String articleWriter;
		Article(int articleId, String articleTitle, String articleTime, String articleWriter) {
		    this.articleId = articleId;
		    this.articleTitle = articleTitle;
		    this.articleTime = articleTime;
		    this.articleWriter = articleWriter;
		}
	}
}
ArticleList articleList = new ArticleList();
%>
<html>
    <head>
        <title>管理新闻热点.Stock.com</title>
        <link rel="stylesheet" type="text/css" href="css/main_header.css"/>
        <link rel="stylesheet" type="text/css" href="css/managePage.css"/>
    </head>
    
    <body id="list-Page-Body">
        <jsp:include page="header/HeaderForEditor.jsp"/>
        
        <!--        正文部分-->
        <div class="desk">
        <h1>管理 · 专栏文章</h1>
        <form name="deleteCommentary" action="response/delete.jsp?type=commentary" method="post">
        <table>
	        <%for(int i=0;i<articleList.list.length;i++){ %>
	        	<tr>
	        		<td><input type="checkbox" name="deleteId" value=<%= articleList.list[i].articleId%>></td>
	        		<td><%out.print(articleList.list[i].articleTime); %></td>
	        		<td><%out.print(articleList.list[i].articleTitle); %></td>
	        		<td><%out.print(articleList.list[i].articleWriter); %></td>
	        	</tr>
	        <%} %>
        </table>
        <div class="delete-button"><input type="submit" value="删除所选"/></div>
	    <div class="cancel-button" onclick="cancel()"><input type="button" onclick="cancel()" value="取消选择"/></div>
	    </form>
        </div>
    </body>
    <script>
    	function cancel() {
    		var checkbox=document.getElementByName="delete";
    		for(var i=0;i<checkbox.length;i++){
    			checkbox[i].checked=false;
    		}
    	}
    </script>
</html>