<%@page import=" Student.*, Degree.*, support.*, java.util.*" %>
<html>
	<head>
		<title>Provide Degrees - Choose Discipline</title>
		<%	
			String university = request.getParameter("university");
			int uid = Integer.parseInt(request.getParameter("uid"));
			
			Student theStudent = (Student) session.getAttribute("theStudent");
			Degree theDegree = (Degree) session.getAttribute("curDegree");
			
			Vector countries = (Vector) session.getAttribute("countries");
			Vector uniLocs = (Vector) session.getAttribute("uniLocs");
			Vector listUnis = (Vector) ((Vector) uniLocs.elementAt(theDegree.getLID())).elementAt(1);
		
			// add the university to the vector if it is a user-specified entry
			if(uid == listUnis.size())
				listUnis.add(university);
			
			theDegree.setUniversity(university);
			theDegree.setUID(uid);
			
			Vector majors = (Vector) session.getAttribute("majors");
			
			if(majors == null){
				support s = new support();
				String path1 = config.getServletContext().getRealPath("majors.txt");
				majors = s.getMajors(path1);
				session.setAttribute("majors",majors);
			}
		%>
	</head>
	<body>
		<h2>Choose a displicine below or enter one if yours is not listed:</h2>
		<br />
		
		<!-- Radio buttons for disciplines. -->
		<form action="moredegrees.jsp" method="POST">
			<%
				String nextMajor = "";
				for (int i = 0; i < majors.size(); i++){
					nextMajor = (String) majors.elementAt(i);
			%>				
				<input type="radio" name="major" value="<%= nextMajor %>"/> <%= nextMajor %> <br />
			<%
				}
			%>
			<br />
			Other discipline: <input type="text" name="major" />
			<br />
			Graduation date: <input type="text" name="gradMonth" value="month" size="10" /> 
			<input type="text" name="gradYear" value="year" size="4" />
			<br />
			GPA: <input type="text" name="GPA" size="5" />
			<select name="degLevel">
				<option value="B.S.">B.S.</option>
				<option value="M.S.">M.S.</option>
				<option value="P.H.D">P.H.D</option>
			</select>
			<input type="submit" value="Submit" />
		</form>
		<h3>Student Information:</h3>
		<!-- Show information so far. -->
		First name: <%= theStudent.getFName() %>
		<br />    
		Middle initial: <%= theStudent.getMidInitial() %>
		<br />    
		Last name: <%= theStudent.getLName() %>
		<br />  
		Country of citizenship: <%= countries.get(theStudent.getCID()) %>
		<br />  
		Country of residence: <%= countries.get(theStudent.getRID()) %>
		<br />  
		Street Address: <%= theStudent.getStAddress() %>
		<br />  
		City: <%= theStudent.getCity() %>
		<br />  
		<%
		if ( countries.get(theStudent.getRID()).equals("United States")){
		%>
			State: <%= theStudent.getState() %>
		<%
		} else {
		%>
			Telephone Code: <%= theStudent.getTelephoneCode() %>
		<%
		}
		%>
		<br />
		Zip Code: <%= theStudent.getZipCode() %>
		<br />  
		Area Code: <%= theStudent.getAreaCode() %>
		<br />  
		Phone Number: <%= theStudent.getPhoneNumber() %>
		<br />
		<!--

		-->
		<br />
	</body>
</html>