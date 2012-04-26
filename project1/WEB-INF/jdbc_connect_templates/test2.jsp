<%
try {
    Class.forName("connect.microsoft.MicrosoftDriver");
    //Class.forName("oracle.jdbc.driver.OracleDriver"); for Oracle driver
    //Class.forName("com.sybase.jdbc.SybDriver"); for sybase driver
} catch(ClassNotFoundException e) {
    System.err.println("Error loading driver: " + e);
}

String test = "test";
%>
<%= test %>