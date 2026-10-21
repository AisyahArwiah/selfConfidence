<%-- 
    Document   : success
    Created on : 21 Oct 2026, 3:38:16 pm
    Author     : User
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Success</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 50px; text-align: center; }
        .card { border: 1px solid #ddd; padding: 20px; display: inline-block; border-radius: 8px; }
        a { text-decoration: none; color: #007bff; font-weight: bold; }
    </style>
</head>
<body>
    <div class="card">
        <h2 style="color: green;">Data Saved Successfully!</h2>
        <p>Record for player <strong><%= request.getAttribute("playerName") %></strong> has been added to the database.</p>
        <a href="index.jsp">Add Another Record</a>
    </div>
</body>
</html>