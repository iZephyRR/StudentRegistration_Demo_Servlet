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
import studentRegistration.model.AdminBean;
import studentRegistration.model.CoursesBean;
import studentRegistration.model.StudentBean;

/**
 * Servlet implementation class profileServlet
 */
@WebServlet("/profile")
public class profileServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public profileServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		if(session != null && session.getAttribute("userId") != null) {
			int userId = (int) session.getAttribute("userId");
			AdminDTO dto = AdminDAO.findById(userId);
			AdminBean bean = new AdminBean();
			bean.setName(dto.getName());
			bean.setEmail(dto.getEmail());
			bean.setImage(dto.getImage());
			bean.setPassword(dto.getPassword());
			request.setAttribute("adminBean", bean);
			List<StudentBean> stu_list = StudentDAO.selectByUserID(userId);
			List<CoursesBean> cou_list = CoursesDAO.selectCoursesByUserId(userId);
			request.setAttribute("stu_list", stu_list);
			request.setAttribute("cou_list", cou_list);
			request.getRequestDispatcher("profile.jsp").forward(request, response);
		}else {
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
