<%@page import=" Student.*, support.*, java.util.*" %>
<html>
<title>
	Providing Degrees - Choose Discipline
	<%	
		String university = request.getParameter("university");
 
		HashMap<String,String> degreeInfo = (HashMap<String,String>) session.getAttribute("degreeInfo");
		degreeInfo.put("university",university);
		
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
		
		<input type="submit" value="Submit" />
	</form>
	
	<form action="moredegrees.jsp" method="POST">
		Other discipline: <input type="text" name="major" />	
		<input type="submit" value="Submit" />
	</form>
               
</body>

</html>