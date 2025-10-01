import java.io.IOException;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/motion";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "root";

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String pass = request.getParameter("password");
        String confirmPass = request.getParameter("confirm_password");

        if (!pass.equals(confirmPass)) {
            request.setAttribute("errorMessage", "Passwords do not match!");
            RequestDispatcher rd = request.getRequestDispatcher("Register.jsp");
            rd.forward(request, response);
            return;
        }

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

            PreparedStatement checkStmt = con.prepareStatement("SELECT * FROM users WHERE email=?");
            checkStmt.setString(1, email);
            ResultSet rs = checkStmt.executeQuery();

            if (rs.next()) 
            {
                request.setAttribute("errorMessage", "Email already registered!");
                RequestDispatcher rd = request.getRequestDispatcher("Register.jsp");
                rd.forward(request, response);

                rs.close();
                checkStmt.close();
                con.close();
                return;
            }

            rs.close();
            checkStmt.close();

            PreparedStatement ps = con.prepareStatement(
                "INSERT INTO users (username, email, password) VALUES (?, ?, ?)"
            );
            ps.setString(1, username);
            ps.setString(2, email);
            ps.setString(3, pass); 

            int rows = ps.executeUpdate();

            ps.close();
            con.close();

            if (rows > 0) 
            {
                response.sendRedirect("Login.jsp");
            } 
            else
             {
                request.setAttribute("errorMessage", "Registration failed. Please try again!");
                RequestDispatcher rd = request.getRequestDispatcher("Register.jsp");
                rd.forward(request, response);
            }
        } catch (Exception e) {
            throw new ServletException("Registration Failed", e);
        }
    }
}
