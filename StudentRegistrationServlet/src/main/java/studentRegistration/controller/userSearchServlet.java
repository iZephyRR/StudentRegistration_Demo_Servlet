package studentRegistration.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import studentRegistration.dao.AdminDAO;
import studentRegistration.model.AdminBean;

/**
 * Servlet implementation class userSearchServlet
 */
@WebServlet("/user_search")
public class userSearchServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public userSearchServlet() {
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
		String userId = request.getParameter("userId");
		String name = request.getParameter("name");
		
		List<AdminBean> lst ;
		if(name != null && !name.trim().isEmpty()) {
			lst = AdminDAO.searchUsersByName(name);
		}else {
			lst = AdminDAO.searchUsersById(userId);
		}
		request.setAttribute("users_lst", lst);
		request.getRequestDispatcher("show_users.jsp").forward(request, response);
	}

}
