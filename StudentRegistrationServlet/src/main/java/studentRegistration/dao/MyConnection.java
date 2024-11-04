package studentRegistration.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class MyConnection {
	static Connection con = null;

	public static Connection getConnection() {

		try {
			Class.forName("com.mysql.jdbc.Driver");
			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/students_registration", "root", "root");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			System.out.println("Con : " + e.getMessage());
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			System.out.println("Driver : " + e.getMessage());
		}

		return con;
	}
}
