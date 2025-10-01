import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/EditTaskServlet")
public class EditTaskServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private static final String DB_URL = "jdbc:mysql://localhost:3306/motion";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "root";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String taskId = request.getParameter("taskId");
        String taskName = request.getParameter("task_name");
        String taskDate = request.getParameter("task_date");
        String taskDesc = request.getParameter("task_description");

        // basic validation
        if (taskId == null || taskId.trim().isEmpty()) {
            response.sendRedirect("edit_task_list.jsp");
            return;
        }

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
                 PreparedStatement ps = conn.prepareStatement(
                     "UPDATE tasks SET task_name=?, task_date=?, task_description=? WHERE id=?")) {

                ps.setString(1, taskName);
                ps.setString(2, taskDate);
                ps.setString(3, taskDesc);
                ps.setString(4, taskId);

                ps.executeUpdate();
            }
            response.sendRedirect("edit_task_list.jsp");

        } catch (Exception e) {
            throw new ServletException("Error updating task", e);
        }
    }
}
