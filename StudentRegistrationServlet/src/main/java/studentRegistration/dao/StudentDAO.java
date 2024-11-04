package studentRegistration.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import studentRegistration.dto.StudentDTO;
import studentRegistration.model.StudentBean;

public class StudentDAO {
	public static Connection con = null;
	static {
		con = MyConnection.getConnection();
	}

	// register
	public static int studentRegister(StudentDTO dto) {
		int success = 0;
		String sql = "insert into students (stu_id,name,dob,gender,phone,education,image,users_id,"
				+ "create_date,is_delete,update_date,updater)"
				+ "values (?,?,?,?,?,?,?,?,CURRENT_TIMESTAMP,?,CURRENT_TIMESTAMP,?)";
		try {
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, dto.getStu_id());
			ps.setString(2, dto.getName());
			ps.setString(3, dto.getDob());
			ps.setString(4, dto.getGender());
			ps.setString(5, dto.getPhone());
			ps.setString(6, dto.getEducation());
			ps.setString(7, dto.getImage());
			ps.setInt(8, dto.getUser_id());
			ps.setInt(9, 0);
			ps.setInt(10, dto.getUser_id());

			success = ps.executeUpdate();
		} catch (SQLException e) {
			System.out.println("student register : " + e.getMessage());
		}
		return success;
	}

	// count
	public static int countStudents() {
		int count = 0;
		String sql = "select count(*) as count from students";
		try {
			PreparedStatement ps = con.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				count = rs.getInt("count");
			}
		} catch (SQLException e) {
			System.out.println("count students : " + e.getMessage());
		}
		return count;
	}

	// select all students
	public static List<StudentDTO> selectAllStudents() {
		List<StudentDTO> lst = new ArrayList<>();
		String sql = "SELECT s.id,s.stu_id, s.name,s.image,s.is_delete, GROUP_CONCAT(c.name SEPARATOR ', ') as cou_name "
				+ "FROM courses c INNER JOIN courses_students cs ON cs.courses_id = c.id "
				+ "INNER JOIN students s ON s.id = cs.students_id GROUP BY s.id, s.stu_id, s.name";
		try {
			PreparedStatement ps = con.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				StudentDTO dto = new StudentDTO();
				dto.setId(rs.getInt("id"));
				dto.setStu_id(rs.getInt("stu_id"));
				dto.setName(rs.getString("name"));
				dto.setCourses_name(rs.getString("cou_name"));
				dto.setImage(rs.getString("image"));
				dto.setIs_delete(rs.getInt("is_delete"));
				lst.add(dto);
			}
		} catch (SQLException e) {
			System.out.println("select all students : " + e.getMessage());
		}
		return lst;
	}

	// findbyId
	public static StudentDTO findByStuID(int stu_id) {
		StudentDTO dto = new StudentDTO();
		String sql = "select s.id, s.stu_id, s.name, s.dob, s.gender, s.phone, s.education,"
				+ "s.image, s.create_date, s.update_date, u.name as updater,"
				+ "group_concat(c.name separator ', ') as cou_name " + "from courses c "
				+ "inner join courses_students cs ON cs.courses_id = c.id "
				+ "inner join students s ON s.id = cs.students_id " + "inner join users u ON u.id = s.updater "
				+ "where s.id = ? GROUP BY s.id, s.stu_id, s.name, s.dob, s.gender, s.phone, s.education, "
				+ "s.image, s.create_date, s.update_date, u.name";
		try {
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, stu_id);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				dto.setId(rs.getInt("id"));
				dto.setStu_id(rs.getInt("stu_id"));
				dto.setName(rs.getString("name"));
				dto.setDob(rs.getString("dob"));
				dto.setGender(rs.getString("gender"));
				dto.setPhone(rs.getString("phone"));
				dto.setEducation(rs.getString("education"));
				dto.setImage(rs.getString("image"));
				dto.setCreate_date(rs.getString("create_date"));
				dto.setUpdate_date(rs.getString("update_date"));
				dto.setCourses_name(rs.getString("cou_name"));
				dto.setUpdater(rs.getString("updater"));
			}
		} catch (SQLException e) {
			System.out.println("find by stu_id : " + e.getMessage());
		}
		return dto;
	}

	// update image
	public static int updateImage(int id, String image) {
		int success = 0;
		String sql = "update students set image = ? where id=?";
		try {
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, image);
			ps.setInt(2, id);
			success = ps.executeUpdate();
		} catch (SQLException e) {
			System.out.println("update image : " + e.getMessage());
		}
		return success;
	}

	// findByStuIdForEditPage
	public static StudentDTO findByStuIdForEditPage(int stu_id) {
		StudentDTO dto = new StudentDTO();
		String sql = "SELECT s.id,s.name,s.dob,s.gender,s.phone,s.education,s.image,"
				+ "s.create_date,s.update_date, GROUP_CONCAT(c.id SEPARATOR ', ') as cou_id "
				+ "FROM courses c INNER JOIN courses_students cs ON cs.courses_id = c.id "
				+ "INNER JOIN students s ON s.id = cs.students_id where s.id=? GROUP BY s.id, s.stu_id, s.name";

		try {
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, stu_id);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				dto.setId(rs.getInt("id"));
				dto.setName(rs.getString("name"));
				dto.setDob(rs.getString("dob"));
				dto.setGender(rs.getString("gender"));
				dto.setPhone(rs.getString("phone"));
				dto.setCourses_name(rs.getString("cou_id"));
			}
		} catch (SQLException e) {
			System.out.println("find by stu_id : " + e.getMessage());
		}
		return dto;
	}

	// select by user id
	public static List<StudentBean> selectByUserID(int userId) {
		List<StudentBean> lst = new ArrayList<>();
		String sql = "select stu_id, name, gender, create_date,image from students where users_id=?";
		try {
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, userId);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				StudentBean bean = new StudentBean();
				bean.setStu_id(rs.getInt("stu_id"));
				bean.setName(rs.getString("name"));
				bean.setGender(rs.getString("gender"));
				bean.setCreate_date(rs.getString("create_date"));
				bean.setImage(rs.getString("image"));
				lst.add(bean);
			}
		} catch (SQLException e) {
			System.out.println("select all students : " + e.getMessage());
		}
		return lst;
	}

	// select all students for main page
	public static List<StudentBean> selectAllStudentsMainPage() {
		List<StudentBean> lst = new ArrayList<>();
		String sql = "select stu_id, name, gender, create_date,image from students ";
		try {
			PreparedStatement ps = con.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				StudentBean bean = new StudentBean();
				bean.setStu_id(rs.getInt("stu_id"));
				bean.setName(rs.getString("name"));
				bean.setGender(rs.getString("gender"));
				bean.setCreate_date(rs.getString("create_date"));
				bean.setImage(rs.getString("image"));
				lst.add(bean);
			}
		} catch (SQLException e) {
			System.out.println("select all students : " + e.getMessage());
		}
		return lst;
	}

	// select student by id
	public static List<StudentDTO> selectStudentById(String id) {
		List<StudentDTO> lst = new ArrayList<>();
		String sql = "SELECT s.id,s.stu_id, s.name,s.image, GROUP_CONCAT(c.name SEPARATOR ', ') as cou_name "
				+ "FROM courses c INNER JOIN courses_students cs ON cs.courses_id = c.id "
				+ "INNER JOIN students s ON s.id = cs.students_id where s.id=? " + "GROUP BY s.id, s.stu_id, s.name";
		try {
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, id);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				StudentDTO dto = new StudentDTO();
				dto.setId(rs.getInt("id"));
				dto.setStu_id(rs.getInt("stu_id"));
				dto.setName(rs.getString("name"));
				dto.setCourses_name(rs.getString("cou_name"));
				dto.setImage(rs.getString("image"));
				lst.add(dto);
			}
		} catch (SQLException e) {
			System.out.println("select students by id : " + e.getMessage());
		}
		return lst;
	}

	// select student by name
	public static List<StudentDTO> selectStudentByName(String name) {
		List<StudentDTO> lst = new ArrayList<>();
		String sql = "SELECT s.id,s.stu_id, s.name,s.image, GROUP_CONCAT(c.name SEPARATOR ', ') as cou_name "
				+ "FROM courses c INNER JOIN courses_students cs ON cs.courses_id = c.id "
				+ "INNER JOIN students s ON s.id = cs.students_id where s.name like ? "
				+ "GROUP BY s.id, s.stu_id, s.name";
		try {
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, "%" + name + "%");
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				StudentDTO dto = new StudentDTO();
				dto.setId(rs.getInt("id"));
				dto.setStu_id(rs.getInt("stu_id"));
				dto.setName(rs.getString("name"));
				dto.setCourses_name(rs.getString("cou_name"));
				dto.setImage(rs.getString("image"));
				lst.add(dto);
			}
		} catch (SQLException e) {
			System.out.println("select students by name: " + e.getMessage());
		}
		return lst;
	}

	// select student by course name
	public static List<StudentDTO> selectStudentByCourse(String course) {
		List<StudentDTO> lst = new ArrayList<>();
		String sql = "SELECT s.id,s.stu_id, s.name,s.image, GROUP_CONCAT(c.name SEPARATOR ', ') as cou_name "
				+ "FROM courses c INNER JOIN courses_students cs ON cs.courses_id = c.id "
				+ "INNER JOIN students s ON s.id = cs.students_id where c.name =? GROUP BY s.id, s.stu_id, s.name";
		try {
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, course);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				StudentDTO dto = new StudentDTO();
				dto.setId(rs.getInt("id"));
				dto.setStu_id(rs.getInt("stu_id"));
				dto.setName(rs.getString("name"));
				dto.setCourses_name(rs.getString("cou_name"));
				dto.setImage(rs.getString("image"));
				lst.add(dto);
			}
		} catch (SQLException e) {
			System.out.println("select students by course: " + e.getMessage());
		}
		return lst;
	}

	// update student
	public static void updateStudent(StudentDTO dto) {
		String sql = "update students set name=?,dob=?,gender=?,phone=?,education=?,updater=?,"
				+ "update_date=CURRENT_TIMESTAMP where id=?";
		try {
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, dto.getName());
			ps.setString(2, dto.getDob());
			ps.setString(3, dto.getGender());
			ps.setString(4, dto.getPhone());
			ps.setString(5, dto.getEducation());
			ps.setInt(6, dto.getUser_id());
			ps.setInt(7, dto.getId());
			ps.execute();
		} catch (SQLException e) {
			System.out.println("update student : " + e.getMessage());
		}
	}

	// soft delete and add
	public static boolean userSoftDeleteAndAdd(int id, int num) {
		boolean softDeleteOk = true;
		String sql = "update students set is_delete=? where id=?";
		try {
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, num);
			ps.setInt(2, id);
			softDeleteOk = ps.execute();
		} catch (SQLException e) {
			System.out.println("student soft delete : " + e.getMessage());
		}
		return softDeleteOk;
	}

}
