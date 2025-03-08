
<%@ page import="java.sql.*" %>
<%
    String url = "jdbc:mysql://localhost:3306/quizdb";
    String user = "root";
    String password = "";

    Connection con = null;
    try {
        Class.forName("com.mysql.jdbc.Driver");  // step 1: Load the Mysql driver
        con = DriverManager.getConnection(url, user, password);
        session.setAttribute("dbConnection", con);
    } catch (Exception e) {
        out.println("Database connection error: " + e);
    }	

RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
rd.forward(request,response);

%>

