<%@page import=" Student.*, support.*, java.util.*" %>
<html>
<title>
	Country of Residence
	
	<%
		String citizenship = request.getParameter("citizenship");
		
		Student theStudent = (Student) session.getAttribute("theStudent");
		theStudent.setCitizenship(citizenship);
	%>
</title>

<body>
	First name: <%= theStudent.getFName() %>
	<br />    
	Middle initial: <%= theStudent.getMidInitial() %>
	<br />    
	Last name: <%= theStudent.getLName() %>
	<br />  
	Country of citizenship: <%= theStudent.getCitizenship() %>
	<br />  
	
	WHERE DO YOU LIVE?
	
	<br />
	
	<a href="address.jsp?residence=<%= theStudent.getCitizenship() %>">Same country as citizenship</a>

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
				<a href="address.jsp?residence=<%= nextCountry %>"><%= nextCountry %></a>
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
				<a href="address.jsp?residence=<%= nextCountry %>"><%= nextCountry %></a>
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
				<a href="address.jsp?residence=<%= nextCountry %>"><%= nextCountry %></a>
				<br />
				
			<%
				}
			%>	
			</td>
		</tr>
	</table>
               
</body>

</html>