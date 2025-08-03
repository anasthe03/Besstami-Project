<%@ page pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>Login | ${AppName}</title>
    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">

    <c:url value="/assets/css/bootstrap.min.css" var="bootstrapCss" />
    <c:url value="/assets/css/style.css" var="styleCss" />
    <c:url value="/assets/css/bootstrap-icons.css" var="iconsCss" />

    <link rel="stylesheet" href="${bootstrapCss}">
    <link rel="stylesheet" href="${styleCss}">
    <link rel="stylesheet" href="${iconsCss}">

    <style>
        .bg-custom-blue {
            background-color: #c9deff; /* Back to previous blue */
        }
        .text-blue {
            color: #3a7bd5; /* Back to previous blue text color */
        }
        body {
            font-family: 'Poppins', sans-serif;
        }
        /* Fixed positioning and size */
        html, body {
            height: 100%;
            margin: 0;
            padding: 0;
            overflow: hidden;
        }
        .login-container {
            max-width: 450px;
            margin: 0 auto;
            box-shadow: 0 10px 20px rgba(0,0,0,0.1);
            border-radius: 15px;
            position: relative;
        }
        .form-control:focus {
            border-color: #3a7bd5;
            box-shadow: 0 0 0 0.25rem rgba(58, 123, 213, 0.25);
        }
        /* Fix input group alignment */
        .input-group-text {
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 0.375rem 0.75rem;
            font-size: 1rem;
            border-radius: 0.375rem 0 0 0.375rem;
            width: 45px; /* Fixed width for consistency */
        }
        .input-group .bi {
            font-size: 1.2rem;
            line-height: 1;
            margin: 0; /* Remove any default margins */
        }
        .input-group .form-control {
            height: calc(3rem + 2px);
            padding-left: 0.5rem;
        }
        .btn-custom-primary {
            background-color: #3a7bd5;
            color: white;
            border: none;
            transition: all 0.3s ease;
            font-weight: 500;
        }
        .btn-custom-primary:hover {
            background-color: #2d62b5;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(58, 123, 213, 0.4);
        }
        .card-img-top {
            max-height: 90px;
            object-fit: contain;
            margin: 0 auto;
        }
    </style>
</head>
<body class="bg-custom-blue d-flex align-items-center justify-content-center vh-100 overflow-hidden">

<div class="container">
    <div class="login-container bg-white p-4 p-md-5">

        <!-- Logo and App Name -->
        <div class="text-center mb-4">
            <img src="${ctx}/assets/img/bastami.png" class="card-img-top" alt="Login Logo">
            <h1 class="text-blue fw-bold h2 mt-3" style="font-weight: 600;">${AppName}</h1>
        </div>

        <!-- Login Form -->
        <form action="login" method="post" autocomplete="off">

            <!-- Username field -->
            <div class="mb-4">
                <div class="input-group">
            <span class="input-group-text bg-white border-end-0 text-primary text-center">
              <i class="bi bi-person-fill"></i>
            </span>
                    <input
                            type="text"
                            class="form-control border-start-0"
                            name="lg"
                            id="username"
                            placeholder="Nom d'utilisateur"
                            aria-label="Username"
                            autocomplete="off"
                    >
                </div>
                <div class="form-text text-danger small fst-italic mt-1">
                    ${empty usernameError ? "" : usernameError}
                </div>
            </div>

            <!-- Password field -->
            <div class="mb-4">
                <div class="input-group">
            <span class="input-group-text bg-white border-end-0 text-primary text-center">
              <i class="bi bi-lock-fill"></i>
            </span>
                    <input
                            type="password"
                            class="form-control border-start-0"
                            name="pss"
                            id="password"
                            placeholder="Mot de passe"
                            aria-label="Password"
                            autocomplete="off"
                    >
                </div>
                <div class="form-text text-danger small fst-italic mt-1">
                    ${empty passwordError ? "" : passwordError}
                </div>
            </div>

            <!-- Remember me checkbox removed -->

            <!-- Global message/error -->
            <c:if test="${not empty globalMessage}">
                <div class="alert alert-danger py-2 mb-4 text-center">
                    <i class="bi bi-exclamation-triangle-fill me-2"></i>${globalMessage}
                </div>
            </c:if>

            <!-- Submit button -->
            <div class="text-center mb-3">
                <button type="submit" class="btn btn-custom-primary py-2 fw-bold px-5">
                    Se Connecter
                </button>
            </div>

            <!-- Optional: Forgot password link -->
            <div class="text-center mt-3">
                <a href="#" class="text-decoration-none text-secondary small">
                    Mot de passe oublié?
                </a>
            </div>
        </form>

    </div>

    <!-- Optional: Footer -->
    <div class="text-center text-muted small mt-4">
        &copy; ${java.time.Year.now().getValue()} ${AppName} - Tous droits réservés
    </div>
</div>
</body>
</html>