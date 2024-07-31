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

@WebServlet("/TransferServlet")
public class TransferServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String fromAccNum = request.getParameter("fromAccNum");
        String toAccNum = request.getParameter("toAccNum");
        String accountType = request.getParameter("account_type");
        double transferAmount = Double.parseDouble(request.getParameter("amount"));

        Connection conn = null;
        PreparedStatement pstmt = null;
        PrintWriter out = response.getWriter();

        try {
            DatabaseConnect databaseConnect = new DatabaseConnect();
            conn = databaseConnect.getCon();
            conn.setAutoCommit(false);

            if (fromAccNum.equals(toAccNum)) {
                out.println("<h1>Error: Cannot transfer money to the same account!</h1>");
                return;
            }

            String checkFromAccountQuery = "SELECT AMOUNT FROM amount_deposit WHERE ACCOUNT_NUMBER=? FOR UPDATE";
            pstmt = conn.prepareStatement(checkFromAccountQuery);
            pstmt.setString(1, fromAccNum);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                double currentBalance = rs.getDouble("AMOUNT");
                if (currentBalance >= transferAmount) {
                    String checkToAccountQuery = "SELECT * FROM account_creation_new WHERE ACCOUNT_NUMBER=? AND ACCOUNT_TYPE=?";
                    pstmt = conn.prepareStatement(checkToAccountQuery);
                    pstmt.setString(1, toAccNum);
                    pstmt.setString(2, accountType);
                    rs = pstmt.executeQuery();
                    if (rs.next()) {
                        String accNumber = rs.getString("account_number");

                        String updateFromAccountQuery = "UPDATE amount_deposit SET AMOUNT=AMOUNT-? WHERE ACCOUNT_NUMBER=?";
                        pstmt = conn.prepareStatement(updateFromAccountQuery);
                        pstmt.setDouble(1, transferAmount);
                        pstmt.setString(2, fromAccNum);
                        int fromRowsAffected = pstmt.executeUpdate();

                        if (fromRowsAffected > 0) {
                            String checktoAccountQuery = "SELECT * FROM amount_deposit WHERE ACCOUNT_NUMBER = ?";
                            pstmt = conn.prepareStatement(checktoAccountQuery);
                            pstmt.setString(1, toAccNum);
                            rs = pstmt.executeQuery();
                            if (rs.next()) {
                                double toCurrentBalance = rs.getDouble("AMOUNT");

                                String updateToAccountQuery = "UPDATE amount_deposit SET AMOUNT=? WHERE ACCOUNT_NUMBER=?";
                                pstmt = conn.prepareStatement(updateToAccountQuery);
                                pstmt.setDouble(1, toCurrentBalance + transferAmount);
                                pstmt.setString(2, toAccNum);
                                int toRowsAffected = pstmt.executeUpdate();

                                if (toRowsAffected > 0) {
                                    String fromTransactionQuery = "INSERT INTO transaction_table (ACCOUNT_NUMBER, TRANSACTION_DATE, TRANSACTION_REFERENCE, CREDIT, DEBIT, BALANCE) VALUES (?, NOW(), ?, ?, ?, ?)";
                                    pstmt = conn.prepareStatement(fromTransactionQuery);
                                    pstmt.setString(1, fromAccNum);
                                    pstmt.setString(2, "Money transferred to account - " + toAccNum);
                                    pstmt.setDouble(3, 0); // Credit
                                    pstmt.setDouble(4, transferAmount); // Debit
                                    pstmt.setDouble(5, currentBalance - transferAmount);
                                    pstmt.executeUpdate();

                                    String toTransactionQuery = "INSERT INTO transaction_table (ACCOUNT_NUMBER, TRANSACTION_DATE, TRANSACTION_REFERENCE, CREDIT, DEBIT, BALANCE) VALUES (?, NOW(), ?, ?, ?, ?)";
                                    pstmt = conn.prepareStatement(toTransactionQuery);
                                    pstmt.setString(1, toAccNum);
                                    pstmt.setString(2, "Money received from account " + fromAccNum);
                                    pstmt.setDouble(3, transferAmount);
                                    pstmt.setDouble(4, 0);
                                    pstmt.setDouble(5, toCurrentBalance + transferAmount);
                                    pstmt.executeUpdate();

                                    conn.commit();
                                    String message = "You have been Successfully transferred the amount.";
                                    response.sendRedirect("transfer.jsp?message=" + URLEncoder.encode(message, "UTF-8"));
                                } else {
                                    conn.rollback();
                                    out.println("<h1>Failed to update destination account!</h1>");
                                }
                            } else {
                                String updateToAccountQuery = "INSERT INTO amount_deposit (ACCOUNT_NUMBER, AMOUNT, UPDATED_AT) VALUES (?, ?, NOW())";
                                pstmt = conn.prepareStatement(updateToAccountQuery);
                                pstmt.setString(1, toAccNum);
                                pstmt.setDouble(2, transferAmount);
                                int toRowsAffected = pstmt.executeUpdate();

                                if (toRowsAffected > 0) {
                                    String fromTransactionQuery = "INSERT INTO transaction_table (ACCOUNT_NUMBER, TRANSACTION_DATE, TRANSACTION_REFERENCE, CREDIT, DEBIT, BALANCE) VALUES (?, NOW(), ?, ?, ?, ?)";
                                    pstmt = conn.prepareStatement(fromTransactionQuery);
                                    pstmt.setString(1, fromAccNum);
                                    pstmt.setString(2, "Money transferred to account - " + toAccNum);
                                    pstmt.setDouble(3, 0); // Credit
                                    pstmt.setDouble(4, transferAmount); // Debit
                                    pstmt.setDouble(5, currentBalance - transferAmount);
                                    pstmt.executeUpdate();

                                    String toTransactionQuery = "INSERT INTO transaction_table (ACCOUNT_NUMBER, TRANSACTION_DATE, TRANSACTION_REFERENCE, CREDIT, DEBIT, BALANCE) VALUES (?, NOW(), ?, ?, ?, ?)";
                                    pstmt = conn.prepareStatement(toTransactionQuery);
                                    pstmt.setString(1, toAccNum);
                                    pstmt.setString(2, "Money received from account " + fromAccNum);
                                    pstmt.setDouble(3, transferAmount);
                                    pstmt.setDouble(4, 0);
                                    pstmt.setDouble(5, transferAmount);
                                    pstmt.executeUpdate();

                                    conn.commit();
                                    String message = "You have been Successfully transferred the amount.";
                                    response.sendRedirect("transfer.jsp?message=" + URLEncoder.encode(message, "UTF-8"));
                                } else {
                                    conn.rollback();
                                    out.println("<h1>Failed to update destination account!</h1>");
                                }
                            }
                        } else {
                            conn.rollback();
                            out.println("<h1>Failed to update source account!</h1>");
                        }
                    } else {
                        out.println("<h1>Error: Destination account does not exist or account type mismatch!</h1>");
                    }
                } else {
                    out.println("<h1>Error: Insufficient balance in the source account!</h1>");
                }
            } else {
                out.println("<h1>Error: Source account does not exist!</h1>");
            }
        } catch (SQLException e) {
            try {
                if (conn != null) {
                    conn.rollback();
                }
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            e.printStackTrace();
            out.println("<h1>Error in processing transaction. Please try again later.</h1>");
        } finally {
            try {
                if (pstmt != null)
                    pstmt.close();
                if (conn != null)
                    conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
