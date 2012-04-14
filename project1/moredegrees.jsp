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
	</body>
</html>