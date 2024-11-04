package studentRegistration.controller;

import java.io.IOException;
import java.util.Base64;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import studentRegistration.dao.AdminDAO;
import studentRegistration.dao.StudentDAO;
import studentRegistration.dto.AdminDTO;

/**
 * Servlet implementation class updatePhotoServlet
 */
@WebServlet("/photo_edit")
@MultipartConfig
public class updatePhotoServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public updatePhotoServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		Part imageFile = request.getPart("photo");
		String image = Base64.getEncoder().encodeToString(imageFile.getInputStream().readAllBytes());

		if (request.getParameter("stuId") == null) {
			HttpSession session = request.getSession(false);
			int id = (int) session.getAttribute("userId");
			int success = AdminDAO.updateImage(id, image);
			System.out.println(success);
			AdminDTO dto = AdminDAO.getUser(id);
			session.setAttribute("userImage", dto.getImage());
			response.sendRedirect("profile");
		} else {
			int stuId = Integer.parseInt(request.getParameter("stuId"));
			System.out.println(image);
			int success = StudentDAO.updateImage(stuId, image);
			System.out.println(success);
			response.sendRedirect("student_detail?stuId=" + stuId);
		}

	}

}
