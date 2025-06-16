package mypackage;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/UpdateServlet")
public class UpdateServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String id = request.getParameter("id");
        String name = request.getParameter("name");
        String phone = request.getParameter("phone");
        String service = request.getParameter("service");
        String date = request.getParameter("date");
        String time = request.getParameter("time");
        String stylistId = request.getParameter("stylist_id"); // إضافة معرف الموظفة

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/salon", "root", "");

            // ✅ تم تعديل أسماء الأعمدة لتتوافق مع قاعدة البيانات
            String sql = "UPDATE appointments SET name=?, phone=?, service=?, date=?, time=?, stylist_id=? WHERE id=?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, name);
            stmt.setString(2, phone);
            stmt.setString(3, service);
            stmt.setString(4, date);
            stmt.setString(5, time);
            stmt.setString(6, stylistId);
            stmt.setString(7, id);

            stmt.executeUpdate();
            conn.close();

            response.sendRedirect("appointments.jsp");
        } catch (Exception e) {
            response.setContentType("text/html;charset=UTF-8");
            response.getWriter().println("خطأ: " + e.getMessage());
        }
    }
}

