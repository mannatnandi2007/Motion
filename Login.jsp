<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
    <title>Login</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- <link href="https://fonts.googleapis.com/css2?family=Press+Start+2P&display=swap" rel="stylesheet"> -->

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

        .container {
            background: #0f1a20;
            border: 4px solid #ffffff;
            border-radius: 0;
            padding: 40px 50px;
            width: 450px;
            text-align: center;
            box-shadow: 10px 10px #3c4c56;
            display: flex;
            flex-direction: column;
            gap: 25px;
        }

        h1 {
            color: #ffffff;
            font-size: 26px;
            text-shadow: 2px 2px #3c4c56;
        }

        input {
            padding: 12px;
            font-size: 14px;
            border: 3px solid #3c4c56;
            border-radius: 0;
            width: 100%;
            box-sizing: border-box;
        }

        button {
            background: #d6edff;
            color: black;
            font-size: 14px;
            border: 3px solid #3c4c56;
            border-radius: 0;
            padding: 12px;
            cursor: pointer;
            box-shadow: 5px 5px #3c4c56;
            text-transform: uppercase;
            letter-spacing: 2px;
            transition: all 0.15s ease-in-out;
        }

        button:hover {
            transform: translate(-2px, -2px);
            box-shadow: 7px 7px #3c4c56;
            background: #89c4f4;
        }

        a {
            color: #ffffff;
            text-decoration: none;
            font-size: 12px;
        }

        a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>LOGIN</h1>
        <form action="LoginServlet" method="post">
            <input type="email" name="email" placeholder="email" required>
            <input type="password" name="password" placeholder="Password" required>
            <button type="submit">Login</button>
        </form>
        <a href="Register.jsp">Don't have an account? Register</a>
    </div>
</body>
</html>
