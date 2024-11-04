package studentRegistration.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import studentRegistration.dao.StudentDAO;
import studentRegistration.dto.StudentDTO;
import studentRegistration.model.StudentBean;

/**
 * Servlet implementation class studentDetailServlet
 */
@WebServlet("/student_detail")
public class studentDetailServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public studentDetailServlet() {
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
			int stu_id = Integer.parseInt(request.getParameter("stuId"));

			StudentDTO stu_detailDto = StudentDAO.findByStuID(stu_id);

			StudentBean stu_detail = new StudentBean();
			stu_detail.setId(stu_detailDto.getId());
			stu_detail.setStu_id(stu_detailDto.getStu_id());
			stu_detail.setName(stu_detailDto.getName());
			stu_detail.setDob(stu_detailDto.getDob());
			stu_detail.setGender(stu_detailDto.getGender());
			stu_detail.setPhone(stu_detailDto.getPhone());
			stu_detail.setEducation(stu_detailDto.getEducation());
			stu_detail.setImage(stu_detailDto.getImage());
			stu_detail.setCreate_date(stu_detailDto.getCreate_date());
			stu_detail.setUpdate_date(stu_detailDto.getUpdate_date());
			stu_detail.setCourses_name(stu_detailDto.getCourses_name());
			stu_detail.setUpdater(stu_detailDto.getUpdater());
			request.setAttribute("stu_detail", stu_detail);
			
			request.getRequestDispatcher("student_detail.jsp").forward(request, response);
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
