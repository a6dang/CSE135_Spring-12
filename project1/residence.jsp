<%@page import=" Student.*, support.*, java.util.*" %>
<html>
	<head>
		<title>Country of Residence</title>
		<%
			String citizenship = request.getParameter("citizenship");
			int citizenID = Integer.parseInt(request.getParameter("cid"));
			
			Student theStudent = (Student) session.getAttribute("theStudent");
			theStudent.setCitizenship(citizenship);
			theStudent.setCID(citizenID);
			
			Vector countries = (Vector) session.getAttribute("countries");
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
		Country of citizenship: <%= countries.get(theStudent.getCID()) %>
		<br />  
		<br />
		<h2>Country of Residence:</h2>
		<a href="address.jsp?residence=<%= countries.get(theStudent.getCID()) %>&rid=<%=citizenID%>">Same country as citizenship</a>
	
		<!-- List all countries. -->
		<table border="1">
			<tr>
				<td>
				<%
					String nextCountry = "";
					for (int i = 0; i < countries.size()/3; i++){
						nextCountry = (String) countries.elementAt(i);
				%>
					<a href="address.jsp?residence=<%= nextCountry %>&rid=<%=i%>"><%= nextCountry %></a>
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
					<a href="address.jsp?residence=<%= nextCountry %>&rid=<%=i%>"><%= nextCountry %></a>
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
					<a href="address.jsp?residence=<%= nextCountry %>&rid=<%=i%>"><%= nextCountry %></a>
					<br />
					
				<%
					}
				%>	
				</td>
			</tr>
		</table>	   
	</body>
</html>