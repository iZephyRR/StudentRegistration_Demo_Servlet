package studentRegistration.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import studentRegistration.dto.AdminDTO;
import studentRegistration.model.AdminBean;

public class AdminDAO {
	public static Connection con = null;
	static {
		con = MyConnection.getConnection();
	}

	// register
	public static boolean userRegister(AdminDTO adminDto) {
		boolean success = true;
		String sql = "insert into users (name,email,password,role, date,is_delete,user_id,image) values (?,?,?,?,CURRENT_TIMESTAMP,?,?,?)";
		try {
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, adminDto.getName());
			ps.setString(2, adminDto.getEmail());
			ps.setString(3, adminDto.getPassword());
			ps.setByte(4, adminDto.getRole());
			ps.setInt(5, 0);
			ps.setInt(6, adminDto.getUser_id());
			ps.setString(7, adminDto.getImage());
			success = ps.execute();
		} catch (SQLException e) {
			System.out.println("user register : " + e.getMessage());
		}
		return success;
	}

	// login
	public static AdminDTO userLogin(String email, String pass) {
		AdminDTO adminDTO = new AdminDTO();
		String sql = "select * from users where email=? and password =?";
		try {
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, email);
			ps.setString(2, pass);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				adminDTO.setId(rs.getInt("id"));
				adminDTO.setEmail(rs.getString("email"));
				adminDTO.setName(rs.getString("name"));
				adminDTO.setPassword(rs.getString("password"));
				adminDTO.setUser_id(rs.getInt("user_id"));
				adminDTO.setRole(rs.getByte("role"));
				adminDTO.setIs_delete(rs.getInt("is_delete"));
				adminDTO.setImage(rs.getString("image"));
			}
		} catch (SQLException e) {
			System.out.println("user login : " + e.getMessage());
		}
		return adminDTO;
	}

	// select user except login user
	public static List<AdminBean> selectUsers(int userId) {
		List<AdminBean> lst = new ArrayList<>();
		String sql = "select id,user_id, name, date,is_delete from users where id <> ?";
		try {
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, userId);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				AdminBean bean = new AdminBean();
				bean.setId(rs.getInt("id"));
				bean.setUser_id(rs.getInt("user_id"));
				bean.setName(rs.getString("name"));
				bean.setDate(rs.getString("date"));
				bean.setIs_delete(rs.getInt("is_delete"));
				lst.add(bean);
			}
		} catch (SQLException e) {
			System.out.println("select users : " + e.getMessage());
		}
		return lst;
	}

	// search user except login user
	public static List<AdminBean> searchUsersById(String userId) {
		List<AdminBean> lst = new ArrayList<>();
		String sql = "select id,user_id, name, date,is_delete from users where id = ? ";
		try {
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, userId);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				AdminBean bean = new AdminBean();
				bean.setId(rs.getInt("id"));
				bean.setUser_id(rs.getInt("user_id"));
				bean.setName(rs.getString("name"));
				bean.setDate(rs.getString("date"));
				bean.setIs_delete(rs.getInt("is_delete"));
				lst.add(bean);
			}
		} catch (SQLException e) {
			System.out.println("select users : " + e.getMessage());
		}
		return lst;
	}

	public static List<AdminBean> searchUsersByName(String name) {
		List<AdminBean> lst = new ArrayList<>();
		String sql = "select id,user_id, name, date,is_delete from users where name like ? ";
		try {
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, "%" + name + "%");
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				AdminBean bean = new AdminBean();
				bean.setId(rs.getInt("id"));
				bean.setUser_id(rs.getInt("user_id"));
				bean.setName(rs.getString("name"));
				bean.setDate(rs.getString("date"));
				bean.setIs_delete(rs.getInt("is_delete"));
				lst.add(bean);
			}
		} catch (SQLException e) {
			System.out.println("select users : " + e.getMessage());
		}
		return lst;
	}

	// count
	public static int countUsers() {
		int count = 0;
		String sql = "select count(*) as count from users";
		try {
			PreparedStatement ps = con.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				count = rs.getInt("count");
			}
		} catch (SQLException e) {
			System.out.println("count users : " + e.getMessage());
		}
		return count;
	}

	// soft delete and add
	public static boolean userSoftDeleteAndAdd(int id, int num) {
		boolean softDeleteOk = true;
		String sql = "update users set is_delete=? where id=?";
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

	// profile
	public static AdminDTO findById(int userId) {
		AdminDTO dto = new AdminDTO();
		String sql = "select * from users where id = ?";
		try {
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, userId);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				dto.setName(rs.getString("name"));
				dto.setEmail(rs.getString("email"));
				dto.setImage(rs.getString("image"));
				dto.setPassword(rs.getString("password"));
			}
		} catch (SQLException e) {
			System.out.println("profile : " + e.getMessage());
		}
		return dto;
	}

	// get name
	public static AdminDTO getUser(int id) {
		AdminDTO adminDTO = new AdminDTO();
		String sql = "select * from users where id=?";
		try {
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, id);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				adminDTO.setEmail(rs.getString("email"));
				adminDTO.setName(rs.getString("name"));
				adminDTO.setPassword(rs.getString("password"));
				adminDTO.setImage(rs.getString("image"));
			}
		} catch (SQLException e) {
			System.out.println("user login : " + e.getMessage());
		}
		return adminDTO;
	}

	// update image
	public static int updateImage(int id, String image) {
		int success = 0;
		String sql = "update users set image=? where id=?";
		try {
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, image);
			ps.setInt(2, id);
			success = ps.executeUpdate();
		} catch (SQLException e) {
			System.out.println("update user image : " + e.getMessage());
		}
		return success;
	}

	// change password
	public static void changePassword(String password, int id) {
		String sql = "update users set password=? where id=?";
		try {
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, password);
			ps.setInt(2, id);
			ps.execute();
		} catch (SQLException e) {
			System.out.println("change password : " + e.getMessage());
		}
	}

	// change name
	public static void changeName(String name, int id) {
		String sql = "update users set name=? where id=?";
		try {
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, name);
			ps.setInt(2, id);
			ps.execute();
		} catch (SQLException e) {
			System.out.println("change name : " + e.getMessage());
		}
	}

}
