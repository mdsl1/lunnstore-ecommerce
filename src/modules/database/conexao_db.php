<?php
    $host = "lunnstore-db";
    $port = 3306;
    $db_name = "lunnstore_db";
    $user = "root";
    $senha = "SQL@142536.";

    try {
        $conn = new PDO("mysql:host=$host;dbname=$db_name;port=$port;charset=utf8", $user, $senha);
        $conn -> setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
        // echo "Conexão bem sucedida.";
    } catch(PDOException $e) {
        die("Erro de conexão: " . $e ->getMessage());
    }
?>