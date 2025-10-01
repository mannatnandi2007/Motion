<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>

<head>
    <meta charset="UTF-8">
    <title>Add Task</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

  
    <link href="https://fonts.googleapis.com/css2?family=Press+Start+2P&display=swap" rel="stylesheet">

    <style>
        body {
            background: linear-gradient(to bottom right, #9fd3ff, #5ba6e6);
            font-family: 'Press Start 2P', cursive;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }

        .task-card {
            background: #0f1a20;
            border: 4px solid #ffffff;
            border-radius: 0; 
            padding: 30px 30px;
            width: 400px;
            height: 450px;
            box-shadow: 6px 6px #3c4c56;
            text-align: center;
        }

        .task-card h2 {
            color: #ffffff;
            font-size: 20px;
            margin-bottom: 20px;
            text-shadow: 2px 2px #3c4c56;
        }

        label {
            display: block;
            text-align: left;
            margin-bottom: 5px;
            font-weight: 600;
            color: #ffffff;
            font-size: 10px;
        }

        input[type="text"], input[type="date"], textarea {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border-radius: 0;
            border: 3px solid #3c4c56;
            font-size: 20px;
            background: #ffffff;
        }

        textarea {
            resize: vertical;
            min-height: 150px;
        }

        input:focus, textarea:focus {
            outline: none;
            border-color: #3399ff;
        }

        .submit-btn {
            background: #d6edff;
            color: black;
            border: 3px solid #3c4c56;
            padding: 12px;
            font-size: 10px;
            cursor: pointer;
            width: 100%;
            text-transform: uppercase;
            letter-spacing: 1px;
            box-shadow: 4px 4px #3c4c56;
            transition: all 0.15s ease-in-out;
        }

        .submit-btn:hover {
            transform: translate(-2px, -2px);
            box-shadow: 6px 6px #3c4c56;
            background: #89c4f4;
        }

        .buttons {
            position: absolute;
            top: 50px;
            left: 50%;
            transform: translateX(-50%);
            display: flex;
            justify-content: center;
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

        @media screen and (max-width: 400px) {
            .task-card {
                width: 90%;
                padding: 20px;
            }
        }
    </style>
</head>
<body>
    <form action="AddTaskServlet" method="post">
        <div class="buttons">
            <a href="index.jsp" class="btn">INDEX</a>
        </div>
        
        <div class="task-card">
            <h2>📝 Add Task</h2>

            <label for="task_name">Task Name:</label>
            <input type="text" name="task_name" id="task_name" required>

            <label for="task_date">Task Date:</label>
            <input type="date" name="task_date" id="task_date" required>

            <label for="task_description">Description:</label>
            <textarea name="task_description" id="task_description" required></textarea>

            <button type="submit" class="submit-btn">➕ Add Task</button>
        </div>
    </form>
</body>
</html>
