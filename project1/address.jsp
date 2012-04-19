<%@page import=" Student.*, support.*, java.util.*" %>
<html>
	<head>
	<title>Address</title>
		<%
			int residenceID = Integer.parseInt(request.getParameter("rid"));
			
			Student theStudent = (Student) session.getAttribute("theStudent");
			theStudent.setRID(residenceID);
			
			Vector countries = (Vector) session.getAttribute("countries");
		%>
	</head>
	<body>
		<h2>Address:</h2>
		<!-- Address form. -->
		<form action="degreelocation.jsp" method="POST">
			Street Address: <input type="text" name="staddress" size="25"/>
			<br />
			City: <input type="text" name="city" size="15"/>
			<br />
			<%
				if (countries.get(theStudent.getRID()).equals("United States")){
			%>
				State: <input type="text" name="state" size="15"/>
			<%
				} else {
			%>
				Telephone code: <input type="text" name="telcode" size="3"/>
			<%
				}
			%>
			<br />
			Zip Code: <input type="text" name="zip" size="8"/>
			<br />
			Area Code: <input type="text" name="area" size="4"/>
			<br />
			Phone Number: <input type="text" name="phone" size="15"/>
			<br />	
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
		<br />
	</body>
</html>