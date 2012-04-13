<%@page import="support.*, java.util.*" %>
<html>


<body>
	
	<%
		String firstName = request.getParameter("first");
		String middleInitial = request.getParameter("middle");
		String lastName = request.getParameter("last");
		
		String specialization = request.getParameter("specialization");
		HashMap<String,String> degreeInfo = (HashMap<String,String>) session.getAttribute("degreeInfo");
		degreeInfo.put("specialization",specialization);
		
	%>
	
	First name: <%= firstName %>
	<br />    
	Middle initial: <%= middleInitial %>
	<br />    
	Last name: <%= lastName %>
	<br />
	
	Degree Info:
	<br />
	
	

</body>

</html>