 <%@page import="support.*, java.util.*" %>
<html>


<body>
	<%
		String firstName = request.getParameter("first");
		String middleInitial = request.getParameter("middle");
		String lastName = request.getParameter("last");
		
		if ( ((String) session.getAttribute("residence")).equals("United States")){
			String state = request.getParameter("state");
			session.setAttribute("state",state);
		} else {
			String telcode = request.getParameter("telcode");
			session.setAttribute("telcode",telcode);
		}
		String staddress = request.getParameter("staddress");
		String city = request.getParameter("city");
		String zip = request.getParameter("zip");
		String area = request.getParameter("area");
		String phone = request.getParameter("phone");

		session.setAttribute("staddress",staddress);
		session.setAttribute("city",city);
		session.setAttribute("zip",zip);
		session.setAttribute("area",area);
		session.setAttribute("phone",phone);
	%>
	
	Get rid of this later.
	First name: <%= firstName %>
	<br />    
	Middle initial: <%= middleInitial %>
	<br />    
	Last name: <%= lastName %>
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
					<a href="degreeuniversity.jsp?first=<%= firstName %>&middle=<%= middleInitial %>&last=<%= lastName %>&location=<%= nextUniversity %>&idx=<%= i %>"><%= nextUniversity %></a>
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
					<a href="degreeuniversity.jsp?first=<%= firstName %>&middle=<%= middleInitial %>&last=<%= lastName %>&location=<%= nextUniversity %>&idx=<%= i %>"><%= nextUniversity %></a>
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
					<a href="degreeuniversity.jsp?first=<%= firstName %>&middle=<%= middleInitial %>&last=<%= lastName %>&location=<%= nextUniversity %>&idx=<%= i %>"><%= nextUniversity %></a>
					<br />
				
			<%
				}
			%>	
			</td>
		</tr>
	</table>

               
</body>

</html>