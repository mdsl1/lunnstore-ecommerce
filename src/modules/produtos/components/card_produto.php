<?php 
    function card( $id, $img, $nome, $descricao, $preco, $desconto, $preco_final, $categoria, $subcategoria ) { 
        $have_desconto = ($desconto !== 0);
        $texto_preco = $have_desconto ? "De <span class='text-decoration-line-through'>R$ " . number_format($preco, 2 , ',','.') . "</span> por <span class='text-yellow fw-bold fs-4'>R$ ". number_format($preco_final, 2 , ',','.') ."</span>" : "<span class='text-yellow fw-bold fs-4'>R$ ". number_format($preco_final, 2 , ',','.') ."</span>";  
        $parcelas = number_format($preco_final/12, 2, ',', '.');
        $texto_parcelas = "Ou até 12x de R$ $parcelas";
?>

    <a href="#" class="swiper-slide">
        <div class="card rounded border-0 shadow-card">
            <img class="rounded-1 card_img" src="<?= $img; ?>" alt="<?= $nome; ?>">
            <div class="overlay rounded-1 py-2 px-3 bg-card">
                <h5 class="text-yellow mb-4"><?= $nome; ?></h5>
                <p><?= $descricao; ?></p>
                <p class="mt-4"><?= $texto_preco; ?></p>
                <p><?= $texto_parcelas; ?></p>
                <p class="card- mt-5 fs-5">Confira os detalhes</p>
            </div>
        </div>
    </a>

<?php } ?>