<%@page import="ma.bankati.model.data.MoneyData" pageEncoding="UTF-8" %>
<%@page import="ma.bankati.model.users.User" %>

<%
  var ctx = request.getContextPath();
  var connectedUser = (ma.bankati.model.users.User) session.getAttribute("connectedUser");
  var appName = (String) application.getAttribute("AppName");
  var usersCount = request.getAttribute("usersCount");
  var creditsCount =  request.getAttribute("creditsCount");
  var creditsApprouveCount =  request.getAttribute("creditsApprouve");
  var creditsRefuseCount = request.getAttribute("creditsRefuse");
  String userInitial = connectedUser.getLastName().substring(0, 1).toUpperCase();
%>
<!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Administration</title>

  <!-- Google Fonts -->
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">

  <link rel="stylesheet" href="<%= ctx %>/assets/css/bootstrap.min.css">
  <link rel="stylesheet" href="<%= ctx %>/assets/css/bootstrap-icons.css">
  <link rel="stylesheet" href="<%= ctx %>/assets/css/style.css">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

  <style>
    body {
      font-family: 'Poppins', sans-serif;
      background-color: #c9deff;
      padding-bottom: 60px; /* Space for fixed footer */
    }

    .text-blue {
      color: #3a7bd5;
    }

    .bg-blue-light {
      background-color: #f0f7ff;
    }

    .navbar-bankati {
      box-shadow: 0 2px 10px rgba(0,0,0,0.1);
    }

    .navbar-brand {
      font-weight: 700; /* Make the brand name bolder */
    }

    /* Updated navbar styles for better alignment */
    .navbar .container {
      justify-content: space-between;
    }

    .navbar-nav {
      align-items: center;
    }

    .nav-item {
      display: flex;
      align-items: center;
    }

    .admin-dashboard-card {
      border-radius: 15px;
      box-shadow: 0 10px 20px rgba(0,0,0,0.08);
      transition: all 0.3s ease;
      padding: 2rem;
      margin-bottom: 1.5rem;
    }

    .admin-dashboard-card:hover {
      transform: translateY(-5px);
      box-shadow: 0 15px 30px rgba(0,0,0,0.12);
    }

    .stats-value {
      font-size: 2rem;
      font-weight: 600;
    }

    .stats-label {
      font-weight: 500;
      color: #3a7bd5;
      margin-bottom: 0.5rem;
    }

    .footer-bankati {
      background-color: white;
      box-shadow: 0 -2px 10px rgba(0,0,0,0.05);
      padding: 0.8rem 0;
    }

    .user-profile {
      display: flex;
      align-items: center;
      padding: 0.5rem 1rem;
      border-radius: 50px;
      background-color: #f0f7ff;
      border: 1px solid #e0e9ff;
      transition: all 0.2s ease;
    }

    .user-profile:hover {
      background-color: #e6f0ff;
      box-shadow: 0 3px 8px rgba(58, 123, 213, 0.15);
    }

    .user-avatar {
      width: 38px;
      height: 38px;
      border-radius: 50%;
      display: flex;
      align-items: center;
      justify-content: center;
      background-color: #3a7bd5;
      color: white;
      font-weight: 600;
      margin-right: 10px;
    }

    .user-info {
      font-size: 0.9rem;
      line-height: 1.2;
    }

    .user-name {
      font-weight: 500;
    }

    .user-role {
      font-size: 0.75rem;
      color: #6c757d;
    }

    .dropdown-menu {
      border-radius: 12px;
      box-shadow: 0 5px 15px rgba(0,0,0,0.1);
      border: none;
      padding: 0.5rem;
    }

    .dropdown-item {
      border-radius: 8px;
      padding: 0.6rem 1rem;
    }

    .logout-btn {
      color: #dc3545;
      transition: all 0.2s;
    }

    .logout-btn:hover {
      background-color: #ffebee;
      color: #dc3545;
    }

    .welcome-title {
      font-weight: 600;
      margin-bottom: 2rem;
    }

    .nav-link {
      border-radius: 6px;
      padding: 0.5rem 1rem;
      transition: all 0.2s;
      font-size: 0.95rem;
    }

    .nav-link:hover {
      background-color: #f0f7ff;
    }

    .nav-link.active {
      background-color: #3a7bd5;
      color: white !important;
    }

    /* Button styles */
    .btn-approve {
      background-color: #28a745;
      border-color: #28a745;
      color: white;
    }

    .btn-approve:hover {
      background-color: #218838;
      border-color: #1e7e34;
      color: white;
    }

    .btn-reject {
      background-color: #dc3545;
      border-color: #dc3545;
      color: white;
    }

    .btn-reject:hover {
      background-color: #c82333;
      border-color: #bd2130;
      color: white;
    }

    /* Added badge styles for notifications */
    .badge-notification {
      position: absolute;
      top: -5px;
      right: -5px;
      padding: 0.25rem 0.5rem;
      border-radius: 50%;
      font-size: 0.7rem;
    }

    .table-responsive {
      border-radius: 12px;
      overflow: hidden;
    }

    .action-btn {
      width: 32px;
      height: 32px;
      border-radius: 50%;
      display: inline-flex;
      align-items: center;
      justify-content: center;
      margin: 0 3px;
    }



  </style>
