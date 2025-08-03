<%@page import="ma.bankati.model.data.MoneyData" pageEncoding="UTF-8" %>
<%@page import="ma.bankati.model.users.User" %>
<%@ page import="ma.bankati.model.compte.Compte" %>
<%
    var ctx = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title> Accueil</title>

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

        .balance-card {
            border-radius: 15px;
            box-shadow: 0 10px 20px rgba(0,0,0,0.08);
            transition: all 0.3s ease;
            padding: 2rem;
            max-width: 550px;
            margin: 0 auto;
        }

        .balance-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 30px rgba(0,0,0,0.12);
        }

        .balance-amount {
            font-size: 2.5rem;
            font-weight: 600;
        }

        .balance-label {
            font-weight: 500;
            color: #3a7bd5;
            margin-bottom: 1.5rem;
        }

        .footer-bankati {
            background-color: white;
            box-shadow: 0 -2px 10px rgba(0,0,0,0.05);
            padding: 0.8rem 0;
        }


        .welcome-title {
            font-weight: 600;
            margin-bottom: 2rem;
        }



        /* Button color styles */
        .btn-deposit {
            background-color: #28a745;
            border-color: #28a745;
            color: white;
        }

        .btn-deposit:hover {
            background-color: #218838;
            border-color: #1e7e34;
            color: white;
        }

        .btn-withdraw {
            background-color: #dc3545;
            border-color: #dc3545;
            color: white;
        }

        .btn-withdraw:hover {
            background-color: #c82333;
            border-color: #bd2130;
            color: white;
        }

        /* Modal enhancements */
        .modal-content {
            border-radius: 15px;
            border: none;
            box-shadow: 0 20px 40px rgba(0,0,0,0.15);
        }

        .modal-header {
            border-bottom: 2px solid #f8f9fa;
            padding: 1.5rem;
        }

        .modal-body {
            padding: 2rem;
        }

        .form-control, .form-select {
            border-radius: 10px;
            padding: 12px 15px;
            border: 2px solid #e9ecef;
            transition: all 0.3s ease;
        }

        .form-control:focus, .form-select:focus {
            border-color: #3a7bd5;
            box-shadow: 0 0 0 0.2rem rgba(58, 123, 213, 0.25);
        }

        .quick-amounts {
            display: flex;
            gap: 8px;
            flex-wrap: wrap;
            margin-top: 10px;
        }

        .quick-amount-btn {
            padding: 6px 12px;
            border: 1px solid #3a7bd5;
            background: transparent;
            color: #3a7bd5;
            border-radius: 6px;
            font-size: 0.85rem;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .quick-amount-btn:hover {
            background: #3a7bd5;
            color: white;
        }
    </style>
</head>
<%
    var result  =  request.getAttribute("result");
    var connectedUser = (User) session.getAttribute("connectedUser");
    var appName = (String) application.getAttribute("AppName");
    String userInitial = connectedUser.getLastName().substring(0, 1).toUpperCase();
%>
<body>

<!-- ✅ Inclusion de la navbar -->
<jsp:include page="/WEB-INF/navbar.jsp" />


<!-- MAIN CONTENT -->
<div class="container py-5">
    <h2 class="text-center welcome-title">
        Bienvenue sur votre espace <span class="text-blue"><%= appName %></span>
    </h2>

    <div class="balance-card bg-white">
        <div class="text-center">
            <h5 class="balance-label">
                <i class="bi bi-wallet2 me-2"></i>&nbsp;Solde de votre compte
            </h5>
            <div class="balance-amount text-success mb-3">
                <%= result %> <small>DH</small>
            </div>

            <div class="row mt-4">
                <div class="col-md-6 mb-3">
                    <button class="btn btn-deposit w-100" data-bs-toggle="modal" data-bs-target="#depositModal">
                        <i class="bi bi-arrow-down-circle me-2"></i>&nbsp;Déposer
                    </button>
                </div>
                <div class="col-md-6 mb-3">
                    <button class="btn btn-withdraw w-100" data-bs-toggle="modal" data-bs-target="#withdrawModal">
                        <i class="bi bi-arrow-up-circle me-2"></i>&nbsp;Retirer
                    </button>
                </div>
            </div>
        </div>
    </div>

    <div class="row mt-5">
        <div class="col-md-6 mb-4">
            <div class="card h-100 border-0 shadow-sm">
                <div class="card-body">
                    <h5 class="card-title text-blue">
                        <i class="bi bi-clock-history me-2"></i>&nbsp;Dernières transactions
                    </h5>
                    <p class="card-text text-muted">Consultez l'historique de vos dernières opérations.</p>
                    <a href="#" class="btn btn-sm btn-outline-primary">Voir tout</a>
                </div>
            </div>
        </div>

        <div class="col-md-6 mb-4">
            <div class="card h-100 border-0 shadow-sm">
                <div class="card-body">
                    <h5 class="card-title text-blue">
                        <i class="bi bi-person-lines-fill me-2"></i>&nbsp;Mon compte
                    </h5>
                    <p class="card-text text-muted">Gérez vos informations personnelles et vos préférences.</p>
                    <a href="#" class="btn btn-sm btn-outline-primary">Gérer</a>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- MODAL DÉPOSER -->
<div class="modal fade" id="depositModal" tabindex="-1" aria-labelledby="depositModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title text-success fw-bold" id="depositModalLabel">
                    <i class="bi bi-arrow-down-circle me-2"></i>&nbsp;Effectuer un dépôt
                </h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form action="<%= ctx %>/home/deposer?id=<%=connectedUser.getId()%>" method="post">

                    <div class="mb-3">
                        <label for="depositAmount" class="form-label fw-medium">Montant à déposer</label>
                        <div class="input-group">
                            <input type="number" class="form-control" id="depositAmount" name="montant"
                                   placeholder="0.00" min="10" step="0.01" required>
                        </div>
                        <div class="quick-amounts">
                            <button type="button" class="quick-amount-btn" onclick="setAmount('depositAmount', 500)">500 DH</button>
                            <button type="button" class="quick-amount-btn" onclick="setAmount('depositAmount', 1000)">1000 DH</button>
                            <button type="button" class="quick-amount-btn" onclick="setAmount('depositAmount', 2000)">2000 DH</button>
                            <button type="button" class="quick-amount-btn" onclick="setAmount('depositAmount', 5000)">5000 DH</button>
                        </div>
                    </div>

                    <div class="text-center">
                        <button type="submit" class="btn btn-success px-4">
                            Confirmer le dépôt
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- MODAL RETIRER -->
<div class="modal fade" id="withdrawModal" tabindex="-1" aria-labelledby="withdrawModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title text-danger fw-bold" id="withdrawModalLabel">
                    <i class="bi bi-arrow-up-circle me-2"></i>&nbsp;Effectuer un retrait
                </h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="alert alert-info">
                    <i class="bi bi-info-circle me-2"></i>
                    <strong>Solde disponible:</strong> <%= result %> DH
                </div>

                <form action="<%= ctx %>/home/retirer?id=<%=connectedUser.getId()%>" method="post">
                    <div class="mb-3">
                        <label for="withdrawAmount" class="form-label fw-medium">Montant à retirer</label>
                        <div class="input-group">
                            <input type="number" class="form-control" id="withdrawAmount" name="montant"
                                   placeholder="0.00" min="10" step="0.01" required>
                        </div>
                        <div class="quick-amounts">
                            <button type="button" class="quick-amount-btn" onclick="setAmount('withdrawAmount', 200)">200 DH</button>
                            <button type="button" class="quick-amount-btn" onclick="setAmount('withdrawAmount', 500)">500 DH</button>
                            <button type="button" class="quick-amount-btn" onclick="setAmount('withdrawAmount', 1000)">1000 DH</button>
                            <button type="button" class="quick-amount-btn" onclick="setAmount('withdrawAmount', 2000)">2000 DH</button>
                        </div>
                    </div>

                    <div class="text-center">
                        <button type="submit" class="btn btn-danger px-4">
                            Confirmer le retrait
                        </button>
                    </div>
                </form>
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

<script>
    // Fonction pour définir les montants rapides
    function setAmount(inputId, amount) {
        document.getElementById(inputId).value = amount;
    }
</script>

</body>
</html>