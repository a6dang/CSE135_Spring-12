<%@page import=" Student.*, Degree.*, support.*, java.util.*" %>
<html>
	<head>
		<title>
			Applications Page
		</title>
		<script type="text/javascript">
			function showApplication(student_id) {
				alert("TEST");
				alert("student_id_" + student_id);
				
				var xmlHttp;
				try {
					xmlHttp = new XMLHttpRequest();
				} catch(e) {
					try {
						xmlHttp = new ActiveXObject("Msxml12.XMLHTTP");
					} catch(e) {
						try {
							xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
						} catch(e) {
							alert("Your browser does not support Ajax!")
							return false;
						}
					}	
				}
				
				var responseHandler = function() {
					if(xmlHttp.readyState == 4){
						// Debug responseHandler
						alert("Entering responseHandler");
						
						// Grab basic response (excluding degrees)
						var xmlDoc = xmlHttp.responseXML.documentElement;
						var response_student_id = xmlDoc.getElementsByTagName("student_id")[0].childNodes[0].nodeValue;
						var first_name = xmlDoc.getElementsByTagName("first_name")[0].childNodes[0].nodeValue;
						var m_initial = xmlDoc.getElementsByTagName("m_initial")[0].childNodes[0].nodeValue;
						var last_name = xmlDoc.getElementsByTagName("last_name")[0].childNodes[0].nodeValue;
						var country_citizenship = xmlDoc.getElementsByTagName("country_citizenship")[0].childNodes[0].nodeValue;
						var country_residence = xmlDoc.getElementsByTagName("country_residence")[0].childNodes[0].nodeValue;
						var street_addr = xmlDoc.getElementsByTagName("street_addr")[0].childNodes[0].nodeValue;
						var city = xmlDoc.getElementsByTagName("city")[0].childNodes[0].nodeValue;
						var which = xmlDoc.getElementsByTagName("which")[0].childNodes[0].nodeValue;
						if (which == "state")
							var state = xmlDoc.getElementsByTagName("state")[0].childNodes[0].nodeValue;
						else
							var telephone_code = xmlDoc.getElementsByTagName("telephone_code")[0].childNodes[0].nodeValue;
						var zip_code = xmlDoc.getElementsByTagName("zip_code")[0].childNodes[0].nodeValue;
						var area_code = xmlDoc.getElementsByTagName("area_code")[0].childNodes[0].nodeValue;
						var phone_no = xmlDoc.getElementsByTagName("phone_no")[0].childNodes[0].nodeValue;
						
						// Debug response (excluding degrees)
						alert("LETS PRINT OUT THE RESPONSE");
						alert("response_student_id: " + response_student_id);
						alert("first_name: " + first_name);
						alert("m_initial: " + first_name);
						alert("last_name: " + first_name);
						alert("country_citizenship: " + country_citizenship);
						alert("country_residence: " + country_residence);
						alert("street_addr: " + street_addr);
						alert("city: " + city);
						alert("state: " + state);
						alert("telephone_code: " + telephone_code);
						alert("zip_code: " + zip_code);
						alert("area_code: " + area_code);
						alert("phone_no: " + phone_no);
						
						// Grab degrees response (using a loop)
						
						// Debug degrees response (using a loop)
						x=xmlDoc.getElementsByTagName("degree")[0].childNodes;
						for (i=0;i<x.length;i++)
						{
							alert(x.length);
							alert(x.item(i).firstChild.data);
						}
						
						/*var xmlDoc = xmlHttp.responseXML.documentElement;
						var result = xmlDoc.getElementsByTagName("res")[0].childNodes[0].nodeValue;
						if(result == "exists") {
							alert("This university already exists in the db");
							return false;
						} else {
							alert("it doesn't exist");
							return true;
						}
						*/
					}
				}
				
				xmlHttp.onreadystatechange = responseHandler;
				
				var url = "getStudentInfo.jsp";
				url = url + "?student_id=" + student_id;
				alert("URL to send: " + url);
				xmlHttp.open("GET",url,true);
				xmlHttp.send(null);
			}
		</script>
	</head>
	<body>
		<h1>Applications</h1>
		<%-- Import the java.sql package --%>
        <%@ page import="java.sql.*"%>
        <%-- -------- Open Connection Code -------- --%>
        <%
        
		String s_id = request.getParameter("specialization");
		String m_id = request.getParameter("discipline");
		
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
			
			String nextUniversity = "";
			String nextLocation = "";
			
			if (s_id != null){
			
				selectStatement = "SELECT * FROM students WHERE specialization_id=" + s_id;
				pstmt = conn.prepareStatement(selectStatement);
				rs = pstmt.executeQuery();
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
						nestedSelect += "SELECT * FROM specializations WHERE s_id =" + s_id;
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
			} // close the case that user came from specialization analytics page.
			else if (m_id != null){ // the case that the user came from the discipline analytics page.
				selectStatement = "SELECT DISTINCT S.* FROM students AS S, degrees AS D, majors AS M WHERE S.id=D.id AND D.discipline_id="+m_id;
				pstmt = conn.prepareStatement(selectStatement);
				rs = pstmt.executeQuery();
				while(rs.next()){
				%>
					<b><%= rs.getString("f_name") %>&nbsp;<%= rs.getString("m_initial") %>&nbsp;<%= rs.getString("l_name") %></b>
					<br />
					Application ID: <%= rs.getInt("id") %>
					<br/>
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
						nestedSelect += "SELECT * FROM specializations WHERE s_id =" + s_id;
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
							University: <% while(nested_rs2.next()){ %> <%= nested_rs2.getString("university") %> <% } %>
							<br />
							Location: <% while(nested_rs2.next()){ %> <%= nested_rs2.getString("country") %> <% } %>
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
			} // close the case that user came from discipline analytics page.
			
			else{ // user must be coming directly to this page by address bar entry.
				selectStatement = "SELECT * FROM students";
				pstmt = conn.prepareStatement(selectStatement);
				rs = pstmt.executeQuery();
				while(rs.next()){
				%>
					<a href="applications_specific.jsp?student_id=<%= rs.getInt("id") %>"><%= rs.getString("f_name") %>&nbsp;<%= rs.getString("m_initial") %>&nbsp;<%= rs.getString("l_name") %></a>
					<button type="button" id="student_id_<%= rs.getInt("id") %>" onclick="showApplication(<%= rs.getInt("id") %>)" >Show Application</button>
					<br />
				<%
				}
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