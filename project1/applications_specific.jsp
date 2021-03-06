<%@page import=" Student.*, Degree.*, support.*, java.util.*" %>
<html>
	<head>
		<title>
			Applications Page
		</title>
	</head>
	<body>
		<h1>Applications</h1>
		<%-- Import the java.sql package --%>
        <%@ page import="java.sql.*"%>
        <%-- -------- Open Connection Code -------- --%>
        <%
        
		String student_id = request.getParameter("student_id");
		
        Connection conn = null;
        PreparedStatement pstmt = null;
		ResultSet rs = null;
		ResultSet nested_rs = null;
		ResultSet nested_rs2 = null;
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
			
			String nestedSelect = "";
			String selectStatement = "";
			
			if (student_id != null){
				selectStatement = "SELECT * FROM students WHERE id=" + student_id;
				pstmt = conn.prepareStatement(selectStatement);
				rs = pstmt.executeQuery();
				
				String nextUniversity = "";
				String nextLocation = "";
				
				while(rs.next()){
				%>
					<b><%= rs.getString("f_name") %>&nbsp;<%= rs.getString("m_initial") %>&nbsp;<%= rs.getString("l_name") %></b>
					<br />
					Application ID: <%= rs.getInt("id") %>
					<br />	
					<%
						nestedSelect = "";
						nestedSelect += "SELECT * FROM countries WHERE c_id =" + (rs.getInt("country_citizenship"));
						pstmt = conn.prepareStatement(nestedSelect);
						nested_rs = pstmt.executeQuery();
					%>
					Country of citizenship: <% while(nested_rs.next()){ %> <%= nested_rs.getString("country") %> <% } %>
					<br />
					<%
						nestedSelect = "";
						nestedSelect += "SELECT * FROM countries WHERE c_id =" + (rs.getInt("country_residence"));
						pstmt = conn.prepareStatement(nestedSelect);
						nested_rs = pstmt.executeQuery();
					%>
					Country of residence: <% while(nested_rs.next()){ %> <%= nested_rs.getString("country") %> <% } %>
					<br />
					Street Address: <%= rs.getString("street_addr") %>
					<br />
					City: <%= rs.getString("city") %>
					<br />
					<%
						if (rs.getString("state") != null){
					%>
						State: <%= rs.getString("state") %>
					<br />
					<%
						}else{
					%>
					Telephone: <%= rs.getString("telephone_code") %>
					<br />
					<%
						}
					%>
					Zip Code: <%= rs.getString("zip_code") %>
					<br />
					Area Code: <%= rs.getString("area_code") %>
					<br />
					Phone Number: <%= rs.getString("phone_no") %>
					<br />
					<%
						nestedSelect = "";
						nestedSelect += "SELECT * FROM specializations WHERE s_id =" + student_id;
						pstmt = conn.prepareStatement(nestedSelect);
						nested_rs = pstmt.executeQuery();
					%>
					Specialization: <% while(nested_rs.next()){ %> <%= nested_rs.getString("specialization") %> <% } %>
					<br /><br />
					<%
						nestedSelect = "";
						nestedSelect += "SELECT * FROM degrees WHERE id =" + rs.getInt("id");
						pstmt = conn.prepareStatement(nestedSelect);
						nested_rs = pstmt.executeQuery();
					
						int i = 0;
						while(nested_rs.next()){ %> 
							Degree <%= i + 1 %>
							<br />
						<%
							// set the next location,university.
							nestedSelect = "";
							nestedSelect += "SELECT country_state, university FROM universities WHERE u_id =" + nested_rs.getInt("university_id");
							pstmt = conn.prepareStatement(nestedSelect);
							nested_rs2 = pstmt.executeQuery();
							
							while(nested_rs2.next()){
								nextLocation = nested_rs2.getString("country_state");
								nextUniversity = nested_rs2.getString("university");
							}
						%> 
							University: <%= nextUniversity %>
							<br />
							Location: <%= nextLocation %>
							<br />
						<%
							nestedSelect = "";
							nestedSelect += "SELECT * FROM majors WHERE m_id =" + nested_rs.getInt("discipline_id");
							pstmt = conn.prepareStatement(nestedSelect);
							nested_rs2 = pstmt.executeQuery(); 
						%> 
							Discipline: <% while(nested_rs2.next()){ %> <%= nested_rs2.getString("major") %> <% } %>
							<br />
							GPA: <%= nested_rs.getDouble("gpa") %>
							<br />
							Degree Level: <%= nested_rs.getString("degree_level") %>
							<br />
							Graduation Date: <%= nested_rs.getString("grad_month") + " " + nested_rs.getInt("grad_year") %>
							<br />
							<br />
						<% 
							i++;
							
						} 
						%>
				<%
				
				}
			} // close case that user specified an application to view based on get param.
			else {
			%>
				No student information requested.
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
			if (nested_rs2 != null) {
                try {
                    nested_rs2.close();
                } catch (SQLException e) { } // Ignore
                nested_rs2 = null;
            }
			
			if (nested_rs != null) {
                try {
                    nested_rs.close();
                } catch (SQLException e) { } // Ignore
                nested_rs = null;
            }
			
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