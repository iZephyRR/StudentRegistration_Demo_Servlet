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
import studentRegistration.dao.CoursesDAO;
import studentRegistration.dao.StudentDAO;
import studentRegistration.dto.AdminDTO;
import studentRegistration.model.CoursesBean;
import studentRegistration.model.StudentBean;

/**
 * Servlet implementation class loginServlet
 */
@WebServlet("/user_login")
public class loginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public loginServlet() {
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
			int id = (int) session.getAttribute("userId");
			AdminDTO dto = AdminDAO.getUser(id);
			session.setAttribute("userName", dto.getName());
			session.setAttribute("userImage", dto.getImage());
			int courses_count = CoursesDAO.countCourses();
			int students_count = StudentDAO.countStudents();
			int users_count = AdminDAO.countUsers();
			request.setAttribute("courses", courses_count);
			request.setAttribute("students", students_count);
			request.setAttribute("users", users_count);
			
			List<CoursesBean> cou_list = CoursesDAO.countManyTable();
			request.setAttribute("cou_list", cou_list);
			
			List<StudentBean> stu_lst = StudentDAO.selectAllStudentsMainPage();
			request.setAttribute("stu_lst", stu_lst);
			
			request.getRequestDispatcher("main.jsp").forward(request, response);
		} else {
			request.getRequestDispatcher("login.jsp").forward(request, response);
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String email = request.getParameter("email");
		String password = request.getParameter("password");
		AdminDTO adminDTO = AdminDAO.userLogin(email, password);
		if (adminDTO != null && adminDTO.getName() != null) {
			if (adminDTO.getIs_delete() == 0) {
				HttpSession session = request.getSession();// session create
				session.setAttribute("userId", adminDTO.getUser_id());
				session.setAttribute("userName", adminDTO.getName());
				session.setAttribute("id", adminDTO.getId());
				session.setAttribute("userImage", adminDTO.getImage());
				session.setAttribute("user_role", adminDTO.getRole());
				
				int courses_count = CoursesDAO.countCourses();
				int students_count = StudentDAO.countStudents();
				int users_count = AdminDAO.countUsers();
				request.setAttribute("courses", courses_count);
				request.setAttribute("students", students_count);
				request.setAttribute("users", users_count);
				
				List<CoursesBean> lst = CoursesDAO.countManyTable();
				request.setAttribute("cou_list", lst);
				
				List<StudentBean> stu_lst = StudentDAO.selectAllStudentsMainPage();
				request.setAttribute("stu_lst", stu_lst);
				
				request.getRequestDispatcher("main.jsp").forward(request, response);
			} else {
				request.setAttribute("errorMessage", "You got ban. You can't login at this time!!!");
				request.getRequestDispatcher("login.jsp").forward(request, response);
			}
		} else {
			request.setAttribute("errorMessage", "Invalid email or password.");
			request.getRequestDispatcher("login.jsp").forward(request, response);
		}
	}

}
