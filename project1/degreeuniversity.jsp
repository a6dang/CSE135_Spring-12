 <%@page import="support.*, java.util.*" %>
<html>


<body>
	<%
		String firstName = request.getParameter("first");
		String middleInitial = request.getParameter("middle");
		String lastName = request.getParameter("last");
		
		String location = request.getParameter("location");
		int idx = Integer.parseInt(request.getParameter("idx"));
		session.setAttribute("location",location);
		
		
	%>
	
	Get rid of this later.
	First name: <%= firstName %>
	<br />    
	Middle initial: <%= middleInitial %>
	<br />    
	Last name: <%= lastName %>
	<br />  
	
	

	<table>
		<tr>
			<td>
			<%
				support s = new support();
				String path1 = config.getServletContext().getRealPath("universities.txt");
				Vector universities = s.getUniversities(path1);
				Vector listUnis = (Vector) ((Vector) universities.elementAt(idx)).elementAt(1);
				String nextUniversity = "";
				for (int i = 0; i < listUnis.size()/3; i++){
					nextUniversity = (String) listUnis.elementAt(i);
			%>
				<a href="degreediscipline.jsp?first=<%= firstName %>&middle=<%= middleInitial %>&last=<%= lastName %>&university=<%= nextUniversity %>"><%= nextUniversity %></a>
				<br />
				
				
			<%
				}
			%>
			
			</td>
			<td>
			<%
				for (int i = listUnis.size()/3; i < (listUnis.size()*2)/3; i++){
					nextUniversity = (String) listUnis.elementAt(i);
			%>
				<a href="degreediscipline.jsp?first=<%= firstName %>&middle=<%= middleInitial %>&last=<%= lastName %>&university=<%= nextUniversity %>"><%= nextUniversity %></a>
				<br />
				
			<%
				}
			%>	
			</td>
			<td>
			<%
				for (int i = (listUnis.size()*2)/3; i < listUnis.size(); i++){
					nextUniversity = (String) listUnis.elementAt(i);
			%>
				<a href="degreediscipline.jsp?first=<%= firstName %>&middle=<%= middleInitial %>&last=<%= lastName %>&university=<%= nextUniversity %>"><%= nextUniversity %></a>
				<br />
				
			<%
				}
			%>	
			</td>
		</tr>
	</table>

	<form action="degreediscipline.jsp" method="POST">
		University: <input type="text" name="university" />
		<input type="hidden" name="first" value="<%= firstName %>" />
		<input type="hidden" name="middle" value="<%= middleInitial %>" />
		<input type="hidden" name="last" value="<%= lastName %>" />		
		<input type="submit" value="Submit" />
	</form>
               
</body>

</html>