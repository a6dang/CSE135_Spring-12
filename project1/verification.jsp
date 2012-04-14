<%@page import=" Student.*, support.*, java.util.*" %>
<html>
	<head>
		<title>Verification</title>
		<%
			Student theStudent = (Student) session.getAttribute("theStudent");
			
			int ctr = (Integer) session.getAttribute("ctr");
			
			String specialization = request.getParameter("specialization");
			theStudent.setSpecialization(specialization);
		%>
	</head>
	<body>
		<h2>Verify that this information is correct:</h2>
		<br /><br />
		<!-- Display user information. -->
		<b>First name:</b> <%= theStudent.getFName() %>
		<br />
		<b>Middle initial:</b> <%= theStudent.getMidInitial() %>
		<br />
		<b>Last name:</b> <%= theStudent.getLName() %>
		<br />
		<b>Country of Residence:</b> <%= theStudent.getResidence() %>
		<br />
		<b>Country of Citizenship:</b> <%= theStudent.getCitizenship() %>
		<br />
		<b>Street Address:</b> <%= theStudent.getStAddress() %>
		<br />
		<b>City:</b> <%= theStudent.getCity() %>
		<br />
		<% if(theStudent.getResidence().equals("United States")){ %>
		<b>State:</b> <%= theStudent.getState() %>
		<% }else{ %>
		<b>Telephone Code:</b> <%= theStudent.getTelephoneCode() %>
		<% } %>
		<br />
		<b>Zip Code:</b> <%= theStudent.getZipCode() %>
		<br />
		<b>Area Code:</b> <%= theStudent.getAreaCode() %>
		<br />
		<b>Phone Number:</b> <%= theStudent.getPhoneNumber() %>
		<br /><br />
		
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
			<br /><br />
		<% 
			} 
		%>

		<b>Specialization:</b> <%= theStudent.getSpecialization() %>
		<br /><br />
		
		<!-- Submit and Cancel buttons -->
		<form action="" method="POST" >
			<input type="submit" value="Submit" />
			<input type="submit" value="Cancel" />
		</form>
	</body>
</html>