<%@page import="support.*, java.util.*" %>
<html>


<body>
	<%
		String firstName = request.getParameter("first");
		String middleInitial = request.getParameter("middle");
		String lastName = request.getParameter("last");
		
		String university = request.getParameter("university");
 
		HashMap<String,String> degreeInfo = (HashMap<String,String>) session.getAttribute("degreeInfo");
		degreeInfo.put("university",university);
		
	%>
	
	Get rid of this later.
	First name: <%= firstName %>
	<br />    
	Middle initial: <%= middleInitial %>
	<br />    
	Last name: <%= lastName %>
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
			
		<input type="hidden" name="first" value="<%= firstName %>" />
		<input type="hidden" name="middle" value="<%= middleInitial %>" />
		<input type="hidden" name="last" value="<%= lastName %>" />
		<input type="submit" value="Submit" />
	</form>
	
	<form action="moredegrees.jsp" method="POST">
		University: <input type="text" name="university" />	
		<input type="hidden" name="first" value="<%= firstName %>" />
		<input type="hidden" name="middle" value="<%= middleInitial %>" />
		<input type="hidden" name="last" value="<%= lastName %>" />
		<input type="submit" value="Submit" />
	</form>
               
</body>

</html>