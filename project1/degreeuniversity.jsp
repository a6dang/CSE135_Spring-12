<%@page import=" Student.*, support.*, java.util.*" %>
<html>
	<head>
		<title>Provide Degrees - Choose University</title>
		<%	
			Student theStudent = (Student) session.getAttribute("theStudent");
			theStudent.insertNewDegree();
			int numDegrees = theStudent.numOfDegrees();

			String location = request.getParameter("location");
			int idx = Integer.parseInt(request.getParameter("idx"));

			theStudent.setDegreeInfo(numDegrees-1,"location",location);
		%>
	</head>
	<body>
		<h2>Select the university that you attended or enter one if the one you attended is not present:</h2>
		<br />
		
		<!-- Show all universities per location chosen. -->
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
					<a href="degreediscipline.jsp?university=<%= nextUniversity %>"><%= nextUniversity %></a>
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
					<a href="degreediscipline.jsp?university=<%= nextUniversity %>"><%= nextUniversity %></a>
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
					<a href="degreediscipline.jsp?university=<%= nextUniversity %>"><%= nextUniversity %></a>
					<br />
				<%
					}
				%>	
				</td>
			</tr>
		</table>
		<br />
		
		<!-- Other university not listed. -->
		<form action="degreediscipline.jsp" method="POST">
			Other University: <input type="text" name="university" />	
			<input type="submit" value="Submit" />
		</form>	  
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
		Country of residence: <%= theStudent.getResidence() %>
		<br />  
		Street Address: <%= theStudent.getStAddress() %>
		<br />  
		City: <%= theStudent.getCity() %>
		<br />  
		<%
		if ( theStudent.getResidence().equals("United States")){
		%>
			State: <%= theStudent.getState() %>
		<%
		} else {
		%>
			Telephone Code: <%= theStudent.getTelephoneCode() %>
		<%
		}
		%>
		<br />
		Zip Code: <%= theStudent.getZipCode() %>
		<br />  
		Area Code: <%= theStudent.getAreaCode() %>
		<br />  
		Phone Number: <%= theStudent.getPhoneNumber() %>
		<br />
		<% 
			for(int i=0; i<numDegrees; i++){
		%>
		<br />
			<b>Degree <%=i+1%></b>
			<br />
			<b>University:</b> <% if(theStudent.getDegreeInfo(i,"university") != null){ %> <%=theStudent.getDegreeInfo(i,"university")%> <% } %>
			<br />
			<b>Location:</b> <% if(theStudent.getDegreeInfo(i,"location") != null){ %> <%=theStudent.getDegreeInfo(i,"location")%> <% } %>
			<br />
			<b>Discipline:</b> <% if(theStudent.getDegreeInfo(i,"major") != null){ %> <%=theStudent.getDegreeInfo(i,"major")%> <% } %>
			<br />
			<b>GPA:</b> <% if(theStudent.getDegreeInfo(i,"gpa") != null){ %> <%=theStudent.getDegreeInfo(i,"gpa")%> <% } %>
			<br />
			<b>Degree Level:</b> <% if(theStudent.getDegreeInfo(i,"degreeLevel") != null){ %> <%=theStudent.getDegreeInfo(i,"degreeLevel")%> <% } %>
			<br />
			<b>Graduation Date:</b> <% if(theStudent.getDegreeInfo(i,"gradMonth") != null){ %> <%=theStudent.getDegreeInfo(i,"gradMonth")%> <% } %> <% if(theStudent.getDegreeInfo(i,"gradYear") != null){ %> <%=theStudent.getDegreeInfo(i,"gradYear")%> <% } %>
			<br /><br />
		<% 
			} 
		%>
		<br />		
	</body>
</html>