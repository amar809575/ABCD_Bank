<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.sql.SQLException"%>
<%@ page import="ABCD_Bank.DatabaseConnect"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>ABCD Bank Admin Login</title>
<link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
<style>
    .login-container {
        max-width: 500px;
        margin: auto;
        margin-top: 10%;
        background: #f8f9fa;
        padding: 20px;
        border-radius: 10px;
        box-shadow: 0px 0px 10px 0px #000000;
    }
    body {
        background: -webkit-linear-gradient(left, #0072ff, #00c6ff);
    }
    .message {
        display: none;
    }
</style>
</head>
<body>

<div class="login-container">
    <h2 class="text-center">Login</h2>
    
    <form id="loginForm" method="post">
        <div class="form-group">
            <input type="text" placeholder="Username" name="username" class="form-control"  required />
        </div>
        <div class="form-group">
            <input type="password" placeholder="Password" name="password" class="form-control" required />
        </div>
        <div class="form-group text-center">
            <button type="submit" class="btn btn-primary">Login</button>
        <a href="index.jsp" class="btn btn-primary">Home</a>
        </div>
    </form>
    
    <%
        if (request.getMethod().equalsIgnoreCase("POST")) {
                String username = request.getParameter("username");
                String password = request.getParameter("password");
                
                DatabaseConnect database = new DatabaseConnect();
                Connection con = null;
                PreparedStatement ps = null;
                ResultSet rs = null;

                try {
                    con = database.getCon();
                    String sqlQuery = "SELECT * FROM admin_table WHERE username = ? AND password = ?";
                    ps = con.prepareStatement(sqlQuery);
                    ps.setString(1, username);
                    ps.setString(2, password);
                    rs = ps.executeQuery();
                    
                    if (rs.next()) {
                        String admin_id = rs.getString("admin_id");
                        session = request.getSession();
                        session.setAttribute("admin_id", admin_id);
                        response.sendRedirect("admin.jsp");
                    } else {
                        out.println("<div class='alert alert-danger text-center' role='alert'>Invalid username or password</div>");
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                    out.println("<div class='alert alert-danger text-center' role='alert'>Error connecting to the database</div>");
                } finally {
                    try {
                        if (rs != null) rs.close();
                        if (ps != null) ps.close();
                        if (con != null) con.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
            }
        %>
       
</div>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
