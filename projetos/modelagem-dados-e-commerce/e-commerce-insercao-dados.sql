USE ecommerce;

INSERT INTO categoria (descricao) VALUES ('Eletrônicos'), ('Informática'), ('Livros'), ('Casa'), ('Moda'), ('Beleza'), ('Brinquedos');

INSERT INTO produto (nome, categoria_id, valor_unitario, avaliacao) VALUES 
('Smartphone S23', 1, 4500.00, 4.8),
('Notebook Nitro 5', 2, 5200.00, 4.7),
('Mouse Sem Fio', 2, 120.00, 4.3),
('Livro: O Algoritmo Mestre', 3, 65.00, 4.9),
('Air Fryer Philco', 4, 380.00, 4.6),
('Camiseta Básica Algodão', 5, 45.00, 4.0),
('Perfume Importado 100ml', 6, 450.00, 4.5),
('Lego Star Wars', 7, 299.00, 4.8),
('Monitor 24 Pol Gaming', 2, 850.00, 4.4),
('Smart TV 55 4K', 1, 2800.00, 4.6);

INSERT INTO endereco (cep, logradouro, numero, bairro, cidade, estado) VALUES 
('01001000', 'Av. Paulista', 1500, 'Bela Vista', 'São Paulo', 'SP'),
('20040002', 'Rua das Flores', 12, 'Centro', 'Rio de Janeiro', 'RJ'),
('30140010', 'Rua Amazonas', 500, 'Lourdes', 'Belo Horizonte', 'MG'),
('80010010', 'Rua Sete de Setembro', 101, 'Centro', 'Curitiba', 'PR'),
('90010000', 'Av. Brasil', 2020, 'Navegantes', 'Porto Alegre', 'RS'),
('70040000', 'Eixo Monumental', 1, 'Asa Sul', 'Brasília', 'DF'),
('40010000', 'Rua Chile', 55, 'Comércio', 'Salvador', 'BA'),
('60010000', 'Av. Santos Dumont', 300, 'Aldeota', 'Fortaleza', 'CE'),
('69000000', 'Rua Manaus', 99, 'Adrianópolis', 'Manaus', 'AM'),
('50010000', 'Rua do Sol', 44, 'Santo Antônio', 'Recife', 'PE'),
('01311000', 'Logística SP Central', 5000, 'Jaraguá', 'São Paulo', 'SP'),
('32000000', 'Galpão MG', 10, 'Industrial', 'Contagem', 'MG'),
('81000000', 'CD Sul', 88, 'Porto', 'Itajaí', 'SC');

INSERT INTO cliente (p_nome, nome_do_meio, sobrenome, contato) VALUES 
('Ana', 'Beatriz', 'Silva', '11988887771'),
('Bruno', 'Oliveira', 'Santos', '21977776662'),
('Carla', 'Melo', 'Pereira', '31966665553'),
('Daniel', 'Souza', 'Lima', '41955554444'),
('Eduarda', 'Costa', 'Rocha', '51944443335'),
('Fabio', 'Junior', 'Almeida', '61933332226'),
('Gabriela', 'Nunes', 'Vieira', '71922221117'),
('Hugo', 'Marques', 'Barbosa', '85911110008'),
('Isabela', 'Farias', 'Cardoso', '92900009999'),
('João', 'Victor', 'Teixeira', '81988776655');

INSERT INTO pessoa_fisica (cpf, data_nascimento, sexo, cliente_id) VALUES 
('11122233344', '1985-03-10', 'Feminino', 1),
('22233344455', '1990-07-22', 'Masculino', 2),
('33344455566', '1982-11-05', 'Feminino', 3),
('44455566677', '1995-01-30', 'Masculino', 4),
('55566677788', '1988-05-15', 'Feminino', 5),
('66677788899', '1975-09-12', 'Masculino', 6),
('77788899900', '1992-12-25', 'Feminino', 7);

INSERT INTO pessoa_juridica (cnpj, razao_social, cliente_id) VALUES 
('10100100000199', 'Hugo Marques ME', 8),
('20200200000188', 'Isabela Farias LTDA', 9),
('30300300000177', 'João Victor Comércio', 10);

INSERT INTO cliente_endereco (cliente_id, endereco_id, tipo) VALUES 
(1, 1, 'Residencial'), (2, 2, 'Residencial'), (3, 3, 'Residencial'),
(4, 4, 'Residencial'), (5, 5, 'Residencial'), (6, 6, 'Residencial'),
(7, 7, 'Residencial'), (8, 8, 'Comercial'), (9, 9, 'Comercial'), (10, 10, 'Comercial');

INSERT INTO forma_pagamento (tipo) VALUES ('Pix'), ('Boleto'), ('Cartão');

INSERT INTO cliente_pagamento (id_cliente_pagamento, cliente_id, forma_pagamento_id) VALUES 
(101, 1, 3), (102, 2, 3), (103, 3, 3), (104, 4, 3), (105, 5, 3);

