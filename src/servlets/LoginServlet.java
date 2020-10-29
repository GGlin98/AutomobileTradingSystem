package servlets;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import util.PasswordUtil;
import database.DBAO;
import java.util.*;

/**
 * Servlet implementation class LoginServlet
 */
//@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public LoginServlet() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		DBAO db;
		String log_in = (String) request.getParameter("log_in");
		String sign_in = (String) request.getParameter("sign_in");
		String uid = (String) request.getParameter("uid");
		String pwd = (String) request.getParameter("pwd");
		String referer = request.getHeader("referer");
		String save_pwd;
		String salted_pwd;

		HttpSession session = request.getSession();
		response.setContentType("text/html");
		db = (DBAO) session.getAttribute("db");
		if (db == null)
			try {
				db = new DBAO();
			} catch (Exception e) {
				e.printStackTrace();
			}

		if (sign_in != null) {
			byte[] salt = PasswordUtil.generateSalt();
			save_pwd = PasswordUtil.getSecurePassword(pwd, salt);
			int ct = db.savePwd(uid, salt, save_pwd);
			if (ct == 1)
				// Sign up successfully
				session.setAttribute("disp_signup_success_modal", "y");
			else
				session.setAttribute("disp_signup_fail_modal", "y");
			response.sendRedirect("login.jsp");
		} else if (log_in != null) {
			ArrayList result = db.getSaltPwd(uid);
			if (result.size() == 2) {
				byte[] salt = (byte[]) result.get(0);
				save_pwd = (String) result.get(1);
				salted_pwd = PasswordUtil.getSecurePassword(pwd, salt);
			} else {
				// User ID not existed
				session.setAttribute("disp_login_modal", "y");
				response.sendRedirect("login.jsp");
				return;
			}
			if (save_pwd.equals(salted_pwd)) {
				// Login successful
				session.setAttribute("disp_login_modal", "n");
				session.setAttribute("uid", uid);
				Map<String, String> userInfo = db.getUserInfo(uid);
				if (((String) userInfo.get("user_type")).equals("dealer")) {
					// User is a dealer
					response.sendRedirect("dealer_menu.jsp");
				} else {
					// User is a customer
					String order_state = (String) session.getAttribute("order_state");
					if (order_state != null && order_state.equals("y")) {
						response.sendRedirect("placeOrder.jsp");
						session.setAttribute("order_state", "n");
					} else {
						response.sendRedirect("shopping.jsp");
					}
				}
			} else {
				// Wrong Password
				session.setAttribute("disp_login_modal", "y");
				response.sendRedirect("login.jsp");
			}
		}
	}
}
