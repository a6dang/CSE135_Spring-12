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
		 
        try {
            // Registering Postgresql JDBC driver with the DriverManager
            Class.forName("org.postgresql.Driver");

            // Open a connection to the database using DriverManager
			conn = DriverManager.getConnection(
					"jdbc:postgresql://localhost/postgres?" +
                    "user=postgres&password=password");
        %>
            
        <%-- -------- INSERT Statement Code -------- --%>
        <%
            // Create the statement
            Statement statement = conn.createStatement();
			
			// get the number of degrees
			
			
			// get all the degrees, and the number of applicants per degree
			String selectStatement = "SELECT COUNT(discipline_id) FROM degrees WHERE discipline_id = ";
			pstmt = conn.prepareStatement(selectStatement);
			ResultSet rs = pstmt.executeQuery();
			
			while (rs.next()) {
			%>
				<a href="applications.jsp?discipline=<%= rs.getString("major") %>"><%= rs.getString("major") %></a>
				<br />
			<%
			}

			// get the student id
			String selectStatement = "SELECT * FROM majors";
			pstmt = conn.prepareStatement(selectStatement);
			ResultSet rs = pstmt.executeQuery();
			
			while (rs.next()) {
			%>
				<a href="applications.jsp?discipline=<%= rs.getString("major") %>"><%= rs.getString("major") %></a>
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