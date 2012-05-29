TEAM INFO:
Nathaniel Asunction A08795157
Anthony Dang A08740980

Assignment 1 Architecture

This webapp follows the model 1 design pattern that features a linear
progression between the pages. The user inputs data on each page, which
is passed and stored in the subsequent page before any new information
processing occurs. The main methods of passing information used during
this assignment was the GET, POST, and session attribute methods. We
created a Student class to facilitate cleaner storage of applicant
information. This was the preferred method over storing several attributes
with session variables.

Assignment 2 Database Comments

Our webapp has now extended use of SQL databases. We have 6 different tables for
countries, degrees, majors, specializations, students, and universities. We also
went back and took the liberty of changing our whole app to work off the database
rather than the vectors from the support package in assignment 1. Our pages
still follow the model 1 programming. We used a variety of queries to get the
applicant data for the analytics pages.

Our table schema and create table commands can be found in the files 
CSE135ERDiagram and CREATE_TABLE_COMMANDS in the same directory.

Assignment 3 AJAX

Our webapp now includes verification on the names.jsp page and the degreeUniversity.jsp
pages. We have also modified our application to only submit custom universities and majors
after the applicant has finished the application completely (i.e. reached the confirmation.jsp page)
The javascript verification on the names.jsp page makes use of regex and Javascript strings.
The verification on the degreeUniversity.jsp page makes use of AJAX protocol to do
the verification of the custom university. Our applications.jsp page also includes functionality
to display applicant info based on a button.