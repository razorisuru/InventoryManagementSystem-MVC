<%-- 
    Document   : list
    Created on : Dec 15, 2024, 7:10:23 PM
    Author     : iduni
--%>

<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    session = request.getSession(false); // Do not create a new session if it doesn't exist

    if (session == null || session.getAttribute("user") == null) {
        response.sendRedirect("Views/Auth/login.jsp");
    }
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>User Management</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    </head>
    <body>
        <div class="container mt-5">
            <h2 class="text-center">User Management</h2>
            <% if (request.getAttribute("message") != null) {%>
            <div class="alert alert-success mt-3"><%= request.getAttribute("message")%></div>
            <% } %>
            <a href="${pageContext.request.contextPath}/UserController?action=add" class="btn btn-primary mb-3">Add New User</a>
            <a href="${pageContext.request.contextPath}/AuthController?action=logout" class="btn btn-danger mb-3">Logout</a>
            <table class="table table-stripped table-hover">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>First Name</th>
                        <th>Last Name</th>
                        <th>Username</th>
                        <th>Email</th>
                        <th>Role</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        List<Models.User> users = (List<Models.User>) request.getAttribute("userList");
                        for (Models.User user : users) {
                    %>
                    <tr>
                        <td><%= user.getId()%></td>
                        <td><%= user.getFirstName()%></td>
                        <td><%= user.getLastName()%></td>
                        <td><%= user.getUsername()%></td>
                        <td><%= user.getEmail()%></td>
                        <td><%= user.getRole()%></td>
                        <td>
                            <a href="${pageContext.request.contextPath}/UserController?action=edit&id=<%= user.getId()%>" class="btn btn-warning btn-sm">Edit</a>
                            <a href="${pageContext.request.contextPath}/UserController?action=delete&id=<%= user.getId()%>" class="btn btn-danger btn-sm">Delete</a>
                        </td>
                    </tr>
                    <% }%>
                </tbody>
            </table>
        </div>
    </body>
</html>
