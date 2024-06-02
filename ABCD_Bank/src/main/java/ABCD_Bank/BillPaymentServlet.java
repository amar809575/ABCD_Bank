package ABCD_Bank;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

@WebServlet("/BillPaymentServlet")
public class BillPaymentServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;
	private DatabaseConnect databaseConnect;

	@Override
	public void init() throws ServletException {
		super.init();
		databaseConnect = new DatabaseConnect();
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();

		HttpSession session = request.getSession(false);
		if (session != null && session.getAttribute("user_id") != null) {
			String user_id = (String) session.getAttribute("user_id");

			String type = request.getParameter("type");
	        String mobileNumber = request.getParameter("mobileNumber");
	        String dthId = request.getParameter("dthId");
	        String electricity = request.getParameter("electricity");
	        String lpgNumber = request.getParameter("lpgNumber");
	        String broadbandNumber = request.getParameter("broadbandNumber");
	        String amount = request.getParameter("amount");

			
			 
			
	        
	        if (type == null || amount == null) {
	            out.println("<h2>Error: Missing input parameters.</h2>");
	            return;
	        }
	        
	       

			Connection con = null;
			PreparedStatement ps = null;
			ResultSet rs = null;

			try {
				con = databaseConnect.getCon();

				ps = con.prepareStatement("SELECT ACCOUNT_NUMBER FROM user_table WHERE user_id = ?");
				ps.setString(1, user_id);
				rs = ps.executeQuery();

				if (rs.next()) {
					String accNumber = rs.getString("ACCOUNT_NUMBER");
					double amountInput2;
					try {
						amountInput2 = Double.parseDouble(amount);
					} catch (NumberFormatException e) {
						out.println("<h2>Error: Invalid amount format.</h2>");
						return;
					}

					PreparedStatement balancePs = con
							.prepareStatement("SELECT amount FROM amount_deposit WHERE account_number = ?");
					balancePs.setString(1, accNumber);
					ResultSet balanceRs = balancePs.executeQuery();

					if (balanceRs.next()) {
						double currentBalance = balanceRs.getDouble("amount");

						if (currentBalance >= amountInput2) {
							double newBalance = currentBalance - amountInput2;

							PreparedStatement updatePs = con
									.prepareStatement("UPDATE amount_deposit SET amount = ? WHERE account_number = ?");
							updatePs.setDouble(1, newBalance);
							updatePs.setString(2, accNumber);
							int affectedRows = updatePs.executeUpdate();

							if (affectedRows > 0) {
								PreparedStatement insertTransactionPs = con.prepareStatement(
										"INSERT INTO transaction_table (account_number, transaction_date, transaction_reference, credit, debit, balance) VALUES (?, CURRENT_TIMESTAMP, ?, ?, ?, ?)");
								insertTransactionPs.setString(1, accNumber);
								insertTransactionPs.setString(2, type + " " + amountInput2);
								insertTransactionPs.setDouble(3, 0);
								insertTransactionPs.setDouble(4, amountInput2);
								insertTransactionPs.setDouble(5, newBalance);
								insertTransactionPs.executeUpdate();

								String message = type+" Successfully.";
                                response.sendRedirect("payBills.jsp?message=" + URLEncoder.encode(message, "UTF-8"));
							} else {
								out.println("<h2>Error: Transaction failed.</h2>");
							}
						} else {
							out.println("<h2>Error: Insufficient balance.</h2>");
						}
					} else {
						out.println("<h2>Error: Account not found.</h2>");
					}
					balanceRs.close();
					balancePs.close();
				} else {
					out.println("<h2>Error: Invalid user ID.</h2>");
				}
			} catch (SQLException e) {
				e.printStackTrace();
				out.println("<h2>Error: Database error.</h2>");
			} finally {
				try {
					if (rs != null)
						rs.close();
					if (ps != null)
						ps.close();
					if (con != null)
						con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		} else {
			out.println("<h2>Your session has expired. Please log in again.</h2>");
		}
		out.close();
	}
}
