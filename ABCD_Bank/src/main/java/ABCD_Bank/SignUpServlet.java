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

@WebServlet("/SignUpServlet")
public class SignUpServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private DatabaseConnect databaseConnect;

	@Override
	public void init() throws ServletException {
		super.init();
		databaseConnect = new DatabaseConnect();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String accountNumber = request.getParameter("accountNumber");
		if (accountNumber != null && !accountNumber.isEmpty()) {
			try (Connection con = databaseConnect.getCon();
					PreparedStatement ps = con
							.prepareStatement("SELECT * FROM account_creation_new WHERE account_number=?")) {
				ps.setString(1, accountNumber);
				ResultSet rs = ps.executeQuery();
				if (rs.next()) {
					String status = rs.getString("status");
					if (status.equals("Activated")) {
						request.setAttribute("accountNumber", rs.getString("account_number"));
						request.setAttribute("name", rs.getString("first_name") + " " + rs.getString("middle_name")
								+ " " + rs.getString("last_name"));
						request.setAttribute("email", rs.getString("email"));
						request.setAttribute("phone1", rs.getString("phone_number"));
						request.getRequestDispatcher("signup.jsp").forward(request, response);
					} else {
						request.setAttribute("errorMessage", "Your Account has been deleted!!!");
						request.getRequestDispatcher("signup.jsp").forward(request, response);

					}
				} else {
					request.setAttribute("errorMessage", "Account Number does not exist!");
					request.getRequestDispatcher("signup.jsp").forward(request, response);
				}
			} catch (SQLException e) {
				e.printStackTrace();
				request.setAttribute("errorMessage", "Internal Server Error! Please try again later.");
				request.getRequestDispatcher("signup.jsp").forward(request, response);
			}
		} else {
			request.setAttribute("errorMessage", "Account Number is required!");
			request.getRequestDispatcher("signup.jsp").forward(request, response);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		Connection con = null;

		try {
			con = databaseConnect.getCon();

			String accountNumber = request.getParameter("accNumber");
			String name = request.getParameter("name");
			String email = request.getParameter("email");
			String phone1 = request.getParameter("phone1");
			String username = request.getParameter("username");
			String password = request.getParameter("password");
			String cpassword = request.getParameter("cpassword");

			if (password.equals(cpassword)) {
				if (accountNumber != null && !accountNumber.isEmpty()) {
					String sql = "SELECT * FROM account_creation_new WHERE account_number = ?";
					PreparedStatement ps = con.prepareStatement(sql);
					ps.setString(1, accountNumber);
					ResultSet resultSet = ps.executeQuery();

					if (resultSet.next()) {
						String status = resultSet.getString("status");
						if (status.equals("Activated")) {

							PreparedStatement ps2 = con.prepareStatement("SELECT * FROM user_table WHERE username=?");
							ps2.setString(1, username);
							ResultSet rs1 = ps2.executeQuery();
							if (rs1.next()) {
								out.println(
										"<script>alert('Username already exists!'); window.location.href = 'signup.jsp';</script>");
							} else {

								String insertQuery = "INSERT INTO user_table (name, account_number, email, username, password, phone1) "
										+ "VALUES (?, ?, ?, ?, ?, ?)";
								PreparedStatement ps1 = con.prepareStatement(insertQuery);
								ps1.setString(1, name);
								ps1.setString(2, accountNumber);
								ps1.setString(3, email);
								ps1.setString(4, username);
								ps1.setString(5, password);
								ps1.setString(6, phone1);

								int rowsInserted = ps1.executeUpdate();
								if (rowsInserted > 0) {
									String message = "You have been Successfully registered for Internet Banking.";
									response.sendRedirect("index.jsp?message=" + URLEncoder.encode(message, "UTF-8"));
								} else {
									out.println(
											"<script>alert('Error occurred while registering user!'); window.location.href = 'signup.jsp';</script>");
								}
							}
						} else {
							out.println(
									"<script>alert('Account Number Does not match!!!'); window.location.href = 'signup.jsp';</script>");

						}
					} else {
						out.println(
								"<script>alert('Account Number Does not match!!!'); window.location.href = 'signup.jsp';</script>");
					}

					resultSet.close();
					ps.close();

				} else {
					out.println(
							"<script>alert('Account Number is required!'); window.location.href = 'signup.jsp';</script>");
				}
			} else {
				out.println("<script>alert('Passwords do not match!'); window.location.href = 'signup.jsp';</script>");
			}

		} catch (SQLException e) {
			out.println(
					"<script>alert('Internal Server Error! Please try again later.'); window.location.href = 'signup.jsp';</script>");
			e.printStackTrace();
		} finally {
			try {
				if (con != null)
					con.close();
				if (out != null)
					out.close();
			} catch (SQLException ex) {
				ex.printStackTrace();
			}
		}
	}

	@Override
	public void destroy() {
		super.destroy();
	}
}