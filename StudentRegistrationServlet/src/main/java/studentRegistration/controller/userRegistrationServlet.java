package studentRegistration.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Base64;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import studentRegistration.dao.AdminDAO;
import studentRegistration.dto.AdminDTO;
import studentRegistration.model.AdminBean;

/**
 * Servlet implementation class userRegistrationServlet
 */
@WebServlet("/user_registration")
public class userRegistrationServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public userRegistrationServlet() {
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
			System.out.println(session.getAttribute("user_role"));

			Byte user_role = (byte) session.getAttribute("user_role");
			
			if (user_role == 1) {
				response.sendRedirect("management");
			}else {
				int count = AdminDAO.countUsers();
				request.setAttribute("user_id", count + 1);
				request.getRequestDispatcher("user_registration.jsp").forward(request, response);
			}
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

		String defaultImagePath = getServletContext().getRealPath("/resources/default.png");
		File imageFile = new File(defaultImagePath);
		try (InputStream imageInputStream = new FileInputStream(imageFile)) {
			String image = Base64.getEncoder().encodeToString(imageInputStream.readAllBytes());

			AdminBean bean = new AdminBean();
			bean.setName(request.getParameter("name"));
			bean.setEmail(request.getParameter("email"));
			bean.setPassword(request.getParameter("password"));
			bean.setRole(Byte.parseByte(request.getParameter("role")));
			bean.setUser_id(Integer.parseInt(request.getParameter("user_id")));
			bean.setImage(image);

			AdminDTO adminDto = new AdminDTO();
			adminDto.setName(bean.getName());
			adminDto.setEmail(bean.getEmail());
			adminDto.setPassword(bean.getPassword());
			adminDto.setRole(bean.getRole());
			adminDto.setUser_id(bean.getUser_id());
			adminDto.setImage(bean.getImage());

			boolean success = AdminDAO.userRegister(adminDto);
			if(success) {
				request.setAttribute("already", "Your Email is already registered!!!");
				int count = AdminDAO.countUsers();
				request.setAttribute("user_id", count + 1);
				request.getRequestDispatcher("user_registration.jsp").forward(request, response);
				return;
			}
		} catch (NumberFormatException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		response.sendRedirect("user_registration");
	}

}
