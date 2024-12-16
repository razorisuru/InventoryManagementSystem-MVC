package Controllers;

import Models.User;
import Models.UserDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;
import javax.servlet.RequestDispatcher;

@WebServlet("/UserController")
public class UserController extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        userDAO = new UserDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        try {
            if (action == null) {
                listUsers(request, response);
            } else {
                switch (action) {
                    case "add":
                        showAddForm(request, response);
                        break;
                    case "edit":
                        showEditForm(request, response);
                        break;
                    case "delete":
                        deleteUser(request, response);
                        break;
                    default:
                        listUsers(request, response);
                        break;
                }
            }
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        try {
            switch (action) {
                case "insert":
                    insertUser(request, response);
                    break;
                case "update":
                    updateUser(request, response);
                    break;
                default:
                    listUsers(request, response);
                    break;
            }
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    private void listUsers(HttpServletRequest request, HttpServletResponse response) throws Exception {
        List<User> userList = userDAO.selectAllUsers();
        request.setAttribute("userList", userList);
        request.getRequestDispatcher("Views/users/list.jsp").forward(request, response);
    }

    private void showAddForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("Views/users/add.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response) throws Exception {
        int id = Integer.parseInt(request.getParameter("id"));
        User existingUser = userDAO.selectUserById(id); // Retrieve user by ID

        request.setAttribute("user", existingUser); // Set user data in request
        RequestDispatcher dispatcher = request.getRequestDispatcher("Views/users/edit.jsp");
        dispatcher.forward(request, response); // Forward to the edit form
    }

    private void insertUser(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String firstName = request.getParameter("first_name");
        String lastName = request.getParameter("last_name");
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String role = request.getParameter("role");

        User newUser = new User(firstName, lastName, username, password, email, role);
        userDAO.insertUser(newUser);
        response.sendRedirect("UserController");
    }

    private void updateUser(HttpServletRequest request, HttpServletResponse response) throws Exception {
        int id = Integer.parseInt(request.getParameter("id"));
        String firstName = request.getParameter("first_name");
        String lastName = request.getParameter("last_name");
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String role = request.getParameter("role");

        User updatedUser = new User(id, firstName, lastName, username, email, role);
        userDAO.updateUser(updatedUser);
        response.sendRedirect("UserController");
    }

    private void deleteUser(HttpServletRequest request, HttpServletResponse response) throws Exception {
        int id = Integer.parseInt(request.getParameter("id"));
        userDAO.deleteUser(id);
        response.sendRedirect("UserController");
    }
}
