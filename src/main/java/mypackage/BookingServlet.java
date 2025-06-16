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

        // استقبال البيانات من الفورم
        String name = request.getParameter("name");
        String phone = request.getParameter("phone");
        String service = request.getParameter("service");
        String dateStr = request.getParameter("date");
        String time = request.getParameter("time");
        String stylistIdStr = request.getParameter("stylist_id");

        PrintWriter out = response.getWriter();

        try {
            // تنسيق التاريخ
            SimpleDateFormat inputFormat = new SimpleDateFormat("yyyy-MM-dd");
            SimpleDateFormat dbFormat = new SimpleDateFormat("yyyy-MM-dd");
            Date parsedDate = inputFormat.parse(dateStr);
            String formattedDate = dbFormat.format(parsedDate);

            int stylistId = Integer.parseInt(stylistIdStr); // تحويل المعرف إلى رقم

            // الاتصال بقاعدة البيانات
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/salon", "root", "");

            // إدخال الموعد في قاعدة البيانات
            String sql = "INSERT INTO appointments (name, phone, service, date, time, stylist_id) VALUES (?, ?, ?, ?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, name);
            stmt.setString(2, phone);
            stmt.setString(3, service);
            stmt.setString(4, formattedDate);
            stmt.setString(5, time);
            stmt.setInt(6, stylistId);

            int rows = stmt.executeUpdate();

            if (rows > 0) {
                response.sendRedirect("appointments.jsp");
            } else {
                out.println("<h3>فشل في تسجيل الحجز. يرجى المحاولة مرة أخرى.</h3>");
            }

            stmt.close();
            conn.close();

        } catch (ClassNotFoundException e) {
            out.println("<h3>خطأ: لم يتم العثور على Driver قاعدة البيانات.</h3>");
        } catch (SQLException e) {
            out.println("<h3>خطأ في قاعدة البيانات:</h3>");
            out.println("<pre>" + e.getMessage() + "</pre>");
        } catch (Exception e) {
            out.println("<h3>حدث خطأ غير متوقع:</h3>");
            out.println("<pre>" + e.getMessage() + "</pre>");
        }
    }
}
