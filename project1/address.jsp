<%@page import=" Student.*, support.*, java.util.*" %>
<html>
	<head>
	<title>Address</title>
		<%
			int residenceID = Integer.parseInt(request.getParameter("rid"));
			
			Student theStudent = (Student) session.getAttribute("theStudent");
			theStudent.setRID(residenceID);
			
			int citizenshipID = theStudent.getCID();
			
			//Vector countries = (Vector) session.getAttribute("countries");
		%>
	</head>
	<body>
		<%@ page import="java.sql.*"%>
		<%-- -------- Open Connection Code -------- --%>
		<%
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String countryOfCitizenship = "";
		String countryOfResidence = "";
		
		try {
			// Registering Postgresql JDBC driver with the DriverManager
			Class.forName("org.postgresql.Driver");
				// Open a connection to the database using DriverManager
			conn = DriverManager.getConnection(
					"jdbc:postgresql://localhost/cse135?" +
					"user=postgres&password=password");
		%>
			
		<%-- -------- INSERT Statement Code -------- --%>
		<%
			// Create the statement
			Statement statement = conn.createStatement();
			
			String selectStatement = "";
			
			selectStatement = "SELECT * FROM countries WHERE c_id =" + citizenshipID;
			pstmt = conn.prepareStatement(selectStatement);
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				countryOfCitizenship = rs.getString("country");
			}
			
			selectStatement = "SELECT * FROM countries WHERE c_id =" + residenceID;
			pstmt = conn.prepareStatement(selectStatement);
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				countryOfResidence = rs.getString("country");
			}
		%>
		<%-- -------- Close Connection Code -------- --%>
		<%
			// Close our connections
				statement.close();
				conn.close();
		} catch (SQLException e) {
			// in the event of a bad connection or invalid query syntax
			throw new RuntimeException(e);
		} finally {
			// Release resources in a finally block in reverse-order of
			// their creation
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException e) { } // Ignore
				rs = null;
			}
			
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) { } // Ignore
				pstmt = null;
			}
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) { } // Ignore
				conn = null;
			}
		}
		%>		
		<h2>Address:</h2>
		<!-- Address form. -->
		<form action="degreelocation.jsp" method="POST">
			Street Address: <input type="text" name="staddress" size="25"/>
			<br />
			City: <input type="text" name="city" size="15"/>
			<br />
			<%
				if (countryOfResidence.equals("United States")){
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
		Country of citizenship: <%= countryOfCitizenship %>
		<br />  
		Country of residence: <%= countryOfResidence %>
		<br /> 
		<br />
	</body>
</html>