<% response.setContentType("text/xml"); %>
<%@ page import="java.sql.*"%>
<%
	String student_id = request.getParameter("student_id");

	if(student_id != null){
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
		<%-- -------- SELECT Statement Code -------- --%>
		<%
				String selectStatement = "SELECT * FROM students WHERE id=" + student_id;
				String nestedSelect = "";
				String nestedSelect2 = "";
				
				pstmt = conn.prepareStatement(selectStatement);
				rs = pstmt.executeQuery();
				
				String nextUniversity = "";
				String nextLocation = "";
				
				while(rs.next()){
				%>
					<result>
						<student_id><%= rs.getInt("id") %></student_id>
						<first_name><%= rs.getString("f_name") %></first_name>
						<m_initial><%= rs.getString("m_initial") %></m_initial>
						<last_name><%= rs.getString("l_name") %></last_name>
					<%
						nestedSelect = "";
						nestedSelect += "SELECT * FROM countries WHERE c_id =" + (rs.getInt("country_citizenship"));
						pstmt = conn.prepareStatement(nestedSelect);
						nested_rs = pstmt.executeQuery();

						while(nested_rs.next()){ %> 
							<country_citizenship><%= nested_rs.getString("country") %></country_citizenship> 
						<% 
						} 

						nestedSelect = "";
						nestedSelect += "SELECT * FROM countries WHERE c_id =" + (rs.getInt("country_residence"));
						pstmt = conn.prepareStatement(nestedSelect);
						nested_rs = pstmt.executeQuery();
					%>
					<% while(nested_rs.next()){ %> 
						<country_residence><%= nested_rs.getString("country") %></country_residence>
					<% 
					} 
					%>
					<street_addr><%= rs.getString("street_addr") %></street_addr>
					<city><%= rs.getString("city") %></city>
					<%
						if (rs.getString("state") != null){
					%>
						<stateOrTelephone>
							<which>state</which>
							<state><%= rs.getString("state") %></state>
						</stateOrTelephone>
					<%
						}else{
					%>
						<stateOrTelephone>
							<which>telephone_code</which>
							<telephone_code><%= rs.getString("telephone_code") %></telephone_code>
						</stateOrTelephone>
					<%
						}
					%>
					<zip_code><%= rs.getString("zip_code") %></zip_code>
					<area_code><%= rs.getString("area_code") %></area_code>
					<phone_no><%= rs.getString("phone_no") %></phone_no>
					<%
						nestedSelect = "";
						nestedSelect += "SELECT * FROM specializations WHERE s_id =" + student_id;
						pstmt = conn.prepareStatement(nestedSelect);
						nested_rs = pstmt.executeQuery();
					%>
					<% while(nested_rs.next()){ %> 
						<specialization><%= nested_rs.getString("specialization") %></specialization> 
					<% 
					} 

						nestedSelect = "";
						nestedSelect += "SELECT * FROM degrees WHERE id =" + rs.getInt("id");
						pstmt = conn.prepareStatement(nestedSelect);
						nested_rs = pstmt.executeQuery();
					
						int i = 0;
						while(nested_rs.next()){ //note that degree number can be found using (i + 1) %> 
							<degree>
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
							<university><%= nextUniversity %></university>
							<location><%= nextLocation %></location>
						<%
							nestedSelect = "";
							nestedSelect += "SELECT * FROM majors WHERE m_id =" + nested_rs.getInt("discipline_id");
							pstmt = conn.prepareStatement(nestedSelect);
							nested_rs2 = pstmt.executeQuery(); 
						%> 
							<% while(nested_rs2.next()){ %> 
								<major><%= nested_rs2.getString("major") %></major>
							<% 
							} 
							%>
							<gpa><%= nested_rs.getDouble("gpa") %></gpa>
							<degree_level><%= nested_rs.getString("degree_level") %></degree_level>
							<grad_month><%= nested_rs.getString("grad_month") %></grad_month>
							<grad_year><%= nested_rs.getInt("grad_year") %></grad_year>
							</degree>
						<% 
							i++;
						} 
						%>
					</result>
					<%
				}
		rs.close();
		pstmt.close();
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
		
	} else {
		%>
			<result>
				<res>dne</res>
			</result>
		<%
		}
		%>