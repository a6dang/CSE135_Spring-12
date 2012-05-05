<%@page import=" Student.*, Degree.*, support.*, java.util.*" %>
<html>
	<head>
		<title>
			Specialization Analytics Page
		</title>
	</head>
	<body>
		<h1>Specialization Analytics Page</h1>
		<%-- Import the java.sql package --%>
        <%@ page import="java.sql.*"%>
        <%-- -------- Open Connection Code -------- --%>
        <%
            
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
            
        <%-- -------- INSERT Statement Code -------- --%>
        <%
            // Create the statement
            Statement statement = conn.createStatement();

			//select count(specialization_id) from specializations
			String selectStatement = "SELECT COUNT(s_id) as count FROM specializations";
			pstmt = conn.prepareStatement(selectStatement);
			rs = pstmt.executeQuery();
			int count = 0;
			while(rs.next()){
				count = rs.getInt("count");
			}
			
			int[] array = new int[count];
			
			for (int i = 0; i < count; i++){
				// select count(specialization_id) from student where specialization_id = i
				selectStatement = "SELECT COUNT(specialization_id) as count FROM students WHERE specialization_id = " + i;
				pstmt = conn.prepareStatement(selectStatement);
				rs = pstmt.executeQuery();
				while (rs.next()) {
					array[i] = rs.getInt("count");
				}
			}
			
			// get the student id
			selectStatement = "SELECT * FROM specializations";
			pstmt = conn.prepareStatement(selectStatement);
			rs = pstmt.executeQuery();
			int i = 0;
			while (rs.next()) {
			%>
				<a href="applications.jsp?specialization=<%= rs.getInt("s_id") %>"><%= rs.getString("specialization") %></a>
				<%= array[i] %>
				<br />
			<%
				i++;
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
		<!-- id of the person's entry in our db -->
	</body>
</html>