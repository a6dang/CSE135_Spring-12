<%@page import=" Student.*, support.*, java.util.*" %>
<html>
<title>
	More Degrees
	<%
		String major = request.getParameter("major");
 
		HashMap<String,String> degreeInfo = (HashMap<String,String>) session.getAttribute("degreeInfo");
		degreeInfo.put("major",major);
	%>
</title>

<body>
	
	Is this the last degree?
	
	<form action="degreediscipline.jsp" method="POST">
		<input type="submit" value="Submit Next Degree" />
	</form>
	
	<form action="specializations.jsp" method="POST">
		<input type="submit" value="Done" />
	</form>
</body>

</html>