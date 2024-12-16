<%-- 
    Document   : login
    Created on : Dec 15, 2024, 7:10:00 PM
    Author     : iduni
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>
    <div class="container mt-5">
        <h2 class="text-center">Login</h2>
        <form action="${pageContext.request.contextPath}/AuthController" method="POST">
            <input type="hidden" name="action" value="login">
            <div class="mb-3">
                <label for="username" class="form-label">Username</label>
                <input type="text" class="form-control" id="username" name="username" required>
            </div>
            <div class="mb-3">
                <label for="password" class="form-label">Password</label>
                <input type="password" class="form-control" id="password" name="password" required>
            </div>
            <button type="submit" class="btn btn-primary">Login</button>
        </form>
        <% if (request.getAttribute("error") != null) { %>
            <div class="alert alert-danger mt-3"><%= request.getAttribute("error") %></div>
        <% } %>
        <p class="mt-3">Don't have an account? <a href="register.jsp">Register here</a>.</p>
    </div>
</body>
</html>
