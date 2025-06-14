<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ar">
<head>
    <meta charset="UTF-8"> <!-- مهم لتفسير الأحرف -->
    <title>صالون الجمال - حجز موعد</title>
    <style>
        body {
            background: linear-gradient(to right, #ffe6f0, #ffccdd);
            font-family: 'Cairo', sans-serif;
            direction: rtl;
            text-align: center;
            padding: 30px;
        }
        .form-container {
            background-color: #fff0f5;
            padding: 30px;
            border-radius: 20px;
            box-shadow: 0 0 10px #f8c6d8;
            width: 400px;
            margin: auto;
        }
        input, select {
            padding: 10px;
            margin: 10px;
            width: 90%;
            border: 1px solid #ffb6c1;
            border-radius: 8px;
        }
        input[type=submit] {
            background-color: #ff69b4;
            color: white;
            font-weight: bold;
            cursor: pointer;
        }
        h2 {
            color: #d63384;
        }
    </style>
</head>
<body>
    <div class="form-container">
        <h2>احجزي موعدك في صالون الجمال ✨</h2>
        <form action="BookingServlet" method="post">
            الاسم الكامل: <input type="text" name="name" required><br>
            رقم الهاتف: <input type="text" name="phone" required><br>
            نوع الخدمة: 
            <select name="service">
                <option>تسريح شعر</option>
                <option>مكياج</option>
                <option>عناية بالبشرة</option>
                <option>حمام زيت</option>
            </select><br>
            التاريخ: <input type="date" name="date" required><br>
            الوقت: <input type="time" name="time" required><br>
            <input type="submit" value="احجزي الآن">
        </form>
    </div>
</body>
</html>


