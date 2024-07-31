package ABCD_Bank;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;

@WebServlet("/DatabaseConnect")
public class DatabaseConnect extends HttpServlet {
	
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private static final String JDBC_DRIVER = "com.mysql.cj.jdbc.Driver";
    private static final String DB_URL = "jdbc:mysql://localhost:3306/abcd_bank";
    private static final String USERNAME = "root";
    private static final String PASSWORD = "";

    public Connection getCon() throws SQLException {
        try {
            Class.forName(JDBC_DRIVER);
            System.out.println("MySQL JDBC driver loaded successfully!");
        } catch (ClassNotFoundException e) {
            System.out.println("Failed to load MySQL JDBC driver: " + e.getMessage());
            throw new SQLException("Failed to load MySQL JDBC driver", e);
        }

        return DriverManager.getConnection(DB_URL, USERNAME, PASSWORD);
    }
}
