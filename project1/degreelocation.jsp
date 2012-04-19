<%@page import=" Student.*, Degree.*, support.*, java.util.*" %>
<html>
	<head>
		<title>Provide Degrees - Choose Locations</title>
		<%
			Vector countries = (Vector) session.getAttribute("countries");
			Student theStudent = (Student) session.getAttribute("theStudent");
			int numDegrees = theStudent.numOfDegrees();

			if(numDegrees == 0){
				if (countries.get(theStudent.getRID()).equals("United States")){
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
			
			Vector uniLocs = (Vector) session.getAttribute("uniLocs");
			
			if(uniLocs == null){
				support s = new support();
				String path1 = config.getServletContext().getRealPath("universities.txt");
				uniLocs = s.getUniversities(path1);	
				session.setAttribute("uniLocs", uniLocs);
			}
		%>
	</head>
	<body>
		<h2>Choose the country or U.S. state where you attained your degree:</h2>
		
		<br />
		
		<!-- Show all U.S. states and foreign countries. -->
		<table border="1">
			<tr>
				<td>
				<%	
					String nextLoc = "";
					for (int i = 0; i < uniLocs.size()/3; i++){
						nextLoc = (String) ((Vector) uniLocs.elementAt(i)).elementAt(0);
				%>
						<a href="degreeuniversity.jsp?lid=<%= i %>"><%= nextLoc %></a>
						<br />
				<%
					}
				%>
				</td>
				<td>
				<%
					for (int i = uniLocs.size()/3; i < (uniLocs.size()*2)/3; i++){
						nextLoc = (String) ((Vector) uniLocs.elementAt(i)).elementAt(0);
				%>
						<a href="degreeuniversity.jsp?lid=<%= i %>"><%= nextLoc %></a>
						<br />		
				<%
					}
				%>	
				</td>
				<td>
				<%
					for (int i = (uniLocs.size()*2)/3; i < uniLocs.size(); i++){
						nextLoc = (String) ((Vector) uniLocs.elementAt(i)).elementAt(0);
				%>
						<a href="degreeuniversity.jsp?lid=<%= i %>"><%= nextLoc %></a>
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
		Country of citizenship: <%= countries.get(theStudent.getCID()) %>
		<br />  
		Country of residence: <%= countries.get(theStudent.getRID()) %>
		<br />  
		Street Address: <%= theStudent.getStAddress() %>
		<br />  
		City: <%= theStudent.getCity() %>
		<br />  
		<%
		if ( countries.get(theStudent.getRID()).equals("United States")){
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

		<br />
		<br />		
	</body>
</html>