</head>

<body>
<!-- NAVBAR -->
<jsp:include page="/WEB-INF/navbarAdmin.jsp" />

<!-- MAIN CONTENT -->
<div class="container py-5">
  <h2 class="text-center welcome-title">
    Espace d'administration <span class="text-blue"><%= appName %></span>
  </h2>

  <!-- Stats Overview -->
  <div class="row mb-4">
    <div class="col-md-3">
      <div class="admin-dashboard-card bg-white text-center">
        <div class="stats-label">Utilisateurs</div>
        <div class="stats-value text-primary"><%= usersCount %></div>
        <div class="text-muted small">Utilisateurs existants</div>
      </div>
    </div>
    <div class="col-md-3">
      <div class="admin-dashboard-card bg-white text-center">
        <div class="stats-label">Demandes de crédit</div>
        <div class="stats-value text-info"><p style="color: #fd7e14;"><%= creditsCount %></p></div>
        <div class="text-muted small">En attente d'approbation</div>
      </div>
    </div>

    <div class="col-md-3">
      <div class="admin-dashboard-card bg-white text-center">
        <div class="stats-label">Demandes de crédit</div>
        <div class="stats-value text-danger"><%= creditsRefuseCount %></div>
        <div class="text-muted small">Refusées</div>
      </div>
    </div>

    <div class="col-md-3">
      <div class="admin-dashboard-card bg-white text-center">
        <div class="stats-label">Demandes de crédit</div>
        <div class="stats-value text-info"><%= creditsApprouveCount %></div>
        <div class="text-muted small">Approuvées</div>
      </div>
    </div>

  </div>
  <!-- Quick Actions Section -->
  <div class="row mt-4">
    <div class="col-md-6 mb-4">
      <div class="card h-100 border-0 shadow-sm">
        <div class="card-body">
          <h5 class="card-title text-blue">
            <i class="bi bi-file-earmark-text me-2"></i> Rapports
          </h5>
          <p class="card-text text-muted">Générez des rapports sur les activités de la plateforme.</p>
          <div class="mt-3">
            <a href="#" class="btn btn-sm btn-outline-primary me-2">Rapport journalier</a>
            <a href="#" class="btn btn-sm btn-outline-primary">Rapport mensuel</a>
          </div>
        </div>
      </div>
    </div>

    <div class="col-md-6 mb-4">
      <div class="card h-100 border-0 shadow-sm">
        <div class="card-body">
          <h5 class="card-title text-blue">
            <i class="bi bi-gear-fill me-2"></i> Paramètres système
          </h5>
          <p class="card-text text-muted">Configurez les paramètres de l'application et du système.</p>
          <a href="#" class="btn btn-sm btn-outline-primary">Accéder aux paramètres</a>
        </div>
      </div>
    </div>
  </div>
</div>

<!-- FOOTER -->
<footer class="footer-bankati fixed-bottom">
  <div class="container">
    <div class="d-flex justify-content-between align-items-center">
      <div>
        <span class="text-blue fw-medium">
          <i class="bi bi-bank me-1"></i> <%= appName %> Administration <%= java.time.Year.now().getValue() %>
        </span>
        <span class="text-muted small ms-2">— © Tous droits réservés</span>
      </div>
      <div class="text-muted small">
        <i class="bi bi-shield-check me-1"></i> Connexion sécurisée
      </div>
    </div>
  </div>
</footer>

</body>
</html>