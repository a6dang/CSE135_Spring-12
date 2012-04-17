<%@page import=" Student.*, support.*, java.util.*" %>
<html>
	<head>
		<title>Provide Degrees - Choose Locations</title>
		<%
			Student theStudent = (Student) session.getAttribute("theStudent");
			int numDegrees = theStudent.numOfDegrees();

			if(numDegrees == 0){
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
		if(numDegrees > 0){
			for(int i=0; i< numDegrees; i++){
		%>
			<br />
			<b>Degree <%=i+1%></b>
			<br />
			<b>University:</b> <% if(theStudent.getDegreeInfo(i,"university") != null) %> <%=theStudent.getDegreeInfo(i,"university")%>
			<br />
			<b>Location:</b> <% if(theStudent.getDegreeInfo(i,"location") != null) %> <%=theStudent.getDegreeInfo(i,"location")%>
			<br />
			<b>Discipline:</b> <% if(theStudent.getDegreeInfo(i,"major") != null) %> <%=theStudent.getDegreeInfo(i,"major")%>
			<br />
			<b>GPA:</b> <% if(theStudent.getDegreeInfo(i,"gpa") != null) %> <%=theStudent.getDegreeInfo(i,"gpa")%>
			<br />
			<b>Degree Level:</b> <% if(theStudent.getDegreeInfo(i,"degreeLevel") != null) %> <%=theStudent.getDegreeInfo(i,"degreeLevel")%>
			<br />
			<b>Graduation Date:</b> <% if(theStudent.getDegreeInfo(i,"gradMonth") != null) %> <%=theStudent.getDegreeInfo(i,"gradMonth")%> <% if(theStudent.getDegreeInfo(i,"gradYear") != null) %> <%=theStudent.getDegreeInfo(i,"gradYear")%>
			<br /><br />
		<% 
			} 
		}
		%>
		<br />
		<br />		
	</body>
</html>