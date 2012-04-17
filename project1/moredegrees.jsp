<%@page import=" Student.*, support.*, java.util.*" %>
<html>
	<head>
		<title>More Degrees</title>
		<%
			Student theStudent = (Student) session.getAttribute("theStudent");
			int ctr = (Integer) session.getAttribute("ctr");
			
			String major = request.getParameter("major");
			String gpa = request.getParameter("GPA");
			String degreeLevel = request.getParameter("degLevel");
			String gradMonth = request.getParameter("gradMonth");
			String gradYear = request.getParameter("gradYear");
			
			theStudent.setDegreeInfo(ctr,"major",major);
			theStudent.setDegreeInfo(ctr,"gpa",gpa);
			theStudent.setDegreeInfo(ctr,"degreeLevel",degreeLevel);
			theStudent.setDegreeInfo(ctr,"gradMonth",gradMonth);
			theStudent.setDegreeInfo(ctr,"gradYear",gradYear);
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