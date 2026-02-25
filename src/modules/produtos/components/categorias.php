<?php 
    $categorias = select($conn, "vw_all_categorias");
?>

<div class="container w-75 mt-5 mb-3 px-4 py-4 rounded shadow-card bg-card">
    <h3 class="text-center text-yellow mb-4">Categorias</h3>
    <div class="container w-100 d-flex justify-content-center flex-wrap gap-3">
        <?php foreach( $categorias as $c ) { ?>
            <a href="#" class="btn btn-yellow"><?= ucfirst($c["tipo"]); ?></a>
        <?php } ?>
    </div>
</div>