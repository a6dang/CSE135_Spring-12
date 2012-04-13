<%@page import=" Student.*, support.*, java.util.*" %>
<html>
<title>
	Country of Citizenship
	<%
		String firstName = request.getParameter("first");
		String middleInitial = request.getParameter("middle");
		String lastName = request.getParameter("last");
		
		Student theStudent = new Student();
		theStudent.setFName(firstName);
		theStudent.setMidInitial(middleInitial);
		theStudent.setLName(lastName);
		
		session.setAttribute("theStudent",theStudent);
	%>
</title>
<body>
	First name: <%= theStudent.getFName() %>
	<br />    
	Middle initial: <%= theStudent.getMidInitial() %>
	<br />    
	Last name: <%= theStudent.getLName() %>

	<br />  
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
				<a href="residence.jsp?citizenship=<%= nextCountry %>"><%= nextCountry %></a>
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
				<a href="residence.jsp?citizenship=<%= nextCountry %>"><%= nextCountry %></a>
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
				<a href="residence.jsp?citizenship=<%= nextCountry %>"><%= nextCountry %></a>
				<br />
				
			<%
				}
			%>	
			</td>
		</tr>
	</table>
               
</body>

</html>