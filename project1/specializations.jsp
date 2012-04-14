<%@page import=" Student.*, support.*, java.util.*" %>
<html>
	<head>
		<title>Specialization</title>
	</head>
	<body>
		
		<h2>Please choose a specialization from the dropdown menu:<h2>
		<br />
		
		<!-- Drop down menu for specializations. -->
		<form action="verification.jsp" method="POST" >
			<select name="specialization">
			<%
				support s = new support();
				String path1 = config.getServletContext().getRealPath("specializations.txt");
				Vector spec = s.getSpecializations(path1);
				String nextSpec = "";
				for (int i = 0; i < spec.size(); i++){
					nextSpec = (String) spec.elementAt(i);
			%>				
				<option value="<%= nextSpec %>"><%= nextSpec %></option>
			<%
				}
			%>
			</select>
			<input type="submit" value="Submit" />
		</form>
	</body>
</html>