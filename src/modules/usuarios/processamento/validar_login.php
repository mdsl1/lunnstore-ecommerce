<?php
    session_start();
    require_once __DIR__ . "/../../../config.php";
    require_once ROOT_PATH . "modules/database/conexao_db.php";
    require_once ROOT_PATH . "modules/database/crud.php";

    $email = htmlspecialchars($_POST["email"]);
    $senha = hash("sha256", htmlspecialchars($_POST["senha"]));

    $usuario = select($conn, "vw_usuario_basico", "WHERE email = ? AND senha = ?", [$email, $senha]);
    
    if(isset($usuario[0]["first_nome"])) {
        
        $_SESSION["id_cli"] = $usuario[0]["id"];
        $is_adm = $usuario[0]["is_adm"];
        $_SESSION["is_adm"] = $is_adm;
        
        if(!$is_adm) {
            header("Location: ". BASE_URL ." index.php");
        }
        else {
            header("Location: ". BASE_URL . "pages/escolha_login.php");
        }

        if(isset($_SESSION["erro_login"]) && $_SESSION["erro_login"]) {
            unset($_SESSION["erro_login"]);
        }
    } else {
        $_SESSION["erro_login"] = true;
        header("Location: " . BASE_URL . "pages/login.php");
    }
?>