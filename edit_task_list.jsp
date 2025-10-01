<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Tasks</title>
    <link href="https://fonts.googleapis.com/css2?family=Press+Start+2P&display=swap" rel="stylesheet">
    <style>
        body
         {
            background: linear-gradient(to bottom right, #9fd3ff, #5ba6e6);
            font-family: 'Press Start 2P', cursive;
            display: flex;
            justify-content: center;
            align-items: flex-start;
            padding-top: 50px;
            margin: 0;
        }
        .container 
        {
            width: 500px;
            height: 100%;
            background: #0f1a20;
            border: 4px solid #ffffff;
            padding: 30px;
            box-shadow: 6px 6px #3c4c56;
        }
        h2 
        { 
            color:#fff;
             text-align:center;
              text-shadow: 2px 2px #3c4c56; 
              font-size:20px; 
              margin-bottom:20px; 
        }
        .task-item
         {
            background:#fff;
             border:3px solid #3c4c56;
              padding:12px; 
              margin-bottom:12px; 
              font-size:14px;
            display:flex; 
            justify-content:space-between; 
            align-items:center;
        }
        .task-item div
         { 
            text-align:left; 
        }
        .edit-btn
         {
            background: #d6edff; 
            color:black;
             border:3px solid #3c4c56;
              padding:8px;
               font-size:10px;
            cursor:pointer;
             text-transform:uppercase;
              letter-spacing:1px; 
              box-shadow:4px 4px #3c4c56;
            transition: all 0.15s ease-in-out;
        }
        .edit-btn:hover
         { transform:translate(-2px,-2px); 
            box-shadow:6px 6px #3c4c56;
             background:#89c4f4;
             }
        .buttons 
        { 
            display:flex; 
            justify-content:center; 
            margin-bottom:20px;
         }
        .btn 
        {
            background: #d6edff; 
            color:black; 
            border:3px solid #3c4c56;
             padding:10px; 
             font-size:10px;
            text-decoration:none;
             text-align:center;
              box-shadow:4px 4px #3c4c56; 
              text-transform:uppercase;
            letter-spacing:1px; 
            transition:all 0.15s ease-in-out; 
            margin:0 5px;
        }
        .btn:hover
         { 
            transform:translate(-2px,-2px); 
            box-shadow:6px 6px #3c4c56; 
            background:#89c4f4;
         }
    </style>
</head>
<body>
<div class="container">
    <div class="buttons">
        <a href="index.jsp" class="btn">INDEX</a>
        <a href="add_task.jsp" class="btn">ADD TASK</a>
    </div>

    <h2>✏️ Edit Tasks</h2>

    <%
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/motion","root","root");
            PreparedStatement ps = con.prepareStatement("SELECT * FROM tasks ORDER BY task_date");
            ResultSet rs = ps.executeQuery();

            while(rs.next()){
                String id = rs.getString("id");
                String name = rs.getString("task_name");
                String desc = rs.getString("task_description");
                String date = rs.getString("task_date");
    %>

    <div class="task-item">
        <div>
            <b><%= name %></b><br>
            <small><%= desc %></small><br>
            <small><%= date %></small>
        </div>
        <form method="get" action="edit_task.jsp">
            <input type="hidden" name="taskId" value="<%=id%>"/>
            <button type="submit" class="edit-btn">EDIT</button>
        </form>
    </div>

    <%
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
