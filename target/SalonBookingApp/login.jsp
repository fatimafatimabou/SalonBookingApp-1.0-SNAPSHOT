<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.net.URLDecoder" %>
<%
    String errorMessage = request.getParameter("error");
    if (errorMessage != null) {
        errorMessage = URLDecoder.decode(errorMessage, "UTF-8");
    }
%>
<!DOCTYPE html>
<html lang="ar">
<head>
    <meta charset="UTF-8">
    <title>تسجيل الدخول | صالون الجمال</title>
    <link href="https://fonts.googleapis.com/css2?family=Cairo:wght@400;700&family=Amiri&display=swap" rel="stylesheet">
    <style>
        body {
            background-color: #fff0f5;
            font-family: 'Cairo', sans-serif;
            direction: rtl;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }

        .login-box {
            background: white;
            padding: 40px 30px;
            width: 370px;
            border-radius: 20px;
            box-shadow: 0 8px 20px rgba(233, 30, 99, 0.3);
            animation: floatUp 0.8s ease-out;
            text-align: center;
        }

        .login-box:hover {
            transform: translateY(-5px);
            box-shadow: 0 12px 25px rgba(233, 30, 99, 0.4);
        }

        @keyframes floatUp {
            from {
                transform: translateY(30px);
                opacity: 0;
            }
            to {
                transform: translateY(0);
                opacity: 1;
            }
        }

        .logo {
            width: 80px;
            height: 80px;
            border-radius: 50%;
            margin-bottom: 10px;
            object-fit: cover;
            box-shadow: 0 0 10px #e91e63;
        }

        .salon-name {
            font-family: 'Amiri', serif;
            font-size: 30px;
            font-weight: bold;
            color: #e91e63;
            margin-bottom: 20px;
            text-shadow: 2px 2px 4px #ffebee;
            animation: fadeSlideDown 1.2s ease-out;
        }

        @keyframes fadeSlideDown {
            from {
                opacity: 0;
                transform: translateY(-20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        h2 {
            color: #d63384;
            margin-bottom: 15px;
            font-size: 20px;
        }

        input[type="text"],
        input[type="password"] {
            width: 90%;
            padding: 12px;
            margin: 10px 0;
            border: 1px solid #ccc;
            border-radius: 8px;
            transition: border-color 0.3s ease;
        }

        input:focus {
            border-color: #e91e63;
            outline: none;
        }

        button {
            padding: 12px 25px;
            background: #e91e63;
            color: white;
            border: none;
            border-radius: 30px;
            cursor: pointer;
            font-size: 16px;
            transition: background 0.3s ease, transform 0.2s ease;
            margin-top: 10px;
        }

        button:hover {
            background: #d81b60;
            transform: scale(1.05);
        }

        .error-message {
            background-color: #ffe4e1;
            color: #c62828;
            border: 1px solid #f44336;
            padding: 10px 15px;
            border-radius: 8px;
            margin-bottom: 15px;
            font-size: 15px;
        }
    </style>
</head>
<body>
    <div class="login-box">
        <img src="images/logo-removebg-preview.png" alt="شعار الصالون" class="logo">
        <div class="salon-name">✨ صالون الجمال ✨</div>
        <h2>تسجيل الدخول</h2>

        <% if (errorMessage != null && !errorMessage.isEmpty()) { %>
            <div class="error-message">
                <%= errorMessage %>
            </div>
        <% } %>

        <form action="LoginServlet" method="post">
            <input type="text" name="username" placeholder="اسم المستخدم" required><br>
            <input type="password" name="password" placeholder="كلمة المرور" required><br>
            <button type="submit">دخول</button>
        </form>
    </div>
</body>
</html>
