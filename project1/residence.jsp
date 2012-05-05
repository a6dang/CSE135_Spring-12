<%@page import=" Student.*, support.*, java.util.*" %>
<html>
	<head>
		<title>Country of Residence</title>
		<%
			int citizenID = Integer.parseInt(request.getParameter("cid"));
			
			Student theStudent = (Student) session.getAttribute("theStudent");
			theStudent.setCID(citizenID);
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
					
					selectStatement = "SELECT * FROM countries WHERE c_id=" + citizenID;
					pstmt = conn.prepareStatement(selectStatement);
					rs = pstmt.executeQuery();
					while(rs.next()){
						countryOfCitizenship = rs.getString("country");
					}
					
					selectStatement = "SELECT * FROM countries";
					pstmt = conn.prepareStatement(selectStatement);
					rs = pstmt.executeQuery();
					
					while(rs.next()){
						countries.add(rs.getString("country"));
					}
				%>

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
		<br />
		<h2>Country of Residence:</h2>
		<a href="address.jsp?residence=<%= countryOfCitizenship %>&rid=<%=citizenID%>">Same country as citizenship</a>
	
		<!-- List all countries. -->
		<table border="1">
			<tr>
				<td>
				<%
					String nextCountry = "";
					for (int i = 0; i < countries.size()/3; i++){
						nextCountry = (String) countries.elementAt(i);
				%>
					<a href="address.jsp?rid=<%=i+1%>"><%= nextCountry %></a>
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
					<a href="address.jsp?rid=<%=i+1%>"><%= nextCountry %></a>
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
					<a href="address.jsp?rid=<%=i+1%>"><%= nextCountry %></a>
					<br />
					
				<%
					}
				%>	
				</td>
			</tr>
		</table>
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