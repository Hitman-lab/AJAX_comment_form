<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Comment</title>
</head>
<body>
	<%
		String email = request.getParameter("email");
		String comment = request.getParameter("comment");

		if (comment == null || email == null || comment.trim().equals("") || email.trim().equals("")) {
			out.print("<h4>Please write Comment.</h4>");
		}

		try {

			Class.forName("oracle.jdbc.driver.OracleDriver");
			Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "michael",
					"welcome123");

			PreparedStatement ps1 = con.prepareStatement("insert into usercomment(email,comments) values(?,?)");
			ps1.setString(1, email);
			ps1.setString(2, comment);

			int in_status = ps1.executeUpdate();

			PreparedStatement ps2 = con.prepareStatement("select * from usercomment order by id desc");
			ResultSet rs2 = ps2.executeQuery();
	%>
	<h4>comments:</h4>
	<hr>
	<%
		while (rs2.next()) {
	%>
		<h4><% out.print(rs2.getString("email")); %></h4>
		<h4><% out.print(rs2.getString("comments")); %></h4>
		<hr>
	<%
		}

		} catch (Exception e) {
			System.out.println("Could not load the Database");
			e.printStackTrace();
		}
	%>
</body>
</html>