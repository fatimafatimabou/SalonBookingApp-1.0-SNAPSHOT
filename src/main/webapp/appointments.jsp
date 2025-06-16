<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ar">
<head>
    <meta charset="UTF-8">
    <title>قائمة المواعيد</title>
    <style>
        body {
            font-family: 'Cairo', sans-serif;
            background: linear-gradient(to right, #ffe6f0, #ffccdd);
            text-align: center;
            padding: 40px;
            direction: rtl;
        }

        .btn {
            display: inline-block;
            margin-bottom: 20px;
            padding: 12px 18px;
            background-color: #e91e63;
            color: white;
            text-decoration: none;
            border-radius: 10px;
            font-weight: bold;
            transition: background-color 0.3s, transform 0.2s;
        }

        .btn:hover {
            background-color: #c2185b;
        }

        .btn:active {
            transform: scale(0.95);
        }

        table {
            width: 95%;
            margin: auto;
            border-collapse: collapse;
            background: white;
            box-shadow: 0 0 15px #f8c6d8;
            border-radius: 12px;
            overflow: hidden;
        }

        th, td {
            padding: 14px;
            border: 1px solid #f3cdd7;
        }

        th {
            background-color: #ffb6c1;
            color: white;
        }

        td {
            background-color: #fffafc;
        }

        a, form input[type="submit"] {
            background-color: #e91e63;
            color: white;
            padding: 8px 14px;
            border: none;
            border-radius: 8px;
            text-decoration: none;
            font-weight: bold;
            cursor: pointer;
            transition: background-color 0.3s, transform 0.2s;
        }

        a:hover, form input[type="submit"]:hover {
            background-color: #d81b60;
        }

        a:active, form input[type="submit"]:active {
            transform: scale(0.95);
        }

        form {
            display: inline;
        }
    </style>
</head>
<body>
    <a href="index.jsp" class="btn">🔙 الرجوع إلى صفحة الحجز</a>
    <h2 style="color:#d63384;">📋 قائمة المواعيد</h2>
    <table>
        <tr>
            <th>الاسم</th>
            <th>الهاتف</th>
            <th>الخدمة</th>
            <th>التاريخ</th>
            <th>الوقت</th>
            <th>الموظفة</th>
            <th>تعديل</th>
            <th>حذف</th>
        </tr>
        <%
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/salon", "root", "");
                Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery("SELECT * FROM appointments");

                while(rs.next()) {
                    int stylistId = rs.getInt("stylist_id");
                    String stylistName = "غير محدد";

                    switch (stylistId) {
                        case 1: stylistName = "ليلى"; break;
                        case 2: stylistName = "سعاد"; break;
                        case 3: stylistName = "مريم"; break;
                    }
        %>
        <tr>
            <td><%= rs.getString("name") %></td>
            <td><%= rs.getString("phone") %></td>
            <td><%= rs.getString("service") %></td>
            <td><%= rs.getDate("date") %></td>
            <td><%= rs.getTime("time") %></td>
            <td><%= stylistName %></td>
            <td>
                <a href="edit.jsp?id=<%= rs.getInt("id") %>">تعديل</a>
            </td>
            <td>
                <form action="DeleteServlet" method="post">
                    <input type="hidden" name="id" value="<%= rs.getInt("id") %>">
                    <input type="submit" value="حذف">
                </form>
            </td>
        </tr>
        <%
                }
                rs.close();
                stmt.close();
                conn.close();
            } catch(Exception e) {
                out.println("<tr><td colspan='8'>❌ خطأ: " + e.getMessage() + "</td></tr>");
            }
        %>
    </table>
</body>
</html>
