<%@page import=" Student.*, Degree.*, support.*, java.util.*" %>
<html>
	<head>
		<title>Provide Degrees - Choose University</title>
		<script type="text/javascript">
			var exist = 0;
			function checkUniversity() {
				var xmlHttp;
				try {
					xmlHttp = new XMLHttpRequest();
				} catch(e) {
					try {
						xmlHttp = new ActiveXObject("Msxml12.XMLHTTP");
					} catch(e) {
						try {
							xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
						} catch(e) {
							alert("Your browser does not support Ajax!")
							return false;
						}
					}	
				}
				
				var responseHandler = function() {
					if(xmlHttp.readyState == 4){
						var xmlDoc = xmlHttp.responseXML.documentElement;
						var result = xmlDoc.getElementsByTagName("res")[0].childNodes[0].nodeValue;
						if(result == "exists") {
							alert("This university already exists in the database. Please click on the hyperlink instead.");
							exist = 1;
						} else {
							exist = 0;
						}
					}
				}
				
				xmlHttp.onreadystatechange = responseHandler;
				
				var url = "checkUniversity.jsp";
				url = url + "?customUni=" + document.getElementById("customUni").value + "&lid=" + document.getElementById("lid").value;
				
				xmlHttp.open("GET",url,true);
				xmlHttp.send(null);
			}
			function checkExist(){
				if(exist == 1){
					alert("This university already exists in the database. Please click on the hyperlink instead.");
					return false;
				}
				else
					return true;
			}
		</script>
		<%	
			Student theStudent = (Student) session.getAttribute("theStudent");
			Degree theDegree = new Degree();
			
			String lid = request.getParameter("lid");
			
			theDegree.setLID(lid);
			
			session.setAttribute("curDegree", theDegree);
			
			int numDegrees = theStudent.numOfDegrees();
			
			
			int citizenshipID = theStudent.getCID();
			int residenceID = theStudent.getRID();
			
			
			Vector<String> listUnis = new Vector<String>();
			Vector<Integer> uniIndexes = new Vector<Integer>();
			
			
			//Vector uniLocs = (Vector) session.getAttribute("uniLocs");
			//Vector countries = (Vector) session.getAttribute("countries");
			//Vector listUnis = (Vector) ((Vector) uniLocs.elementAt(lid)).elementAt(1);
			
			//Vector majors = (Vector) session.getAttribute("majors");
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
		
		String lastUniversityID = "";
		
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
			
			// set the universities vector.
			selectStatement = "SELECT u_id, university FROM universities WHERE country_state='" + lid + "'";
			pstmt = conn.prepareStatement(selectStatement);
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				uniIndexes.add(rs.getInt("u_id"));
				listUnis.add(rs.getString("university"));
			}
			
			// set the universities vector.
			selectStatement = "SELECT MAX(u_id) as maxID FROM universities";
			pstmt = conn.prepareStatement(selectStatement);
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				lastUniversityID = String.valueOf(rs.getInt("maxID"));
			}
		%>
	
	</head>
	<body>
		<h2>Select the university that you attended or enter one if the one you attended is not present:</h2>
		<br />
		
		<!-- Show all universities per location chosen. -->
		<table border="1">
			<tr>
				<td>
				<%
					
					String nextUniversity = "";
					int nextUID = -1;
					
					for (int i = 0; i < listUnis.size()/3; i++){
						nextUniversity = (String) listUnis.elementAt(i);
						nextUID = (Integer) uniIndexes.elementAt(i);
				%>
					<a href="degreediscipline.jsp?university=<%= nextUniversity %>&uid=<%= nextUID %>"><%= nextUniversity %></a>
					<br />	
				<%
					}
				%>
				
				</td>
				<td>
				<%
					for (int i = listUnis.size()/3; i < (listUnis.size()*2)/3; i++){
						nextUniversity = (String) listUnis.elementAt(i);
						nextUID = (Integer) uniIndexes.elementAt(i);
				%>
					<a href="degreediscipline.jsp?university=<%= nextUniversity %>&uid=<%= nextUID %>"><%= nextUniversity %></a>
					<br />
				<%
					}
				%>	
				</td>
				<td>
				<%
					for (int i = (listUnis.size()*2)/3; i < listUnis.size(); i++){
						nextUniversity = (String) listUnis.elementAt(i);
						nextUID = (Integer) uniIndexes.elementAt(i);
				%>
					<a href="degreediscipline.jsp?university=<%= nextUniversity %>&uid=<%= nextUID %>"><%= nextUniversity %></a>
					<br />
				<%
					}
				%>	
				</td>
			</tr>
		</table>
		<br />
		<!-- Other university not listed. -->
		<form action="degreediscipline.jsp" method="POST" onsubmit="return checkExist()">
			Other University: <input type="text" name="custom_university" onblur="checkUniversity()" id="customUni"/>
			<input type="hidden" name="uid" value="<%= (Integer.parseInt(lastUniversityID)+1) %>" />
			<input type="hidden" name="lid" value="<%= lid %>" id="lid" />
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
			int nextDID = -1;
			String nextLocation = "";
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