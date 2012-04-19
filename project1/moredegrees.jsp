<%@page import=" Student.*, Degree.*, support.*, java.util.*" %>
<html>
	<head>
		<title>More Degrees</title>
		<%
			Student theStudent = (Student) session.getAttribute("theStudent");
			Degree theDegree = (Degree) session.getAttribute("curDegree");
			Vector majors = (Vector) session.getAttribute("majors");
			
			String major = request.getParameter("major");
			String gpa = request.getParameter("GPA");
			String degreeLevel = request.getParameter("degLevel");
			String gradMonth = request.getParameter("gradMonth");
			String gradYear = request.getParameter("gradYear");
			
			int did = majors.indexOf(major);
			if(did == -1){
				did = majors.size();
				majors.add(major);
			}
			
			theDegree.setDID(did);
			theDegree.setMajor(major);
			theDegree.setGPA(gpa);
			theDegree.setDegreeLevel(degreeLevel);
			theDegree.setGradMonth(gradMonth);
			theDegree.setGradYear(gradYear);
			
			theStudent.addDegree(theDegree);
			
			int numDegrees = theStudent.numOfDegrees();
			
			Vector countries = (Vector) session.getAttribute("countries");
		%>
	</head>
	<body>
		<h2>Is this the last degree?</h2>

		<!-- Submit next degree button. -->
		<form action="degreelocation.jsp" method="POST">
			<input type="submit" value="Submit Next Degree" />
		</form>
		<br />
		<!-- Done button. -->
		<form action="specializations.jsp" method="POST">
			<input type="submit" value="Done" />
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
		<!--

		-->
		<br />
	</body>
</html>