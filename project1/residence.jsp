<%@page import=" Student.*, support.*, java.util.*" %>
<html>
	<head>
		<title>Country of Residence</title>
		<%
			String citizenship = request.getParameter("citizenship");
			
			Student theStudent = (Student) session.getAttribute("theStudent");
			theStudent.setCitizenship(citizenship);
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
		Country of citizenship: <%= theStudent.getCitizenship() %>
		<br />  
		
		
		
		<br />
		<h2>Country of Residence:</h2>
		<a href="address.jsp?residence=<%= theStudent.getCitizenship() %>">Same country as citizenship</a>
	
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