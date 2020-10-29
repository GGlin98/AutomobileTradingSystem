package servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import database.DBAO;
import java.util.*;
import java.sql.Timestamp;

/**
 * Servlet implementation class CreateOrderServlet
 */
@WebServlet("/CreateOrderServlet")
public class CreateOrderServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public CreateOrderServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		DBAO db;
		HttpSession session = request.getSession();
		response.setContentType("text/html");
		db = (DBAO) session.getAttribute("db");

		Date date = new java.util.Date();
		Calendar cal = Calendar.getInstance();
		cal.setTime(date);

		Timestamp ts = new Timestamp(cal.getTimeInMillis());
		String Dealer = (String) session.getAttribute("Dealer");
		String car_id = (String) session.getAttribute("car_id");

		String uid = (String) session.getAttribute("uid");
		String firstName = (String) request.getParameter("firstName");
		String lastName = (String) request.getParameter("lastName");
		String email = (String) request.getParameter("email");
		String tel = (String) request.getParameter("tel");
		String address = (String) request.getParameter("address");
		String country = (String) request.getParameter("country");
		String zip = (String) request.getParameter("zip");
		String saveInfo = (String) request.getParameter("save-info");

		if (db == null) {
			try {
				db = new DBAO();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		int ct = db.createOrder(uid, car_id, ts, Dealer, firstName, lastName, email, tel, address, country, zip);
		
		if (saveInfo.equals("on"))
			// Save User Info
			ct = db.saveUserInfo(firstName, lastName, email, tel, address, country, zip);
		else
			ct = db.saveUserInfo("", "", "", "", "", "", "");
		
//		request.getRequestDispatcher("ordersList.jsp").forward(request, response);
		response.sendRedirect("ordersList.jsp");
	}

}
