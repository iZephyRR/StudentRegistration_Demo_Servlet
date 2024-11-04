package studentRegistration.controller;

import java.io.IOException;
import java.util.Base64;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import studentRegistration.dao.CoursesDAO;
import studentRegistration.dao.StudentDAO;
import studentRegistration.dto.CoursesDTO;
import studentRegistration.dto.StudentDTO;
import studentRegistration.model.StudentBean;

/**
 * Servlet implementation class studentRegistrationServlet
 */
@WebServlet("/student_registration")
@MultipartConfig
public class studentRegistrationServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public studentRegistrationServlet() {
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
			List<CoursesDTO> lst = CoursesDAO.selectCourses();
			request.setAttribute("lst", lst);
			int count = StudentDAO.countStudents();
			request.setAttribute("stu_id", count + 1);
			request.getRequestDispatcher("student_registration.jsp").forward(request, response);
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
		if (request.getSession(false) != null && request.getSession(false).getAttribute("userId") != null) {
			int stuId = Integer.parseInt(request.getParameter("stu_id"));
			
			StudentBean bean = new StudentBean();
			bean.setStu_id(stuId);
			bean.setName(request.getParameter("name"));
			bean.setDob(request.getParameter("dob"));
			bean.setGender(request.getParameter("gender"));
			bean.setPhone(request.getParameter("phone"));
			bean.setEducation(request.getParameter("education"));
			Part imageFile = request.getPart("imageFile");
			String image = Base64.getEncoder().encodeToString(imageFile.getInputStream().readAllBytes());
			bean.setImage(image);

			StudentDTO dto = new StudentDTO();
			dto.setStu_id(bean.getStu_id());
			dto.setName(bean.getName());
			dto.setDob(bean.getDob());
			dto.setGender(bean.getGender());
			dto.setPhone(bean.getPhone());
			dto.setEducation(bean.getEducation());
			dto.setImage(bean.getImage());

			int userId = (Integer) request.getSession(false).getAttribute("userId");
			
			dto.setUser_id(userId);
			
			StudentDAO.studentRegister(dto);

			String[] attendValues = request.getParameterValues("attendance");

			int[] attend = null;
			if (attendValues != null) {
				attend = new int[attendValues.length];
				for (int i = 0; i < attendValues.length; i++) {
					attend[i] = Integer.parseInt(attendValues[i]);
				}
			}

			for (int i : attend) {
				CoursesDAO.addStudentCourses(i, stuId);
			}

			response.sendRedirect("student_registration");
		} else {
			response.sendRedirect("user_login");
		}
	}

}
