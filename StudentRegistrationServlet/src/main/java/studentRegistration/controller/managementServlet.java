package studentRegistration.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import studentRegistration.dao.AdminDAO;
import studentRegistration.model.AdminBean;

/**
 * Servlet implementation class managementServlet
 */
@WebServlet("/management")
public class managementServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public managementServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		if (session != null && session.getAttribute("userId") != null) {
			int userId = (int) session.getAttribute("userId");
			List<AdminBean> lst = AdminDAO.selectUsers(userId);
			byte loginUserRole =  (byte) session.getAttribute("user_role");
			request.setAttribute("users_lst", lst);
			request.setAttribute("loginUserRole", loginUserRole);
			request.getRequestDispatcher("show_users.jsp").forward(request, response);
		} else {
			response.sendRedirect("user_login");
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
