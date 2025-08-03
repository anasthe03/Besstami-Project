<%@ page contentType="text/html;charset=UTF-8" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
  var ctx = request.getContextPath();
  var connectedUser = (ma.bankati.model.users.User) session.getAttribute("connectedUser");
  var appName = (String) application.getAttribute("AppName");
  String userInitial = connectedUser.getLastName().substring(0, 1).toUpperCase();
%>

<!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Gestion des Utilisateurs</title>

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


    .footer-bankati {
      background-color: white;
      box-shadow: 0 -2px 10px rgba(0,0,0,0.05);
      padding: 0.8rem 0;
    }

    /* User form modal */
    .modal-user-form {
      max-width: 650px;
    }

    .modal-user-form .modal-content {
      border-radius: 15px;
      border: none;
      box-shadow: 0 10px 30px rgba(0, 0, 0, 0.15);
    }

    .modal-user-form .modal-header {
      background-color: #3a7bd5;
      color: white;
      border-radius: 15px 15px 0 0;
      border-bottom: none;
      padding: 16px 20px;
    }

    .modal-user-form .modal-title {
      font-weight: 600;
      font-size: 1.2rem;
      display: flex;
      align-items: center;
    }

    .modal-user-form .modal-title i {
      margin-right: 10px;
      font-size: 1.3rem;
    }

    .modal-user-form .modal-body {
      padding: 25px;
    }

    .modal-user-form .modal-footer {
      border-top: none;
      padding: 15px 25px 25px;
    }


    /* Users table styles */
    .users-container {
      border-radius: 15px;
      overflow: hidden;
      box-shadow: 0 8px 16px rgba(0,0,0,0.1);
    }

    .table-users th {
      background-color: #3a7bd5;
      color: white;
      font-weight: 500;
      border: none;
      padding: 12px;
      vertical-align: middle;
    }

    .table-users td {
      padding: 12px;
      vertical-align: middle;
    }

    .table-users tr:nth-child(even) {
      background-color: #f8f9fa;
    }

    .table-users tr:hover {
      background-color: #f0f7ff;
    }


    .btn-edit {
      color: #ffc107;
      border-color: #ffc107;
    }

    .btn-edit:hover {
      background-color: #ffc107;
      color: white;
    }

    .btn-delete {
      color: #dc3545;
      border-color: #dc3545;
    }

    .btn-delete:hover {
      background-color: #dc3545;
      color: white;
    }

    /* User form styles */
    .input-icon {
      color: #3a7bd5;
      opacity: 0.8;
    }

    .form-control, .form-select {
      border-radius: 8px;
      padding: 10px 15px;
      border: 1px solid #e0e9ff;
      transition: all 0.2s;
    }

    .form-control:focus, .form-select:focus {
      border-color: #3a7bd5;
      box-shadow: 0 0 0 0.2rem rgba(58, 123, 213, 0.25);
    }

    .input-group-text {
      border-radius: 8px 0 0 8px;
      border: 1px solid #e0e9ff;
      border-right: none;
    }

    .btn-save {
      background-color: #28a745;
      color: white;
      border-radius: 8px;
      padding: 8px 22px;
      font-weight: 500;
      transition: all 0.2s;
    }

    .btn-save:hover {
      background-color: #218838;
      box-shadow: 0 4px 8px rgba(40, 167, 69, 0.2);
      transform: translateY(-2px);
    }

    /* Modifier: Bouton nouveau utilisateur en vert */
    .btn-new-user {
      background-color: #28a745;
      color: white;
      border-radius: 8px;
      padding: 10px 6px 10px 10px;
      font-weight: 500;
      transition: all 0.2s;
      display: inline-flex;
      align-items: center;
    }

    .btn-new-user i {
      margin-right: 4px;
      font-size: 1rem;
    }

    .btn-new-user:hover {
      background-color: #218838;
      box-shadow: 0 4px 8px rgba(40, 167, 69, 0.2);
      transform: translateY(-2px);
    }

    /* Modifier: Réduction de la taille du titre */
    .page-title {
      font-weight: 600;
      color: #3a7bd5;
      margin-bottom: 0;
      font-size: 1.5rem;
      display: flex;
      align-items: center;
    }

    /* Animation */
    @keyframes fadeIn {
      from { opacity: 0; transform: translateY(10px); }
      to { opacity: 1; transform: translateY(0); }
    }

    .animate-fade-in {
      animation: fadeIn 0.3s ease-out forwards;
    }

    /* Nouveau style pour l'en-tête de la table */
    .table-header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      padding: 0.5rem 0;
    }
  </style>
</head>
<body>
<!-- NAVBAR -->
<jsp:include page="/WEB-INF/navbarAdmin.jsp" />


