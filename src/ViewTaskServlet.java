import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/ViewTaskServlet")
public class ViewTaskServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private static final String DB_URL = "jdbc:mysql://localhost:3306/motion";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "root";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");

        try (PrintWriter out = response.getWriter()) {

            out.println("<!DOCTYPE html>");
            out.println("<html><head>");
            out.println("<title>View Tasks</title>");
            out.println("<style>");
            out.println("body { font-family: Arial, sans-serif; background-color: #f0f2f5; padding: 20px; }");
            out.println("h1 { text-align: center; color: #333; }");
            out.println("table { width: 80%; margin: 20px auto; border-collapse: collapse; }");
            out.println("th, td { padding: 12px; border: 1px solid #ccc; text-align: left; }");
            out.println("th { background-color: #4CAF50; color: white; }");
            out.println("tr:nth-child(even) { background-color: #f9f9f9; }");
            out.println(".back-btn { display: block; width: 100px; margin: 20px auto; padding: 10px; text-align: center; background-color: #4CAF50; color: white; text-decoration: none; border-radius: 5px; }");
            out.println("</style>");
            out.println("</head><body>");
            out.println("<h1>All Tasks</h1>");

            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
                 PreparedStatement ps = conn.prepareStatement("SELECT * FROM tasks");
                 ResultSet rs = ps.executeQuery()) {

                out.println("<table>");
                out.println("<tr><th>ID</th><th>Task Name</th><th>Date</th><th>Description</th></tr>");

                while (rs.next()) {
                    int id = rs.getInt("id");
                    String name = rs.getString("task_name");
                    String date = rs.getString("task_date");
                    String description = rs.getString("task_description");

                    out.println("<tr>");
                    out.println("<td>" + id + "</td>");
                    out.println("<td>" + name + "</td>");
                    out.println("<td>" + date + "</td>");
                    out.println("<td>" + description + "</td>");
                    out.println("</tr>");
                }

                out.println("</table>");
                out.println("<a class='back-btn' href='add_task.jsp'>Add Task</a>");
            }

            out.println("</body></html>");

        } catch (Exception e) {
            throw new ServletException("Error retrieving tasks: " + e.getMessage(), e);
        }
    }
}
