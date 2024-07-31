
<%
session = request.getSession(false);
if (session != null) {
    session.invalidate(); 
}
request.getRequestDispatcher("/index.jsp").forward(request,response);

%>
