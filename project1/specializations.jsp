<%@page import=" Student.*, Degree.*, support.*, java.util.*" %>
<html>
	<head>
		<title>Specialization</title>
		<%
			Student theStudent = (Student) session.getAttribute("theStudent");
			int numDegrees = theStudent.numOfDegrees();
			
			//Vector countries = (Vector) session.getAttribute("countries");
			//Vector uniLocs = (Vector) session.getAttribute("uniLocs");
			//Vector majors = (Vector) session.getAttribute("majors");
			
			Vector<String> specs = new Vector<String>();
			
			
			int citizenshipID = theStudent.getCID();
			int residenceID = theStudent.getRID();
		%>
		
		
		<%@ page import="java.sql.*"%>
		<%-- -------- Open Connection Code -------- --%>
		<%
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ResultSet nested_rs = null;
		
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
			
		<%-- -------- SELECT Statement Code -------- --%>
		<%
			// Create the statement
			Statement statement = conn.createStatement();
			
			String selectStatement = "";
			
			// set the country of citizenship.
			selectStatement = "SELECT * FROM countries WHERE c_id =" + citizenshipID;
			pstmt = conn.prepareStatement(selectStatement);
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				countryOfCitizenship = rs.getString("country");
			}
			
			// set the country of residence.
			selectStatement = "SELECT * FROM countries WHERE c_id =" + residenceID;
			pstmt = conn.prepareStatement(selectStatement);
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				countryOfResidence = rs.getString("country");
			}
			
			// set the specializations.
			selectStatement = "SELECT specialization FROM specializations";
			pstmt = conn.prepareStatement(selectStatement);
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				specs.add(rs.getString("specialization"));
			}
			
		%>

		
		
		
		
	</head>
	<body>
		<h2>Please choose a specialization from the dropdown menu:</h2>
		<br />
		<!-- Drop down menu for specializations. -->
		<form action="verification.jsp" method="POST" >
			<select name="specialization">
			<%

				String nextSpec = "";
				for (int i = 0; i < specs.size(); i++){
					nextSpec = (String) specs.elementAt(i);
			%>				
				<option value="<%= i+1 %>"><%= nextSpec %></option>
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
		Country of citizenship: <%= countryOfCitizenship %>
		<br />  
		Country of residence: <%= countryOfResidence %>
		<br />  
		Street Address: <%= theStudent.getStAddress() %>
		<br />  
		City: <%= theStudent.getCity() %>
		<br />  
		<%
		if (countryOfResidence.equals("United States")){
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
			int nextDID = -1;
			int nextUID = -1;
			String nextLocation = "";
			String nextUniversity = "";
			String nextDiscipline = "";
			
			for(int i=0; i<numDegrees; i++){
			Degree curDegree = theStudent.getDegree(i);
			nextUID = curDegree.getUID();
			nextDID = curDegree.getDID();
			
			// set the next location,university.
			selectStatement = "SELECT country_state, university FROM universities WHERE u_id =" + nextUID;
			pstmt = conn.prepareStatement(selectStatement);
			nested_rs = pstmt.executeQuery();
			
			while(nested_rs.next()){
				nextLocation = nested_rs.getString("country_state");
				nextUniversity = nested_rs.getString("university");
			}
			
			// set the next discipline.
			selectStatement = "SELECT major FROM majors WHERE m_id =" + nextDID;
			pstmt = conn.prepareStatement(selectStatement);
			nested_rs = pstmt.executeQuery();
			
			while(nested_rs.next()){
				nextDiscipline = nested_rs.getString("major");
			}
		%>
			<br />
			<b>Degree <%=i + 1%></b>
			<br />
			<b>University:</b> <%= nextUniversity %>
			<br />
			<b>Location:</b> <%= nextLocation %>
			<br />
			<b>Discipline:</b> <%= nextDiscipline %>
			<br />
			<b>GPA:</b> <%= curDegree.getGPA() %>
			<br />
			<b>Degree Level:</b> <%= curDegree.getDegreeLevel() %>
			<br />
			<b>Graduation Date:</b> <%= curDegree.getGradMonth() %> <%= curDegree.getGradYear() %>
			<br /><br />
		<% 
			} 
		%>
		<br />
		
		
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
		
	</body>
</html>