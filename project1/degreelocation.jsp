<%@page import=" Student.*, Degree.*, support.*, java.util.*" %>
<html>
	<head>
		<title>Provide Degrees - Choose Locations</title>
		<%
			Student theStudent = (Student) session.getAttribute("theStudent");
			int numDegrees = theStudent.numOfDegrees();
			
			int citizenshipID = theStudent.getCID();
			int residenceID = theStudent.getRID();
			
			Vector<String> uniLocs = new Vector<String>();
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
			
			// set the countries vector.
			selectStatement = "SELECT DISTINCT country_state FROM universities ORDER BY country_state";
			pstmt = conn.prepareStatement(selectStatement);
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				uniLocs.add(rs.getString("country_state"));
			}
		%>
				
		
		
		
		<%
			if(numDegrees == 0){
				if (countryOfResidence.equals("United States")){
					String state = request.getParameter("state");
					theStudent.setState(state);
				} else {
					String telcode = request.getParameter("telcode");
					theStudent.setTelephoneCode(telcode);
				}
				
				String staddress = request.getParameter("staddress");
				String city = request.getParameter("city");
				String zip = request.getParameter("zip");
				String area = request.getParameter("area");
				String phone = request.getParameter("phone");

				theStudent.setStAddress(staddress);
				theStudent.setCity(city);
				theStudent.setZipCode(zip);
				theStudent.setAreaCode(area);
				theStudent.setPhoneNumber(phone);
			}
			
			if(uniLocs == null){
				support s = new support();
				String path1 = config.getServletContext().getRealPath("universities.txt");
				uniLocs = s.getUniversities(path1);	
				session.setAttribute("uniLocs", uniLocs);
			}
			
			Vector majors = (Vector) session.getAttribute("majors");
			
			if(majors == null){
				support s = new support();
				String path1 = config.getServletContext().getRealPath("majors.txt");
				majors = s.getMajors(path1);
				session.setAttribute("majors",majors);
			}
		%>
	</head>
	<body>
		<h2>Choose the country or U.S. state where you attained your degree:</h2>
		
		<br />
		
		<!-- Show all U.S. states and foreign countries. -->
		<table border="1">
			<tr>
				<td>
				<%	
					String nextLoc = "";
					for (int i = 0; i < uniLocs.size()/3; i++){
						nextLoc = uniLocs.elementAt(i);
				%>
						<a href="degreeuniversity.jsp?lid=<%= nextLoc %>"><%= nextLoc %></a>
						<br />
				<%
					}
				%>
				</td>
				<td>
				<%
					for (int i = uniLocs.size()/3; i < (uniLocs.size()*2)/3; i++){
						nextLoc = uniLocs.elementAt(i);
				%>
						<a href="degreeuniversity.jsp?lid=<%= nextLoc %>"><%= nextLoc %></a>
						<br />		
				<%
					}
				%>	
				</td>
				<td>
				<%
					for (int i = (uniLocs.size()*2)/3; i < uniLocs.size(); i++){
						nextLoc = uniLocs.elementAt(i);
				%>
						<a href="degreeuniversity.jsp?lid=<%= nextLoc %>"><%= nextLoc %></a>
						<br />
				<%
					}
				%>	
				</td>
			</tr>
		</table>	
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
		if ( countryOfResidence.equals("United States")){
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
		<% 
			int nextUID = -1;
			int nextDID = -1;
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