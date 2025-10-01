<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>Complete Task</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <link href="https://fonts.googleapis.com/css2?family=Press+Start+2P&display=swap" rel="stylesheet">

    <style>
        body {
            background: linear-gradient(to bottom right, #9fd3ff, #5ba6e6);
            font-family: 'Press Start 2P', cursive;
            display: flex;
            justify-content: center;
            align-items: flex-start;
            padding-top: 50px;
            margin: 0;
        }

        .container {
            width: 500px;
            background: #0f1a20;
            border: 4px solid #ffffff;
            border-radius: 0;
            padding: 30px;
            box-shadow: 6px 6px #3c4c56;
        }

        h2 {
            color: #ffffff;
            font-size: 16px;
            text-align: center;
            margin-bottom: 20px;
            text-shadow: 2px 2px #3c4c56;
        }

        .task-item {
            background: #ffffff;
            border: 3px solid #3c4c56;
            padding: 12px;
            margin-bottom: 12px;
            font-size: 15px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .task-item div {
            text-align: left;
            font-size: 15px;
        }

        .task-name {
            font-weight: bold;
        }

        .status {
            font-size: 8px;
            color: #e65c00;
            margin-left: 5px;
        }

        .completed {
            text-decoration: line-through;
            color: gray;
        }

        .complete-btn {
            background: #d6edff;
            color: black;
            border: 3px solid #3c4c56;
            padding: 8px;
            font-size: 10px;
            cursor: pointer;
            text-transform: uppercase;
            letter-spacing: 1px;
            box-shadow: 4px 4px #3c4c56;
            transition: all 0.15s ease-in-out;
        }

        .complete-btn:hover {
            transform: translate(-2px, -2px);
            box-shadow: 6px 6px #3c4c56;
            background: #89c4f4;
        }

        .buttons {
            display: flex;
            justify-content: center;
            margin-bottom: 20px;
        }

        .btn {
            background: #d6edff;
            color: black;
            border: 3px solid #3c4c56;
            padding: 10px;
            font-size: 10px;
            text-decoration: none;
            text-align: center;
            box-shadow: 4px 4px #3c4c56;
            text-transform: uppercase;
            letter-spacing: 1px;
            transition: all 0.15s ease-in-out;
            margin: 0 5px;
        }

        .btn:hover {
            transform: translate(-2px, -2px);
            box-shadow: 6px 6px #3c4c56;
            background: #89c4f4;
        }

        @media screen and (max-width: 450px) {
            .container { width: 90%; padding: 20px; }
        }
    </style>
</head>
<body>

<div class="container">
    <div class="buttons">
        <a href="index.jsp" class="btn">INDEX</a>
        <a href="add_task.jsp" class="btn">ADD TASK</a>
    </div>

    <h2>📋 Complete Task</h2>

    <%
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/motion","root","root");
            PreparedStatement ps = con.prepareStatement("SELECT * FROM tasks ORDER BY task_date");
            ResultSet rs = ps.executeQuery();

            boolean found = false;
            while(rs.next()){
                found = true;
                String id = rs.getString("id");
                String name = rs.getString("task_name");
                String desc = rs.getString("task_description");
                String date = rs.getString("task_date");
                String status = rs.getString("status");
                String completedClass = status.equals("done") ? "completed" : "";
    %>

    <div class="task-item <%=completedClass%>">
        <div>
            <span class="task-name"><%= name %></span>
            <% if(status.equals("pending")) { %>
                <span class="status">(Pending)</span>
            <% } %>
            <br>
            <small><%= desc %></small><br>
            <small><%= date %></small>
        </div>

        <% if(status.equals("pending")) { %>
        <form method="post" action="CompleteTaskServlet">
            <input type="hidden" name="taskId" value="<%=id%>"/>
            <button type="submit" class="complete-btn" onclick="return confirm('Are you sure?')">DONE</button>
        </form>
        <% } %>
    </div>

    <%
            }
            if(!found){
                out.println("<div class='task-item'>No tasks found.</div>");
            }
            rs.close();
            ps.close();
            con.close();
        } catch(Exception e){
            out.println("<h3 style='color:white;'>Error: "+e.getMessage()+"</h3>");
        }
    %>
</div>
</body>
</html>
