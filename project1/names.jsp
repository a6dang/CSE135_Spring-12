 <%@page import="java.util.*" %>
<html>
<title>
	Names
</title>
<body>


	<form action="citizenship.jsp" method="POST">
		<%-- Get the first name --%>
		First name: <input type="text" name="first" size="15"/>
        <br />       

        <%-- Get the middle name --%>
		Middle initial: <input type="text" name="middle" size="15"/>
        <br />       

        <%-- Get the last name --%>               
		Last name: <input type="text" name="last" size="15"/>
		<br />
		<input type="submit" value="Submit" />
	</form>
               
</body>

</html>