 <%@page import="support.*, java.util.*" %>
<html>
<title>
	Country of residence
</title>
<body>
	<%
		String firstName = request.getParameter("first");
		String middleInitial = request.getParameter("middle");
		String lastName = request.getParameter("last");
		String citizenship = request.getParameter("citizenship");
		
		session.setAttribute("citizenship",citizenship);
	%>
	
	First name: <%= firstName %>
	<br />    
	Middle initial: <%= middleInitial %>
	<br />    
	Last name: <%= lastName %>
	<br />  
	Country of citizenship: <%= citizenship %>
	<br />  
	
	WHERE DO YOU LIVE?
	
	<br />
	
	<a href="address.jsp?first=<%= firstName %>&middle=<%= middleInitial %>&last=<%= lastName %>&residence=<%= citizenship %>">Same country as citizenship</a>

	<table>
		<tr>
			<td>
			<%
				support s = new support();
				String path1 = config.getServletContext().getRealPath("countries.txt");
				Vector countries = s.getCountries(path1);
				String nextCountry = "";
				for (int i = 0; i < countries.size()/3; i++){
					nextCountry = (String) countries.elementAt(i);
			%>
				<a href="address.jsp?first=<%= firstName %>&middle=<%= middleInitial %>&last=<%= lastName %>&residence=<%= nextCountry %>"><%= nextCountry %></a>
				<br />
				
			<%
				}
			%>
			</td>
			<td>
			<%
				for (int i = countries.size()/3; i < (countries.size()*2)/3; i++){
					nextCountry = (String) countries.elementAt(i);
			%>
				<a href="address.jsp?first=<%= firstName %>&middle=<%= middleInitial %>&last=<%= lastName %>&residence=<%= nextCountry %>"><%= nextCountry %></a>
				<br />
				
			<%
				}
			%>	
			</td>
			<td>
			<%
				for (int i = (countries.size()*2)/3; i < countries.size(); i++){
					nextCountry = (String) countries.elementAt(i);
			%>
				<a href="address.jsp?first=<%= firstName %>&middle=<%= middleInitial %>&last=<%= lastName %>&residence=<%= nextCountry %>"><%= nextCountry %></a>
				<br />
				
			<%
				}
			%>	
			</td>
		</tr>
	</table>
               
</body>

</html>