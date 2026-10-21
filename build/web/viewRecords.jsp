<%-- 
    Document   : viewRecords
    Author     : User
--%>

<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Complete Database Records - Self Confidence System</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 30px; background-color: #f8f9fa; }
        h2 { color: #333; margin-top: 30px; border-bottom: 2px solid #007bff; padding-bottom: 5px; }
        .btn { display: inline-block; padding: 10px 15px; background-color: #007bff; color: white; text-decoration: none; border-radius: 4px; margin-bottom: 10px; font-weight: bold; }
        .btn:hover { background-color: #0056b3; }
        table { width: 100%; border-collapse: collapse; background: white; box-shadow: 0 2px 5px rgba(0,0,0,0.1); margin-bottom: 25px; }
        th, td { border: 1px solid #dee2e6; padding: 10px; text-align: left; }
        th { background-color: #343a40; color: white; }
        tr:nth-child(even) { background-color: #f2f2f2; }
        .badge { background-color: #28a745; color: white; padding: 3px 8px; border-radius: 12px; font-weight: bold; }
    </style>
</head>
<body>
    <h1>Self Confidence Database Viewer</h1>
    <a href="index.jsp" class="btn">+ Add New Assessment Entry</a>

    <%
        String url = "jdbc:mysql://selfconfidence-db-selfconfidence-project.c.aivencloud.com:13286/defaultdb?useSSL=true&allowPublicKeyRetrieval=true&serverTimezone=UTC";
        String user = "avnadmin";
        String password = "AVNS_K2WDuGy49H47BX0-f_3"; // Match your database password

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(url, user, password);
                 Statement stmt = conn.createStatement()) {

                // ==========================================
                // 1. TEAMS TABLE
                // ==========================================
    %>
                <h2>1. Teams </h2>
                <table>
                    <thead>
                        <tr>
                            <th>Team ID</th>
                            <th>Team Name</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            try (ResultSet rs = stmt.executeQuery("SELECT * FROM teams ORDER BY team_id ASC")) {
                                boolean hasData = false;
                                while (rs.next()) {
                                    hasData = true;
                        %>
                                    <tr>
                                        <td><%= rs.getLong("team_id") %></td>
                                        <td><strong><%= rs.getString("name") %></strong></td>
                                    </tr>
                        <%
                                }
                                if (!hasData) {
                                    out.println("<tr><td colspan='2' style='text-align:center;'>No teams found.</td></tr>");
                                }
                            }
                        %>
                    </tbody>
                </table>

    <%
                // ==========================================
                // 2. PLAYERS TABLE
                // ==========================================
    %>
                <h2>2. Players </h2>
                <table>
                    <thead>
                        <tr>
                            <th>Player ID</th>
                            <th>Team ID</th>
                            <th>First Name</th>
                            <th>Last Name</th>
                            <th>Position</th>
                            <th>Jersey #</th>
                            <th>Created At</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            try (ResultSet rs = stmt.executeQuery("SELECT * FROM players ORDER BY player_id ASC")) {
                                boolean hasData = false;
                                while (rs.next()) {
                                    hasData = true;
                        %>
                                    <tr>
                                        <td><%= rs.getLong("player_id") %></td>
                                        <td><%= rs.getObject("team_id") != null ? rs.getLong("team_id") : "N/A" %></td>
                                        <td><%= rs.getString("first_name") %></td>
                                        <td><%= rs.getString("last_name") %></td>
                                        <td><%= rs.getString("position") != null ? rs.getString("position") : "-" %></td>
                                        <td>#<%= rs.getInt("jersey_number") %></td>
                                        <td><%= rs.getTimestamp("created_at") %></td>
                                    </tr>
                        <%
                                }
                                if (!hasData) {
                                    out.println("<tr><td colspan='7' style='text-align:center;'>No players found.</td></tr>");
                                }
                            }
                        %>
                    </tbody>
                </table>

    <%
                // ==========================================
                // 3. CONFIDENCE DOMAINS TABLE
                // ==========================================
    %>
                <h2>3. Confidence Domains </h2>
                <table>
                    <thead>
                        <tr>
                            <th>Domain ID</th>
                            <th>Domain Code</th>
                            <th>Display Name</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            try (ResultSet rs = stmt.executeQuery("SELECT * FROM confidence_domains ORDER BY domain_id ASC")) {
                                boolean hasData = false;
                                while (rs.next()) {
                                    hasData = true;
                        %>
                                    <tr>
                                        <td><%= rs.getLong("domain_id") %></td>
                                        <td><code><%= rs.getString("domain_code") %></code></td>
                                        <td><%= rs.getString("display_name") %></td>
                                    </tr>
                        <%
                                }
                                if (!hasData) {
                                    out.println("<tr><td colspan='3' style='text-align:center;'>No domains found.</td></tr>");
                                }
                            }
                        %>
                    </tbody>
                </table>

    <%
                // ==========================================
                // 4. CONFIDENCE ASSESSMENTS TABLE
                // ==========================================
    %>
                <h2>4. Confidence Assessments </h2>
                <table>
                    <thead>
                        <tr>
                            <th>Assessment ID</th>
                            <th>Player ID</th>
                            <th>Context</th>
                            <th>Overall Score</th>
                            <th>Notes</th>
                            <th>Assessed At</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            try (ResultSet rs = stmt.executeQuery("SELECT * FROM confidence_assessments ORDER BY assessment_id DESC")) {
                                boolean hasData = false;
                                while (rs.next()) {
                                    hasData = true;
                        %>
                                    <tr>
                                        <td><%= rs.getLong("assessment_id") %></td>
                                        <td><%= rs.getLong("player_id") %></td>
                                        <td><%= rs.getString("context") != null ? rs.getString("context") : "-" %></td>
                                        <td><span class="badge"><%= rs.getInt("overall_score") %>/5</span></td>
                                        <td><%= rs.getString("notes") != null ? rs.getString("notes") : "-" %></td>
                                        <td><%= rs.getTimestamp("assessed_at") %></td>
                                    </tr>
                        <%
                                }
                                if (!hasData) {
                                    out.println("<tr><td colspan='6' style='text-align:center;'>No assessments found.</td></tr>");
                                }
                            }
                        %>
                    </tbody>
                </table>

    <%
                // ==========================================
                // 5. CONFIDENCE SCORES TABLE
                // ==========================================
    %>
                <h2>5. Confidence Scores </h2>
                <table>
                    <thead>
                        <tr>
                            <th>Assessment ID</th>
                            <th>Domain ID</th>
                            <th>Score</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            try (ResultSet rs = stmt.executeQuery("SELECT * FROM confidence_scores ORDER BY assessment_id DESC, domain_id ASC")) {
                                boolean hasData = false;
                                while (rs.next()) {
                                    hasData = true;
                        %>
                                    <tr>
                                        <td><%= rs.getLong("assessment_id") %></td>
                                        <td><%= rs.getLong("domain_id") %></td>
                                        <td><%= rs.getInt("score") %>/5</td>
                                    </tr>
                        <%
                                }
                                if (!hasData) {
                                    out.println("<tr><td colspan='3' style='text-align:center;'>No scores found.</td></tr>");
                                }
                            }
                        %>
                    </tbody>
                </table>

    <%
            }
        } catch (Exception e) {
            out.println("<p style='color:red;'>Error connecting to database: " + e.getMessage() + "</p>");
        }
    %>
</body>
</html>