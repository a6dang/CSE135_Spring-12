<%@page import="support.*, java.util.*" %>
<html>


<body>
	
	<%
		String firstName = request.getParameter("first");
		String middleInitial = request.getParameter("middle");
		String lastName = request.getParameter("last");
		
		String major = request.getParameter("major");
 
		HashMap<String,String> degreeInfo = (HashMap<String,String>) session.getAttribute("degreeInfo");
		degreeInfo.put("major",major);
		
	%>
	
	Get rid of this later.
	First name: <%= firstName %>
	<br />    
	Middle initial: <%= middleInitial %>
	<br />    
	Last name: <%= lastName %>
	<br />  
	
	DO YOU HAVE ANY MORE DEGREES?
	
	<form action="degreediscipline.jsp" method="POST">
		<input type="hidden" name="first" value="<%= firstName %>" />
		<input type="hidden" name="middle" value="<%= middleInitial %>" />
		<input type="hidden" name="last" value="<%= lastName %>" />
		<input type="submit" value="Submit next degree" />
	</form>
	
	<form action="specializations.jsp" method="POST">
		<input type="hidden" name="first" value="<%= firstName %>" />
		<input type="hidden" name="middle" value="<%= middleInitial %>" />
		<input type="hidden" name="last" value="<%= lastName %>" />
		<input type="submit" value="Done" />
	</form>
</body>

</html>