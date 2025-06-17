package mypackage;

import java.io.IOException;
import java.sql.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    // ✅ استقبال طلبات POST (عند إرسال النموذج)
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // إعداد الترميز
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        response.setCharacterEncoding("UTF-8");

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        try {
            // الاتصال بقاعدة البيانات
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/salon", "root", "");

            // التحقق من اسم المستخدم وكلمة المرور
            String sql = "SELECT * FROM users WHERE username=? AND password=?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, username);
            stmt.setString(2, password);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                String role = rs.getString("role"); // استخراج الدور

                if ("manager".equalsIgnoreCase(role) || "employee".equalsIgnoreCase(role)) {
                    // نجاح الدخول
                    HttpSession session = request.getSession();
                    session.setAttribute("user", username);
                    session.setAttribute("role", role);
                    response.sendRedirect("index.jsp");
                } else {
                    // دور غير مسموح به
                    response.sendRedirect("login.jsp?error=صلاحيات غير كافية للدخول");
                }
            } else {
                // اسم المستخدم أو كلمة المرور خاطئة
                response.sendRedirect("login.jsp?error=اسم المستخدم أو كلمة المرور غير صحيحة");
            }

            rs.close();
            stmt.close();
            conn.close();

        } catch (Exception e) {
            // في حال حدوث خطأ تقني
            response.sendRedirect("login.jsp?error=حدث خطأ تقني: " + e.getMessage());
        }
    }

    // ✅ استقبال طلبات GET (مثل زيارة الرابط مباشرة)
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("login.jsp");
    }
}
