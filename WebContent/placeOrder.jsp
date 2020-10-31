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
<title>Place Order</title>
<link rel="canonical"
	href="https://getbootstrap.com/docs/4.5/examples/grid/">

<!-- Bootstrap core CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2"
	crossorigin="anonymous">
<link rel="stylesheet" href="style/style.css">
<link href="style/placeOrder.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"
	integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj"
	crossorigin="anonymous"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-ho+j7jyWK8fNQe+A12Hb8AhRq26LrZ/JpcUGGOn+Y7RsweNrtN/tE3MoK7ZeZDyx"
	crossorigin="anonymous"></script>
<script src="js/placeOrder.js"></script>
</head>
<body class="bg-light">
	<%
		String uid = (String) session.getAttribute("uid");
	if (null == uid) {
		// Didn't log in
		session.setAttribute("order_state", "y");
		session.setAttribute("disp_order_first_login", "y");
		request.getRequestDispatcher("login.jsp").forward(request, response);
	}
	Map car = (Map) session.getAttribute("car");
	session.setAttribute("Dealer", (String) car.get("Dealer"));
	session.setAttribute("car_id", (String) car.get("ID"));
	DBAO db = (DBAO) session.getAttribute("db");
	Map<String, String> userInfo = db.getUserInfo(uid);
	%>
	<div class="container">
		<div class="row mt-3">
			<div class="col-md-4 order-md-2 mb-4">
				<h4 class="d-flex justify-content-between align-items-center mb-3">
					<span class="text-muted">Your order</span>
				</h4>
				<ul class="list-group mb-3">
					<li
						class="list-group-item d-flex justify-content-between lh-condensed">
						<div>
							<h6 class="my-0"><%=(String) car.get("Dealer") + " " + car.get("Model")%></h6>
							<small class="text-muted"><%=car.get("Year")%></small><br> <br>
							<small class="text-muted"><%=((String) car.get("(description)")).replace("(", "").replace(")", "")%></small><br>
							<br> <small class="text-muted"><%="Built in: " + car.get("Country of origin")%></small><br>
							<br> <small class="text-muted"><%="Type: " + car.get("Body type")%></small><br>
							<br> <small class="text-muted"><%=car.get("Horsepower (HP)") + "HP"%></small>
						</div>
					</li>
					<li class="list-group-item d-flex justify-content-between"><span>Price</span>
						<strong><%="$" + car.get("MSRP")%></strong></li>
				</ul>
			</div>

			<div class="col-md-8 order-md-1">
				<h4 class="mb-3">Shipping address</h4>
				<form class="needs-validation" method="post"
					action="<%=response.encodeURL(request.getContextPath() + "/CreateOrderServlet")%>"
					novalidate>
					<div class="row">
						<div class="col-md-6 mb-3">
							<label for="firstName">First name</label> <input type="text"
								class="form-control" id="firstName" name="firstName"
								placeholder="" value="<%=userInfo.get("first_name")%>" required>
							<div class="invalid-feedback">Valid first name is required.
							</div>
						</div>
						<div class="col-md-6 mb-3">
							<label for="lastName">Last name</label> <input type="text"
								class="form-control" id="lastName" name="lastName"
								placeholder="" value="<%=userInfo.get("last_name")%>" required>
							<div class="invalid-feedback">Valid last name is required.
							</div>
						</div>
					</div>

					<div class="mb-3">
						<label for="email">Email <span class="text-muted">(Optional)</span></label>
						<input type="email" class="form-control" id="email" name="email"
							placeholder="you@example.com" value="<%=userInfo.get("email")%>">
						<div class="invalid-feedback">Please enter a valid email
							address for shipping updates.</div>
					</div>

					<div class="mb-3">
						<label for="tel">Tel <span class="text-muted">(Optional)</span></label>
						<input type="tel" class="form-control" id="tel" name="tel"
							placeholder="6512345678" value="<%=userInfo.get("tel")%>">
						<div class="invalid-feedback">Please enter a valid telephone
							number.</div>
					</div>

					<div class="mb-3">
						<label for="address">Address</label> <input type="text"
							class="form-control" id="address" name="address"
							placeholder="1234 Main St" value="<%=userInfo.get("address")%>"
							required>
						<div class="invalid-feedback">Please enter your shipping
							address.</div>
					</div>

					<div class="row">
						<div class="col-md-8 mb-3">
							<label for="country">Country</label> <select
								class="custom-select d-block w-100" id="country" name="country"
								required>
								<option value="">Choose...</option>
								<%
									if (!((String) userInfo.get("country")).equals("")) {
								%>
								<option selected><%=userInfo.get("country")%></option>
								<%
									}
								%>
								<option>Singapore</option>
								<option>Australia</option>
								<option>Brazil</option>
								<option>Canada</option>
								<option>China</option>
								<option>France</option>
								<option>Germany</option>
								<option>India</option>
								<option>Italy</option>
								<option>Japan</option>
								<option>Mexico</option>
								<option>Netherlands</option>
								<option>Spain</option>
								<option>Turkey</option>
								<option>United Arab Emirates</option>
								<option>United Kingdom</option>
								<option>United States</option>
							</select>
							<div class="invalid-feedback">Please select a valid
								country.</div>
						</div>
						<div class="col-md-4 mb-3">
							<label for="zip">Zip</label> <input type="text"
								class="form-control" id="zip" name="zip" placeholder=""
								value="<%=userInfo.get("zip")%>" required>
							<div class="invalid-feedback">Zip code required.</div>
						</div>
					</div>

					<div class="custom-control custom-checkbox">
						<input type="checkbox" class="custom-control-input" id="save-info"
							name="save-info" checked> <label
							class="custom-control-label mb-4" for="save-info">Save
							this information for next time</label>
					</div>

					<button class="btn btn-primary btn-lg btn-block mb-3" type="submit">Confirm
						Order</button>
				</form>
			</div>
		</div>
	</div>
</body>
</html>