<%@page import=" Student.*, Degree.*, support.*, java.util.*" %>
<html>
	<head>
		<title>More Degrees</title>
		<%
			Student theStudent = (Student) session.getAttribute("theStudent");
			Degree theDegree = (Degree) session.getAttribute("curDegree");
			//Vector majors = (Vector) session.getAttribute("majors");
			
			// Temporary case to take care of empty major until JS validation added.
			String strDid = request.getParameter("major");
			int did = -1;
			if(strDid != null){
				did = Integer.parseInt(strDid);
			}
			
			
			String gpa = request.getParameter("GPA");
			String degreeLevel = request.getParameter("degLevel");
			String gradMonth = request.getParameter("gradMonth");
			String gradYear = request.getParameter("gradYear");
			Integer nextMajorID = Integer.parseInt(request.getParameter("nextMajorID"));
			
			
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
			String insertStatement = "";
			
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
			
		%>
			
			<%

			if(did == -1){
				did = nextMajorID;
				String newMajor = request.getParameter("otherMajor");
				
				ArrayList<String> customMajors = (ArrayList<String>) session.getAttribute("customMajors");
				ArrayList<Integer> customMajorIDs = (ArrayList<Integer>) session.getAttribute("customMajorIDs");
				if(customMajors == null){
					customMajors = new ArrayList<String>();
					customMajorIDs = new ArrayList<Integer>();
					session.setAttribute("customMajors",customMajors);
					session.setAttribute("customMajorIDs",customMajorIDs);
				}
				
				customMajors.add(newMajor);
				if(customMajorIDs.size() == 0){
					customMajorIDs.add(nextMajorID);
				} else {
					customMajorIDs.add((customMajorIDs.get(customMajorIDs.size()-1))+1);
				}
				
				/*
				selectStatement = "SELECT * FROM majors WHERE major ='" + newMajor + "'";
				pstmt = conn.prepareStatement(selectStatement);
				rs = pstmt.executeQuery();
				int count = 0;
				while(rs.next()){
					count++;
				}
				
				if(count == 0){
					insertStatement = "INSERT INTO majors VALUES (" + did + ",'" + newMajor + "')";
					pstmt = conn.prepareStatement(insertStatement);
					pstmt.executeUpdate();
				}
				*/
			}
			
			theDegree.setDID(did);
			theDegree.setGPA(gpa);
			theDegree.setDegreeLevel(degreeLevel);
			theDegree.setGradMonth(gradMonth);
			theDegree.setGradYear(gradYear);
			
			if(!theStudent.containsDegree(theDegree)){
				theStudent.addDegree(theDegree);
			}
			
			int numDegrees = theStudent.numOfDegrees();
			
			//Vector countries = (Vector) session.getAttribute("countries");
			//Vector uniLocs = (Vector) session.getAttribute("uniLocs");
			
			
			
			
		%>
		
		
		

	
	</head>
	<body>
		<h2>Is this the last degree?</h2>

		<!-- Submit next degree button. -->
		<form action="degreelocation.jsp" method="POST">
			<input type="submit" value="Submit Next Degree" />
		</form>
		<br />
		<!-- Done button. -->
		<form action="specializations.jsp" method="POST">
			<input type="submit" value="Done" />
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

		<% 
			} 
		%>
		<br />
		<br />
		<br />
	</body>
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
</html>