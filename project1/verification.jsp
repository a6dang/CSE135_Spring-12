<%@page import=" Student.*, support.*, java.util.*" %>
<html>
<title>
	Verification
	
	<%
		Student theStudent = (Student) session.getAttribute("theStudent");
		
		String specialization = request.getParameter("specialization");
		HashMap<String,String> degreeInfo = (HashMap<String,String>) session.getAttribute("degreeInfo");
		degreeInfo.put("specialization",specialization);	
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
	<br />
	
	Need to do degree info
	<br />
	
	<form action="" method="POST" >
		<input type="submit" value="Submit" />
		<input type="submit" value="Cancel" />
	</form>
</body>

</html>