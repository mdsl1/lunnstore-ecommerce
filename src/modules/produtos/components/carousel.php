<?php 
    $banners = select($conn, "vw_banner_produto", "LIMIT 3");
?>

<div id="carouselProducts" class="carousel slide w-100 mt-3 mb-2 mb-md-5" data-bs-ride="carousel">

    <div class="carousel-indicators">
        <?php foreach ($banners as $i => $banner) { ?>

            <button type="button" data-bs-target="#carouselProducts" data-bs-slide-to="<?= $i; ?>" class="active" aria-current="true" aria-label="Slide <?= $i; ?>"></button>

        <?php } ?>
    </div>

    <div class="carousel-inner">

        <?php foreach ($banners as $i => $banner) { ?>

            <div class="carousel-item <?php echo ($i === 0) ? 'active' : ''; ?>">

                <img src=" <?= $banner["url"]; ?> " class="d-block w-100 img_carousel" alt="...">
                <div class="carousel-caption d-none d-md-block">
                    <h5 class="text-yellow"><?= $banner["titulo"]; ?></h5>
                    <p><?= $banner["cta"]; ?></p>
                    <a href="#" class="btn btn-yellow mb-2">Ver Produto</a>
                </div>

            </div>

        <?php } ?>

    </div>

    <button class="carousel-control-prev" type="button" data-bs-target="#carouselProducts" data-bs-slide="prev">
        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
        <span class="visually-hidden">Previous</span>
    </button>

    <button class="carousel-control-next" type="button" data-bs-target="#carouselProducts" data-bs-slide="next">
        <span class="carousel-control-next-icon" aria-hidden="true"></span>
        <span class="visually-hidden">Next</span>
    </button>
</div>