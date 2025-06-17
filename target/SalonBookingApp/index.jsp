 <%@ page import="java.sql.*" %>
<%@ page import="jakarta.servlet.http.*, jakarta.servlet.*" %>
<%
    if (session == null || session.getAttribute("user") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ar">
<head>
    <meta charset="UTF-8">
    <title>صالون الأناقة | حجز موعد</title>
    <link href="https://fonts.googleapis.com/css2?family=Cairo:wght@400;700&family=Amiri&display=swap" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: 'Cairo', sans-serif;
            direction: rtl;
            background: linear-gradient(to right, #ffe6f0, #ffccdd);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .container {
            background: rgba(255, 255, 255, 0.75);
            backdrop-filter: blur(12px);
            box-shadow: 0 12px 30px rgba(233, 30, 99, 0.2);
            padding: 40px 35px;
            border-radius: 25px;
            width: 450px;
            animation: zoomIn 0.9s ease;
        }

        @keyframes zoomIn {
            from {
                transform: scale(0.95);
                opacity: 0;
            }
            to {
                transform: scale(1);
                opacity: 1;
            }
        }

        .header {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 15px;
            margin-bottom: 25px;
        }

        .header img {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            box-shadow: 0 0 5px rgba(0,0,0,0.2);
        }

        .header h2 {
            font-family: 'Amiri', serif;
            font-size: 24px;
            color: #e91e63;
            margin: 0;
            text-shadow: 1px 1px #fff;
        }

        label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
            color: #ad1457;
        }

        input, select {
            width: 100%;
            padding: 12px 14px;
            margin-bottom: 18px;
            border-radius: 14px;
            border: 1px solid #f48fb1;
            background: #fff;
            transition: border 0.3s, box-shadow 0.3s;
            font-size: 15px;
        }

        input:focus, select:focus {
            border-color: #e91e63;
            box-shadow: 0 0 5px #ec407a;
            outline: none;
        }

        input[type="submit"] {
            background-color: #e91e63;
            color: white;
            font-weight: bold;
            font-size: 16px;
            border: none;
            transition: 0.3s;
            cursor: pointer;
        }

        input[type="submit"]:hover {
            background-color: #d81b60;
            transform: scale(1.03);
        }

        .btn-group {
            margin-top: 20px;
            display: flex;
            justify-content: space-between;
        }

        .btn-link {
            display: inline-block;
            background-color: #f06292;
            color: white;
            padding: 10px 20px;
            text-decoration: none;
            border-radius: 10px;
            font-weight: bold;
            transition: 0.3s;
        }

        .btn-link:hover {
            background-color: #ec407a;
            transform: scale(1.05);
        }

        .icon {
            margin-left: 6px;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <img src="images/logo-removebg-preview.png"  alt="شعار الصالون">
            
            <h2>  احجزي موعدك في صالون الجمال</h2>
        </div>

        <form action="BookingServlet" method="post">
            <label>الاسم الكامل:</label>
            <input type="text" name="name" required>

            <label>رقم الهاتف:</label>
            <input type="text" name="phone" required>

            <label>نوع الخدمة:</label>
            <select name="service" required>
                <option>تسريح شعر</option>
                <option>مكياج</option>
                <option>عناية بالبشرة</option>
                <option>حمام زيت</option>
                <option>تجميل الأظافر</option>
                <option>العناية بالقدمين</option>
            </select>

            <label>اختاري الموظفة:</label>
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
                        out.println("<option disabled>⚠ خطأ في تحميل الموظفات</option>");
                    }
                %>
            </select>

            <label>التاريخ:</label>
            <input type="date" name="date" required>

            <label>الوقت:</label>
            <input type="time" name="time" required>

            <input type="submit" value="احجزي الآن">
        </form>

        <div class="btn-group">
            <a href="appointments.jsp" class="btn-link"><i class="fa fa-calendar-check icon"></i>عرض المواعيد</a>
            <a href="logout.jsp" class="btn-link"><i class="fa fa-sign-out-alt icon"></i>خروج</a>
        </div>
    </div>
</body>
</html>
