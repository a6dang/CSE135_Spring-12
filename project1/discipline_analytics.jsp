<%@page import=" Student.*, Degree.*, support.*, java.util.*" %>
<html>
	<head>
		<title>
			Discipline Analytics Page
		</title>
	</head>
	<body>
		<h1>Discipline Analytics Page</h1>
		<%-- Import the java.sql package --%>
        <%@ page import="java.sql.*"%>
        <%-- -------- Open Connection Code -------- --%>
        <%
            
        Connection conn = null;
        PreparedStatement pstmt = null;
		ResultSet rs = null; 
		ResultSet nested_rs = null;
		 
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
			
			// get the number of degrees


			// get the student id
			String selectStatement = "SELECT * FROM majors ORDER by major";
			String nestedSelect = "";
			pstmt = conn.prepareStatement(selectStatement);
			rs = pstmt.executeQuery();
			
			int disciplineCount = -1;
			while (rs.next()) {
				nestedSelect = "SELECT DISTINCT id, discipline_id FROM degrees WHERE discipline_id ="+rs.getInt("m_id");
				pstmt = conn.prepareStatement(nestedSelect);
				nested_rs = pstmt.executeQuery();
				disciplineCount = 0;
				while(nested_rs.next()){
					disciplineCount++;
				}
			%>
				<a href="applications.jsp?discipline=<%= rs.getString("m_id") %>"><%= rs.getString("major") %></a>
				<%= disciplineCount %>
				<br />
			<%
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
			if (nested_rs != null) {
                try {
                    nested_rs.close();
                } catch (SQLException e) { } // Ignore
                nested_rs = null;
            }
			if (nested_rs != null) {
                try {
                    nested_rs.close();
                } catch (SQLException e) { } // Ignore
                nested_rs = null;
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
		<!-- id of the person's entry in our db -->
	</body>
</html>