package studentRegistration.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import studentRegistration.dao.StudentDAO;
import studentRegistration.dto.StudentDTO;

/**
 * Servlet implementation class studentSearchServlet
 */
@WebServlet("/student_search")
public class studentSearchServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public studentSearchServlet() {
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
		String stuId = request.getParameter("stu_id");
		String name = request.getParameter("stu_name");
		String course = request.getParameter("course");
		
		List<StudentDTO> stu_lst;
		if (course != null && !course.trim().isEmpty()) {
			stu_lst = StudentDAO.selectStudentByCourse(course);
		} else if (name != null && !name.trim().isEmpty()) {
			stu_lst = StudentDAO.selectStudentByName(name);
		}else {
			stu_lst = StudentDAO.selectStudentById(stuId);
			
		}
		request.setAttribute("stu_lst", stu_lst);
		request.getRequestDispatcher("show_students.jsp").forward(request, response);
	}

}
