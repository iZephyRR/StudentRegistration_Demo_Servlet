package studentRegistration.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import studentRegistration.dao.CoursesDAO;
import studentRegistration.dao.StudentDAO;
import studentRegistration.dto.StudentDTO;

/**
 * Servlet implementation class updateStudentServlet
 */
@WebServlet("/student_update")
public class updateStudentServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public updateStudentServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int userId= (int) request.getSession(false).getAttribute("userId");
		int stuId = Integer.parseInt(request.getParameter("stuId"));
		String name = request.getParameter("name");
		String dob = request.getParameter("dob");
		String gender = request.getParameter("gender");
		String phone = request.getParameter("phone");
		String edu = request.getParameter("education");
		
		System.out.println(name+" "+dob);
		
		StudentDTO dto = new StudentDTO();
		dto.setId(stuId);
		dto.setName(name);
		dto.setDob(dob);
		dto.setGender(gender);
		dto.setPhone(phone);
		dto.setEducation(edu);
		dto.setUser_id(userId);
		StudentDAO.updateStudent(dto);
		
		CoursesDAO.deleteCouIdAndStuId(stuId);
		
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
		
		response.sendRedirect("student_detail?stuId="+stuId);
		
	}

}
