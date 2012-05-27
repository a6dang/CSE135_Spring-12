<% response.setContentType("text/xml"); %>
<%@ page import="java.sql.*"%>
<%
	String customUni = request.getParameter("customUni");
	String lid = request.getParameter("lid");

	if(customUni != null){
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
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
			selectStatement = "SELECT COUNT(*) as count FROM universities WHERE university = '" + customUni + "' AND country_state = '" + lid + "'";
			pstmt = conn.prepareStatement(selectStatement);
			rs = pstmt.executeQuery();
			
			int count = -1;
			
			while(rs.next()){
				count = rs.getInt("count");
			}
			
			if(count > 0){
		%>
			<result>
				<res>exists</res>
			</result>
		<%
			}
			else{
		%>
			<result>
				<res>dne</res>
			</result>
		<%
			}
		rs.close();
		statement.close();
		conn.close();
		}

		catch (SQLException e) {
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
		
	}
	else{
		%>
			<result>
				<res>dne</res>
			</result>
		<%
		}
		%>