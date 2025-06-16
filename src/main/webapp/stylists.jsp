<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ar">
<head>
    <meta charset="UTF-8">
    <title>قائمة الموظفات</title>
    <style>
        body {
            font-family: 'Cairo', sans-serif;
            background-color: #fff0f5;
            direction: rtl;
            text-align: center;
            padding: 30px;
        }
        table {
            width: 90%;
            margin: auto;
            border-collapse: collapse;
            background: #fff;
            box-shadow: 0 0 10px #ccc;
        }
        th, td {
            padding: 10px;
            border: 1px solid #ddd;
        }
        th {
            background-color: #f06292;
            color: white;
        }
    </style>
</head>
<body>
    <h2>💇‍♀️ قائمة الموظفات</h2>
    <table>
        <tr>
            <th>الاسم</th>
            <th>رقم الهاتف</th>
            <th>التخصص</th>
            <th>الحالة</th>
        </tr>
        <%
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/salon", "root", "");
                Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery("SELECT * FROM stylists");

                while (rs.next()) {
        %>
        <tr>
            <td><%= rs.getString("name") %></td>
            <td><%= rs.getString("phone") %></td>
            <td><%= rs.getString("specialization") %></td>
            <td><%= rs.getBoolean("available") ? "متاحة" : "غير متاحة" %></td>
        </tr>
        <%
                }
                rs.close();
                stmt.close();
                conn.close();
            } catch (Exception e) {
                out.println("<tr><td colspan='4'>حدث خطأ: " + e.getMessage() + "</td></tr>");
            }
        %>
    </table>
</body>
</html>
