<%@page import=" Student.*, support.*, java.util.*" %>
<html>
<title>
	More Degrees
	<%
		String major = request.getParameter("major");
		String gpa = request.getParameter("GPA");
		String degreeLevel = request.getParameter("degreeLevel");
		
		int ctr = (Integer) session.getAttribute("ctr");
		ArrayList<HashMap<String,String>> degrees = (ArrayList<HashMap<String,String>>) session.getAttribute("degrees");
		degrees.get(ctr).put("major",major);
		degrees.get(ctr).put("gpa",gpa);
		degrees.get(ctr).put("degreeLevel",degreeLevel);
	%>
</title>

<body>
	
	Is this the last degree?
	
	<form action="degreelocation.jsp" method="POST">
		<input type="submit" value="Submit Next Degree" />
	</form>
	
	<form action="specializations.jsp" method="POST">
		<input type="submit" value="Done" />
	</form>
</body>

</html>