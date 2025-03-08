<%@ page language="java" import="java.sql.*" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%
String usr_type="NORMAL";
String q="SELECT u.id,u.username, u.user_type,COUNT(q1.question_id) AS total_attempted, SUM(CASE WHEN q1.chosen_option = q2.correct_option THEN 1 ELSE 0 END) AS score FROM users u LEFT JOIN quiz_attempts q1 ON u.id = q1.user_id LEFT JOIN questions q2 ON q1.question_id = q2.id where user_type='"+usr_type+"' GROUP BY u.id, u.username;";
Connection Con=(Connection) session.getAttribute("dbConnection");
Statement st=Con.createStatement();
ResultSet rs=st.executeQuery(q);
String tbl="<table align='center' border=1><tr><th colspan=7> Online Quiz Score </th></tr><tr><th>id</th><th>username</th><th>user_type</th><th>total_attempted</th><th>score</th><th>percentage</th><th>Status</th></tr>";
while(rs.next()){
	int uid=rs.getInt(1);
	String username=rs.getString(2);
	String user_type=rs.getString(3);
	int total_attempted=rs.getInt(4);
	int score=rs.getInt(5);
	float Percentage; 
	if(total_attempted==0){
		Percentage=0;
	}
	else{
		Percentage=Math.round(((float)score/total_attempted)*100); 
	}
	String exam_status="Appeared";
	if(total_attempted==0)
	{
		exam_status="<span style='color:red'>Exam NOT-Appeared</span>";
	}
	
	tbl=tbl+"<tr><td>"+uid+"</td><td>"+username+"</td><td>"+user_type+"</td><td>"+total_attempted+"</td><td>"+score+"</td><td>"+Percentage+"</td><td>"+exam_status+"</td></tr>";
	
	
}
tbl=tbl+"</table>";
out.println(tbl);

%>

</body>
</html>