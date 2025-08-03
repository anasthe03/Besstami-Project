<%@page import="ma.bankati.model.users.User"%>
<%
    var ctx = request.getContextPath();
    var connectedUser = (User) session.getAttribute("connectedUser");
    String userInitial = connectedUser.getLastName().substring(0, 1).toUpperCase();
    String uri = request.getRequestURI();

%>

<link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/navbar.css">
<nav class="navbar navbar-expand-lg navbar-light bg-white navbar-bankati py-3">
    <div class="container">
        <a class="navbar-brand d-flex align-items-center" href="<%= ctx %>/home">
            <img src="<%= ctx %>/assets/img/bastami.png" alt="Logo" width="40" height="40" class="d-inline-block align-text-top me-2">
            &nbsp;
            <span class="text-blue fw-bold"><%= application.getAttribute("AppName") %></span>
        </a>

        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarContent"
                aria-controls="navbarContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse justify-content-end" id="navbarContent">
                <ul class="navbar-nav me-3">

                    <li class="nav-item mx-1">
                        <a class="nav-link <%= uri.endsWith("/home") ? "active" : "text-primary" %>" href="<%= ctx %>/home">
                            <i class="bi bi-house-door me-1"></i> Accueil
                        </a>
                    </li>

                    <li class="nav-item mx-1">
                        <a class="nav-link <%= uri.endsWith("/demandes") ? "active" : "text-primary" %>" href="<%= ctx %>/demandes">
                            <i class="bi bi-file-earmark-text me-1"></i> Mes demandes
                        </a>
                    </li>
                </ul>

            <div class="dropdown">
                <div class="user-profile" role="button" id="userProfileDropdown" data-bs-toggle="dropdown" aria-expanded="false">
                    <div class="user-avatar"><%= userInitial %></div>
                    <div class="user-info">
                        <div class="user-name"><%= connectedUser.getLastName() %></div>
                        <div class="user-role"><%= connectedUser.getRole() %></div>
                    </div>
                    &nbsp;&nbsp;
                    <i class="bi bi-chevron-down text-muted ms-3"></i>
                </div>

                <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="userProfileDropdown">
                    <li><a class="dropdown-item" href="#"><i class="bi bi-person me-2"></i> Mon profil</a></li>
                    <li><a class="dropdown-item" href="#"><i class="bi bi-gear me-2"></i> Parametres</a></li>
                    <li><hr class="dropdown-divider"></li>
                    <li><a class="dropdown-item logout-btn" href="<%= ctx %>/logout"><i class="bi bi-box-arrow-right me-2"></i> Se deconnecter</a></li>
                </ul>
            </div>
        </div>
    </div>
</nav>
