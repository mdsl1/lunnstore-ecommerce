<?php 
    $is_home = (basename($_SERVER["SCRIPT_NAME"]) == "index.php");

    $class_bg = $is_home ? 'header-hidden' : 'header-visible';
?>
<style>
    .header-hidden {
        opacity: 0;
        visibility: hidden;
        transition: all 0.3s ease-in-out;
    }

    .header-visible {
        opacity: 0.8;
        visibility: visible;
    }

    .h-header {
        height: 9vh;
    }

    #accountBtn, .dropdown-menu {
        background: #050124;
        border: #ffffff 1px solid;
        transition: transform 0.3s ease;
    }
    #accountBtn:hover {
        border: #fdff6a 1px solid;
    }
    
    @media (max-width: 990px) {
        .h-header {
            height: 8vh;
        }

        #navbarNav {
            background: #050124;
            padding: 2% 0 2% 10%;
        }
    }

</style>

<header class="navbar navbar-expand-lg py-1 d-flex justify-content-center w-100 h-header position-fixed top-0 align-items-center" data-bs-theme="dark" style="z-index: 18;">
        <div class="container-fluid m-auto">
            
            <a class="navbar-brand ms-3 f-megrim text-white d-flex align-items-center fs-3 me-md-5 pe-md-5" href="#"><div id="logo" class="d-flex align-items-center" style="width: 4rem; height: 4rem; margin-right: 2rem; background: url('<?= BASE_URL ?>Midias/favicon.png') no-repeat; background-size: cover;"></div>Lunn<span class="text-yellow">Store</span></a>

            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>

            <nav class="collapse navbar-collapse align-items-baseline justify-content-end" id="navbarNav">
                <ul class="navbar-nav nav-underline fs-4 text-white me-5">
                    <li class="nav-item">
                        <a class="nav-link link-hover text-white" href="<?= BASE_URL ?>index.php">Home</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link link-hover text-white" href="<?= BASE_URL ?>pages/produtos.php">Produtos</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link link-hover text-white position-relative" href="<?= BASE_URL ?>pages/carrinho.php">
                            Carrinho
                            <?php
                                $qtde_carrinho = isset($_SESSION['carrinho']) ? count($_SESSION['carrinho']) : 0;
                                if ($qtde_carrinho > 0):
                            ?>
                            <span class="position-absolute start-100 translate-middle badge rounded-pill bg-danger" style="font-size: 0.6rem; top: 15%;"><?= $qtde_carrinho; ?></span>
                            <?php endif; ?>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link link-hover text-white" href="<?= BASE_URL ?>pages/sobre.php">Sobre</a>
                    </li>
                    <li class="nav-item align-content-center">

                        <?php if(!isset($_SESSION["id_cli"])) { ?>
                            <a class="nav-link link-hover text-white" href="<?= BASE_URL ?>pages/login.php">Entrar</a>
                        <?php } else { ?>
                            <div class="dropdown-center">

                                <button id="accountBtn" class="btn btn-secondary dropdown-toggle link-hover" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                                    <i class="bi bi-person-lines-fill"></i>
                                </button>

                                <ul class="dropdown-menu">
                                    <li><a class="dropdown-item link-hover" href="#">Meu Perfil</a></li>
                                    <li><a class="dropdown-item link-hover" href="#">Compras</a></li>
                                    <li><a class="dropdown-item link-hover" href="#">Favoritos</a></li>
                                    <li><a class="dropdown-item link-hover text-white" href="<?= BASE_URL ?>modules/usuarios/processamento/logoff.php">Sair</a></li>
                                </ul>

                        <?php } ?>
                    </li>
                </ul>
            </nav>
            
        </div>
    </header>

    <div id="bgHeader" class="container-fluid w-100 h-header position-fixed top-0 <?= $class_bg ?>" style="background: #050124; z-index: 15; backdrop-filter: blur(10px);"></div>

    <script defer>
        const is_home = <?=json_encode($is_home); ?>;

        if(is_home) {
            window.addEventListener( "scroll", () => {
                const header = document.getElementById("bgHeader");
    
                if (header) {
                    header.classList.toggle("header-visible", window.scrollY > (window.innerHeight - 100));
                }       
            });
        }
    </script>