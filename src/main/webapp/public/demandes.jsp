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
    <title>Mes Demandes</title>

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

        /* Styles navbar retirés */

        .footer-bankati {
            background-color: white;
            box-shadow: 0 -2px 10px rgba(0,0,0,0.05);
            padding: 0.8rem 0;
        }

        /* Credit form modal */
        .modal-credit-form {
            max-width: 650px;
        }

        .modal-credit-form .modal-content {
            border-radius: 15px;
            border: none;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.15);
        }

        .modal-credit-form .modal-header {
            background-color: #3a7bd5;
            color: white;
            border-radius: 15px 15px 0 0;
            border-bottom: none;
            padding: 16px 20px;
        }

        .modal-credit-form .modal-title {
            font-weight: 600;
            font-size: 1.2rem;
            display: flex;
            align-items: center;
        }

        .modal-credit-form .modal-title i {
            margin-right: 10px;
            font-size: 1.3rem;
        }

        .modal-credit-form .modal-body {
            padding: 25px;
        }

        .modal-credit-form .modal-footer {
            border-top: none;
            padding: 15px 25px 25px;
        }

        /* Credits table styles */
        .credits-container {
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 8px 16px rgba(0,0,0,0.1);
        }

        .table-credits th {
            background-color: #3a7bd5;
            color: white;
            font-weight: 500;
            border: none;
            padding: 12px;
            vertical-align: middle;
        }

        .table-credits td {
            padding: 12px;
            vertical-align: middle;
        }

        .table-credits tr:nth-child(even) {
            background-color: #f8f9fa;
        }

        .table-credits tr:hover {
            background-color: #f0f7ff;
        }

        .btn-delete {
            color: #dc3545;
            border-color: #dc3545;
        }

        .btn-delete:hover {
            background-color: #dc3545;
            color: white;
        }

        /* Credit form styles */
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

        /* Bouton nouvelle demande en vert */
        .btn-new-credit {
            background-color: #28a745;
            color: white;
            border-radius: 8px;
            padding: 10px 16px;
            font-weight: 500;
            transition: all 0.2s;
            display: inline-flex;
            align-items: center;
        }

        .btn-new-credit i {
            margin-right: 8px;
            font-size: 1rem;
        }

        .btn-new-credit:hover {
            background-color: #218838;
            box-shadow: 0 4px 8px rgba(40, 167, 69, 0.2);
            transform: translateY(-2px);
            color: white;
        }

        /* Titre de la page */
        .page-title {
            font-weight: 600;
            color: #3a7bd5;
            margin-bottom: 0; /* Retiré le margin-bottom pour l'alignement */
        }

        /* Scroll table */
        .table-responsive {
            max-height: 420px;
            overflow-y: auto;
        }

        .navbar-brand {
            color: #3a7bd5;
            font-weight: 700; /* Make the brand name bolder */
        }

        /* Couleurs des badges d'état */
        .badge-en-attente {
            background-color: #fd7e14; /* Orange pour les demandes en attente */
            color: white;
        }

        .badge-approuve {
            background-color: #28a745; /* Vert pour les demandes approuvées */
            color: white;
        }

        .badge-rejete {
            background-color: #dc3545; /* Rouge pour les demandes rejetées */
            color: white;
        }

        /* Ajout d'un style pour la ligne d'en-tête avec flexbox */
        .table-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
