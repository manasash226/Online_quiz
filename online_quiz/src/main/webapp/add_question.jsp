
<%@ page import="java.sql.*" %>
<%
    String question = request.getParameter("question");
    String option1 = request.getParameter("option1");
    String option2 = request.getParameter("option2");
    String option3 = request.getParameter("option3");
    String option4 = request.getParameter("option4");
    int correctOption = Integer.parseInt(request.getParameter("correct_option"));

    Connection con = (Connection) session.getAttribute("dbConnection");
    PreparedStatement pst = con.prepareStatement("INSERT INTO questions (question, option1, option2, option3, option4, correct_option) VALUES (?, ?, ?, ?, ?, ?)");
    pst.setString(1, question);
    pst.setString(2, option1);
    pst.setString(3, option2);
    pst.setString(4, option3);
    pst.setString(5, option4);
    pst.setInt(6, correctOption);
    pst.executeUpdate();

    out.println("Question added successfully!");
%>

<html>
<head>
</head>
</html>