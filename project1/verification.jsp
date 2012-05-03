<%@page import=" Student.*, Degree.*, support.*, java.util.*" %>
<html>
	<head>
		<title>Verification</title>
		<%
			Student theStudent = (Student) session.getAttribute("theStudent");
			int numDegrees = theStudent.numOfDegrees();
			
			Vector specs = (Vector) session.getAttribute("specs");
			Vector countries = (Vector) session.getAttribute("countries");
			Vector majors = (Vector) session.getAttribute("majors");
			Vector uniLocs = (Vector) session.getAttribute("uniLocs");
			
			int sid = Integer.parseInt(request.getParameter("specialization"));
			
			theStudent.setSID(sid);
		%>
	</head>
	<body>
		<h2>Verify that this information is correct:</h2>
		<!-- Display user information. -->
		<h3>Student Information:</h3>
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
			<b>University:</b> <%= ((Vector) ((Vector) uniLocs.elementAt(curDegree.getLID())).elementAt(1)).elementAt(curDegree.getUID()) %>
			<br />
			<b>Location:</b> <%= ((Vector) uniLocs.get(curDegree.getLID())).elementAt(0)%>
			<br />
			<b>Discipline:</b> <%= majors.get(curDegree.getDID()) %>
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
		
		
		<b>Specialization:</b> <%= specs.get(theStudent.getSID()) %>
		<br /><br />
		
		<!-- Submit and Cancel buttons -->
		<form action="confirmation.jsp" method="POST" >
			<input type="submit" value="Submit" />
		</form>
		<form action="cancellation.jsp" method="POST" >
			<input type="submit" value="Cancel" />
		</form>
	</body>
</html>