INSERT INTO cartao (numero, validade, cvc, bandeira, tipo, cliente_pagamento_id) VALUES 
('4444555566665136', '12/28', '123', 'Mastercard', 'Crédito', 101),
('5555666677771234', '10/27', '456', 'Visa', 'Crédito', 102),
('3333444455559988', '05/30', '789', 'Elo', 'Débito', 103),
('2222333344447766', '08/26', '111', 'Amex', 'Crédito', 104),
('1111222233334444', '01/29', '222', 'Visa', 'Crédito', 105);

INSERT INTO terceiro (cnpj, razao_social, contato) VALUES 
('99888777001', 'Depósito Central Tech', '1140028922'),
('55444333001', 'Importadora Global', '21999998888'),
('11222333001', 'Logística Express', '3133332222'),
('44555666001', 'Fábrica de Livros SA', '4132221111'),
('77888999001', 'Eletro Tudo', '5130004000');

INSERT INTO estoque (endereco_id) VALUES (11), (12), (13);

INSERT INTO produto_vendedor (produto_id, vendedor_id, quantidade, status_produto_vendedor) VALUES 
(3, 1, 100, 'Disponível'), (4, 4, 50, 'Disponível'), (5, 5, 30, 'Disponível'), (6, 5, 200, 'Disponível');

INSERT INTO produto_fornecedor (produto_id, fornecedor_id, status_produto_fornecedor) VALUES 
(1, 2, 'Disponível'), (2, 2, 'Disponível'), (7, 3, 'Disponível'), (8, 3, 'Disponível'), (9, 1, 'Disponível'), (10, 1, 'Disponível');

INSERT INTO produto_estoque (produto_id, estoque_id, quantidade) VALUES 
(1, 1, 20), (2, 1, 15), (7, 2, 40), (8, 2, 10), (9, 3, 25), (10, 3, 5);

INSERT INTO entrega (status_entrega, codigo) VALUES 
('Pendente de envio', 'TRK101'), ('Postado', 'TRK102'), ('Em trânsito', 'TRK103'), ('Entregue', 'TRK104'),
('Pendente de envio', 'TRK105'), ('Postado', 'TRK106'), ('Em trânsito', 'TRK107'), ('Entregue', 'TRK108'),
('Pendente de envio', 'TRK109'), ('Postado', 'TRK110'), ('Em trânsito', 'TRK111'), ('Entregue', 'TRK112');

INSERT INTO pedido (total, frete, data_pedido, cliente_id, forma_pagamento_id, cliente_pagamento_id, detalhes_pagamento, status_pedido) VALUES 
(4550.00, 50.00, '2023-11-01 10:00:00', 1, 3, 101, 'Mastercard terminando em 5136', 'Enviado'),
(140.00, 10.00, '2023-11-02 14:30:00', 2, 1, NULL, NULL, 'Pago'),
(135.00, 15.00, '2023-11-03 09:15:00', 3, 3, 103, 'Elo terminando em 9988', 'Aguardando Pagamento'),
(5300.00, 100.00, '2023-10-25 16:40:00', 4, 2, NULL, NULL, 'Aguardando Pagamento'),
(405.00, 25.00, '2023-11-04 11:00:00', 5, 3, 105, 'Visa terminando em 4444', 'Pago'),
(237.00, 12.00, '2023-11-05 18:20:00', 6, 1, NULL, NULL, 'Em Separação'),
(470.00, 20.00, '2023-11-06 13:00:00', 7, 1, NULL, NULL, 'Pago'),
(314.00, 15.00, '2023-11-07 10:00:00', 8, 2, NULL, NULL, 'Enviado'),
(880.00, 30.00, '2023-11-08 15:50:00', 9, 1, NULL, NULL, 'Enviado'),
(2840.00, 40.00, '2023-11-09 17:00:00', 10, 3, 102, 'Visa terminando em 1234', 'Pago'),
(370.00, 10.00, '2023-11-10 08:00:00', 1, 1, NULL, NULL, 'Pago'),
(70.00, 5.00, '2023-11-10 12:00:00', 2, 1, NULL, NULL, 'Em Separação');

INSERT INTO pedido_produto (produto_id, pedido_id, quantidade, preco_unitario_aplicado, entrega_id, terceiro_id, estoque_id) VALUES 
(1, 1, 1, 4500.00, 1, 2, 1),
(4, 2, 2, 65.00, 2, 4, NULL),
(3, 3, 1, 120.00, 3, 1, NULL),
(2, 4, 1, 5200.00, 4, 2, 1),
(5, 5, 1, 380.00, 5, 5, NULL),
(6, 6, 5, 45.00, 6, 5, NULL),
(7, 7, 1, 450.00, 7, 3, 2),
(8, 8, 1, 299.00, 8, 3, 2),
(9, 9, 1, 850.00, 9, 1, 3),
(10, 10, 1, 2800.00, 10, 1, 3),
(3, 11, 3, 120.00, 11, 1, NULL),
(4, 12, 1, 65.00, 12, 4, NULL);
