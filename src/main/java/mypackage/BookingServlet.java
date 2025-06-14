package mypackage;

import java.io.*;
import java.sql.*;
import java.text.SimpleDateFormat;
import java.util.Date;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/BookingServlet")
public class BookingServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        String name = request.getParameter("name");
        String phone = request.getParameter("phone");
        String service = request.getParameter("service");
        String dateStr = request.getParameter("date"); // ex: 11-06-2025
        String time = request.getParameter("time");

        PrintWriter out = response.getWriter();

        try {
            // تحويل التاريخ من dd-MM-yyyy إلى yyyy-MM-dd
            SimpleDateFormat inputFormat = new SimpleDateFormat("dd-MM-yyyy");
            SimpleDateFormat dbFormat = new SimpleDateFormat("yyyy-MM-dd");
            Date parsedDate = inputFormat.parse(dateStr);
            String formattedDate = dbFormat.format(parsedDate);

            // تحميل الدرايفر
            Class.forName("com.mysql.cj.jdbc.Driver");

            // الاتصال بقاعدة البيانات
            Connection conn = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/salon", "root", "");

            // جملة الإدخال
            String sql = "INSERT INTO appointments(name, phone, service, date, time) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, name);
            stmt.setString(2, phone);
            stmt.setString(3, service);
            stmt.setString(4, formattedDate); // التاريخ بالتنسيق الصحيح
            stmt.setString(5, time);

            int rows = stmt.executeUpdate();

            if (rows > 0) {
                response.sendRedirect("success.jsp");
            } else {
                out.println("<h3>فشل في الحجز. الرجاء المحاولة لاحقًا.</h3>");
            }

            stmt.close();
            conn.close();

        } catch (ClassNotFoundException e) {
            out.println("<h3>خطأ: لم يتم العثور على الدرايفر الخاص بقاعدة البيانات.</h3>");
            out.println("<p>تأكد أنك أضفت ملف mysql-connector-j.jar إلى المشروع.</p>");
        } catch (SQLException e) {
            out.println("<h3>خطأ في الاتصال بقاعدة البيانات أو تنفيذ الطلب.</h3>");
            out.println("<pre>" + e.getMessage() + "</pre>");
        } catch (Exception e) {
            out.println("<h3>حدث خطأ غير متوقع:</h3>");
            out.println("<pre>" + e.getMessage() + "</pre>");
        }
    }
}
