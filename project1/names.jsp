<html>
	<head>
		<title>Name of Applicant</title>
		<script type="text/javascript">
			function validateNames(){
				var fname = document.getElementById("fname").value;
				var lname = document.getElementById("lname").value;
				var midInit = document.getElementById("midInit").value;
				
				var lettersRegex = /^[a-zA-Z]+$/;
				
				if(!fname.match(lettersRegex)){
					alert("Your first name should only contain letters from the English alphabet.");
					return false;
				}
				if(!lname.match(lettersRegex)){
					alert("Your last name should only contain letters from the English alphabet.");
					return false;
				}
				if(midInit.length>0 && !midInit.match(lettersRegex)){
					alert("Your middle initial should only contain letters from the English alphabet.");
					return false;
				}
				return true;
			}
		</script>
	<head>
	<body>
		<h2>Name of Applicant:</h2>
		<!-- Applicant name form. -->
		<form action="citizenship.jsp" method="POST" onsubmit="return validateNames()">
			<%-- Get the first name --%>
			First name: <input type="text" id="fname" name="first" size="15"/>
			<br />       
			<%-- Get the middle name --%>
			Middle Initial: <input type="text" id="midInit" name="middle" size="15"/>
			<br />       
			<%-- Get the last name --%>               
			Last name: <input type="text" id="lname" name="last" size="15"/>
			<br />
			<input type="submit" value="Submit"/>
		</form>              
	</body>
</html>