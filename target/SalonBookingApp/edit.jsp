<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String id = request.getParameter("id");
    String name = "", phone = "", service = "", date = "", time = "", stylistId = "";

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/salon", "root", "");

        // جلب بيانات الموعد
        PreparedStatement stmt = conn.prepareStatement("SELECT * FROM appointments WHERE id=?");
        stmt.setString(1, id);
        ResultSet rs = stmt.executeQuery();
        if (rs.next()) {
            name = rs.getString("name");
            phone = rs.getString("phone");
            service = rs.getString("service");
            date = rs.getString("date");
            time = rs.getString("time");
            stylistId = rs.getString("stylist_id");
        }
        rs.close();
        stmt.close();

        // جلب قائمة الموظفات
        PreparedStatement stylistStmt = conn.prepareStatement("SELECT * FROM stylists");
        ResultSet stylistRs = stylistStmt.executeQuery();
        request.setAttribute("stylists", stylistRs); // نمررهم للصفحة
%>
<!DOCTYPE html>
<html lang="ar">
<head>
    <meta charset="UTF-8">
    <title>تعديل الموعد</title>
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
            transition: box-shadow 0.3s;
        }

        input:focus, select:focus {
            box-shadow: 0 0 6px #e91e63;
            outline: none;
        }

        input[type=submit] {
            background-color: #e91e63;
            color: white;
            font-weight: bold;
            cursor: pointer;
            transition: background-color 0.3s, transform 0.2s;
        }

        input[type=submit]:hover {
            background-color: #d81b60;
        }

        input[type=submit]:active {
            transform: scale(0.95);
        }

        h2 {
            color: #d63384;
        }
    </style>
</head>
<body>
    <div class="form-container">
        <h2>تعديل الموعد</h2>
        <form action="UpdateServlet" method="post">
            <input type="hidden" name="id" value="<%= id %>">
            الاسم الكامل: <input type="text" name="name" value="<%= name %>" required><br>
            رقم الهاتف: <input type="text" name="phone" value="<%= phone %>" required><br>

            نوع الخدمة:
            <select name="service">
                <option <%= service.equals("تسريح شعر") ? "selected" : "" %>>تسريح شعر</option>
                <option <%= service.equals("مكياج") ? "selected" : "" %>>مكياج</option>
                <option <%= service.equals("عناية بالبشرة") ? "selected" : "" %>>عناية بالبشرة</option>
                <option <%= service.equals("حمام زيت") ? "selected" : "" %>>حمام زيت</option>
                <option <%= service.equals("تجميل الأظافر") ? "selected" : "" %>>تجميل الأظافر</option>
                <option <%= service.equals("العناية بالقدمين") ? "selected" : "" %>>العناية بالقدمين</option>
            </select><br>

            الموظفة:
            <select name="stylist_id" required>
                <%
                    while (stylistRs.next()) {
                        String sId = stylistRs.getString("id");
                        String sName = stylistRs.getString("name");
                        String selected = sId.equals(stylistId) ? "selected" : "";
                %>
                    <option value="<%= sId %>" <%= selected %>><%= sName %></option>
                <%
                    }
                    stylistRs.close();
                    stylistStmt.close();
                    conn.close();
                %>
            </select><br>

            التاريخ: <input type="date" name="date" value="<%= date %>" required><br>
            الوقت: <input type="time" name="time" value="<%= time %>" required><br>
            <input type="submit" value="تحديث الموعد">
        </form>
    </div>
</body>
</html>
<%
    } catch(Exception e) {
        out.println("❌ خطأ: " + e.getMessage());
    }
%>
