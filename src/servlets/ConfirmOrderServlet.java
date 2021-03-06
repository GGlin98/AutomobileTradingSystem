package servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import database.DBAO;

/**
 * Servlet implementation class ConfirmOrderServlet
 */
@WebServlet("/ConfirmOrderServlet")
public class ConfirmOrderServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ConfirmOrderServlet() {
		super();
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		DBAO db;
		@SuppressWarnings("unused")
		int ct;
		HttpSession session = request.getSession();

		String uid = request.getParameter("uid");
		String order_time = request.getParameter("order_time");
		String confirmed = request.getParameter("confirmed");
		db = (DBAO) session.getAttribute("db");

		if (db == null) {
			try {
				db = new DBAO();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		if (confirmed.equals("y"))
			ct = db.confirmOrder(uid, order_time);
		else
			ct = db.cancelOrder(uid, order_time);
	}

}
