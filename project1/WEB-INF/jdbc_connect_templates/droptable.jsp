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
            
            try {
                // Registering Postgresql JDBC driver with the DriverManager
                Class.forName("org.postgresql.Driver");

                // Open a connection to the database using DriverManager
				conn = DriverManager.getConnection(
                    "jdbc:postgresql://localhost/postgres?" +
                    "user=postgres&password=password");
            %>
            
            <%-- -------- DROP TABLE Statement Code -------- --%>
            <%
                // Create the statement
                Statement statement = conn.createStatement();

                // execute this update on our database, conn is our connection object
				pstmt = conn.prepareStatement("DROP TABLE students");
				// notice the function is executeUpdate, not executeQuery, since we do not expect a return value
				pstmt.executeUpdate();
            %>
			
            <%-- -------- Close Connection Code -------- --%>
            <%
                // Close our connections

                statement.close();

                conn.close();
            } catch (SQLException e) {
                // in the event of a bad connection or invalid query syntax
                throw new RuntimeException(e);
            }
            finally {
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
        </table>
        </td>
    </tr>
</table>
</body>

</html>
