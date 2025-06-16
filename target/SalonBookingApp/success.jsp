<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ar">
<head>
    <meta charset="UTF-8">
    <title>تم الحجز</title>
    <style>
        body {
            background: linear-gradient(to right, #ffe6f0, #ffccdd);
            font-family: 'Cairo', sans-serif;
            direction: rtl;
            text-align: center;
            padding: 50px;
        }
        .card {
            background-color: #fff0f5;
            padding: 40px;
            border-radius: 20px;
            box-shadow: 0 0 15px #f8c6d8;
            width: 60%;
            margin: auto;
        }
        h2 {
            color: #e91e63;
            font-size: 30px;
            margin-bottom: 20px;
        }
        p {
            color: #555;
            font-size: 18px;
            margin-bottom: 10px;
        }
        .btn {
            display: inline-block;
            margin-top: 20px;
            padding: 12px 20px;
            background-color: #e91e63;
            color: white;
            text-decoration: none;
            border-radius: 10px;
            font-weight: bold;
            font-size: 16px;
            transition: background-color 0.3s ease;
        }
        .btn:hover {
            background-color: #d81b60;
        }
    </style>
</head>
<body>
    <div class="card">
        <h2>✨ تم حجز الموعد بنجاح!</h2>
        <p>شكراً لاختيارك <strong>صالون الجمال</strong> 💅</p>
        <p>سنكون في خدمتك في الموعد المحدد بكل سرور 🌸</p>
        <a href="index.jsp" class="btn">🔙 العودة إلى صفحة الحجز</a>
    </div>
</body>
</html>
