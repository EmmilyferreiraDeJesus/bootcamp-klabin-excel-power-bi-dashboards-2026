USE ecommerce;

-- ANÁLISES
--
-- QUAL A QUANTIDADE TOTAL DE PEDIDOS REALIZADOS NA PLATAFORMA?
SELECT COUNT(*) as Qtd_Pedidos FROM pedido;

-- QUAIS PEDIDOS ESTÃO COM STATUS 'EM SEPARAÇÃO' E QUAIS SÃO OS MAIS ANTIGOS?
SELECT * FROM pedido
	WHERE status_pedido = 'Em Separação'
    ORDER BY data_pedido ASC;

-- QUAL O VALOR MÉDIO GASTO POR TIPO DE CLIENTE?
SELECT 
    CASE 
        WHEN pf.cpf IS NOT NULL THEN 'Pessoa Física'
        WHEN pj.cnpj IS NOT NULL THEN 'Pessoa Jurídica'
        ELSE 'Não Identificado'
    END AS Tipo_Cliente,
    ROUND(AVG(p.total), 2) AS Valor_Medio_Gasto
FROM pedido p
INNER JOIN cliente c ON p.cliente_id = c.id_cliente
LEFT JOIN pessoa_fisica pf ON c.id_cliente = pf.cliente_id
LEFT JOIN pessoa_juridica pj ON c.id_cliente = pj.cliente_id
GROUP BY Tipo_Cliente;

-- QUAIS SÃO OS CLIENTES QUE REALIZARAM MAIS DE 1 PEDIDO NA PLATAFORMA?
SELECT concat(c.p_nome, ' ', c.sobrenome) as Cliente, COUNT(*) as Qtd_Pedidos 
	FROM pedido as p JOIN cliente as c
    ON p.cliente_id = c.id_cliente
    GROUP BY Cliente
    HAVING Qtd_Pedidos > 1;

-- QUAL ESTADO TEM MAIS PEDIDOS? 
SELECT e.estado as Estado, COUNT(*) as Qtd_Pedidos
	FROM pedido as p JOIN cliente as c
    ON p.cliente_id = c.id_cliente
    JOIN cliente_endereco as c_d 
    ON c_d.cliente_id = c.id_cliente
    JOIN endereco as e
    ON e.id_endereco = c_d.endereco_id
    GROUP BY Estado;
    
-- QUAIS PRODUTOS SÃO OS MAIS VENDIDOS? TOP 5
SELECT p.nome as Nome, SUM(p_p.quantidade) as Qtd_Vendidas
	FROM pedido_produto as p_p JOIN produto as p
    ON p_p.produto_id = p.id_produto
    GROUP BY p.nome 
    ORDER BY Qtd_Vendidas DESC LIMIT 5;
