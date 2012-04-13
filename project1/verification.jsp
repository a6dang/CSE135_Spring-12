<%@page import="support.*, java.util.*" %>
<html>
<title>
	Verification
</title>

<body>
	
	<%
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
	

</body>

</html>