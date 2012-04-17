<%@page import=" Student.*, support.*, java.util.*" %>
<html>
	<head>
		<title>Provide Degrees - Choose Discipline</title>
		<%	
			String university = request.getParameter("university");
	 
			Student theStudent = (Student) session.getAttribute("theStudent");
			int numDegrees = theStudent.numOfDegrees();
			theStudent.setDegreeInfo(numDegrees-1,"university",university);
		%>
	</head>
	<body>
		<h2>Choose a displicine below or enter one if yours is not listed:</h2>
		<br />
		
		<!-- Radio buttons for disciplines. -->
		<form action="moredegrees.jsp" method="POST">
			<%
				support s = new support();
				String path1 = config.getServletContext().getRealPath("majors.txt");
				Vector majors = s.getMajors(path1);
				String nextMajor = "";
				for (int i = 0; i < majors.size(); i++){
					nextMajor = (String) majors.elementAt(i);
			%>				
				<input type="radio" name="major" value="<%= nextMajor %>"/> <%= nextMajor %> <br />				
			<%
				}
			%>
			<br />
			Other discipline: <input type="text" name="major" />
			<br />
			Graduation date: <input type="text" name="gradMonth" value="month" size="10" /> 
			<input type="text" name="gradYear" value="year" size="4" />
			<br />
			GPA: <input type="text" name="GPA" size="5" />
			<select name="degLevel">
				<option value="B.S.">B.S.</option>
				<option value="M.S.">M.S.</option>
				<option value="P.H.D">P.H.D</option>
			</select>
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
			for(int i=0; i < numDegrees; i++){
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