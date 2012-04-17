<%@page import=" Student.*, support.*, java.util.*" %>
<html>
	<head>
		<title>Provide Degrees - Choose Locations</title>
		<%
			Student theStudent = (Student) session.getAttribute("theStudent");
			
			if(session.getAttribute("ctr")== null){
			
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
			}
		%>
	</head>
	<body>
		<h2>Choose the country or U.S. state where you attained your degree:</h2>
		
		<br />
		
		<!-- Show all U.S. states and foreign countries. -->
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
		if(session.getAttribute("ctr")!= null){
			int ctr = (Integer) session.getAttribute("ctr");
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
		}
		%>
		<br />
		<br />		
	</body>
</html>