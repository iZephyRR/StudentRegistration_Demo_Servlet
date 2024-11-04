package studentRegistration.controller;

import java.io.IOException;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import studentRegistration.dao.CoursesDAO;
import studentRegistration.dao.StudentDAO;
import studentRegistration.dto.CoursesDTO;
import studentRegistration.dto.StudentDTO;

/**
 * Servlet implementation class editStudentServlet
 */
@WebServlet("/edit_student/*")
public class editStudentServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public editStudentServlet() {
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
			int stuId = Integer.parseInt(request.getParameter("stuId"));
			List<CoursesDTO> lst = CoursesDAO.selectAllCourses();
			request.setAttribute("lst", lst); 
			StudentDTO dto = StudentDAO.findByStuIdForEditPage(stuId);

			Set<Integer> enrolledCourses = new HashSet<>();
            if (dto.getCourses_name() != null && !dto.getCourses_name().isEmpty()) {
                for (String courseId : dto.getCourses_name().split(", ")) {
                    enrolledCourses.add(Integer.parseInt(courseId.trim()));
                }
            }
            
            request.setAttribute("student", dto);
            request.setAttribute("enrolledCourses", enrolledCourses); 
			
			request.getRequestDispatcher("edit_student.jsp").forward(request, response);
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
