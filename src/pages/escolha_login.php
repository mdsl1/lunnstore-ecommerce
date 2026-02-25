<?php
    session_start();
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>LunnStore</title>
    <link rel="shortcut icon" href="../Midias/favicon.png" type="image/x-icon">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="../css/index.css">
    <link rel="stylesheet" href="../css/bootstrap-icons.css">
</head>

<body>

    <main class="container-fluid w-100 py-5 text-center d-flex flex-column justify-content-center" style="height: 100vh;">

        <div class="container w-50 d-flex flex-column justify-content-center align-items-center p-5 rounded-4" style="background-color: #ffffff9d; backdrop-filter: blur(10px);">

            <h1 class="my-5 fw-bolder">Escolher Login</h1>
            
            <p class="mb-3 fs-4">Identificamos que você possui acessos de administrador, como deseja logar?</p>

            <a href="../index.php" class="mt-5 btn btn-primary fs-3 w-50" type="submit">Entrar como Cliente</a>
            
            <a href="../admin/index.php" class="mt-5 btn btn-primary fs-3 w-50 mb-5" type="submit">Entrar como Administrador</a>

        </div>

    </main>

    <div id="bgImg" class="container-fluid position-fixed top-0" style="width: 100vw; height: 100vh; background: url('../Midias/background.jpeg') no-repeat; background-size: cover; z-index: -99; "></div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>