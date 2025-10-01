import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/AddTaskServlet")
public class AddTaskServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

  
    private static final String DB_URL = "jdbc:mysql://localhost:3306/motion";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "root";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String taskName = request.getParameter("task_name");
        String taskDate = request.getParameter("task_date");
        String taskDescription = request.getParameter("task_description");

        if (taskName == null || taskName.trim().isEmpty() ||
            taskDate == null || taskDate.trim().isEmpty() ||
            taskDescription == null || taskDescription.trim().isEmpty()) {

            request.setAttribute("errorMessage", "All fields are required!");
            request.getRequestDispatcher("add_task.jsp").forward(request, response);
            return;
        }

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
                 PreparedStatement ps = conn.prepareStatement( "INSERT INTO tasks (task_name, task_date, task_description, status) VALUES (?, ?, ?, ?)"))
         {

                ps.setString(1, taskName);
                ps.setString(2, taskDate);
                ps.setString(3, taskDescription);
                ps.setString(4, "pending"); 

                int rowsInserted = ps.executeUpdate();

                if (rowsInserted > 0) {
                  System.out.println("Task added successfully!");
                    response.sendRedirect("add_task.jsp");
                } else {
                 
                    request.setAttribute("errorMessage", "Failed to add task. Try again.");
                    request.getRequestDispatcher("add_task.jsp").forward(request, response);
                }
            }
        } catch (Exception e) {
            throw new ServletException("Error adding task: " + e.getMessage(), e);
        }
    }
}
