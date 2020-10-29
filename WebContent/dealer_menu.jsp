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
<title>Customers' orders</title>
<link rel="canonical"
	href="https://getbootstrap.com/docs/4.5/examples/grid/">

<!-- Bootstrap core CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2"
	crossorigin="anonymous">
<link rel="stylesheet" href="style/style.css">
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"
	integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj"
	crossorigin="anonymous"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-ho+j7jyWK8fNQe+A12Hb8AhRq26LrZ/JpcUGGOn+Y7RsweNrtN/tE3MoK7ZeZDyx"
	crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script defer src="js/dealer_menu.js"></script>
<style type="text/css">
.lh-condensed {
	line-height: 1.25;
}
</style>
</head>
<body>
	<%
		String uid = (String) session.getAttribute("uid");
	DBAO db = (DBAO) session.getAttribute("db");
	if (null == db) {
		db = new DBAO();
		session.setAttribute("db", db);
	}
	ArrayList<Map<String, String>> orders = db.getCustomersOrders(uid);
	int size = orders.size();
	%>
	<div class="container">

		<div class="row mt-3 justify-content-between">
			<div class="col-auto">
				<h4 class="d-flex justify-content-between align-items-center">Customers'
					orders</h4>
			</div>
			<div class="col-auto">
				<a
					href="<%=response.encodeURL(request.getContextPath() + "/logout.jsp")%>"
					class="btn btn-secondary">Log out</a>
			</div>
		</div>

		<div class="row mt-3">
			<%
				if (size > 0) {
			%>
			<ul class="list-group mb-3">
				<%
					for (int i = 0; i < size; i++) {
					Map<String, String> order = (HashMap<String, String>) orders.get(i);
					HashMap<String, ?> car = (HashMap<String, ?>) db.getCarDetail((String) order.get("car_id"));
					String status = (String) order.get("order_status");
				%>
				<li
					class="list-group-item d-flex justify-content-between lh-condensed">
					<div>
						<h5 class="my-0 order_time"><%=(String) order.get("order_time")%></h5>
						<hr class="my-1">
						<h6 class="my-0">
							<%=(String) car.get("Dealer") + " " + car.get("Model")%></h6>
						<small class="text-muted"><%=car.get("Year")%></small><br> <small
							class="text-muted"><%=((String) car.get("(description)")).replace("(", "").replace(")", "")%></small>
						<br>
						<h6 class="my-0">
							Price: $<%=(String) car.get("MSRP")%></h6>
						<hr class="my-1">
						<small class="text-muted"><span
							class="text_bold text_black">User: </span><span class="uid"><%=order.get("uid")%></span></small><br>
						<small class="text-muted"><span
							class="text_bold text_black">Deliver to: </span><%=order.get("first_name") + " " + order.get("last_name")%></small><br>
						<small class="text-muted"><span
							class="text_bold text_black">Email: </span><%=order.get("email")%></small><br>
						<small class="text-muted"><span
							class="text_bold text_black">Tel: </span><%=order.get("tel")%></small><br>
						<small class="text-muted"><span
							class="text_bold text_black">Address: </span><%=order.get("address")%></small><br>
						<small class="text-muted"><span
							class="text_bold text_black">Country: </span><%=order.get("country")%></small><br>
						<small class="text-muted"><span
							class="text_bold text_black">Zip code: </span><%=order.get("zip")%></small>
						<hr class="mt-1 mb-2">
						<h6>
							Status:
							<%
							if (status.equals("initiated")) {
						%>
							<span class="order_status">Waiting for confirmation</span>
							<%
								} else if (status.equals("confirmed")) {
							%>
							<span class="order_status">The order has been confirmed,
								waiting for the customer's payment.</span>
							<%
								} else if (status.equals("canceled")) {
							%>
							<span class="order_status">The order has been canceled.</span>
							<%
								} else if (status.equals("paid")) {
							%>
							<span class="order_status">The order has been paid, please
								set the expected deliver date.</span><br>
							<p class="my-3">
								Expected deliver date: <input type="text" class="datepicker"
									size="30">
							</p>
							<button type="button" class="btn btn-success confirm_date_btn">Set
								date</button>
							<%
								} else if (status.equals("delivering")) {
							%>
							<span class="order_status">The order is being delivered.<br>
								Expected deliver date: <%=order.get("edd")%></span>
							<%
								} else if (status.equals("completed")) {
							%>
							<span class="order_status">The order has been completed.</span>
							<%
								}
							%>
						</h6>
						<!-- 						<button type="button" class="btn btn-success" data-toggle="modal" -->
						<!-- 							data-target="#confirmModal">Confirm</button> -->
						<%
							if (status.equals("initiated")) {
						%>
						<button type="button" class="btn btn-success confirm_btn">Confirm</button>
						<button type="button" class="btn btn-danger cancel_btn">Cancel</button>
						<%
							}
						%>
					</div>
				</li>
				<%
					}
				%>
			</ul>
			<%
				}
			%>
		</div>
	</div>

	<div class="modal fade" id="confirmModal" tabindex="-1" role="dialog"
		aria-labelledby="Confirm the order" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalCenterTitle">Confirm
						the order</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">...</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary">Done</button>
				</div>
			</div>
		</div>
	</div>
</body>
</html>