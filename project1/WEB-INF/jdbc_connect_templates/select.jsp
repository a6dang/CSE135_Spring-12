<html>

<body>
<table>
    <tr>
        <td valign="top">
        </td>
        <td>
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
                    "jdbc:postgresql://localhost/postgres?" +
                    "user=postgres&password=password");
            %>
            
            <%-- -------- SELECT Statement Code -------- --%>
            <%
                // Create the statement
                Statement statement = conn.createStatement();

                // execute this query on our database, conn is our connection object, rs holds the return value
				pstmt = conn.prepareStatement("SELECT * FROM students");
				rs = pstmt.executeQuery();
				// statement.executeUpdate("INSERT INTO students VALUES (2, 'anthony')");
            %>

			 <%			 
                // Print out each result row one by one
                while (rs.next()) {
			%>
					<%= rs.getInt("PID") %>
					<%= rs.getString("fname") %>
					<br />
			<%
				}
			%>
			
            <%-- -------- Close Connection Code -------- --%>
            <%
                // Close our connections
                rs.close();

                statement.close();

                conn.close();
            } catch (SQLException e) {
                // in the event of a bad connection or invalid query syntax
                throw new RuntimeException(e);
            }
            finally {
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
        </table>
        </td>
    </tr>
</table>
</body>

</html>
