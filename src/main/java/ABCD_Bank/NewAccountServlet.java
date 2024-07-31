package ABCD_Bank;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/NewAccountServlet")
public class NewAccountServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	private DatabaseConnect databaseConnect;

	@Override
	public void init() throws ServletException {
		super.init();
		databaseConnect = new DatabaseConnect();
	}

	protected void doGet(HttpServletRequest req, HttpServletResponse response) throws ServletException, IOException {
	    response.setContentType("text/html");
	    PrintWriter out = response.getWriter();
	    Connection con = null;

	    try {
	        con = databaseConnect.getCon();

	        String accNumberStr = req.getParameter("accountNumber");
	        Long accNumber = Long.parseLong(accNumberStr);
	        String firstName = req.getParameter("firstname");
	        String middleName = req.getParameter("middlename");
	        String lastName = req.getParameter("lastname");
	        String dob = req.getParameter("dob");
	        String gender = req.getParameter("gender");
	        String email = req.getParameter("email");
	        String motherName = req.getParameter("motherName");
	        String fatherName = req.getParameter("fatherName");
	        String phone1 = req.getParameter("phone1");
	        String phone2 = req.getParameter("phone2");
	        String address1 = req.getParameter("address1");
	        String address2 = req.getParameter("address2");
	        String city = req.getParameter("city");
	        String state = req.getParameter("state");
	        String country = req.getParameter("country");
	        String zipcode = req.getParameter("zipcode");
	        String education = req.getParameter("education");
	        String occupation = req.getParameter("occupation");
	        String accountType = req.getParameter("account_type");
	        String monthlySalary = req.getParameter("salary");
	        String status = "Activated";

	        System.out.println("Account Number: " + accNumber);

	        System.out.println("Phone 2: " + phone2);

	        String ACCOUNT_CHECK = "SELECT * FROM account_creation_new WHERE account_number = ?";
	        PreparedStatement ps = con.prepareStatement(ACCOUNT_CHECK);
	        ps.setLong(1, accNumber);

	        ResultSet rs = ps.executeQuery();

	        if (rs.next()) {
	            String alert = "The given account number already exists. Please choose another account number.";
	            response.sendRedirect("newAccount.jsp?alert=" + URLEncoder.encode(alert, "UTF-8"));

	        } else {
	            String INSERT_SQL = "INSERT INTO account_creation_new "
	                    + "(account_number, first_name, middle_name, last_name, dob, gender, email, "
	                    + "mother_name, father_name, phone_number, phone_number2, address_line1, address_line2, "
	                    + "city, state, country, zipcode, education, occupation, account_type, monthly_salary, status) "
	                    + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

	            try (PreparedStatement preparedStatement = con.prepareStatement(INSERT_SQL)) {
	                preparedStatement.setLong(1, accNumber);
	                preparedStatement.setString(2, firstName);
	                preparedStatement.setString(3, middleName);
	                preparedStatement.setString(4, lastName);
	                preparedStatement.setString(5, dob);
	                preparedStatement.setString(6, gender);
	                preparedStatement.setString(7, email);
	                preparedStatement.setString(8, motherName);
	                preparedStatement.setString(9, fatherName);
	                preparedStatement.setString(10, phone1);
	                preparedStatement.setString(11, phone2);
	                preparedStatement.setString(12, address1);
	                preparedStatement.setString(13, address2);
	                preparedStatement.setString(14, city);
	                preparedStatement.setString(15, state);
	                preparedStatement.setString(16, country);
	                preparedStatement.setString(17, zipcode);
	                preparedStatement.setString(18, education);
	                preparedStatement.setString(19, occupation);
	                preparedStatement.setString(20, accountType);
	                preparedStatement.setString(21, monthlySalary);
	                preparedStatement.setString(22, status);

	                int rowsInserted = preparedStatement.executeUpdate();
	                if (rowsInserted > 0) {
	                    String message = "Your account has been created, now you are eligible for Internet Banking.";
	                    response.sendRedirect("index.jsp?message=" + URLEncoder.encode(message, "UTF-8"));
	                }
	            }
	        }

	    } catch (SQLException | NumberFormatException e) {
	        e.printStackTrace();
	    } finally {
	        if (con != null) {
	            try {
	                con.close();
	            } catch (SQLException e) {
	                e.printStackTrace();
	            }
	        }
	    }
	}
}
