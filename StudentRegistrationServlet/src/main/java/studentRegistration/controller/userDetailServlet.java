package studentRegistration.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import studentRegistration.dao.CoursesDAO;
import studentRegistration.dao.StudentDAO;
import studentRegistration.model.CoursesBean;
import studentRegistration.model.StudentBean;

/**
 * Servlet implementation class userDetailServlet
 */
@WebServlet("/user_detail")
public class userDetailServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public userDetailServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		if (session != null && session.getAttribute("userId") != null) {
			int user_id = Integer.parseInt(request.getParameter("userId"));
			List<StudentBean> stu_list = StudentDAO.selectByUserID(user_id);
			List<CoursesBean> cou_list = CoursesDAO.selectCoursesByUserId(user_id);
			request.setAttribute("stu_list", stu_list);
			request.setAttribute("cou_list", cou_list);
			request.getRequestDispatcher("user_detail.jsp").forward(request, response);
		} else {
			response.sendRedirect("user_login");
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
