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
<title>Log In</title>
<link rel="canonical"
	href="https://getbootstrap.com/docs/4.5/examples/grid/">

<!-- Bootstrap core CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2"
	crossorigin="anonymous">
<link rel="stylesheet" href="style/style.css">
<link rel="stylesheet" href="style/login.css">
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"
	integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj"
	crossorigin="anonymous"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-ho+j7jyWK8fNQe+A12Hb8AhRq26LrZ/JpcUGGOn+Y7RsweNrtN/tE3MoK7ZeZDyx"
	crossorigin="anonymous"></script>
<script defer type="text/javascript">
	$(document).ready(function() {
		$("#myModal").modal();
	});
</script>
</head>
<body class="text-center">
	<%
		String disp_login_modal = (String) session.getAttribute("disp_login_modal");
	if (disp_login_modal != null && disp_login_modal.equals("y")) {
	%>
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog">
		<div class="modal-dialog modal-dialog-centered" role="document">
			<div class="modal-content">
				<div class="modal-header bg-warning">
					<h5 class="modal-title">Error</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<h5 class="font-weight-bold">Incorrect username or password.</h5>
				</div>
				<div class="modal-footer my-0 py-0">
					<button type="button" class="btn btn-secondary"
						data-dismiss="modal">Close</button>
				</div>
			</div>
		</div>
	</div>
	<%
		}
	session.setAttribute("disp_login_modal", "n");
	%>

	<%
		String disp_signup_success_modal = (String) session.getAttribute("disp_signup_success_modal");
	if (disp_signup_success_modal != null && disp_signup_success_modal.equals("y")) {
	%>
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog">
		<div class="modal-dialog modal-dialog-centered" role="document">
			<div class="modal-content">
				<div class="modal-body">
					<h5 class="font-weight-bold">Sign up successfully!</h5>
				</div>
				<div class="modal-footer my-0 py-0">
					<button type="button" class="btn btn-secondary"
						data-dismiss="modal">Close</button>
				</div>
			</div>
		</div>
	</div>
	<%
		}
	session.setAttribute("disp_signup_success_modal", "n");
	%>

	<%
		String disp_logout_done = (String) request.getAttribute("disp_logout_done");
	if (disp_logout_done != null && disp_logout_done.equals("y")) {
	%>
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog">
		<div class="modal-dialog modal-dialog-centered" role="document">
			<div class="modal-content">
				<div class="modal-body">
					<h5 class="font-weight-bold">You successfully logged out.</h5>
				</div>
				<div class="modal-footer my-0 py-0">
					<button type="button" class="btn btn-secondary"
						data-dismiss="modal">Close</button>
				</div>
			</div>
		</div>
	</div>
	<%
		}
	request.setAttribute("disp_logout_done", "n");
	%>

	<%
		String disp_signup_fail_modal = (String) session.getAttribute("disp_signup_fail_modal");
	if (disp_signup_fail_modal != null && disp_signup_fail_modal.equals("y")) {
	%>
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog">
		<div class="modal-dialog modal-dialog-centered" role="document">
			<div class="modal-content">
				<div class="modal-header bg-warning">
					<h5 class="modal-title">Error</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<h5 class="font-weight-bold">Duplicate username!</h5>
				</div>
				<div class="modal-footer my-0 py-0">
					<button type="button" class="btn btn-secondary"
						data-dismiss="modal">Try again</button>
				</div>
			</div>
		</div>
	</div>
	<%
		}
	session.setAttribute("disp_signup_fail_modal", "n");
	%>

	<%
		String disp_order_first_login = (String) session.getAttribute("disp_order_first_login");
	if (disp_order_first_login != null && disp_order_first_login.equals("y")) {
	%>
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog">
		<div class="modal-dialog modal-dialog-centered" role="document">
			<div class="modal-content">
				<div class="modal-body">
					<h5 class="font-weight-bold">Please login first.</h5>
				</div>
				<div class="modal-footer my-0 py-0">
					<button type="button" class="btn btn-secondary"
						data-dismiss="modal">OK</button>
				</div>
			</div>
		</div>
	</div>
	<%
		}
	session.setAttribute("disp_order_first_login", "n");
	%>

	<form class="form-signin" method="post"
		action="<%=response.encodeURL(request.getContextPath() + "/LoginServlet")%>">
		<img class="mb-1" src="res/car_icon.svg" alt="" width="72" height="72">
		<h4 id="ats_title">Automobile Trading System</h4>
		<input type="text" id="uid" class="form-control" name="uid"
			placeholder="ID" required autofocus> <label
			for="inputPassword" class="sr-only">Password</label> <input
			type="password" id="inputPassword" class="form-control" name="pwd"
			placeholder="Password" required>
		<div class="checkbox mb-3"></div>
		<button class="btn btn-lg btn-primary btn-block" type="submit"
			name="log_in">Log In</button>
		<hr>
		<button class="btn btn-lg btn-success btn-block" type="submit"
			name="sign_in">Sign Up</button>
		<a id="skip"
			href="<%=response.encodeURL(request.getContextPath() + "/shopping.jsp")%>">Skip</a>
	</form>
</body>
</html>