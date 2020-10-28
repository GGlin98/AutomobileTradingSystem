<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>index</title>
</head>
<body>
	<% session.invalidate();
	request.setAttribute("disp_logout_done", "y");
	%>
	<jsp:forward page="login.jsp"></jsp:forward> 
</body>
</html>