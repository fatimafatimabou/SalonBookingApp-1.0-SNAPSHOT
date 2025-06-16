<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ar">
<head>
    <meta charset="UTF-8">
    <title>صالون الجمال - حجز موعد</title>
    <style>
        body {
            background: linear-gradient(to right, #ffe6f0, #ffccdd);
            font-family: 'Cairo', sans-serif;
            direction: rtl;
            text-align: center;
            padding: 30px;
        }

        /* مؤثرات الحركة */
        .fade-in {
            opacity: 0;
            animation: fadeIn 1.5s ease-in forwards;
        }

        .slide-in-up {
            transform: translateY(40px);
            opacity: 0;
            animation: slideInUp 1.2s ease-out forwards;
        }

        @keyframes fadeIn {
            to {
                opacity: 1;
            }
        }

        @keyframes slideInUp {
            to {
                transform: translateY(0);
                opacity: 1;
            }
        }

        .form-container {
            background-color: #fff0f5;
            padding: 30px;
            border-radius: 20px;
            box-shadow: 0 0 10px #f8c6d8;
            width: 400px;
            margin: auto;
            transition: transform 0.3s;
        }

        input, select {
            padding: 10px;
            margin: 10px;
            width: 90%;
            border: 1px solid #ffb6c1;
            border-radius: 8px;
            transition: border-color 0.3s, box-shadow 0.3s;
        }

        input:focus, select:focus {
            border-color: #e91e63;
            box-shadow: 0 0 5px #e91e63;
            outline: none;
        }

        input[type=submit] {
            background-color: #ff69b4;
            color: white;
            font-weight: bold;
            cursor: pointer;
            transition: background-color 0.3s, transform 0.2s;
        }

        input[type=submit]:hover {
            background-color: #ff1493;
        }

        input[type=submit]:active {
            transform: scale(0.95);
        }

        h2 {
            color: #d63384;
        }

        .link-btn {
            display: inline-block;
            margin-top: 20px;
            padding: 10px 15px;
            background-color: #e91e63;
            color: white;
            text-decoration: none;
            border-radius: 8px;
            font-weight: bold;
            transition: background-color 0.3s, transform 0.2s;
        }

        .link-btn:hover {
            background-color: #c2185b;
        }

        .link-btn:active {
            transform: scale(0.95);
        }
    </style>
</head>
<body>
    <div class="form-container fade-in">
        <h2 class="slide-in-up">احجزي موعدك في صالون الجمال ✨</h2>

        <form action="BookingServlet" method="post" class="slide-in-up">
            الاسم الكامل: <input type="text" name="name" required><br>
            رقم الهاتف: <input type="text" name="phone" required><br>

            نوع الخدمة:
            <select name="service">
                <option>تسريح شعر</option>
                <option>مكياج</option>
                <option>عناية بالبشرة</option>
                <option>حمام زيت</option>
                <option>تجميل الأظافر</option>
                <option>العناية بالقدمين</option>
            </select><br>

            اختاري الموظفة:
            <select name="stylist_id" required>
                <%
                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/salon", "root", "");
                        Statement stmt = conn.createStatement();
                        ResultSet rs = stmt.executeQuery("SELECT * FROM stylists");

                        while (rs.next()) {
                %>
                    <option value="<%= rs.getInt("id") %>"><%= rs.getString("name") %></option>
                <%
                        }
                        rs.close();
                        stmt.close();
                        conn.close();
                    } catch (Exception e) {
                        out.println("<option disabled>⚠ لا يمكن تحميل الموظفات</option>");
                    }
                %>
            </select><br>

            التاريخ: <input type="date" name="date" required><br>
            الوقت: <input type="time" name="time" required><br>
            <input type="submit" value="احجزي الآن">
        </form>

        <a class="link-btn slide-in-up" href="appointments.jsp">📋 عرض المواعيد</a>
    </div>
</body>
</html>
