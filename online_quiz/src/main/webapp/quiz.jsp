<%@ page import="java.sql.*, java.util.*" %>
<%
    Connection con = (Connection) session.getAttribute("dbConnection");
    Statement stmt = con.createStatement();
    ResultSet rs = stmt.executeQuery("SELECT * FROM questions");

    List<String> questions = new ArrayList<>();
    int qno = 0;
    while (rs.next()) {
        questions.add("<div class='question'>"
            + "<p>Q" + (++qno) + ". " + rs.getString("question") + "</p>"
            + "<label><input type='radio' name='q" + rs.getInt("id") + "' value='1'> " + rs.getString("option1") + "</label><br>"
            + "<label><input type='radio' name='q" + rs.getInt("id") + "' value='2'> " + rs.getString("option2") + "</label><br>"
            + "<label><input type='radio' name='q" + rs.getInt("id") + "' value='3'> " + rs.getString("option3") + "</label><br>"
            + "<label><input type='radio' name='q" + rs.getInt("id") + "' value='4'> " + rs.getString("option4") + "</label><br>"
            + "</div>"
        );
    }
    session.setAttribute("total_questions",qno);
   
%>
<html>
<head>
    <title>Online Quiz</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
            text-align: center;
        }
        .quiz-container {
            width: 50%;
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0px 0px 10px gray;
            margin: auto;
            margin-top: 50px;
        }
        .question {
            text-align: left;
            padding: 10px;
            margin: 15px 0;
            background-color: #e3f2fd;
            border-left: 5px solid #007bff;
            border-radius: 5px;
        }
        .question p {
            color: #007bff;
            font-weight: bold;
            font-size: 18px;
        }
        label {
            font-size: 16px;
            display: block;
            margin-bottom: 5px;
        }
        input[type="radio"] {
            margin-right: 10px;
        }
        input[type="submit"] {
            background-color: #28a745;
            color: white;
            padding: 10px 20px;
            font-size: 18px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            margin-top: 20px;
        }
        input[type="submit"]:hover {
            background-color: #218838;
        }
        .timer {
            position: fixed;
            top: 20px;
            right: 20px;
            background: #ffc107;
            color: black;
            padding: 10px;
            border-radius: 5px;
            font-size: 18px;
            font-weight: bold;
        }
        .timer.warning {
            background: red;
            color: white;
        }
    </style>
    <script>
        let timeLeft = 60*<%=qno%>; // 5 minutes (300 seconds)
        
        function startTimer() {
         let timerElement = document.getElementById("timer");
            
            let countdown = setInterval(function() {
                let minutes = Math.floor(timeLeft / 60);
                let seconds = timeLeft % 60;
                seconds = seconds < 10 ? "0" + seconds : seconds;

    timerElement.innerHTML = "Time Left: " + minutes + ":" + seconds;

                if (timeLeft <= 30) {
                    timerElement.classList.add("warning"); // Change color to red
                }

                if (timeLeft <= 0) {
                    clearInterval(countdown);
             document.getElementById("quizForm").submit(); // Auto-submit
                }

                timeLeft--;
            }, 1000);
        }
    </script>
</head>
<body onload="startTimer()">
    <div class="timer" id="timer">Time Left: </div>

    <div class="quiz-container">
        <h2>Online Quiz</h2>
        <form id="quizForm" action="submit_quiz.jsp" method="post">
            <%= String.join("<br>", questions) %>
            <input type="submit" value="Submit">
        </form>
    </div>
</body>
</html>
