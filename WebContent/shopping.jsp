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
<title>Shopping</title>
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
		String uid = (String) session.getAttribute("uid");
	if (null != uid) {
	%>

	<div class="container">
		<div class="row justify-content-between">
			<div class="col-auto">
				<h4 id="ats_title" class="mt-2">Automobile Trading System</h4>
			</div>
			<div class="col-auto">
				<nav class="nav">
					<a class="nav-link"> Sign in as <mark><%=uid%></mark>
					</a> <a class="nav-link btn btn-outline-info m-1"
						href="<%=response.encodeURL(request.getContextPath() + "/ordersList.jsp")%>">My
						orders</a> <a class="nav-link btn btn-outline-dark m-1"
						href="<%=response.encodeURL(request.getContextPath() + "/logout.jsp")%>">Log
						out</a>
				</nav>
			</div>
		</div>
	</div>
	<%
		} else {
	%>
	<div class="container">
		<div class="row justify-content-between">
			<div class="col-auto">
				<h4 id="ats_title" class="mt-2">Automobile Trading System</h4>
			</div>
			<div class="col-auto">
				<nav class="nav">
					<a class="nav-link btn btn-outline-primary m-1"
						href="<%=response.encodeURL(request.getContextPath() + "/login.jsp")%>">Log
						in</a>
				</nav>
			</div>
		</div>
	</div>
	<%
		}
	%>
	<%!DBAO db;
	ArrayList<Map<String, ?>> cars;%>
	<%
		String page_num = request.getParameter("page"), sort_model = request.getParameter("sort_model"),
			sort_price = request.getParameter("sort_price"), sort_year = request.getParameter("sort_year"),
			sort_country = request.getParameter("sort_country"), sort_type = request.getParameter("sort_type"),
			sort_hp = request.getParameter("sort_hp");
	if (sort_price != null) {
		db = (DBAO) session.getAttribute("db");
		if (session.getAttribute("price_order") == null) {
			session.setAttribute("price_order", "DESC");
		}
		cars = db.getCars("MSRP", (String) session.getAttribute("price_order"));
		if ((String) session.getAttribute("price_order") == "DESC")
			session.setAttribute("price_order", "");
		else
			session.setAttribute("price_order", "DESC");
	} else if (sort_year != null) {
		db = (DBAO) session.getAttribute("db");
		if (session.getAttribute("year_order") == null) {
			session.setAttribute("year_order", "DESC");
		}
		cars = db.getCars("Year", (String) session.getAttribute("year_order"));
		if ((String) session.getAttribute("year_order") == "DESC")
			session.setAttribute("year_order", "");
		else
			session.setAttribute("year_order", "DESC");
	} else if (sort_model != null) {
		db = (DBAO) session.getAttribute("db");
		if (session.getAttribute("model_order") == null) {
			session.setAttribute("model_order", "DESC");
		}
		cars = db.getCars("Dealer", (String) session.getAttribute("model_order"));
		if ((String) session.getAttribute("model_order") == "DESC")
			session.setAttribute("model_order", "");
		else
			session.setAttribute("model_order", "DESC");
	} else if (sort_country != null) {
		db = (DBAO) session.getAttribute("db");
		if (session.getAttribute("country_order") == null) {
			session.setAttribute("country_order", "DESC");
		}
		cars = db.getCars("Country of origin", (String) session.getAttribute("country_order"));
		if ((String) session.getAttribute("country_order") == "DESC")
			session.setAttribute("country_order", "");
		else
			session.setAttribute("country_order", "DESC");
	} else if (sort_type != null) {
		db = (DBAO) session.getAttribute("db");
		if (session.getAttribute("type_order") == null) {
			session.setAttribute("type_order", "DESC");
		}
		cars = db.getCars("Body type", (String) session.getAttribute("type_order"));
		if ((String) session.getAttribute("type_order") == "DESC")
			session.setAttribute("type_order", "");
		else
			session.setAttribute("type_order", "DESC");
	} else if (sort_hp != null) {
		db = (DBAO) session.getAttribute("db");
		if (session.getAttribute("hp_order") == null) {
			session.setAttribute("hp_order", "DESC");
		}
		cars = db.getCars("Horsepower (HP)", (String) session.getAttribute("hp_order"));
		if ((String) session.getAttribute("hp_order") == "DESC")
			session.setAttribute("hp_order", "");
		else
			session.setAttribute("hp_order", "DESC");
	} else {
		// 		cars = null;
		cars = (ArrayList<Map<String, ?>>) session.getAttribute("cars");
	}
	if (null == page_num) {
		page_num = "1";
	}
	%>

	<div class="container">
		<div class="row car_header">
			<div class="col-3 text_center text_bold">
				<p>Image</p>
			</div>
			<div class="col-3 text_center text_bold">
				<p>
					<a class="text_link"
						href="<%=response.encodeURL(request.getContextPath() + "/shopping.jsp?sort_model=true")%>">Car
						Model </a>
				</p>
			</div>
			<div class="col-1 text_center text_bold">
				<p>
					<a class="text_link"
						href="<%=response.encodeURL(request.getContextPath() + "/shopping.jsp?sort_price=true")%>">Price
					</a>
				</p>
			</div>
			<div class="col-1 text_center text_bold">
				<p>
					<a class="text_link"
						href="<%=response.encodeURL(request.getContextPath() + "/shopping.jsp?sort_year=true")%>">Year
					</a>
				</p>
			</div>
			<div class="col-1 text_center text_bold">
				<p>
					<a class="text_link"
						href="<%=response.encodeURL(request.getContextPath() + "/shopping.jsp?sort_country=true")%>">Built
						in </a>
				</p>
			</div>
			<div class="col-1 text_center text_bold">
				<p>
					<a class="text_link"
						href="<%=response.encodeURL(request.getContextPath() + "/shopping.jsp?sort_type=true")%>">Type
					</a>
				</p>
			</div>
			<div class="col-2 text_center text_bold">
				<p>
					<a class="text_link"
						href="<%=response.encodeURL(request.getContextPath() + "/shopping.jsp?sort_hp=true")%>">Horse
						Power </a>
				</p>
			</div>
		</div>
		<%!HashMap<String, ?> car;%>
		<%
			db = new DBAO();
		if (cars == null)
			cars = db.getCars();
		session.setAttribute("cars", cars);
		session.setAttribute("db", db);
		%>
		<%
			int start = (Integer.parseInt(page_num) - 1) * 10;
		int end;
		if (start + 10 > cars.size()) {
			end = cars.size() - 1;
		} else {
			end = start + 9;
		}
		for (int i = start; i <= end; i++) {
			car = (HashMap<String, ?>) cars.get(i);
		%>
		<%
			if (i % 2 == 0) {
		%>
		<div class="row mb-2">
			<%
				} else {
			%>
			<div class="row mb-2 odd-row">
				<%
					}
				%>
				<div class="col-3 text_center">
					<img class="img-fluid" src=<%=car.get("Image URL")%>>
				</div>
				<div class="col-3 text_center description">
					<br>
					<p>
						<a
							href="<%=response.encodeURL(request.getContextPath() + "/carDetail.jsp?id=" + car.get("ID"))%>"
							target="_blank"><span class="model"><%=(String) car.get("Dealer") + " " + car.get("Model")%></span><br><%=((String) car.get("(description)")).replace("(", "").replace(")", "")%></a>
					</p>
				</div>
				<div class="col-1 text_center">
					<br> <br>
					<p class="price">
						$<%=car.get("MSRP")%></p>
				</div>
				<div class="col-1 text_center text_bold">
					<br> <br>
					<p>
						<%=car.get("Year")%></p>
				</div>
				<div class="col-1 text_center text_bold">
					<br> <br>
					<p>
						<%=car.get("Country of origin")%></p>
				</div>
				<div class="col-1 text_center text_bold">
					<br> <br>
					<p>
						<%=car.get("Body type")%></p>
				</div>
				<div class="col-2 text_center text_bold">
					<br> <br>
					<p>
						<%=car.get("Horsepower (HP)") + "HP"%></p>
				</div>
			</div>
			<%
				}
			%>
			<div class="row justify-content-center">
				<div class="col-auto">
					<nav aria-label="Page navigation example">
						<ul class="pagination">
							<%
								String page_str = response.encodeURL(request.getContextPath() + "/shopping.jsp?page=");
							int page_start, page_end;
							int page_cur = Integer.parseInt(page_num);
							if (page_cur <= 5) {
								page_start = 1;
								page_end = page_start + 10;
							} else if (page_cur + 5 > cars.size() / 10 + 1) {
								page_end = cars.size() / 10 + 1;
								page_start = page_end - 10;
							} else {
								page_start = page_cur - 5;
								page_end = page_cur + 5;
							}
							%>
							<%
								if (page_cur != 1) {
							%>
							<li class="page-item"><a class="page-link"
								href="<%=page_str + (page_cur - 1)%>" aria-label="Previous">
									<span aria-hidden="true">&laquo;</span>
							</a></li>
							<%
								} else {
							%>
							<li class="page-item disabled"><a class="page-link" href="#"
								tabindex="-1" aria-disabled="true" aria-label="Previous"> <span
									aria-hidden="true">&laquo;</span>
							</a></li>
							<%
								}
							%>
							<%
								for (int i = page_start; i <= page_end; i++) {
								car = (HashMap<String, ?>) cars.get(i);
							%>
							<%
								if (i == page_cur) {
							%>
							<li class="page-item disabled"><a class="page-link" href="#"
								tabindex="-1" aria-disabled="true"><%=i%></a></li>
							<%
								} else {
							%>
							<li class="page-item"><a class="page-link"
								href="<%=page_str + i%>"><%=i%></a></li>
							<%
								}
							}
							%>
							<%
								if (page_cur != cars.size() / 10 + 1) {
							%>
							<li class="page-item"><a class="page-link"
								href="<%=page_str + (page_cur + 1)%>" aria-label="Next"> <span
									aria-hidden="true">&raquo;</span>
							</a></li>
							<%
								} else {
							%>
							<li class="page-item disabled"><a class="page-link" href="#"
								tabindex="-1" aria-disabled="true" aria-label="Next"> <span
									aria-hidden="true">&raquo;</span>
							</a></li>
							<%
								}
							%>
						</ul>
					</nav>
				</div>
			</div>
		</div>
	</div>
</body>
</html>