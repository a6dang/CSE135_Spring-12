<%@page import=" Student.*, support.*, java.util.*" %>
<html>
	<head>
		<title>Specialization</title>
		<%
			Student theStudent = (Student) session.getAttribute("theStudent");
			int numDegrees = theStudent.numOfDegrees();
			
			Vector countries = (Vector) session.getAttribute("countries");
		%>
	</head>
	<body>
		<h2>Please choose a specialization from the dropdown menu:</h2>
		<br />
		<!-- Drop down menu for specializations. -->
		<form action="verification.jsp" method="POST" >
			<select name="specialization">
			<%
				support s = new support();
				String path1 = config.getServletContext().getRealPath("specializations.txt");
				Vector specs = s.getSpecializations(path1);
				session.setAttribute("specs",specs);
				
				String nextSpec = "";
				for (int i = 0; i < specs.size(); i++){
					nextSpec = (String) specs.elementAt(i);
			%>				
				<option value="<%= nextSpec %>"><%= nextSpec %></option>
			<%
				}
			%>
			</select>
			<input type="submit" value="Submit" />
		</form>
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
	</body>
</html>