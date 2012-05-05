<%@page import=" Student.*, support.*, java.util.*" %>
<html>
	<head>
		<title>Country of Citizenship</title>
		<%
			String firstName = request.getParameter("first");
			String middleInitial = request.getParameter("middle");
			String lastName = request.getParameter("last");
			
			Student theStudent = new Student();
			theStudent.setFName(firstName);
			theStudent.setMidInitial(middleInitial);
			theStudent.setLName(lastName);
			
			session.setAttribute("theStudent",theStudent);
		%>
	</head>

	<body>
		<h3>Student Information:</h3>
		<!-- Show information so far. -->
		First name: <%= theStudent.getFName() %>
		<br />    
		Middle initial: <%= theStudent.getMidInitial() %>
		<br />    
		Last name: <%= theStudent.getLName() %>

		<br />  
		<h2>Country of Citizenship:</h2>
		<!-- List all countries. -->
		<table border="1">
			<tr>
				<td>
				<%-- Import the java.sql package --%>
				<%@ page import="java.sql.*"%>
				<%-- -------- Open Connection Code -------- --%>
				<%
				Connection conn = null;
				PreparedStatement pstmt = null;
				ResultSet rs = null;
				
				Vector<String> countries = new Vector<String>();
				
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
					
					selectStatement = "SELECT * FROM countries";
					pstmt = conn.prepareStatement(selectStatement);
					rs = pstmt.executeQuery();
					
					while(rs.next()){
						countries.add(rs.getString("country"));
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
				<%
					//session.setAttribute("countries",countries);
					
					String nextCountry = "";
					for (int i = 0; i < countries.size()/3; i++){
						nextCountry = (String) countries.elementAt(i);
				%>
					<a href="residence.jsp?cid=<%=i+1%>"><%= nextCountry %></a>
					<br />
					
				<%
					}
				%>
				</td>
				<td>
				<%
					for (int i = countries.size()/3; i < (countries.size()*2)/3; i++){
						nextCountry = (String) countries.elementAt(i);
				%>
					<a href="residence.jsp?cid=<%=i+1%>"><%= nextCountry %></a>
					<br />
					
				<%
					}
				%>	
				</td>
				<td>
				<%
					for (int i = (countries.size()*2)/3; i < countries.size(); i++){
						nextCountry = (String) countries.elementAt(i);
				%>
					<a href="residence.jsp?cid=<%=i+1%>"><%= nextCountry %></a>
					<br />
					
				<%
					}
				%>	
				</td>
			</tr>
		</table>	   
	</body>
</html>