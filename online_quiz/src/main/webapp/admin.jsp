
<%@ page import="java.sql.*" %>
<html>
<head>
    <title>Admin Panel</title>
</head>
<body>
    <h2>Add New Question</h2>
    <form action="add_question.jsp" method="post">
        Question: <input type="text" name="question"><br>
        Option 1: <input type="text" name="option1"><br>
        Option 2: <input type="text" name="option2"><br>
        Option 3: <input type="text" name="option3"><br>
        Option 4: <input type="text" name="option4"><br>
        Correct Option (1-4): <input type="number" name="correct_option"><br>
        <input type="submit" value="Add Question">
    </form>
</body>
</html>

