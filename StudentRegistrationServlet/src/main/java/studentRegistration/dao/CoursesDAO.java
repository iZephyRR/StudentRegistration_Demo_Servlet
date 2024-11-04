package studentRegistration.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import studentRegistration.dto.CoursesDTO;
import studentRegistration.model.CoursesBean;

public class CoursesDAO {

	public static Connection con = null;
	static {
		con = MyConnection.getConnection();
	}

	// insert course
	public static boolean addCourse(CoursesDTO cDto, int userId) {
		boolean success = true;
		String sql = "insert into courses (name,users_id, date,is_delete) values(?,?, CURRENT_TIMESTAMP,?)";
		try {
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, cDto.getName());
			ps.setInt(2, userId);
			ps.setInt(3, 0);
			success = ps.execute();
		} catch (SQLException e) {
			System.out.println("insert course : " + e.getMessage());
		}
		return success;
	}

	// select courses
	public static List<CoursesDTO> selectCourses() {
		List<CoursesDTO> lst = new ArrayList<>();
		String sql = "select * from courses where is_delete=" + 0;
		try {
			PreparedStatement ps = con.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				CoursesDTO cDto = new CoursesDTO();
				cDto.setId(rs.getInt("id"));
				cDto.setName(rs.getString("name"));
				lst.add(cDto);
			}
		} catch (SQLException e) {
			System.out.println("select courses : " + e.getMessage());
		}
		return lst;
	}

	// select courses
	public static List<CoursesDTO> selectAllCourses() {
		List<CoursesDTO> lst = new ArrayList<>();
		String sql = "select * from courses";
		try {
			PreparedStatement ps = con.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				CoursesDTO cDto = new CoursesDTO();
				cDto.setId(rs.getInt("id"));
				cDto.setName(rs.getString("name"));
				lst.add(cDto);
			}
		} catch (SQLException e) {
			System.out.println("select courses : " + e.getMessage());
		}
		return lst;
	}

	// many to many
	public static int addStudentCourses(int couId, int stuId) {
		int success = 0;
		String sql = "insert into courses_students(courses_id, students_id) values (?,?)";
		try {
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, couId);
			ps.setInt(2, stuId);
			success = ps.executeUpdate();
		} catch (SQLException e) {
			System.out.println("insert course and student : " + e.getMessage());
		}
		return success;
	}

	// select courses by user ID
	public static List<CoursesBean> selectCoursesByUserId(int userId) {
		List<CoursesBean> lst = new ArrayList<>();
		String sql = "select name , date from courses where users_id=?";
		try {
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, userId);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				CoursesBean bean = new CoursesBean();
				bean.setName(rs.getString("name"));
				bean.setCreate_date(rs.getString("date"));
				lst.add(bean);
			}
		} catch (SQLException e) {
			System.out.println("select courses : " + e.getMessage());
		}
		return lst;
	}

	// count
	public static int countCourses() {
		int count = 0;
		String sql = "select count(*) as count from courses";
		try {
			PreparedStatement ps = con.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				count = rs.getInt("count");
			}
		} catch (SQLException e) {
			System.out.println("count courses : " + e.getMessage());
		}
		return count;
	}

	// delete rows many-to-many table
	public static void deleteCouIdAndStuId(int stuId) {
		String sql = "delete from  courses_students where students_id=?";
		try {
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, stuId);
			ps.execute();
		} catch (SQLException e) {
			System.out.println("delete many-to-many : " + e.getMessage());
		}
	}

	// count from many-to-many
	public static List<CoursesBean> countManyTable() {
		List<CoursesBean> lst = new ArrayList<>();
		String sql = "select COUNT(cs.students_id) AS student_count ,c.id, c.name,c.date, c.is_delete from courses c "
				+ "left join courses_students cs  on cs.courses_id = c.id group by c.name order by c.id desc";
		try {
			PreparedStatement ps = con.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				CoursesBean bean = new CoursesBean();
				bean.setId(rs.getInt("id"));
				bean.setName(rs.getString("name"));
				bean.setCount(rs.getInt("student_count"));
				bean.setCreate_date(rs.getString("date"));
				bean.setIs_delete(rs.getInt("is_delete"));
				lst.add(bean);
			}
		} catch (SQLException e) {
			System.out.println("count from many-to-many : " + e.getMessage());
		}
		return lst;
	}

	// select courses name
	public static String selectCoursesName() {
		String coursesName = null;
		String sql = "select group_concat(name separator ',') as courses_name from courses";
		try {
			PreparedStatement ps = con.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				coursesName = rs.getString("courses_name");
			}
		} catch (SQLException e) {

		}
		return coursesName;
	}

	// soft delete and add
	public static boolean userSoftDeleteAndAdd(int id, int num) {
		boolean softDeleteOk = true;
		String sql = "update courses set is_delete=? where id=?";
		try {
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, num);
			ps.setInt(2, id);
			softDeleteOk = ps.execute();
		} catch (SQLException e) {
			System.out.println("user soft delete : " + e.getMessage());
		}
		return softDeleteOk;
	}

}
