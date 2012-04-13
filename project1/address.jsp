<%@page import=" Student.*, support.*, java.util.*" %>
<html>
<title>
	Address
	<%
		String residence = request.getParameter("residence");
		
		Student theStudent = (Student) session.getAttribute("theStudent");
		theStudent.setResidence(residence);
	%>
</title>

<body>

	
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
	<br />
	<form action="degreelocation.jsp" method="POST">
		Street Address: <input type="text" name="staddress" size="25"/>
		<br />
		City: <input type="text" name="city" size="15"/>
		<br />
		<%
			if (theStudent.getResidence().equals("United States")){
		%>
			State: <input type="text" name="state" size="15"/>
		<%
			} else {
		%>
			Telephone code: <input type="text" name="telcode" size="15"/>
		<%
			}
		%>
		<br />
		Zip Code: <input type="text" name="zip" size="15"/>
		<br />
		Area Code: <input type="text" name="area" size="4"/>
		<br />
		Phone Number: <input type="text" name="phone" size="15"/>
		<br />	
		<input type="submit" value="Submit" />
	</form>
	  
</body>

</html>