<%-- 
    Document   : edit
    Created on : Dec 15, 2024, 7:10:34 PM
    Author     : iduni
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    session = request.getSession(false); // Do not create a new session if it doesn't exist

    if (session == null || session.getAttribute("user") == null) {
        response.sendRedirect("Views/Auth/login.jsp");
    }
%>
<%@ page import="Models.User" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css">
        <title>Edit User</title>
    </head>
    <body>
        <div class="container">
            <h2 class="text-center">Edit User</h2>
            <form action="${pageContext.request.contextPath}/UserController" method="POST">
                <%
                    // Cast the attribute to the User type
                    User existingUser = (User) request.getAttribute("user");
                %>
                <input type="hidden" name="action" value="update">
                <input type="hidden" name="id" value="<%= existingUser.getId()%>">
                <div class="mb-3">
                    <label for="first_name" class="form-label">First Name</label>
                    <input type="text" class="form-control" id="first_name" name="first_name" value="<%= existingUser.getFirstName()%>" required>
                </div>
                <div class="mb-3">
                    <label for="last_name" class="form-label">Last Name</label>
                    <input type="text" class="form-control" id="last_name" name="last_name" value="<%= existingUser.getLastName()%>" required>
                </div>
                <div class="mb-3">
                    <label for="email" class="form-label">Email</label>
                    <input type="email" class="form-control" id="email" name="email" value="<%= existingUser.getEmail()%>" required>
                </div>
                <div class="mb-3">
                    <label for="username" class="form-label">Username</label>
                    <input type="text" class="form-control" id="username" name="username" value="<%= existingUser.getUsername()%>" required>
                </div>
                <div class="mb-3">
                    <label for="role" class="form-label">Role</label>
                    <select class="form-control" id="role" name="role" required>
                        <option value="ADMIN" <%= "ADMIN".equals(existingUser.getRole()) ? "selected" : ""%>>ADMIN</option>
                        <option value="USER" <%= "USER".equals(existingUser.getRole()) ? "selected" : ""%>>USER</option>
                    </select>
                </div>

                <button type="submit" class="btn btn-success">Update User</button>
            </form>
        </div>
    </body>
</html>
