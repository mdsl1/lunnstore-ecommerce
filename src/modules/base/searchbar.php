<style>
    .btn-form {
        background-color: #ffc107;
        color: #121212;
        border-radius: 8px;
        border: #ffc107 solid 2px;
        transition: ease 0.2s;
        align-content: center;
    }
    .btn-form:hover {
        background-color: none;
        font-weight: bolder;
        outline: 3px solid #ffc107;
        outline-offset: -3px;
        border-radius: 8px;
    }
    .form-control:focus {
        border: 1px solid #000;
    }
</style>
<form action="<?php BASE_URL; ?>modules/produtos/processamento/filtrar_produtos.php" class="d-flex w-75 gap-3">

    <input class="form-control me-auto focus-ring focus-ring-secondary px-5 py-2 rounded-5" type="text" placeholder="Qual o produto de hoje?" aria-label="Buscar por nome?">
    <button class="btn btn-form w-25" type="button">Buscar <i class="bi bi-search"></i></button>

</form>