<?php 
    session_start();
    require_once __DIR__ . "/../config.php";
    require_once ROOT_PATH . "modules/database/conexao_db.php";
    require_once ROOT_PATH . "modules/database/crud.php";
    require_once ROOT_PATH . "modules/produtos/components/card_produto.php";

    $sql = "SELECT * FROM vw_produtos_vitrine ORDER BY id";
    $stmt = $conn->prepare($sql);
    $stmt->execute();
    $produtos = $stmt->fetchAll();
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
    <style>
        .card {
            width: 22rem;
        }
    </style>
</head>

<body>

    <?php require_once ROOT_PATH . "modules/base/header.php"; ?>

    <main class="container w-100 my-5 mx-auto py-5 text-center">

        <h2 class="fs-1 my-5 text-title fw-bold">Todos os Nossos Produtos</h2>
        <div class="container my-5 w-100 d-flex flex-wrap align-items-center justify-content-center gap-5">    

            <?php foreach($produtos as $p) {
                card(
                    id: $p["id"], 
                    img: $p["url_imagem_capa"], 
                    nome: $p["nome"], 
                    descricao: $p["descricao"],
                    preco: $p["preco"],
                    desconto: $p["percentual_desconto"],
                    preco_final: $p["preco_final"],
                    categoria: $p["categoria"],
                    subcategoria: $p["subcategoria"]
                );
            } ?>

        </div>
    </main>

    <?php require_once ROOT_PATH . "modules/base/footer.php"; ?>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>