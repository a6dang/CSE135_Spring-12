<%@page import=" Student.*, support.*, java.util.*" %>
<html>
	<head>
		<title>Provide Degrees - Choose University</title>
		<%	
			Student theStudent = (Student) session.getAttribute("theStudent");
			Integer ctr = (Integer) session.getAttribute("ctr"); 
			
			if( ctr == null){
				ctr = 0;
			} else {
				ctr++;	
			}
			
			String location = request.getParameter("location");
			int idx = Integer.parseInt(request.getParameter("idx"));
			session.setAttribute("ctr",ctr);
				
			if(theStudent.numOfDegrees() == ctr){
				theStudent.insertNewDegree();
			}
			theStudent.setDegreeInfo(ctr,"location",location);
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
			for(int i=0; i<=ctr; i++){
		%>
			<br />
			<b>Degree <%=i+1%></b>
			<br />
			<b>University:</b> <%=theStudent.getDegreeInfo(i,"university")%>
			<br />
			<b>Location:</b> <%=theStudent.getDegreeInfo(i,"location")%>
			<br />
			<b>Discipline:</b> <%=theStudent.getDegreeInfo(i,"major")%>
			<br />
			<b>GPA:</b> <%=theStudent.getDegreeInfo(i,"gpa")%>
			<br />
			<b>Degree Level:</b> <%=theStudent.getDegreeInfo(i,"degreeLevel")%>
			<br />
			<b>Graduation Date:</b> <%=theStudent.getDegreeInfo(i,"gradMonth")%> <%=theStudent.getDegreeInfo(i,"gradYear")%>
			<br /><br />
		<% 
			} 
		%>
		<br />		
	</body>
</html>