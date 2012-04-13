<%@page import=" Student.*, support.*, java.util.*" %>
<html>
<title>
	Verification
	
	<%
		Student theStudent = (Student) session.getAttribute("theStudent");
		
		int ctr = (Integer) session.getAttribute("ctr");
		
		String specialization = request.getParameter("specialization");
		ArrayList<HashMap<String,String>> degrees = (ArrayList<HashMap<String,String>>) session.getAttribute("degrees");
		//<!-- only one specialization per student should be a field in the student class instead -->
		degrees.get(ctr).put("specialization",specialization);
	%>
</title>

<body>
	Verify that this information is correct:
	<br /><br />

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
	<b>State:</b> <%= theStudent.getLName() %>
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

	<% for(int i=0; i<=ctr; i++){
			HashMap<String,String> curDegree = degrees.get(i);
	%>
		<br />
		<b>Degree <%=i+1%></b>
		<br />
		<b>University:</b> <%=curDegree.get("university")%>
		<br />
		<b>Location:</b> <%=curDegree.get("location")%>
		<br />
		<b>Discipline:</b> <%=curDegree.get("major")%>
		<br />
		<b>GPA:</b> <%=curDegree.get("gpa")%>
		<br />
		<b>Degree Level:</b> <%=curDegree.get("degreeLevel")%>
		<br /><br />
	<% 
		} 
	%>
	<form action="" method="POST" >
		<input type="submit" value="Submit" />
		<input type="submit" value="Cancel" />
	</form>
</body>

</html>