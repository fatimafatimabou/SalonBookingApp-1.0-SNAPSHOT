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

@WebServlet("/DeleteServlet")
public class DeleteServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String id = request.getParameter("id");

        // ✅ تحقق من استقبال المعرف في الكونسول
        System.out.println("🟡 تم استقبال ID للحذف: " + id);

        if (id == null || id.trim().isEmpty()) {
            response.getWriter().println("⚠ المعرف (ID) غير موجود أو فارغ.");
            return;
        }

        try {
            int appointmentId = Integer.parseInt(id);

            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/salon", "root", "");

            String sql = "DELETE FROM appointments WHERE id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, appointmentId);

            int affectedRows = stmt.executeUpdate();

            // ✅ إغلاق الاتصال
            conn.close();

            // ✅ عرض النتيجة في الكونسول
            System.out.println("🟢 عدد الصفوف المحذوفة: " + affectedRows);

            if (affectedRows > 0) {
                response.sendRedirect("appointments.jsp");
            } else {
                response.getWriter().println("❌ لم يتم العثور على الموعد المطلوب حذفه.");
            }

        } catch (NumberFormatException e) {
            System.out.println("🚫 خطأ في تحويل المعرف إلى رقم: " + e.getMessage());
            response.getWriter().println("⚠ المعرف غير صالح.");
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("🚫 خطأ أثناء الحذف: " + e.getMessage());
        }
    }
}
