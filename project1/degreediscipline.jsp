<%@page import=" Student.*, support.*, java.util.*" %>
<html>
<title>
	Providing Degrees - Choose Discipline
	<%	
		String university = request.getParameter("university");
 
		int ctr = (Integer) session.getAttribute("ctr");
		ArrayList<HashMap<String,String>> degrees = (ArrayList<HashMap<String,String>>) session.getAttribute("degrees");
		
		degrees.get(ctr).put("university",university);		
	%>
</title>

<body>
	
	Choose a displicine below or enter one if yours is not listed:
	<br />
	
	<form action="moredegrees.jsp" method="POST">
		<%
			support s = new support();
			String path1 = config.getServletContext().getRealPath("majors.txt");
			Vector majors = s.getMajors(path1);
			String nextMajor = "";
			for (int i = 0; i < majors.size(); i++){
				nextMajor = (String) majors.elementAt(i);
		%>				
			<input type="radio" name="major" value=<%= nextMajor %>/> <%= nextMajor %> <br />				
		<%
			}
		%>
		<br />
		GPA: <input type="text" name="GPA" />
		<select name="degLevel">
			<option value="degreeLevel">B.S.</option>
			<option value="degreeLevel">M.S.</option>
			<option value="degreeLevel">P.H.D</option>
		</select>
		<input type="submit" value="Submit" />
	</form>
	
	<form action="moredegrees.jsp" method="POST">
		Other discipline: <input type="text" name="major" />
		GPA: <input type="text" name="GPA" />
		<select name="degLevel">
			<option value="degreeLevel">B.S.</option>
			<option value="degreeLevel">M.S.</option>
			<option value="degreeLevel">P.H.D</option>
		</select>
		<input type="submit" value="Submit" />
	</form>
               
</body>

</html>