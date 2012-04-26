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
                    "jdbc:postgresql://localhost/test?" +
                    "user=postgres&password=password");
            %>
            
            <%-- -------- SELECT Statement Code -------- --%>
            <%
                // Create the statement
                Statement statement = conn.createStatement();

                // Use the created statement to SELECT
                // the student attributes FROM the Student table.
				PreparedStatement prest = conn.prepareStatement("SELECT * FROM students");
				// rs = statement.executeQuery("SELECT * FROM students");
				rs = prest.executeQuery();
				// statement.executeUpdate("INSERT INTO students VALUES (2, 'anthony')");
            %>

			 <%
				int pid = 0;
				String fname = "hello";
			 
                // Iterate over the ResultSet
                while (rs.next()) {
					pid = rs.getInt("PID");
					fname = rs.getString("fname");
				}
			%>
			
			<%= pid %>
			<%= fname %>
			
            <%-- -------- Close Connection Code -------- --%>
            <%
                // Close the ResultSet
                rs.close();

                // Close the Statement
                statement.close();

                // Close the Connection
                conn.close();
            } catch (SQLException e) {

                // Wrap the SQL exception in a runtime exception to propagate
                // it upwards
                throw new RuntimeException(e);
            }
            finally {
                // Release resources in a finally block in reverse-order of
                // their creation

                // if (rs != null) {
                    // try {
                        // rs.close();
                    // } catch (SQLException e) { } // Ignore
                    // rs = null;
                // }
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