<!-- MAIN CONTENT -->
<div class="container py-4">
  <!-- Modifier: Titre et bouton sur la même ligne -->
  <div class="table-header mb-3">
    <h2 class="page-title">
      <i class="bi bi-people-fill me-2"></i>&nbsp;Gestion des utilisateurs
    </h2>
    <button type="button" class="btn btn-new-user" data-bs-toggle="modal" data-bs-target="#userFormModal">
      <i class="bi bi-plus-circle"></i>&nbsp;Nouvel utilisateur&nbsp;
    </button>
  </div>

  <!-- Users Table -->
  <div class="card users-container bg-white animate-fade-in">
    <div class="card-body p-0">
      <div class="table-responsive">
        <table class="table table-hover table-borderless table-users mb-0">
          <thead>
          <tr>
            <th>ID</th>
            <th>Nom</th>
            <th>Prénom</th>
            <th>Nom d'utilisateur</th>
            <th>Rôle</th>
            <th class="text-center">Actions</th>
          </tr>
          </thead>
          <tbody>
          <c:forEach items="${users}" var="user">
            <tr>
              <td>${user.id}</td>
              <td class="fw-medium">${user.firstName}</td>
              <td>${user.lastName}</td>
              <td><span class="badge bg-light text-dark px-3 py-2">${user.username}</span></td>
              <td>
                <c:choose>
                  <c:when test="${user.role == 'ADMIN'}">
                    <span class="badge bg-danger rounded-pill">ADMIN</span>
                  </c:when>
                  <c:otherwise>
                    <span class="badge bg-info rounded-pill">USER</span>
                  </c:otherwise>
                </c:choose>
              </td>
              <td class="text-center">
                <a href="${pageContext.request.contextPath}/users/edit?id=${user.id}" class="btn btn-sm btn-edit me-2">
                  <i class="bi bi-pencil-fill"></i>
                </a>
                <a href="${pageContext.request.contextPath}/users/delete?id=${user.id}" class="btn btn-sm btn-delete"
                   onclick="return confirm('Êtes-vous sûr de vouloir supprimer cet utilisateur?')">
                  <i class="bi bi-trash-fill"></i>
                </a>
              </td>
            </tr>
          </c:forEach>
          </tbody>
        </table>
      </div>
    </div>
  </div>
</div>

<!-- User Form Modal -->
<div class="modal fade" id="userFormModal" tabindex="-1" aria-labelledby="userFormModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered modal-user-form">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="userFormModalLabel">
          <c:choose>
            <c:when test="${not empty user}">
              <i class="bi bi-person-gear"></i> Modifier l'utilisateur
            </c:when>
            <c:otherwise>
              <i class="bi bi-person-plus"></i> Ajouter un nouvel utilisateur
            </c:otherwise>
          </c:choose>
        </h5>
        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>

      <div class="modal-body">
        <form action="${pageContext.request.contextPath}/users/save" method="post" id="userForm">
          <input type="hidden" name="id" value="${user.id}"/>

          <div class="row">
            <!-- First Name -->
            <div class="col-md-6 mb-3">
              <label class="form-label text-muted mb-1">Prénom</label>
              <div class="input-group">
                  <span class="input-group-text bg-white">
                    <i class="bi bi-person-badge input-icon"></i>
                  </span>
                <input type="text" class="form-control" name="firstName" placeholder="Prénom" value="${user.firstName}" required/>
              </div>
            </div>

            <!-- Last Name -->
            <div class="col-md-6 mb-3">
              <label class="form-label text-muted mb-1">Nom</label>
              <div class="input-group">
                  <span class="input-group-text bg-white">
                    <i class="bi bi-person input-icon"></i>
                  </span>
                <input type="text" class="form-control" name="lastName" placeholder="Nom" value="${user.lastName}" required/>
              </div>
            </div>
          </div>

          <div class="row">
            <!-- Username -->
            <div class="col-md-6 mb-3">
              <label class="form-label text-muted mb-1">Nom d'utilisateur</label>
              <div class="input-group">
                  <span class="input-group-text bg-white">
                    <i class="bi bi-person-circle input-icon"></i>
                  </span>
                <input type="text" class="form-control" name="username" placeholder="Nom d'utilisateur" value="${user.username}" required/>
              </div>
            </div>

            <!-- Password -->
            <div class="col-md-6 mb-3">
              <label class="form-label text-muted mb-1">Mot de passe</label>
              <div class="input-group">
                  <span class="input-group-text bg-white">
                    <i class="bi bi-lock-fill input-icon"></i>
                  </span>
                <input type="password" class="form-control" name="password" placeholder="Mot de passe" value="${user.password}" required/>
              </div>
            </div>
          </div>

          <!-- Role -->
          <div class="mb-4">
            <label class="form-label text-muted mb-1">Rôle</label>
            <div class="input-group">
                <span class="input-group-text bg-white">
                  <i class="bi bi-shield-lock input-icon"></i>
                </span>
              <select name="role" class="form-select">
                <option value="ADMIN" ${user.role == 'ADMIN' ? 'selected' : ''}>ADMIN</option>
                <option value="USER"  ${user.role == 'USER'  ? 'selected' : ''}>USER</option>
              </select>
            </div>
          </div>
        </form>
      </div>

      <div class="modal-footer">
        <button type="button" class="btn btn-light" data-bs-dismiss="modal">Annuler</button>
        <button type="submit" form="userForm" class="btn btn-save">
          <i class="bi bi-save"></i> Enregistrer
        </button>
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

<!-- Edit User Modal Script -->
<c:if test="${not empty user}">
  <script>
    document.addEventListener('DOMContentLoaded', function() {
      // Automatically show modal if edit user is requested
      var userFormModal = new bootstrap.Modal(document.getElementById('userFormModal'));
      userFormModal.show();
    });
  </script>
</c:if>
</body>
</html>