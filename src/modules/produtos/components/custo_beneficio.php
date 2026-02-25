<?php 
    require_once __DIR__ . "/../../../config.php";
    require_once ROOT_PATH . "modules/produtos/components/card_produto.php";
    $menor_preco = select($conn, "vw_produtos_vitrine", "ORDER BY preco DESC LIMIT 6");
?>

<div class="swiper w-100">

    <div class="swiper-wrapper w-100 mb-5">
        <?php foreach($menor_preco as $p) {

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

    <div class="swiper-pagination"></div>
    <div class="swiper-button-prev"></div>
    <div class="swiper-button-next"></div>

</div>