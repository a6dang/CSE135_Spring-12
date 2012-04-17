<%@page import=" Student.*, support.*, java.util.*" %>
<html>
	<head>
		<title>Country of Citizenship</title>
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
	</head>

	<body>
		<h3>Student Information:</h3>
		<!-- Show information so far. -->
		First name: <%= theStudent.getFName() %>
		<br />    
		Middle initial: <%= theStudent.getMidInitial() %>
		<br />    
		Last name: <%= theStudent.getLName() %>

		<br />  
		<h2>Country of Citizenship:</h2>
		<!-- List all countries. -->
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