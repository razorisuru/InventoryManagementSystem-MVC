package Controllers;

import Models.User;
import Models.UserDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/AuthController")
public class AuthController extends HttpServlet {

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
            if ("logout".equals(action)) {
                logout(request, response);
            } else {
                response.sendRedirect("Views/Auth/login.jsp");
            }
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        try {
            if ("login".equals(action)) {
                loginUser(request, response);
            } else if ("register".equals(action)) {
                registerUser(request, response);
            } else {
                response.sendRedirect("views/auth/login.jsp");
            }
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    private void loginUser(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        User user = userDAO.validateUser(username, password);
        if (user != null) {
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            response.sendRedirect("UserController");
        } else {
            request.setAttribute("error", "Invalid username or password");
            request.getRequestDispatcher("Views/Auth/login.jsp").forward(request, response);
        }
    }

    private void registerUser(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String firstName = request.getParameter("first_name");
        String lastName = request.getParameter("last_name");
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String role = "user";

        User newUser = new User(firstName, lastName, username, password, email, role);
        userDAO.insertUser(newUser);
        response.sendRedirect("Views/Auth/login.jsp");
    }

    private void logout(HttpServletRequest request, HttpServletResponse response) throws Exception {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }
        response.sendRedirect("Views/Auth/login.jsp");
    }
}
