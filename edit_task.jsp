<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Task</title>
    <link href="https://fonts.googleapis.com/css2?family=Press+Start+2P&display=swap" rel="stylesheet">
    <style>
        body 
        { 
            background: linear-gradient(to bottom right, #9fd3ff, #5ba6e6); 
            font-family:'Press Start 2P',cursive;
            display:flex;
             justify-content:center;
             align-items:flex-start; 
               padding-top:90px; 
            margin:0;
         }
        .container 
        {
           width:500px;
          background:#0f1a20;
           border:4px solid #fff;
            padding:30px;
            box-shadow:6px 6px #3c4c56;
        }
        h2
         { 
            color:#fff;
             text-align:center;
              margin-bottom:20px;
               text-shadow:2px 2px #3c4c56;
                font-size:16px; 
            }
        label 
        { 
            display:block;
             text-align:left;
              color:#fff;
               font-size:20px; 
               margin-top:10px; 
        }
        input, textarea 
        { 
            width:100%; 
            padding:10px; 
            margin-top:5px; 
            border:3px solid #3c4c56;
             font-size:15px;
              border-radius:0; 
            }
        textarea 
        {
             min-height:60px; 
             resize:vertical; 
      }
        .submit-btn 
        {
             background:#d6edff;
              color:black; 
              border:3px solid #3c4c56; 
              padding:12px; font-size:10px; 
              cursor:pointer; width:100%;
              text-transform:uppercase;
             letter-spacing:1px; 
             box-shadow:4px 4px #3c4c56;
                margin-top:15px; 
          }
        .submit-btn:hover 
        { 
            transform:translate(-2px,-2px);
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
            background:#d6edff; 
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
               margin:0 5px; }
        .btn:hover
         { 
            transform:translate(-2px,-2px); 
            box-shadow:6px 6px #3c4c56; 
            background:#89c4f4; }
    </style>
</head>
<body>
<div class="container">
    <div class="buttons">
        <a href="edit_task_list.jsp" class="btn">BACK</a>
        <a href="index.jsp" class="btn">INDEX</a>
    </div>

    <h2>✏️ Edit Task</h2>

    <%
        String taskId = request.getParameter("taskId");
        String taskName="", taskDate="", taskDesc="";
        if(taskId != null){
            try{
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/motion","root","root");
                PreparedStatement ps = con.prepareStatement("SELECT * FROM tasks WHERE id=?");
                ps.setString(1, taskId);
                ResultSet rs = ps.executeQuery();
                if(rs.next()){
                    taskName = rs.getString("task_name");
                    taskDate = rs.getString("task_date");
                    taskDesc = rs.getString("task_description");
                }
                rs.close(); ps.close(); con.close();
            } catch(Exception e){
                out.println("<p style='color:red;'>Error: "+e.getMessage()+"</p>");
            }
        }
    %>

    <form action="<%=request.getContextPath()%>/EditTaskServlet" method="post">

        <input type="hidden" name="taskId" value="<%=taskId%>">

        <label>Task Name:</label>
        <input type="text" name="task_name" value="<%=taskName%>" required>

        <label>Task Date:</label>
        <input type="date" name="task_date" value="<%=taskDate%>" required>

        <label>Task Description:</label>
        <textarea name="task_description" required><%=taskDesc%></textarea>

        <button type="submit" class="submit-btn">UPDATE TASK</button>
    </form>
</div>
</body>
</html>
