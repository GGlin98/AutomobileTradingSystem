<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="database.DBAO"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>Car Detail</title>
<link rel="canonical"
	href="https://getbootstrap.com/docs/4.5/examples/grid/">

<!-- Bootstrap core CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2"
	crossorigin="anonymous">
<link rel="stylesheet" href="style/style.css">
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"
	integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj"
	crossorigin="anonymous"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-ho+j7jyWK8fNQe+A12Hb8AhRq26LrZ/JpcUGGOn+Y7RsweNrtN/tE3MoK7ZeZDyx"
	crossorigin="anonymous"></script>
</head>
<body>
	<%
		String id = request.getParameter("id");
	DBAO db = (DBAO) session.getAttribute("db");
	HashMap<String, ?> car = (HashMap<String, ?>) db.getCarDetail(id);
	session.setAttribute("car", car.clone());
	car.remove("ID");
	car.remove("Image URL");
	%>
	<div class="container">
		<div class="row my-2 justify-content-center">
			<div class="col-auto">
				<h4>Car specification</h4>
			</div>
		</div>
		<div class="row">
			<div class="col-auto table-wrapper-scroll-y">
				<table class="table table-striped table-bordered">
					<tbody>
						<%
							for (Object key : car.keySet()) {
							key = (String) key;
						%>
						<tr>
							<td class="text_bold" colspan="4"><%=key%></td>
							<td colspan="8"><%=car.get(key)%></td>
						</tr>
						<%
							}
						%>
					</tbody>
				</table>
			</div>
		</div>
		<div class="row justify-content-center">
			<a
				href="<%=response.encodeURL(request.getContextPath() + "/placeOrder.jsp")%>"
				class="btn btn-warning col-3 mt-3">Buy Now</a>
		</div>
	</div>
</body>
</html>