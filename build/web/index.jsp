<%-- 
    Document   : index
    Created on : 21 Oct 2026, 3:36:25 pm
    Author     : User
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Player Assessment Entry</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 30px; }
        .form-group { margin-bottom: 15px; }
        label { display: inline-block; width: 180px; font-weight: bold; }
        input, select, textarea { padding: 6px; width: 250px; }
        button { padding: 10px 20px; background-color: #28a745; color: white; border: none; cursor: pointer; }
        button:hover { background-color: #218838; }
    </style>
</head>
<body>
    <h2>Add Player Assessment</h2>
    <form action="selfConfidenceServlet" method="POST">
        
        <h3>1. Team Details</h3>
        <div class="form-group">
            <label>Team Name:</label>
            <input type="text" name="teamName" required placeholder="e.g., FC Cyberjaya">
        </div>

        <h3>2. Player Details</h3>
        <div class="form-group">
            <label>First Name:</label>
            <input type="text" name="firstName" required placeholder="e.g., John">
        </div>
        <div class="form-group">
            <label>Last Name:</label>
            <input type="text" name="lastName" required placeholder="e.g., Doe">
        </div>
        <div class="form-group">
            <label>Position:</label>
            <input type="text" name="position" placeholder="e.g., Forward">
        </div>
        <div class="form-group">
            <label>Jersey Number:</label>
            <input type="number" name="jerseyNumber" min="0" max="99" required placeholder="0-99">
        </div>

        <h3>3. Confidence Assessment</h3>
        <div class="form-group">
            <label>Domain Code:</label>
            <input type="text" name="domainCode" required placeholder="e.g., PHYSICAL">
        </div>
        <div class="form-group">
            <label>Domain Display Name:</label>
            <input type="text" name="domainName" required placeholder="e.g., Physical Preparedness">
        </div>
        <div class="form-group">
            <label>Context:</label>
            <input type="text" name="context" placeholder="e.g., Match Day">
        </div>
        <div class="form-group">
            <label>Overall Score (1-5):</label>
            <select name="overallScore" required>
                <option value="1">1 - Poor</option>
                <option value="2">2 - Fair</option>
                <option value="3">3 - Good</option>
                <option value="4" selected>4 - Very Good</option>
                <option value="5">5 - Excellent</option>
            </select>
        </div>
        <div class="form-group">
            <label>Domain Score (1-5):</label>
            <select name="domainScore" required>
                <option value="1">1</option>
                <option value="2">2</option>
                <option value="3">3</option>
                <option value="4">4</option>
                <option value="5" selected>5</option>
            </select>
        </div>
        <div class="form-group">
            <label>Notes:</label>
            <textarea name="notes" rows="3"></textarea>
        </div>

        <button type="submit">Submit Record</button>
    </form>
</body>
</html>
