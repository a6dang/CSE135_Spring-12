<%@page import=" Student.*, Degree.*, support.*, java.util.*" %>
<html>
	<head>
		<title>Provide Degrees - Choose Discipline</title>
		<%	
			String university = request.getParameter("university");
			String custom_university = request.getParameter("custom_university");
			int uid = Integer.parseInt(request.getParameter("uid"));
			String lid = request.getParameter("lid");
			
			if(custom_university != null){
				ArrayList<String> custom_universities = (ArrayList<String>) session.getAttribute("custom_universities");
				ArrayList<Integer> custom_uids = (ArrayList<Integer>) session.getAttribute("custom_uids");
				ArrayList<String> custom_lids = (ArrayList<String>) session.getAttribute("custom_lids");
				if(custom_universities == null){
					custom_universities = new ArrayList<String>();
					session.setAttribute("custom_universities",custom_universities);
				}
				if(custom_uids == null){
					custom_uids = new ArrayList<Integer>();
					session.setAttribute("custom_uids",custom_uids);
				}
				if(custom_lids == null){
					custom_lids = new ArrayList<String>();
					session.setAttribute("custom_lids",custom_lids);
				}
				custom_universities.add(custom_university);
				if (custom_uids.size() == 0){
					custom_uids.add(uid);
				} else {
					custom_uids.add((custom_uids.get(custom_uids.size()-1))+1);
				}
				custom_lids.add(lid);
			}
			
			Student theStudent = (Student) session.getAttribute("theStudent");
			Degree theDegree = (Degree) session.getAttribute("curDegree");
			
			//Vector countries = (Vector) session.getAttribute("countries");
			//Vector uniLocs = (Vector) session.getAttribute("uniLocs");
			//Vector listUnis = (Vector) ((Vector) uniLocs.elementAt(theDegree.getLID())).elementAt(1);
		
			int numDegrees = theStudent.numOfDegrees();
			
			theDegree.setUID(uid);
			
			Vector<String> majors = new Vector<String>();//(Vector) session.getAttribute("majors");
			
			
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
		
		int lastMajorID = -1;
		
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
			
			// add the university to the vector if it is a user-specified entry
			/*
			if(custom_university != null){
				selectStatement = "SELECT * FROM universities WHERE country_state = '" + lid + "' AND university = '" + custom_university + "'";
				pstmt = conn.prepareStatement(selectStatement);
				rs = pstmt.executeQuery();
				int count = 0;
				while(rs.next()){
					count++;
				}
				
				if(count == 0){
					insertStatement = "INSERT INTO universities VALUES (" + uid + ",'" + lid + "','" + custom_university + "')";
					pstmt = conn.prepareStatement(insertStatement);
					pstmt.executeUpdate();
				}
			}
			*/
			// set last major ID
			selectStatement = "SELECT MAX(m_id) as maxID FROM majors";
			pstmt = conn.prepareStatement(selectStatement);
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				//lastMajorID = String.valueOf(rs.getInt("maxID"));
				lastMajorID = rs.getInt("maxID");
			}
			
			// set the countries vector.
			selectStatement = "SELECT major FROM majors ORDER by major";
			pstmt = conn.prepareStatement(selectStatement);
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				majors.add(rs.getString("major"));
			}
		%>
	</head>
	<body>
		<h2>Choose a displicine below or enter one if yours is not listed:</h2>
		<br />
		
		<!-- Radio buttons for disciplines. -->
		<form action="moredegrees.jsp" method="POST">
			<%
				String nextMajor = "";
				for (int i = 0; i < majors.size(); i++){
					nextMajor = (String) majors.elementAt(i);
			%>				
				<input type="radio" name="major" value="<%= i+1 %>"/> <%= nextMajor %> <br />
			<%
				}
			%>
			<input type="radio" name="major" value="<%=-1%>"/> Other: <input type="text" name="otherMajor" /><br />	
			<br />
			Graduation date: <input type="text" name="gradMonth" value="month" size="10" /> 
			<input type="text" name="gradYear" value="year" size="4" />
			<br />
			GPA: <input type="text" name="GPA" size="5" />
			<select name="degLevel">
				<option value="B.S.">B.S.</option>
				<option value="M.S.">M.S.</option>
				<option value="P.H.D">P.H.D</option>
			</select>
			
			<input type="hidden" name="nextMajorID" value="<%= lastMajorID + 1 %>"/>
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