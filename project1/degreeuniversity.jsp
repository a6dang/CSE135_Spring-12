<%@page import=" Student.*, support.*, java.util.*" %>
<html>
	<head>
		<title>Provide Degrees - Choose University</title>
		<%	
			Student theStudent = (Student) session.getAttribute("theStudent");
			Integer ctr = (Integer) session.getAttribute("ctr"); 
			
			if( ctr == null){
				ctr = 0;
			} else {
				ctr++;	
			}
			
			String location = request.getParameter("location");
			int idx = Integer.parseInt(request.getParameter("idx"));
			session.setAttribute("ctr",ctr);
				
			if(theStudent.numOfDegrees() == ctr){
				theStudent.insertNewDegree();
			}
			theStudent.setDegreeInfo(ctr,"location",location);
		%>
	</head>
	<body>
		<h2>Select the university that you attended or enter one if the one you attended is not present:</h2>
		<br />
		
		<!-- Show all universities per location chosen. -->
		<table>
			<tr>
				<td>
				<%
					support s = new support();
					String path1 = config.getServletContext().getRealPath("universities.txt");
					Vector universities = s.getUniversities(path1);
					Vector listUnis = (Vector) ((Vector) universities.elementAt(idx)).elementAt(1);
					String nextUniversity = "";
					for (int i = 0; i < listUnis.size()/3; i++){
						nextUniversity = (String) listUnis.elementAt(i);
				%>
					<a href="degreediscipline.jsp?university=<%= nextUniversity %>"><%= nextUniversity %></a>
					<br />	
				<%
					}
				%>
				
				</td>
				<td>
				<%
					for (int i = listUnis.size()/3; i < (listUnis.size()*2)/3; i++){
						nextUniversity = (String) listUnis.elementAt(i);
				%>
					<a href="degreediscipline.jsp?university=<%= nextUniversity %>"><%= nextUniversity %></a>
					<br />
				<%
					}
				%>	
				</td>
				<td>
				<%
					for (int i = (listUnis.size()*2)/3; i < listUnis.size(); i++){
						nextUniversity = (String) listUnis.elementAt(i);
				%>
					<a href="degreediscipline.jsp?university=<%= nextUniversity %>"><%= nextUniversity %></a>
					<br />
				<%
					}
				%>	
				</td>
			</tr>
		</table>
		<br />
		
		<!-- Other university not listed. -->
		<form action="degreediscipline.jsp" method="POST">
			Other University: <input type="text" name="university" />	
			<input type="submit" value="Submit" />
		</form>	   
	</body>
</html>