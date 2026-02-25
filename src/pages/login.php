<?php 
    session_start();
    require_once __DIR__ . "/../config.php";
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>LunnStore</title>
    <link rel="shortcut icon" href="<?= BASE_URL ?>Midias/favicon.png" type="image/x-icon">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="<?= BASE_URL ?>css/index.css">
    <link rel="stylesheet" href="<?= BASE_URL ?>css/bootstrap-icons.css">
</head>

<body>

    <main class="container-fluid w-100 py-5 text-center d-flex flex-column justify-content-center align-items-center" style="height: 100vh;">

        <div class="container w-50 d-flex flex-column justify-content-center p-5 rounded-4" style="background-color: #ffffff9d; backdrop-filter: blur(10px);">

            <form action="<?= BASE_URL ?>modules/usuarios/processamento/validar_login.php" method="POST" class="container w-75 d-flex flex-column align-items-center fs-4 py-5">
                
                <h1 class="mb-5 fw-bolder">Login</h1>
                
                <label class="mt-4 fs-3 fw-bolder" for="email">E-mail:</label>
                <input class="px-3 py-2 w-100 rounded-3 mt-2" type="email" name="email" id="email" required autocomplete="off">

                <label class="mt-4 fs-3 fw-bolder" for="senha">Senha:</label>
                <input class="px-3 py-2 w-100 rounded-3 mt-2" type="password" name="senha" id="senha" required>

                <button class="mt-5 btn btn-primary fs-3 w-50" type="submit">Entrar</button>

            </form>
            
        </div>

        <?php if(isset($_SESSION["erro_login"]) && $_SESSION["erro_login"]) { ?>
            <div class="alert alert-warning alert-dismissible fade show position-fixed" style="bottom: 5vh;" role="alert">
                E-mail ou senha incorretos. Por segurança, tente novamente.
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        <?php } ?>

    </main>

    <div id="bgImg" class="container-fluid position-fixed top-0" style="width: 100vw; height: 100vh; background: url('../Midias/background.jpeg') no-repeat; background-size: cover; z-index: -99; "></div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>