<!-- ✅ Inclusion de la navbar -->
<jsp:include page="/WEB-INF/navbar.jsp" />
<!-- MAIN CONTENT -->
<div class="container py-4">
    <!-- Titre et bouton nouvelle demande -->
    <div class="table-header mb-3">
        <h2 class="page-title">
            <i class="bi bi-file-earmark-text me-1"></i>&nbsp;Mes demandes de crédit
        </h2>
        <button type="button" class="btn btn-new-credit" data-bs-toggle="modal" data-bs-target="#newCreditModal">
            <i class="bi bi-plus-circle"></i>&nbsp;Nouvelle demande
        </button>
    </div>

    <!-- Credits Table -->
    <div class="card credits-container bg-white animate-fade-in">
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover table-borderless table-credits mb-0">
                    <thead>
                    <tr>
                        <th>Montant</th>
                        <th>Motif</th>
                        <th>État</th>
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
                                    <i class="bi bi-info-circle me-2"></i> Vous n'avez pas encore de demandes de crédit.
                                </td>
                            </tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach items="${credits}" var="credit">
                                <tr>
                                    <td class="montant-display">${credit.montant} DH</td>
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
                                                <span class="badge badge-rejete rounded-pill">REJETÉE</span>
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
                                            <a href="${pageContext.request.contextPath}/demandes/delete?id=${credit.id}" class="btn btn-sm btn-delete"
                                               onclick="return confirm('Êtes-vous sûr de vouloir supprimer cette demande de crédit?')">
                                                <i class="bi bi-trash-fill"></i>
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

<!-- Modal pour nouvelle demande de crédit -->
<div class="modal fade" id="newCreditModal" tabindex="-1" aria-labelledby="newCreditModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-credit-form">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="newCreditModalLabel">
                    <i class="bi bi-credit-card"></i> Nouvelle demande de crédit
                </h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form action="${pageContext.request.contextPath}/demandes/save" method="post">
                <div class="modal-body">
                    <div class="row mb-3">
                        <div class="col-md-6">
                            <label for="montant" class="form-label">Montant (DH)</label>
                            <div class="input-group">
                                <span class="input-group-text">
                                    <i class="bi bi-cash input-icon"></i>
                                </span>
                                <input type="number" class="form-control" id="montant" name="montant" required min="1000" placeholder="Ex: 5000">
                            </div>
                        </div>
                        <div class="col-md-6">
                            <label for="motif" class="form-label">Motif</label>
                            <div class="input-group">
                                <span class="input-group-text">
                                    <i class="bi bi-tag input-icon"></i>
                                </span>
                                <select class="form-select" id="motif" name="motif" required>
                                    <option value="" selected disabled>Sélectionner un motif</option>
                                    <option value="IMMOBILIER">Crédit Immobilier</option>
                                    <option value="CONSOMMATION">Crédit Consommation</option>
                                    <option value="AUTOMOBILE">Crédit Automobile</option>
                                    <option value="ETUDES">Financement Études</option>
                                    <option value="PERSONNEL">Prêt Personnel</option>
                                    <option value="AUTRE">Autre</option>
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="mb-3">
                        <label for="description" class="form-label">Description de votre projet</label>
                        <div class="input-group">
                            <span class="input-group-text">
                                <i class="bi bi-chat-left-text input-icon"></i>
                            </span>
                            <textarea class="form-control" id="description" name="description" rows="4" placeholder="Décrivez votre projet et l'usage prévu pour ce crédit..."></textarea>
                        </div>
                    </div>

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-light" data-bs-dismiss="modal">Annuler</button>
                    <button type="submit" class="btn btn-save">
                        <i class="bi bi-send me-1"></i> Soumettre ma demande
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- FOOTER -->
<footer class="footer-bankati fixed-bottom">
    <div class="container">
        <div class="d-flex justify-content-between align-items-center">
            <div>
          <span class="text-blue fw-medium">
              <i class="bi bi-bank me-1"></i> <%= appName %> <%= java.time.Year.now().getValue() %>
          </span>
                <span class="text-muted small ms-2">— © Tous droits réservés</span>
            </div>
            <div class="text-muted small">
                <i class="bi bi-shield-check me-1"></i> Connexion sécurisée
            </div>
        </div>
    </div>
</footer>

<!-- Script pour afficher le toast de confirmation si nécessaire -->
<c:if test="${param.success == 'true'}">
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            var creditToast = new bootstrap.Toast(document.getElementById('creditToast'));
            creditToast.show();
        });
    </script>
</c:if>
</body>
</html>