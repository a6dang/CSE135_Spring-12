<%@page import=" Student.*, support.*, java.util.*" %>
<html>
<title>
	Providing Degrees - Choose Locations
	<%
		Student theStudent = (Student) session.getAttribute("theStudent");
		
		if ( theStudent.getResidence().equals("United States")){
			String state = request.getParameter("state");
			theStudent.setState(state);
		} else {
			String telcode = request.getParameter("telcode");
			theStudent.setTelephoneCode(telcode);
		}
		String staddress = request.getParameter("staddress");
		String city = request.getParameter("city");
		String zip = request.getParameter("zip");
		String area = request.getParameter("area");
		String phone = request.getParameter("phone");

		theStudent.setStAddress(staddress);
		theStudent.setCity(city);
		theStudent.setZipCode(zip);
		theStudent.setAreaCode(area);
		theStudent.setPhoneNumber(phone);
	%>
</title>

<body>
	
	Choose the country or U.S. state where you attained your degree:
	<br />
	
	<table>
		<tr>
			<td>
			<%
				support s = new support();
				String path1 = config.getServletContext().getRealPath("universities.txt");
				Vector universities = s.getUniversities(path1);
				String nextUniversity = "";
				for (int i = 0; i < universities.size()/3; i++){
					nextUniversity = (String) ((Vector) universities.elementAt(i)).elementAt(0);
			%>
					<a href="degreeuniversity.jsp?location=<%= nextUniversity %>&idx=<%= i %>"><%= nextUniversity %></a>
					<br />
			<%
				}
			%>
			</td>
			<td>
			<%
				for (int i = universities.size()/3; i < (universities.size()*2)/3; i++){
					nextUniversity = (String) ((Vector) universities.elementAt(i)).elementAt(0);
			%>
					<a href="degreeuniversity.jsp?location=<%= nextUniversity %>&idx=<%= i %>"><%= nextUniversity %></a>
					<br />		
			<%
				}
			%>	
			</td>
			<td>
			<%
				for (int i = (universities.size()*2)/3; i < universities.size(); i++){
					nextUniversity = (String) ((Vector) universities.elementAt(i)).elementAt(0);
			%>
					<a href="degreeuniversity.jsp?location=<%= nextUniversity %>&idx=<%= i %>"><%= nextUniversity %></a>
					<br />
			<%
				}
			%>	
			</td>
		</tr>
	</table>

               
</body>

</html>