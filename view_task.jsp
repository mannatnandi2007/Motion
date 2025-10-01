<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>View Tasks</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- Pixel Font -->
    <link href="https://fonts.googleapis.com/css2?family=Press+Start+2P&display=swap" rel="stylesheet">

    <style>
        body {
            background: linear-gradient(to bottom right, #9fd3ff, #5ba6e6);
            font-family: 'Press Start 2P', cursive;
            margin: 0;
            padding: 40px;
        }

        .container {
            max-width: 1300px;
            margin: auto;
        }

        h2 {
            color: #ffffff;
            text-align: center;
            text-shadow: 2px 2px #3c4c56;
            margin-bottom: 20px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background: #0f1a20;
            color: #ffffff;
            box-shadow: 6px 6px #3c4c56;
        }

        th, td {
            border: 3px solid #3c4c56;
            padding: 10px;
            text-align: left;
            font-size: 15px;
        }

        th {
            background: #3c4c56;
            text-transform: uppercase;
        }

        tr:nth-child(even) {
            background: #1a2832;
        }

        .buttons {
            margin-bottom: 20px;
            display: flex;
            justify-content: center;
            gap: 10px;
        }

        .btn {
            background: #d6edff;
            border: 3px solid #3c4c56;
            padding: 10px 14px;
            font-size: 10px;
            color: black;
            text-decoration: none;
            cursor: pointer;
            text-align: center;
            box-shadow: 4px 4px #3c4c56;
            text-transform: uppercase;
            letter-spacing: 1px;
            transition: all 0.15s ease-in-out;
        }

        .btn:hover {
            transform: translate(-2px, -2px);
            box-shadow: 6px 6px #3c4c56;
            background: #89c4f4;
        }

        @media screen and (max-width: 500px) {
            table, th, td {
                font-size: 8px;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="buttons">
            <a href="add_task.jsp" class="btn">Add Task</a>
            <a href="index.jsp" class="btn">Home</a>
        </div>

        <h2>📋 All Tasks</h2>

        <table>
            <tr>
                <!-- <th>ID</th> -->
                <th>Task Name</th>
                <th>Date</th>
                <th>Description</th>
            </tr>

            <%
                Connection conn = null;
                PreparedStatement ps = null;
                ResultSet rs = null;
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/motion","root","root");
                    ps = conn.prepareStatement("SELECT * FROM tasks ORDER BY task_date ASC");
                    rs = ps.executeQuery();

                    while(rs.next()) {
            %>
            <tr>
                <!-- <td><%= rs.getInt("id") %></td> -->
                <td><%= rs.getString("task_name") %></td>
                <td><%= rs.getDate("task_date") %></td>
                <td><%= rs.getString("task_description") %></td>
            </tr>
            <%
                    }
                } catch(Exception e) {
                    out.println("<tr><td colspan='4'>Error: " + e.getMessage() + "</td></tr>");
                } 
                finally 
                {
                    if(rs!=null) try { rs.close(); } catch(Exception e) {}
                    if(ps!=null) try { ps.close(); } catch(Exception e) {}
                    if(conn!=null) try { conn.close(); } catch(Exception e) {}
                }
            %>
        </table>
    </div>
</body>
</html>
