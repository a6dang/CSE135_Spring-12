<%@page import=" Student.*, Degree.*, support.*, java.util.*" %>
<html>
	<head>
		<title>Verification</title>
		<%
			Student theStudent = (Student) session.getAttribute("theStudent");
			int numDegrees = theStudent.numOfDegrees();
			
			Vector specs = (Vector) session.getAttribute("specs");
			Vector countries = (Vector) session.getAttribute("countries");
			
			String specialization = request.getParameter("specialization");
			
			theStudent.setSID(specs.indexOf("specialization"));
			theStudent.setSpecialization(specialization);
			
		%>
	</head>
	<body>
		<h2>Verify that this information is correct:</h2>
		<br /><br />
		<!-- Display user information. -->
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
		<br /><br />

		
		<% 
			for(int i=0; i<numDegrees; i++){
			Degree curDegree = theStudent.getDegree(i);
		%>
			<br />
			<b>Degree <%=i+1%></b>
			<br />
			<b>University:</b> <%= curDegree.getUniversity() %>
			<br />
			<b>Location:</b> <%= curDegree.getLocation() %>
			<br />
			<b>Discipline:</b> <%= curDegree.getMajor() %>
			<br />
			<b>GPA:</b> <%= curDegree.getGPA() %>
			<br />
			<b>Degree Level:</b> <%= curDegree.getDegreeLevel() %>
			<br />
			<b>Graduation Date:</b> <%= curDegree.getGradMonth() %> <%= curDegree.getGradYear() %>
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