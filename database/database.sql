SET NAMES utf8mb4;
SET CHARACTER SET utf8mb4;

CREATE DATABASE IF NOT EXISTS lunnstore_db;

USE lunnstore_db;


SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS item_pedido, pedidos, lista_desejos, estoque, produto_banner, produto_imagens, produtos, usuarios, usuario_cartoes, tabela_fretes, zonas_frete;
SET FOREIGN_KEY_CHECKS = 1;

-- CREATES

CREATE TABLE IF NOT EXISTS produtos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(200) NOT NULL,
    preco DECIMAL(10,2) NOT NULL,
    percentual_desconto INT DEFAULT 0,
    descricao TEXT NOT NULL,
    categoria VARCHAR(100) NOT NULL,
    is_ativo BOOLEAN NOT NULL DEFAULT 1
);

CREATE TABLE IF NOT EXISTS produto_imagens (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_produto INT NOT NULL,
    url_img VARCHAR(255),
    FOREIGN KEY (id_produto) REFERENCES produtos(id)
);

CREATE TABLE IF NOT EXISTS produto_banner (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_produto INT NOT NULL,
    url_img VARCHAR(255),
    titulo_banner VARCHAR(255),
    cta_banner VARCHAR(255),
    FOREIGN KEY (id_produto) REFERENCES produtos(id)
);

CREATE TABLE IF NOT EXISTS estoque (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_produto INT NOT NULL,
    qtde INT NOT NULL,
    FOREIGN KEY (id_produto) REFERENCES produtos(id)
);

CREATE TABLE IF NOT EXISTS usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    senha VARCHAR(255) NOT NULL,
    cep VARCHAR(8) NOT NULL,
    numero INT NOT NULL,
    is_adm BOOLEAN NOT NULL DEFAULT 0,
    is_ativo BOOLEAN NOT NULL DEFAULT 1
);

CREATE TABLE IF NOT EXISTS lista_desejos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    id_produto INT NOT NULL,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id),
    FOREIGN KEY (id_produto) REFERENCES produtos(id)
);

CREATE TABLE IF NOT EXISTS pedidos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    data_pedido DATETIME DEFAULT CURRENT_TIMESTAMP,
    total DECIMAL(10,2),
    forma_pagamento ENUM("pix", "a vista", "parcelado"),
    num_parcelas INT DEFAULT 0,
    status ENUM("Em andamento", "Finalizado", "Cancelado") DEFAULT "Em andamento",
    data_final DATETIME,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id)
);

CREATE TABLE IF NOT EXISTS item_pedido (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_pedido INT NOT NULL,
    id_produto INT NOT NULL,
    qtde INT NOT NULL,
    FOREIGN KEY (id_pedido) REFERENCES pedidos(id),
    FOREIGN KEY (id_produto) REFERENCES produtos(id)
);

-- O primeiro digito do numero do cartão informa a bandeira
-- 2 e entre 51 e 55: Mastercard
-- 3 American Express
-- 4 Visa
-- 5 fora do range da mastercard: Elo
CREATE TABLE IF NOT EXISTS usuario_cartoes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    -- Token de pagamento vai ser a criptografia do numero do cartão que será inserida no banco de dados
    token_pagamento VARCHAR(255) NOT NULL UNIQUE,
    bandeira VARCHAR(20) NOT NULL,
    last_4_digitos CHAR(4) NOT NULL,
    data_expiracao DATE NOT NULL,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id)
);

