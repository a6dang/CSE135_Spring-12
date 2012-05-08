<%@page import=" Student.*, Degree.*, support.*, java.util.*" %>
<html>
	<head>
		<title>
			Confirmation Page
		</title>
		<%
		Student theStudent = (Student) session.getAttribute("theStudent");
		%>
		<%-- Import the java.sql package --%>
        <%@ page import="java.sql.*"%>
        <%-- -------- Open Connection Code -------- --%>
        <%
            
        Connection conn = null;
        PreparedStatement pstmt = null;
        int studentID = -1;
		
		if(theStudent != null){
		
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

            // execute this update on our database, conn is our connection object
			
			String insertStatement = "";
			
			int nextUniversityID = -1;
			String nextUniversityLocation = "";
			
			
			Integer telephone_code = -1;
			String state = "";
			
			// retrieve all variables from student object to add to the db.
			String f_name = theStudent.getFName();
			String m_initial = theStudent.getMidInitial();
			String l_name = theStudent.getLName();
			Integer country_citizenship = theStudent.getCID();
			Integer country_residence = theStudent.getRID();
			String street_addr = theStudent.getStAddress();
			String city = theStudent.getCity();
			if (theStudent.getTelephoneCode() == "")
				state = theStudent.getState();
			else
				telephone_code = Integer.parseInt(theStudent.getTelephoneCode());
			Integer zip_code = Integer.parseInt(theStudent.getZipCode());
			Integer area_code = Integer.parseInt(theStudent.getAreaCode());
			String phone_no = theStudent.getPhoneNumber();
			Integer specialization_id = theStudent.getSID();
			
			// insert the applicant into our database.
			if (telephone_code == -1){
				// the student has no telephone code, insert state.
				insertStatement = "INSERT INTO students (f_name,m_initial,l_name,";
				insertStatement += "country_citizenship,country_residence,";
				insertStatement += "street_addr,city,state,zip_code,";
				insertStatement += "area_code,phone_no,specialization_id) VALUES";
				insertStatement += "('"+ f_name +"','"+ m_initial +"','"+ l_name +"',"+ country_citizenship +","+ country_residence +",'"+ street_addr +"',";
				insertStatement += "'"+ city +"','"+ state +"',"+ zip_code +","+ area_code +",'"+ phone_no +"',"+ specialization_id +")";
			}else{
				// the student does have a telephone code, insert this and not state.
				insertStatement = "INSERT INTO students (f_name,m_initial,l_name,";
				insertStatement += "country_citizenship,country_residence,";
				insertStatement += "street_addr,city,telephone_code,zip_code,";
				insertStatement += "area_code,phone_no,specialization_id) VALUES";
				insertStatement += "('"+ f_name +"','"+ m_initial +"','"+ l_name +"',"+ country_citizenship +","+ country_residence +",'"+ street_addr +"',";
				insertStatement += "'"+ city +"','"+ telephone_code +"',"+ zip_code +","+ area_code +",'"+ phone_no +"',"+ specialization_id +")";
			}
			pstmt = conn.prepareStatement(insertStatement);
			
			// notice the function is executeUpdate, not executeQuery, since we do not expect a return value
			pstmt.executeUpdate();

			// get the student id
			String selectStatement = "SELECT MAX(id) as id FROM students";
			pstmt = conn.prepareStatement(selectStatement);
			ResultSet rs = pstmt.executeQuery();
			
			while (rs.next()) {
				studentID = rs.getInt("id");
			}
		
			// change the insert statement so we can loop through all the degrees
			// and add each one to the database.
			Degree nextDegree = null;
			Integer uid = null;
			Integer did = null;
			Double gpa = null;
			String degreeLevel = null;
			String gradMonth = null;
			String gradYear = null;
			
			for (int i = 0; i < theStudent.numOfDegrees(); i++){
				// first, lets save the variables per degree.
				nextDegree = theStudent.getDegree(i);
				uid = nextDegree.getUID();
				did = nextDegree.getDID();
				gpa = Double.parseDouble(nextDegree.getGPA());
				degreeLevel = nextDegree.getDegreeLevel();
				gradMonth = nextDegree.getGradMonth();
				gradYear = nextDegree.getGradYear();
				
				// then, lets insert this degree info into the db.
				insertStatement = "INSERT INTO degrees (id,university_id,";
				insertStatement += "discipline_id,gpa,degree_level,grad_month,grad_year) VALUES";
				insertStatement += "("+ studentID +","+ uid +","+ did +","+ gpa +",'"+ degreeLevel +"',";
				insertStatement += "'"+ gradMonth +"',"+ gradYear +")";
				pstmt = conn.prepareStatement(insertStatement);
				pstmt.executeUpdate();
			}
			

		%>
			
        <%-- -------- Close Connection Code -------- --%>
        <%
            // Close our connections

            statement.close();

            conn.close();
			
			// do not allow multiple submissions
			session.invalidate();
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
		
		} // close if statement that checked if the student was null
        %>
	</head>
	<body>
		<h1>Confirmation Page</h1>
		<%
			if(theStudent != null){
		%>
			YOUR STUDENT ID IS: <%= studentID %>
		<%
			} else {
		%>
			You are not allowed to make multiple submissions.
		<%
			}
		%>
	</body>
</html>