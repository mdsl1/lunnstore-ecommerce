<?php 
    require_once __DIR__ . "/../config.php";
    require_once ROOT_PATH . "modules/base/header.php"; 
?>

<style>
    #heroSection {
        position: relative;
        overflow: hidden;
        outline: 7px double #fbff29;
    }

    .floating-animation {
        animation: float 5s ease-in-out infinite;
    }
    @keyframes float {
        0% { transform: translateY(0px); }
        50% { transform: translateY(-20px); }
        100% { transform: translateY(0px); }
    }

    .img_carousel {
        height: 70vh;
        object-fit: cover;
        object-position: center;
    }
    .carousel-caption {
        background: #050124bc;
        border-radius: 15px;
        width: 50%;
        margin: auto;
    }
    @media (max-width: 990px) {
        .img_carousel {
            height: 20vh;
        }
    }
    .accordion-header, .accordion-body {
        padding: 1rem;
    }
</style>

<section id="heroSection" class="container-fluid w-100 d-flex align-items-center" style="height: 100vh; background: radial-gradient(circle at center, #1c1552 0%, #050124 100%); color: white;">
    <div class="container">
        <div class="row align-items-center">
        
            <div class="col-lg-6 mb-5 mb-lg-0 text-center text-lg-start">

                <h1 class="display-3 fw-bold mb-3">Fragrâncias tão inesquecíveis quanto uma <span class="text-yellow">noite de luar.</span></h1>
                <p class="lead mb-4 text-white">Deixe sua marca por onde passar. Descubra nosso leque de fragrâncias exclusivas que capturam a essência do luxo e da sedução.</p>

                <div class="d-flex gap-3 justify-content-center justify-content-lg-start">

                    <a href="#store" class="btn btn-lg px-2 px-md-4 btn-yellow fw-bold">Comprar Agora</a>
                    <a href="sobre.php" class="btn btn-lg btn-outline-light px-2 px-md-4" style="border-radius: 8px;">Saber Mais</a>

                </div>

            </div>

            <div class="col-lg-6 d-flex justify-content-center">

                <div class="hero-logo-container">
                    <img src="Midias/favicon.png" alt="LunnStore Logo" class="img-fluid floating-animation mt-5 mt-lg-0" style="max-height: 300px; filter: drop-shadow(0 0 30px rgba(253, 255, 105, 0.25));">
                </div>

            </div>

        </div>
    </div>
</section>

<main id="store" class="container-fluid w-100 mb-3 d-flex flex-column align-items-center">

    <!-- Carrossel de Produtos -->
    <?php require_once ROOT_PATH . "modules/produtos/components/carousel.php"; ?>

    <!-- Produtos Mais Vendidos -->
    <section class="w-80 mt-5 mb-3 text-center">

        <h2 class="fs-1 mb-5 text-title fw-bold">Nossos Campeões de Vendas</h2>
        <?php require_once ROOT_PATH . "modules/produtos/components/mais_vendidos.php"; ?>

    </section>

    <!-- Produtos Custo-Beneficio -->
    <section class="w-80 mt-5 mb-3 text-center">

        <h2 class="fs-1 mb-5 text-title fw-bold">Excelentes Custo-Benefício</h2>
        <?php require_once ROOT_PATH . "modules/produtos/components/custo_beneficio.php"; ?>

    </section>

    <!-- Categorias -->
    <?php require_once ROOT_PATH . "modules/produtos/components/categorias.php"; ?>

    <!-- Duvidas Frequentes -->
    <section class="w-80 mt-5 mb-3">
        <h2 class="text-center text-title mb-4">Dúvidas Frequentes</h2>

        <div class="accordion accordion-flush w-100" id="accordionQuestions">

            <div class="accordion-item rounded-2">
                <h2 class="accordion-header">
                <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#questionOne" aria-expanded="false" aria-controls="questionOne">
                    Qual é o prazo de entrega e como posso rastrear meu pedido?
                </button>
                </h2>
                <div id="questionOne" class="accordion-collapse collapse" data-bs-parent="#accordionQuestions">
                <div class="accordion-body">O prazo de entrega varia de acordo com a sua região. Assim que o pedido for despachado, você receberá um código de rastreio por e-mail para acompanhar cada etapa do transporte em nosso site ou no portal da transportadora.</div>
                </div>
            </div>

            <div class="accordion-item rounded-2">
                <h2 class="accordion-header">
                <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapseTwo" aria-expanded="false" aria-controls="questionTwo">
                    Posso trocar ou devolver um produto se eu não gostar?
                </button>
                </h2>
                <div id="flush-collapseTwo" class="accordion-collapse collapse" data-bs-parent="#accordionQuestions">
                <div class="accordion-body">Sim! Você tem até 7 dias corridos após o recebimento para solicitar a devolução por arrependimento, desde que o produto esteja lacrado e sem sinais de uso. Para produtos com defeito, o prazo de garantia segue as normas do Código de Defesa do Consumidor. Entre em contato com nosso suporte para iniciar o processo.</div>
                </div>
            </div>

            <div class="accordion-item rounded-2">
                <h2 class="accordion-header">
                <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#questionThree" aria-expanded="false" aria-controls="questionThree">
                    É seguro comprar na LunnStore? Quais são as formas de pagamento?
                </button>
                </h2>
                <div id="questionThree" class="accordion-collapse collapse" data-bs-parent="#accordionQuestions">
                <div class="accordion-body">Totalmente seguro. Utilizamos tecnologia de criptografia de ponta para proteger seus dados. Aceitamos cartões de crédito (com parcelamento), Pix e boleto bancário. Seus dados de pagamento não são armazenados em nossos servidores, garantindo máxima privacidade.</div>
                </div>
            </div>

        </div>
    </section>

</main>

<?php require_once ROOT_PATH . "modules/base/footer.php"; ?>