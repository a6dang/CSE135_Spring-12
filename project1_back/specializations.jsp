<%@page import="support.*, java.util.*" %>
<html>


<body>
	
	<%
		String firstName = request.getParameter("first");
		String middleInitial = request.getParameter("middle");
		String lastName = request.getParameter("last");
	%>
	
	Get rid of this later.
	First name: <%= firstName %>
	<br />    
	Middle initial: <%= middleInitial %>
	<br />    
	Last name: <%= lastName %>
	<br />  
	
	<form action="verification.jsp" method="POST" >
		<select name="specialization">
		<%
			support s = new support();
			String path1 = config.getServletContext().getRealPath("specializations.txt");
			Vector spec = s.getSpecializations(path1);
			String nextSpec = "";
			for (int i = 0; i < spec.size(); i++){
				nextSpec = (String) spec.elementAt(i);
		%>				
			<option value="<%= nextSpec %>"><%= nextSpec %></option>
		<%
			}
		%>
		</select>
		<input type="hidden" name="first" value="<%= firstName %>" />
		<input type="hidden" name="middle" value="<%= middleInitial %>" />
		<input type="hidden" name="last" value="<%= lastName %>" />
		<input type="submit" value="Submit" />
	</form>
</body>

</html>