CREATE TABLE IF NOT EXISTS tabela_fretes (
    id INT PRIMARY KEY AUTO_INCREMENT,
    faixa_cep CHAR(1) NOT NULL,
    regiao VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS zonas_frete (
    faixa CHAR(1) PRIMARY KEY,
    preco DECIMAL(10, 2) NOT NULL,
    prazo_dias_uteis INT NOT NULL
);


-- PROCEDURES

DELIMITER $$
CREATE PROCEDURE fracionar_string(IN array_text TEXT, IN delimiter VARCHAR(1))
BEGIN
    DECLARE position INT;
    DECLARE item_valor TEXT;
    DECLARE i INT DEFAULT 1;

    CREATE TEMPORARY TABLE IF NOT EXISTS temp_values (
        value TEXT,
        i INT
    );

    TRUNCATE TABLE temp_values;

    simple_loop: LOOP
        SET position = INSTR(array_text, delimiter);

        IF position = 0 THEN
            -- Insere o último item restante (string)
            INSERT INTO temp_values (value, i) VALUES (array_text, i); 
            LEAVE simple_loop;
        ELSE
            -- Pega o item antes do delimitador
            SET item_valor = SUBSTRING(array_text, 1, position - 1);
            INSERT INTO temp_values(value, i) VALUES (item_valor, i);

            -- Remove o item processado e o delimitador
            SET array_text = SUBSTRING(array_text, position + 1);
            SET i = i + 1;
        END IF;
    END LOOP;

END $$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE fracionar_numeros(IN array VARCHAR(255), IN delimiter VARCHAR(1))
BEGIN
    DECLARE position INT;
    DECLARE num VARCHAR(255);
    DECLARE i INT DEFAULT 1;

    CREATE TEMPORARY TABLE IF NOT EXISTS temp_values (
        value INT,
        i INT
    );

    TRUNCATE TABLE temp_values;

    simple_loop: LOOP
        SET position = INSTR(array, delimiter);

        IF position = 0 THEN
            INSERT INTO temp_values (value, i) VALUES (CAST(array AS UNSIGNED), i);
            LEAVE simple_loop;
        ELSE
            SET num = SUBSTRING(array, 1, position - 1);
            INSERT INTO temp_values(value, i) VALUES (CAST(num AS UNSIGNED), i);

            SET array = SUBSTRING(array, position + 1);
            SET i = i + 1;
        END IF;
    END LOOP;

END $$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE inserir_produto (
    IN p_nome VARCHAR(200),
    IN p_preco DECIMAL(10,2),
    IN p_desconto INT,
    IN p_descricao TEXT,
    IN p_categoria VARCHAR(100),
    IN e_qtde INT,
    IN p_img_array TEXT,        -- URLs separadas por ";" para produto_imagens
    IN p_banner_array TEXT,     -- URLs separadas por ";" para produto_banner
    IN p_banner_titulo VARCHAR(255),
    IN p_banner_cta VARCHAR(255)
)
BEGIN
    DECLARE id_p INT;
    DECLARE current_url VARCHAR(255);
    DECLARE done BOOLEAN DEFAULT FALSE;
    
    -- Cursor para processar as URLs
    DECLARE cur CURSOR FOR SELECT value FROM temp_values;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    -- 1. Inserir na tabela principal de produtos
    INSERT INTO produtos (nome, preco, percentual_desconto, descricao, categoria) 
    VALUES (p_nome, p_preco, p_desconto, p_descricao, p_categoria);
    
    SET id_p = LAST_INSERT_ID();

    -- 2. Inserir no estoque
    INSERT INTO estoque (id_produto, qtde) VALUES (id_p, e_qtde);

    -- 3. Processar Imagens do Produto
    IF p_img_array IS NOT NULL AND p_img_array <> '' THEN
        CALL fracionar_string(p_img_array, ";");
        
        OPEN cur;
        img_loop: LOOP
            FETCH cur INTO current_url;
            IF done THEN LEAVE img_loop; END IF;
            INSERT INTO produto_imagens (id_produto, url_img) VALUES (id_p, current_url);
        END LOOP;
        CLOSE cur;
        
        SET done = FALSE; -- Resetar para o próximo uso
        TRUNCATE TABLE temp_values; 
    END IF;

    -- 4. Processar Imagens de Banner
    IF p_banner_array IS NOT NULL AND p_banner_array <> '' THEN
        CALL fracionar_string(p_banner_array, ";");
        
        OPEN cur;
        banner_loop: LOOP
            FETCH cur INTO current_url;
            IF done THEN LEAVE banner_loop; END IF;
            INSERT INTO produto_banner (id_produto, url_img, titulo_banner, cta_banner) 
            VALUES (id_p, current_url, p_banner_titulo, p_banner_cta);
        END LOOP;
        CLOSE cur;
    END IF;

    -- Limpeza final (A tabela temp_values é criada dentro da fracionar_string)
    DROP TEMPORARY TABLE IF EXISTS temp_values;

END $$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE criar_pedido (
    IN p_id_usuario INT,
    IN p_array_produtos VARCHAR(255),  -- Ex: "1,2,3"
    IN p_array_quantidades VARCHAR(255), -- Ex: "2,1,5"
    IN p_forma_pagamento ENUM('pix', 'a vista', 'parcelado'),
    IN p_num_parcelas INT
)
BEGIN
    DECLARE v_done INT DEFAULT FALSE;
    DECLARE v_prod_id INT;
    DECLARE v_prod_qtde INT;
    DECLARE v_estoque_atual INT;
    DECLARE v_pedido_id INT;
    DECLARE v_preco_unitario DECIMAL(10,2);
    DECLARE v_total_acumulado DECIMAL(10,2) DEFAULT 0;

    -- Cursor para ler as tabelas temporárias em conjunto
    DECLARE cur CURSOR FOR 
        SELECT tp.value, tq.value 
        FROM temp_p tp 
        JOIN temp_q tq ON tp.i = tq.i;
        
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_done = TRUE;

    -- 1. Preparar dados temporários
    CREATE TEMPORARY TABLE IF NOT EXISTS temp_p (value INT, i INT);
    CREATE TEMPORARY TABLE IF NOT EXISTS temp_q (value INT, i INT);
    TRUNCATE temp_p;
    TRUNCATE temp_q;

    -- Fraciona IDs de Produtos
    CALL fracionar_numeros(p_array_produtos, ",");
    INSERT INTO temp_p SELECT * FROM temp_values;
    
    -- Fraciona Quantidades
    CALL fracionar_numeros(p_array_quantidades, ",");
    INSERT INTO temp_q SELECT * FROM temp_values;

    -- 2. Criar o cabeçalho do pedido (Total inicial 0)
    INSERT INTO pedidos (id_usuario, data_pedido, total, forma_pagamento, num_parcelas, status) 
    VALUES (p_id_usuario, NOW(), 0, p_forma_pagamento, p_num_parcelas, 'Em andamento');
    
    SET v_pedido_id = LAST_INSERT_ID();

    -- 3. Processar itens do pedido
    OPEN cur;
    read_loop: LOOP
        FETCH cur INTO v_prod_id, v_prod_qtde;
        IF v_done THEN LEAVE read_loop; END IF;

        -- Verifica estoque usando id_produto
        SELECT qtde INTO v_estoque_atual FROM estoque WHERE id_produto = v_prod_id;

        IF v_estoque_atual >= v_prod_qtde THEN
            -- Busca preço atual (considerando desconto se quiser, aqui usei o preço cheio)
            SELECT preco INTO v_preco_unitario FROM produtos WHERE id = v_prod_id;

            -- Insere o item e atualiza estoque
            INSERT INTO item_pedido (id_pedido, id_produto, qtde) VALUES (v_pedido_id, v_prod_id, v_prod_qtde);
            UPDATE estoque SET qtde = qtde - v_prod_qtde WHERE id_produto = v_prod_id;

            -- Soma ao total
            SET v_total_acumulado = v_total_acumulado + (v_preco_unitario * v_prod_qtde);
        ELSE
            -- Se um item falha, poderíamos cancelar tudo. Aqui vamos apenas ignorar e você pode tratar depois.
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Estoque insuficiente para um dos itens';
        END IF;
    END LOOP;
    CLOSE cur;

    -- 4. Atualiza o total final do pedido
    UPDATE pedidos SET total = v_total_acumulado WHERE id = v_pedido_id;

    -- Limpeza
    DROP TEMPORARY TABLE IF EXISTS temp_p;
    DROP TEMPORARY TABLE IF EXISTS temp_q;

END $$
DELIMITER ;


-- INSERTS

INSERT INTO usuarios (nome, email, senha, cep, numero, is_adm, is_ativo) VALUES 
('Administrador da Silva', 'aaa@gmail.com', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', '17512757', 100, 1, 1);

CALL inserir_produto(
    "Luna Nuit", 
    124.90, 
    0, 
    "Luna Nuit exalta o poder feminino, uma fragrância marcante e misteriosa como a noite. Vai do calor do âmbar para o amadeirado e surpreende com um toque floral, revelando uma fragrância sofisticada e apaixonante. Irradia a paixão da mulher confiante que expressa sua autenticidade.", 
    "feminino-florais", 
    50, 
    "https://production.na01.natura.com/on/demandware.static/-/Sites-natura-br-storefront-catalog/default/dwd35e1530/Produtos/NATBRA-204451_1.jpg;https://production.na01.natura.com/on/demandware.static/-/Sites-natura-br-storefront-catalog/default/dwbf5281c8/produto-joia/background/mobile/204451.jpg", 
    "https://production.na01.natura.com/on/demandware.static/-/Sites-natura-br-storefront-catalog/default/dwbd472d1e/produto-joia/background/desktop/204451.jpg", 
    "Novo Luna Nuit", 
    "Uma fragrância marcante e misteriosa como a noite."
);

CALL inserir_produto(
    'Una Blush', 
    319.90, 
    0, 
    'A fragrância icônica de Una Blush em uma edição especial com embalagem colecionável. Inspirado no elegante retorno do brilho à maquiagem e perfumaria, o Deo Parfum Una Blush traz a sofisticação da flor de laranjeira e um toque único do breu branco.', 
    'feminino-adocicados', 
    50, 
    'https://production.na01.natura.com/on/demandware.static/-/Sites-natura-br-storefront-catalog/default/dw4a0dd86a/Produtos/PRODUTO/NATBRA-128756_2.jpg;https://production.na01.natura.com/on/demandware.static/-/Sites-natura-br-storefront-catalog/default/dwcbb93353/produto-joia/background/mobile/128756.jpg', 
    'https://production.na01.natura.com/on/demandware.static/-/Sites-natura-br-storefront-catalog/default/dwd9c69f1f/produto-joia/background/desktop/128756.jpg', 
    'O Clássico está de Volta', 
    'A fragrância icônica de Una Blush em uma edição especial.'
);

CALL inserir_produto(
    'Kriska', 
    169.90, 
    15, 
    'Combinando força e suavidade, Kriska Feminino envolve seus sentidos com uma combinação da doçura das notas de baunilha com o marcante das madeiras, feita para mulheres que equilibram delicadeza e confiança. Kriska revela uma personalidade marcante e inconfundível, traduzindo feminilidade em uma perfumação que desperta emoções. Seu caminho olfativo mescla notas que realçam o poder e a suavidade, criando uma experiência de fragrância única e inesquecível.', 
    'feminino-adocicados', 
    50, 
    'https://production.na01.natura.com/on/demandware.static/-/Sites-natura-br-storefront-catalog/default/dwb1e59a96/Produtos/NATBRA-41795_1.jpg;https://production.na01.natura.com/on/demandware.static/-/Sites-natura-br-storefront-catalog/default/dwf01687ae/Produtos/NATBRA-41795_3.jpg', 
    'https://production.na01.natura.com/on/demandware.static/-/Sites-natura-br-storefront-catalog/default/dw8b22a81f/produto-joia/background/desktop/41795.jpg', 
    'Novo Kriska Feminino', 
    'Uma Fragrância Vibrante e Atemporal.'
);

CALL inserir_produto(
    'Urbano', 
    168.90, 
    0, 
    'Fragrância poderosa para o homem urbano. Amadeirado com notas cítricas e especiadas. Combinação única do akigalawood, ingrediente amadeirado inédito na Perfumaria mundial.', 
    'masculino-aromaticos', 
    50, 
    'https://production.na01.natura.com/on/demandware.static/-/Sites-natura-br-storefront-catalog/default/dw9e7d6e91/NATBRA-184485_1.jpg;https://production.na01.natura.com/on/demandware.static/-/Sites-natura-br-storefront-catalog/default/dwd4d9a18c/produto-joia/background/mobile/184485.jpg', 
    'https://production.na01.natura.com/on/demandware.static/-/Sites-natura-br-storefront-catalog/default/dw599c7f9f/produto-joia/background/desktop/184485.jpg', 
    'O aroma do Homem #Urbano', 
    'Uma fragrância poderosa para o homem Urbano.'
);

CALL inserir_produto(
    'Essêncial Exclusivo Masculino', 
    279.90, 
    30, 
    'Essencial Exclusivo Masculino é uma fragrância que combina sofisticação e intensidade. Com notas amadeiradas e especiadas, é perfeito para o homem que busca uma presença marcante e distinta. Ideal para ocasiões especiais e para o dia a dia.', 
    'masculino-amadeirados', 
    50, 
    'https://production.na01.natura.com/on/demandware.static/-/Sites-natura-br-storefront-catalog/default/dwa1693e28/Produtos/PRODUTO/NATBRA-76422_1.jpg;https://production.na01.natura.com/on/demandware.static/-/Sites-natura-br-storefront-catalog/default/dw22148d31/Produtos/PRODUTO/NATBRA-76422_3.jpg', 
    'https://production.na01.natura.com/on/demandware.static/-/Sites-natura-br-storefront-catalog/default/dwedd24450/produto-joia/background/desktop/76422.jpg', 
    'Apenas o Essêncial.', 
    'Deixe sua marca com elegância e sofisticação.'
);

CALL inserir_produto(
    'Essêncial Exclusivo Feminino', 
    279.90, 
    0, 
    'Para encantar com sua elegância, o novo Essencial traz flores brancas preciosas, como a jasmim e a magnólia, combinadas a um irresistível aroma de frutas. Tudo isso envolvido pelo toque picante da priprioca, ingrediente da biodiversidade brasileira, e notas ambaradas e amadeiradas.', 
    'feminino-florais', 
    50, 
    'https://production.na01.natura.com/on/demandware.static/-/Sites-natura-br-storefront-catalog/default/dw3dce3a82/NATBRA-95575_1.jpg;https://production.na01.natura.com/on/demandware.static/-/Sites-natura-br-storefront-catalog/default/dwcfd986ca/NATBRA-95575_2.jpg', 
    'https://production.na01.natura.com/on/demandware.static/-/Sites-natura-br-storefront-catalog/default/dw5c64becb/produto-joia/background/desktop/95575.jpg', 
    'Apenas o Essêncial.', 
    'Uma fragrância marcante para quem é protagonista da sua vida.'
);

INSERT INTO tabela_fretes (faixa_cep, regiao) VALUES
-- FAIXA A: Vizinhos de SP (Escala 1)
('A', 'São Paulo'), -- O preço/prazo virá da tabela de zonas
('A', 'Rio de Janeiro'),
('A', 'Minas Gerais'),
('A', 'Paraná'),
-- FAIXA B: Próximos / Sul e Centro-Oeste (Escala 2-3)
('B', 'Mato Grosso do Sul'),
('B', 'Santa Catarina'),
('B', 'Espírito Santo'),
('B', 'Goiás'),
-- FAIXA C: Centro-Oeste e DF (Escala 4-5)
('C', 'Distrito Federal'),
('C', 'Rio Grande do Sul'),
('C', 'Mato Grosso'),
-- FAIXA D: Nordeste entrada (Escala 5-6)
('D', 'Bahia'),
('D', 'Tocantins'),
-- FAIXA E: Nordeste Central (Escala 7)
('E', 'Sergipe'),
('E', 'Alagoas'),
('E', 'Pernambuco'),
-- FAIXA F: Nordeste Norte (Escala 8)
('F', 'Ceará'),
('F', 'Paraíba'),
('F', 'Rio Grande do Norte'),
('F', 'Maranhão'),
('F', 'Piauí'),
-- FAIXA G: Norte (Escala 8-9)
('G', 'Pará'),
('G', 'Rondônia'),
('G', 'Amazonas'),
('G', 'Amapá'),
-- FAIXA H: Extremo Norte / Difícil Acesso (Escala 10)
('H', 'Acre'),
('H', 'Roraima');

INSERT INTO zonas_frete (faixa, preco, prazo_dias_uteis) VALUES
('A', 15.00, 2),
('B', 25.00, 5),
('C', 35.00, 7),
('D', 45.00, 10),
('E', 55.00, 12),
('F', 65.00, 15),
('G', 85.00, 22),
('H', 110.00, 30);


-- VIEWS

DROP VIEW IF EXISTS vw_overall_produtos;
CREATE OR REPLACE VIEW vw_overall_produtos AS SELECT
    p.id,
    p.nome,
    p.preco,
    p.percentual_desconto,
    (p.preco * (1 - p.percentual_desconto / 100)) AS preco_final,
    p.categoria,
    e.qtde AS estoque_atual,
    (p.preco * e.qtde) AS total_em_estoque
FROM produtos p
LEFT JOIN estoque e ON p.id = e.id_produto
WHERE p.is_ativo = 1;

DROP VIEW IF EXISTS vw_1st_img_produto;
CREATE OR REPLACE VIEW vw_1st_img_produto AS 
SELECT 
    subquery.id_produto,
    subquery.url 
FROM (
    SELECT 
        pi.id_produto,
        pi.url_img AS url,
        ROW_NUMBER() OVER (PARTITION BY pi.id_produto ORDER BY pi.id) AS rnk 
    FROM produto_imagens pi 
    JOIN produtos p ON p.id = pi.id_produto 
    WHERE p.is_ativo = 1
) subquery 
WHERE subquery.rnk = 1;

DROP VIEW IF EXISTS vw_banner_produto;
CREATE OR REPLACE VIEW vw_banner_produto AS 
SELECT 
    pb.id_produto,
    pb.url_img AS url,
    pb.titulo_banner AS titulo,
    pb.cta_banner AS cta 
FROM produto_banner pb 
JOIN produtos p ON p.id = pb.id_produto 
WHERE p.is_ativo = 1;

DROP VIEW IF EXISTS vw_produtos_vitrine;
CREATE OR REPLACE VIEW vw_produtos_vitrine AS 
SELECT 
    p.id,
    p.nome,
    p.preco,
    p.percentual_desconto,
    ROUND((p.preco * (1 - (p.percentual_desconto / 100))), 2) AS preco_final,
    COALESCE(vendas.total_vendido, 0) AS qtde_vendida,
    p.descricao AS descricao_full,
    LEFT(COALESCE(vbanner.cta, p.descricao), 70) AS descricao,
    SUBSTRING_INDEX(p.categoria, "-",1) AS categoria,
    SUBSTRING_INDEX(p.categoria, "-",-1) AS subcategoria,
    vimg.url AS url_imagem_capa 
FROM produtos p 
LEFT JOIN vw_1st_img_produto vimg ON p.id = vimg.id_produto 
LEFT JOIN vw_banner_produto vbanner ON p.id = vbanner.id_produto 
LEFT JOIN (
    SELECT id_produto, SUM(qtde) AS total_vendido 
    FROM item_pedido 
    GROUP BY id_produto
) vendas ON p.id = vendas.id_produto
WHERE p.is_ativo = 1;

DROP VIEW IF EXISTS vw_tabela_frete;
CREATE OR REPLACE VIEW vw_tabela_frete AS SELECT 
	t.id,
    t.faixa_cep,
    t.regiao, 
    z.preco, 
    z.prazo_dias_uteis as prazo
FROM tabela_fretes t
JOIN zonas_frete z ON t.faixa_cep = z.faixa
ORDER BY preco;

DROP VIEW IF EXISTS vw_usuario_basico;
CREATE OR REPLACE VIEW vw_usuario_basico AS SELECT 
	u.id, 
    u.nome AS nome_full,
    SUBSTRING_INDEX(u.nome, ' ', 1) AS first_nome,
    u.email,
    u.senha,
    is_adm,
    is_ativo
FROM usuarios u
WHERE is_ativo = 1;

DROP VIEW IF EXISTS vw_all_categorias;
CREATE OR REPLACE VIEW vw_all_categorias AS
SELECT DISTINCT categoria AS tipo FROM vw_produtos_vitrine
UNION
SELECT DISTINCT subcategoria AS tipo FROM vw_produtos_vitrine;