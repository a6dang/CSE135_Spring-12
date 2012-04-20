<%@page import=" Student.*, Degree.*, support.*, java.util.*" %>
<html>
	<head>
		<title>More Degrees</title>
		<%
			Student theStudent = (Student) session.getAttribute("theStudent");
			Degree theDegree = (Degree) session.getAttribute("curDegree");
			Vector majors = (Vector) session.getAttribute("majors");
			
			// Temporary case to take care of empty major until JS validation added.
			String strDid = request.getParameter("major");
			int did = -1;
			if(strDid != null){
				did = Integer.parseInt(strDid);
			}
			
			
			String gpa = request.getParameter("GPA");
			String degreeLevel = request.getParameter("degLevel");
			String gradMonth = request.getParameter("gradMonth");
			String gradYear = request.getParameter("gradYear");

			if(did == -1){
				did = majors.size();
				String newMajor = request.getParameter("otherMajor");
				majors.add(newMajor);
			}
			
			theDegree.setDID(did);
			theDegree.setGPA(gpa);
			theDegree.setDegreeLevel(degreeLevel);
			theDegree.setGradMonth(gradMonth);
			theDegree.setGradYear(gradYear);
			
			theStudent.addDegree(theDegree);
			
			int numDegrees = theStudent.numOfDegrees();
			
			Vector countries = (Vector) session.getAttribute("countries");
			Vector uniLocs = (Vector) session.getAttribute("uniLocs");
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
		if (countries.get(theStudent.getRID()).equals("United States")){
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
		<br />
		<br />
		<br />
	</body>
</html>