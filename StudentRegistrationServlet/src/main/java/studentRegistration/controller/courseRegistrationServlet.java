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
import studentRegistration.dto.CoursesDTO;
import studentRegistration.model.CoursesBean;

/**
 * Servlet implementation class course_registration
 */
@WebServlet("/course_registration")
public class courseRegistrationServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public courseRegistrationServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		if (request.getSession(false) != null && request.getSession(false).getAttribute("userId") != null) {
			List<CoursesBean> cou_list = CoursesDAO.countManyTable();
			request.setAttribute("cou_list", cou_list);
			request.getRequestDispatcher("course_registration.jsp").forward(request, response);
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
		HttpSession session = request.getSession(false);
		if (session != null && session.getAttribute("userId") != null) {
			CoursesBean cbean = new CoursesBean();
			cbean.setName(request.getParameter("name"));
			CoursesDTO cDto = new CoursesDTO();
			cDto.setName(cbean.getName());
			int userId = (Integer) session.getAttribute("userId");
			boolean isDuplicate = CoursesDAO.addCourse(cDto, userId);
			if (isDuplicate) {
				request.setAttribute("duplicate", "Course Name is already registered!!!");
			}
			List<CoursesBean> cou_list = CoursesDAO.countManyTable();
			request.setAttribute("cou_list", cou_list);
			request.getRequestDispatcher("course_registration.jsp").forward(request, response);
		} else {
			response.sendRedirect("user_login");
		}

	}

}
