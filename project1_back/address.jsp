 <%@page import="support.*, java.util.*" %>
<html>


<body>
	<%
		String firstName = request.getParameter("first");
		String middleInitial = request.getParameter("middle");
		String lastName = request.getParameter("last");
		String residence = request.getParameter("residence");
		
		String citizenship = (String) session.getAttribute("citizenship");
		session.setAttribute("residence",residence);
		
	%>
	
	First name: <%= firstName %>
	<br />    
	Middle initial: <%= middleInitial %>
	<br />    
	Last name: <%= lastName %>
	<br />  
	Country of citizenship: <%= citizenship %>
	<br />  
	Country of residence: <%= residence %>
	<br /> 
	<br />
	<form action="degreelocation.jsp" method="POST">
		Street Address: <input type="text" name="staddress" size="25"/>
		<br />
		City: <input type="text" name="city" size="15"/>
		<br />
		<%
			if (residence.equals("United States")){
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
		<input type="hidden" name="first" value="<%= firstName %>" />
		<input type="hidden" name="middle" value="<%= middleInitial %>" />
		<input type="hidden" name="last" value="<%= lastName %>" />		
		<input type="submit" value="Submit" />
	</form>
	  
</body>

</html>