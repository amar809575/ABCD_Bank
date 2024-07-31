package ABCD_Bank;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/CloseAccountServlet")
public class CloseAccountServlet extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private DatabaseConnect databaseConnect;

	@Override
	public void init() throws ServletException {
		super.init();
		databaseConnect = new DatabaseConnect();
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    response.setContentType("text/html");
	    PrintWriter out = response.getWriter();

	    String account_number = request.getParameter("accNumber");
	    String status = "Deactivated";

	    HttpSession session = request.getSession(false);
	    if (session != null && session.getAttribute("user_id") != null) {
	        String user_id = (String) session.getAttribute("user_id");

	        Connection conn = null;
	        PreparedStatement ps = null;
	        ResultSet rs = null;

	        try {
	            conn = databaseConnect.getCon();

	            String sql = "SELECT * FROM account_creation_new WHERE ACCOUNT_NUMBER = ?";
	            ps = conn.prepareStatement(sql);
	            ps.setString(1, account_number);
	            rs = ps.executeQuery();

	            if (rs.next()) {
	                String balanceQuery = "SELECT amount FROM amount_deposit WHERE account_number = ?";
	                ps = conn.prepareStatement(balanceQuery);
	                ps.setString(1, account_number);
	                rs = ps.executeQuery();

	                if (rs.next()) {
	                    Double currentBalance = rs.getDouble("amount");
	                    if (rs.wasNull() || currentBalance == 0.0) {
	                        String updateQuery = "UPDATE account_creation_new SET STATUS = ? WHERE ACCOUNT_NUMBER = ?";
	                        ps = conn.prepareStatement(updateQuery);
	                        ps.setString(1, status);
	                        ps.setString(2, account_number);

	                        int rowsAffected = ps.executeUpdate();

	                        if (rowsAffected > 0) {
	                            response.sendRedirect("logout.jsp");
	                        } else {
	                            out.println("<script>alert('Account deactivation failed.');</script>");
	                      
	                        } 
	                    }
	                } else {
	                    out.println("<script>alert('Error retrieving account balance.'); window.location.href='closeac.jsp';</script>");
	                }
	            } else {
	                out.println("<script>alert('Account not found.'); window.location.href='closeac.jsp';</script>");
	            }

	        } catch (SQLException e) {
	            out.println("<script>alert('An error occurred. Please try again later.'); window.location.href='closeac.jsp';</script>");
	            e.printStackTrace();
	        } finally {
	            try {
	                if (rs != null) {
	                    rs.close();
	                }
	                if (ps != null) {
	                    ps.close();
	                }
	                if (conn != null) {
	                    conn.close();
	                }
	            } catch (SQLException e) {
	                e.printStackTrace();
	            }
	        }
	    } else {
	        response.sendRedirect("index.jsp");
	    }
	}

}
