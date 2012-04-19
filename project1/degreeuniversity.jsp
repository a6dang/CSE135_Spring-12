<%@page import=" Student.*, Degree.*, support.*, java.util.*" %>
<html>
	<head>
		<title>Provide Degrees - Choose University</title>
		<%	
			Student theStudent = (Student) session.getAttribute("theStudent");
			Degree theDegree = new Degree();
			
			int lid = Integer.parseInt(request.getParameter("lid"));
			
			theDegree.setLID(lid);
			
			session.setAttribute("curDegree", theDegree);
			
			int numDegrees = theStudent.numOfDegrees();
			
			Vector uniLocs = (Vector) session.getAttribute("uniLocs");
			Vector countries = (Vector) session.getAttribute("countries");
			Vector listUnis = (Vector) ((Vector) uniLocs.elementAt(lid)).elementAt(1);
		%>
	</head>
	<body>
		<h2>Select the university that you attended or enter one if the one you attended is not present:</h2>
		<br />
		
		<!-- Show all universities per location chosen. -->
		<table border="1">
			<tr>
				<td>
				<%
					
					String nextUniversity = "";
					for (int i = 0; i < listUnis.size()/3; i++){
						nextUniversity = (String) listUnis.elementAt(i);
				%>
					<a href="degreediscipline.jsp?university=<%= nextUniversity %>&uid=<%=i%>"><%= nextUniversity %></a>
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
					<a href="degreediscipline.jsp?university=<%= nextUniversity %>&uid=<%=i%>"><%= nextUniversity %></a>
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
					<a href="degreediscipline.jsp?university=<%= nextUniversity %>&uid=<%=i%>"><%= nextUniversity %></a>
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
			<input type="hidden" name="uid" value="<%=listUnis.size()%>" />
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
		Country of citizenship: <%= countries.get(theStudent.getCID()) %>
		<br />  
		Country of residence: <%= countries.get(theStudent.getRID()) %>
		<br />  
		Street Address: <%= theStudent.getStAddress() %>
		<br />  
		City: <%= theStudent.getCity() %>
		<br />  
		<%
		if ( countries.get(theStudent.getRID()).equals("United States")){
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
		
		<br />		
	</body>
</html>