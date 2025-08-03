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
    <title> Gestion des Credits </title>

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

        /* Stylish Action Buttons */
        .action-btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            width: 35px;
            height: 35px;
            border-radius: 8px;
            border: 2px solid;
            transition: all 0.3s ease;
            text-decoration: none;
            margin: 0 3px;
            background: white;
        }

        .action-btn:hover {
            transform: translateY(-1px);
            box-shadow: 0 4px 8px rgba(0,0,0,0.15);
        }

        .btn-approve {
            border-color: #28a745;
            color: #28a745;
        }

        .btn-approve:hover {
            background-color: #28a745;
            color: white;
        }

        .btn-reject {
            border-color: #dc3545;
            color: #dc3545;
        }

        .btn-reject:hover {
            background-color: #dc3545;
            color: white;
        }

        .action-btn i {
            font-size: 16px;
        }

        .btn-new-user i {
            margin-right: 4px;
            font-size: 1rem;
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

        /* Couleurs des badges d'état */
        .badge-en-attente {
            background-color: #fd7e14 !important; /* Orange pour les demandes en attente */
            color: white;
        }

        .badge-approuve {
            background-color: #28a745 !important; /* Vert pour les demandes approuvées */
            color: white;
        }

        .badge-rejete {
            background-color: #dc3545 !important; /* Rouge pour les demandes rejetées */
            color: white;
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
            <i class="bi bi-clipboard-check me-1"></i>&nbsp;Gestion des demandes
        </h2>
    </div>

    <!-- Users Table -->
    <div class="card users-container bg-white animate-fade-in">
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover table-borderless table-users mb-0">
                    <thead>
                    <tr>
                        <th>ID Client</th>
                        <th>Montant</th>
                        <th>Motif</th>
                        <th>Etat</th>
                        <th>Date de demande</th>
                        <th>Date de traitement</th>
                        <th class="text-center">Actions</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:choose>
                        <c:when test="${empty credits}">
                            <tr>
                                <td colspan="7" class="no-credits-message">
                                    <i class="bi bi-info-circle me-2"></i> Vous n'avez pas encore de demandes a traité.
                                </td>
                            </tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach items="${credits}" var="credit">
                                <tr>
                                    <td class="fw-medium">${credit.clientId}</td>
                                    <td>${credit.montant} DH</td>
                                    <td><span class="badge bg-light text-dark px-3 py-2">${credit.motif}</span></td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${credit.statut == 'EN_ATTENTE'}">
                                                <span class="badge badge-en-attente rounded-pill">EN ATTENTE</span>
                                            </c:when>
                                            <c:when test="${credit.statut == 'APPROUVE'}">
                                                <span class="badge badge-approuve rounded-pill">APPROUVÉE</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge badge-rejete rounded-pill">REFUSÉE</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>${credit.dateDemande}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${credit.dateTraitement == null}">
                                                <span>---</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span>${credit.dateTraitement}</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="text-center">
                                        <c:if test="${credit.statut == 'EN_ATTENTE'}">
                                        <a href="${pageContext.request.contextPath}/credits/approuver?id=${credit.id}" class="action-btn btn-approve">
                                            <i class="bi bi-check-circle-fill"></i>
                                        </a>
                                        <a href="${pageContext.request.contextPath}/credits/refuser?id=${credit.id}" class="action-btn btn-reject"
                                           onclick="return confirm('Êtes-vous sûr de vouloir refuser cet demande?')">
                                            <i class="bi bi-x-circle-fill"></i>
                                        </a>
                                        </c:if>
                                        <c:if test="${credit.statut != 'EN_ATTENTE'}">
                                           <span class="text-muted fst-italic">
                                                <i class="bi bi-check-circle me-1"></i>&nbsp;Traitée
                                            </span>
                                        </c:if>

                                    </td>
                                </tr>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                    </tbody>
                </table>
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

<!-- Edit Credit Modal Script -->
<c:if test="${not empty credit}">
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Automatically show modal if edit user is requested
            var creditFormModal = new bootstrap.Modal(document.getElementById('creditFormModal'));
            creditFormModal.show();
        });
    </script>
</c:if>
</body>
</html>