<%@ page import="java.sql.*" %>
<%
    Connection con = (Connection) session.getAttribute("dbConnection");
    Statement stmt = con.createStatement();
    ResultSet rs = stmt.executeQuery("SELECT * FROM questions");
	int user_id=(Integer)session.getAttribute("user_id");
	PreparedStatement ps=null;
	String dq ="delete from quiz_attempts where user_id=?";
	ps = con.prepareStatement(dq);
	ps.setInt(1,user_id);
	ps.executeUpdate();
	
    int total_question=(Integer)session.getAttribute("total_questions");
    int score = 0;
    String q= "INSERT INTO `quiz_attempts`(`user_id`, `question_id`, `chosen_option`) VALUES (?,?,?)";
    ps = con.prepareStatement(q);
   
   	int questionId=0;
    while (rs.next()) 
    {
        questionId = rs.getInt("id");
        int correctAnswer = rs.getInt("correct_option");

        String selectedOption = request.getParameter("q" + questionId);
        if (selectedOption != null && Integer.parseInt(selectedOption) == correctAnswer) 
        {
            score++;
            
        }
        ps.setInt(1,user_id);
        ps.setInt(2,questionId);
        ps.setInt(3,Integer.parseInt(selectedOption));
        ps.executeUpdate();
       
	}   	
    out.println("<h2>Your Score: " + score + "/"+total_question+ "</h2>");
    
    String sq="SELECT `question_id`, question,`chosen_option`, correct_option,option1,option2,option3,option4 FROM `quiz_attempts` q1 inner join questions q2 on q1.question_id=q2.id WHERE user_id=?";
    ps = con.prepareStatement(sq);
    ps.setInt(1,user_id);
    rs = ps.executeQuery();
    String tbl="<table border =1><tr><td>Q.No</td><td>Question</td>   <td>Chosen option</td><td>Correct option</td></tr>";
    String options[]= new String[4];
    while (rs.next()) 
    {
    	
    	options[0]=rs.getString(5);
    	options[1]=rs.getString(6);
    	options[2]=rs.getString(7);
    	options[3]=rs.getString(8);
    	String row="<tr><td>"+rs.getInt(1)+"</td><td>"+rs.getString(2)+	"</td><td style='text-align:center'>"+options[rs.getInt(3)-1]+"</td><td style='text-align:center'>"+options[rs.getInt(4)-1]+"</td></tr>";
    	
    	if(rs.getInt(3)!= rs.getInt(4))    	
    	{   row="<tr style='color:red'><td>"+rs.getInt(1)+"</td>	<td>"+rs.getString(2)+"</td><td >"+options[rs.getInt(3)-1]+"</td>   	<td>"+options[rs.getInt(4)-1]+"</td></tr>";
            
    	}
        tbl += row;       
	} 
    tbl = tbl + "</table>";
    out.println(tbl);
    
%>

