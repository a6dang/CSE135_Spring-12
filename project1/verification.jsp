<%@page import=" Student.*, Degree.*, support.*, java.util.*" %>
<html>
	<head>
		<title>Verification</title>
		<%
			Student theStudent = (Student) session.getAttribute("theStudent");
			int numDegrees = theStudent.numOfDegrees();
			
			Vector specs = (Vector) session.getAttribute("specs");
			Vector countries = (Vector) session.getAttribute("countries");
			Vector majors = (Vector) session.getAttribute("majors");
			Vector uniLocs = (Vector) session.getAttribute("uniLocs");
			
			int sid = Integer.parseInt(request.getParameter("specialization"));
			
			theStudent.setSID(sid);
			
			ArrayList<String> custom_universities = (ArrayList<String>) session.getAttribute("custom_universities");
			ArrayList<Integer> custom_uids = (ArrayList<Integer>) session.getAttribute("custom_uids");
			ArrayList<String> custom_lids = (ArrayList<String>) session.getAttribute("custom_lids");
			ArrayList<String> customMajors = (ArrayList<String>) session.getAttribute("customMajors");
			ArrayList<Integer> customMajorIDs = (ArrayList<Integer>) session.getAttribute("customMajorIDs");
			
			int citizenshipID = theStudent.getCID();
			int residenceID = theStudent.getRID();
			int specID = theStudent.getSID();
		%>
	</head>
	<body>
	
		<%@ page import="java.sql.*"%>
		<%-- -------- Open Connection Code -------- --%>
		<%
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ResultSet nested_rs = null;
		
		String countryOfCitizenship = "";
		String countryOfResidence = "";
		String specialization = "";
		
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
			
			// set the specialization.
			selectStatement = "SELECT * FROM specializations WHERE s_id =" + specID;
			pstmt = conn.prepareStatement(selectStatement);
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				specialization = rs.getString("specialization");
			}
			
		%>
	
	
	
		<h2>Verify that this information is correct:</h2>
		<!-- Display user information. -->
		<h3>Student Information:</h3>
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
		<br /><br />

		
		<% 
			int nextUID = -1;
			int nextDID = -1;
			String nextLocation = "";
			String nextUniversity = "";
			String nextDiscipline = "";
			
			int index = -1;
			
			// for determining whether this is a custom field or not (if custom we pull from session)
			int uniCount = -1;
			int majorCount = -1;
			
			for(int i=0; i<numDegrees; i++){
			Degree curDegree = theStudent.getDegree(i);
			nextUID = curDegree.getUID();
			nextDID = curDegree.getDID();
			
			// Check if this major is custom or not
			selectStatement = "SELECT COUNT(*) as count FROM universities WHERE u_id =" + nextUID;
			pstmt = conn.prepareStatement(selectStatement);
			nested_rs = pstmt.executeQuery();
			
			while(nested_rs.next()){
				uniCount = nested_rs.getInt("count");
			}
			
			// Check if this major is custom or not
			selectStatement = "SELECT COUNT(*) as count FROM majors WHERE m_id =" + nextDID;
			pstmt = conn.prepareStatement(selectStatement);
			nested_rs = pstmt.executeQuery();
			
			while(nested_rs.next()){
				majorCount = nested_rs.getInt("count");
			}
			
			// set the next location,university.
			if(uniCount > 0){
				selectStatement = "SELECT country_state, university FROM universities WHERE u_id =" + nextUID;
				pstmt = conn.prepareStatement(selectStatement);
				nested_rs = pstmt.executeQuery();
				
				while(nested_rs.next()){
					nextLocation = nested_rs.getString("country_state");
					nextUniversity = nested_rs.getString("university");
				}
			}
			else{
				index = custom_uids.indexOf(nextUID);
				nextLocation = custom_lids.get(index);
				nextUniversity = custom_universities.get(index);
			}
			
			if(majorCount > 0){
				// set the next discipline.
				selectStatement = "SELECT major FROM majors WHERE m_id =" + nextDID;
				pstmt = conn.prepareStatement(selectStatement);
				nested_rs = pstmt.executeQuery();
				
				while(nested_rs.next()){
					nextDiscipline = nested_rs.getString("major");
				}
			}
			else{
				index = customMajorIDs.indexOf(nextDID);
				nextDiscipline = customMajors.get(index);
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
		
		
		<b>Specialization:</b> <%= specialization %>
		<br /><br />
		
		<!-- Submit and Cancel buttons -->
		<form action="confirmation.jsp" method="POST" >
			<input type="submit" value="Submit" />
		</form>
		<form action="cancellation.jsp" method="POST" >
			<input type="submit" value="Cancel" />
		</form>
		
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