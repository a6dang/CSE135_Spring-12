<%@page import=" Student.*, support.*, java.util.*" %>
<html>
	<head>
		<title>Provide Degrees - Choose Discipline</title>
		<%	
			String university = request.getParameter("university");
	 
			int ctr = (Integer) session.getAttribute("ctr");

			Student theStudent = (Student) session.getAttribute("theStudent");
			theStudent.setDegreeInfo(ctr,"university",university);
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
			GPA: <input type="text" name="GPA" />
			<select name="degLevel">
				<option value="B.S.">B.S.</option>
				<option value="M.S.">M.S.</option>
				<option value="P.H.D">P.H.D</option>
			</select>
			<input type="submit" value="Submit" />
		</form>

		<!-- Other discipline not listed. -->
		<form action="moredegrees.jsp" method="POST">
			Other discipline: <input type="text" name="major" />
			GPA: <input type="text" name="GPA" />
			<select name="degLevel">
				<option value="B.S.">B.S.</option>
				<option value="M.S.">M.S.</option>
				<option value="P.H.D.">P.H.D</option>
			</select>
			<input type="submit" value="Submit" />
		</form>	   
	</body>
</html>