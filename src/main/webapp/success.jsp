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
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            overflow: hidden;
        }

        .card {
            background-color: #fff0f5;
            padding: 40px 30px;
            border-radius: 25px;
            box-shadow: 0 10px 25px rgba(248, 198, 216, 0.7);
            width: 90%;
            max-width: 500px;
            animation: popUp 1s ease;
            text-align: center;
        }

        @keyframes popUp {
            0% {
                transform: scale(0.9);
                opacity: 0;
            }
            100% {
                transform: scale(1);
                opacity: 1;
            }
        }

        .icon {
            font-size: 50px;
            color: #e91e63;
            margin-bottom: 15px;
            animation: sparkle 2s infinite ease-in-out;
        }

        @keyframes sparkle {
            0%, 100% { transform: rotate(0deg); }
            50% { transform: rotate(5deg); }
        }

        h2 {
            color: #d63384;
            font-size: 28px;
            margin-bottom: 10px;
        }

        p {
            color: #444;
            font-size: 17px;
            margin: 10px 0;
        }

        .btn-container {
            margin-top: 25px;
            display: flex;
            flex-direction: column;
            gap: 12px;
        }

        .btn {
            display: block;
            padding: 12px 25px;
            background-color: #e91e63;
            color: white;
            text-decoration: none;
            border-radius: 12px;
            font-weight: bold;
            font-size: 16px;
            transition: all 0.3s ease;
        }

        .btn:hover {
            background-color: #c2185b;
            transform: scale(1.05);
        }

        .btn:active {
            transform: scale(0.95);
        }
    </style>
</head>
<body>
    <div class="card">
        <div class="icon">💖</div>
        <h2>تم الحجز بنجاح!</h2>
        <p>شكراً لاختيارك <strong>صالون الجمال</strong> 💅</p>
        <p>نتطلع لخدمتك بكل حب واهتمام 🌸</p>
        <div class="btn-container">
            <a href="index.jsp" class="btn">🔄 حجز موعد جديد</a>
            <a href="appointments.jsp" class="btn">📋 عرض المواعيد</a>
           
        </div>
    </div>
</body>
</html>
