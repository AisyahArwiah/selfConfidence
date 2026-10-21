/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


/**
 *
 * @author User
 */

@WebServlet("/selfConfidenceServlet")
public class selfConfidenceServlet extends HttpServlet {

    private static final String URL = "jdbc:mysql://selfconfidence-db-selfconfidence-project.c.aivencloud.com:13286/defaultdb?useSSL=true&allowPublicKeyRetrieval=true&serverTimezone=UTC";
private static final String USER = "avnadmin";
private static final String PASSWORD = "AVNS_K2WDuGy49H47BX0-f_3";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Retrieve form input parameters
        String teamName = request.getParameter("teamName");
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String position = request.getParameter("position");
        int jerseyNumber = Integer.parseInt(request.getParameter("jerseyNumber"));

        String domainCode = request.getParameter("domainCode");
        String domainName = request.getParameter("domainName");
        String context = request.getParameter("context");
        short overallScore = Short.parseShort(request.getParameter("overallScore"));
        short domainScore = Short.parseShort(request.getParameter("domainScore"));
        String notes = request.getParameter("notes");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD)) {
                // 1. Insert or Fetch Team
                long teamId = getOrInsertTeam(conn, teamName);

                // 2. Insert Player
                long playerId = insertPlayer(conn, teamId, firstName, lastName, position, jerseyNumber);

                // 3. Insert or Fetch Domain
                long domainId = getOrInsertDomain(conn, domainCode, domainName);

                // 4. Insert Assessment
                long assessmentId = insertAssessment(conn, playerId, context, overallScore, notes);

                // 5. Insert Domain Score
                insertScore(conn, assessmentId, domainId, domainScore);

                // Forward to success page
                request.setAttribute("playerName", firstName + " " + lastName);
                request.getRequestDispatcher("success.jsp").forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Database error: " + e.getMessage());
        }
    }

    private long getOrInsertTeam(Connection conn, String name) throws Exception {
        String selectSql = "SELECT team_id FROM teams WHERE name = ?";
        try (PreparedStatement pstmt = conn.prepareStatement(selectSql)) {
            pstmt.setString(1, name);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) return rs.getLong("team_id");
            }
        }
        String insertSql = "INSERT INTO teams (name) VALUES (?)";
        try (PreparedStatement pstmt = conn.prepareStatement(insertSql, Statement.RETURN_GENERATED_KEYS)) {
            pstmt.setString(1, name);
            pstmt.executeUpdate();
            try (ResultSet rs = pstmt.getGeneratedKeys()) {
                if (rs.next()) return rs.getLong(1);
            }
        }
        return -1;
    }

    private long insertPlayer(Connection conn, long teamId, String firstName, String lastName, String position, int jersey) throws Exception {
        String sql = "INSERT INTO players (team_id, first_name, last_name, position, jersey_number) VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement pstmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            pstmt.setLong(1, teamId);
            pstmt.setString(2, firstName);
            pstmt.setString(3, lastName);
            pstmt.setString(4, position);
            pstmt.setInt(5, jersey);
            pstmt.executeUpdate();
            try (ResultSet rs = pstmt.getGeneratedKeys()) {
                if (rs.next()) return rs.getLong(1);
            }
        }
        return -1;
    }

    private long getOrInsertDomain(Connection conn, String code, String displayName) throws Exception {
        String selectSql = "SELECT domain_id FROM confidence_domains WHERE domain_code = ?";
        try (PreparedStatement pstmt = conn.prepareStatement(selectSql)) {
            pstmt.setString(1, code);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) return rs.getLong("domain_id");
            }
        }
        String insertSql = "INSERT INTO confidence_domains (domain_code, display_name) VALUES (?, ?)";
        try (PreparedStatement pstmt = conn.prepareStatement(insertSql, Statement.RETURN_GENERATED_KEYS)) {
            pstmt.setString(1, code);
            pstmt.setString(2, displayName);
            pstmt.executeUpdate();
            try (ResultSet rs = pstmt.getGeneratedKeys()) {
                if (rs.next()) return rs.getLong(1);
            }
        }
        return -1;
    }

    private long insertAssessment(Connection conn, long playerId, String context, short score, String notes) throws Exception {
        String sql = "INSERT INTO confidence_assessments (player_id, context, overall_score, notes) VALUES (?, ?, ?, ?)";
        try (PreparedStatement pstmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            pstmt.setLong(1, playerId);
            pstmt.setString(2, context);
            pstmt.setShort(3, score);
            pstmt.setString(4, notes);
            pstmt.executeUpdate();
            try (ResultSet rs = pstmt.getGeneratedKeys()) {
                if (rs.next()) return rs.getLong(1);
            }
        }
        return -1;
    }

    private void insertScore(Connection conn, long assessmentId, long domainId, short score) throws Exception {
        String sql = "INSERT INTO confidence_scores (assessment_id, domain_id, score) VALUES (?, ?, ?)";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setLong(1, assessmentId);
            pstmt.setLong(2, domainId);
            pstmt.setShort(3, score);
            pstmt.executeUpdate();
        }
    }
}