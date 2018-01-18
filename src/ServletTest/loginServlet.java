package ServletTest;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


public class loginServlet extends HttpServlet{
	private static final long serialVersionUID = 1L;  
	  
    public void doPost(HttpServletRequest request, HttpServletResponse response)  
            throws ServletException, IOException {  
        request.setCharacterEncoding("utf-8");  
        response.setContentType("text/html;charset=utf-8");  
        String email = request.getParameter("email");  
        String password = request.getParameter("password");  
        String psw=null;
        PreparedStatement stmt=null;ResultSet rs=null;
		Connection con=null;
		String userrole=null;
		String headimage=null;
		String username=null;
         try{
        	 String driver ="com.mysql.jdbc.Driver";  
             String url ="jdbc:mysql://localhost:3306/test";  
             String user ="root";  
             String pass="123456";
             Class.forName(driver);  
             con = DriverManager.getConnection(url, user, pass);  
             String sql = "select * from user where email=?"; 
             stmt=con.prepareStatement(sql);
             stmt.setString(1, email);
             rs=stmt.executeQuery();
             if(rs.next()) {
            	 psw=rs.getString("password");
            	 userrole=rs.getString("role");
            	 headimage=rs.getString("header");
            	 username=rs.getString("username");
             }
             if(psw==null){
            	 request.setAttribute("msg", "无此用户");  
                 response.sendRedirect("/TomcatTest/mainPage.jsp");
            	 return;  
             }
             if(psw!=null&&!psw.equals(password)){  
                 request.setAttribute("msg", "密码错误");  
                 response.sendRedirect("/TomcatTest/mainPage.jsp"); 
                 return;  
             }  
             if(psw.equals(password)){  
            	 request.getSession().setAttribute("role",userrole);
            	 request.getSession().setAttribute("header", headimage);
            	 request.getSession().setAttribute("email", email);
            	 request.getSession().setAttribute("username", username);
                 request.setAttribute("msg", "用户"+email+",登陆成功");  
               response.sendRedirect("/TomcatTest/mainPage.jsp");
               return;
               
             }  
            	 
         }catch (ClassNotFoundException e) {  
             e.printStackTrace();  
         } catch (SQLException e) {  
             e.printStackTrace();  
         }finally {  
             try {  
                 if(stmt!=null)stmt.close();  
                 if(con!=null)con.close();  
                 }   
             	catch (SQLException e) {          
                }  
         }  
    }  
  

}
