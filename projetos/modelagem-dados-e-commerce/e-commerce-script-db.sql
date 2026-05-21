-- CRIAÇÃO DO BANCO DE DADOS PARA O CENÁRIO DE E-COMMERCE
CREATE DATABASE ecommerce;

USE ecommerce;

CREATE TABLE cliente (
id_cliente INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
p_nome VARCHAR(45) NOT NULL,
nome_do_meio VARCHAR(45) NOT NULL,
sobrenome VARCHAR(45) NOT NULL,
contato CHAR(11) NOT NULL
);

CREATE TABLE pessoa_fisica (
id_pessoa_fisica INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
cpf CHAR(11) NOT NULL,
data_nascimento DATE NOT NULL,
sexo VARCHAR(9) NOT NULL,
cliente_id INT NOT NULL,
CONSTRAINT unique_cpf UNIQUE(cpf),
CONSTRAINT chk_sexo CHECK(sexo IN ('Feminino','Masculino')),
CONSTRAINT fk_cliente_id_pessoa_fisica FOREIGN KEY(cliente_id)
	REFERENCES cliente (id_cliente)
);

CREATE TABLE pessoa_juridica (
id_pessoa_juridica INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
cnpj CHAR(14) NOT NULL,
razao_social VARCHAR(45) NOT NULL,
cliente_id INT NOT NULL,
CONSTRAINT unique_cnpj_pessoa_juridica UNIQUE(cnpj),
CONSTRAINT fk_cliente_id_pessoa_juridica FOREIGN KEY(cliente_id)
	REFERENCES cliente (id_cliente)
);

CREATE TABLE endereco (
id_endereco INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
cep CHAR(8) NOT NULL,
logradouro VARCHAR(45) NOT NULL,
numero INT NOT NULL,
complemento VARCHAR(45) NULL,
bairro VARCHAR(45) NOT NULL,
cidade VARCHAR(45) NOT NULL,
estado CHAR(2) NOT NULL
);

CREATE TABLE cliente_endereco (
cliente_id INT NOT NULL,
endereco_id INT NOT NULL,
tipo VARCHAR(45) NOT NULL,
CONSTRAINT pk_cliente_endereco PRIMARY KEY(cliente_id, endereco_id),
CONSTRAINT fk_cliente_id_cliente_endereco FOREIGN KEY (cliente_id)
	REFERENCES cliente (id_cliente),
CONSTRAINT fk_endereco_id_cliente_endereco FOREIGN KEY (endereco_id)
	REFERENCES endereco (id_endereco),
CONSTRAINT chk_tipo_endereco CHECK(tipo IN ('Residencial','Comercial'))
);

CREATE TABLE forma_pagamento (
id_forma_pagamento INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
tipo VARCHAR(45) NOT NULL,
CONSTRAINT chk_tipo_pagamento CHECK(tipo IN ('Pix','Boleto', 'Cartão'))
);

CREATE TABLE cliente_pagamento (
id_cliente_pagamento INT PRIMARY KEY NOT NULL,
cliente_id INT NOT NULL,
forma_pagamento_id INT NOT NULL,
CONSTRAINT fk_cliente_id_cliente_pagamento FOREIGN KEY (cliente_id)
	REFERENCES cliente (id_cliente),
CONSTRAINT fk_forma_pagamento_id_cliente_pagamento FOREIGN KEY (forma_pagamento_id)
	REFERENCES forma_pagamento (id_forma_pagamento)
);

CREATE TABLE cartao (
id_cartao INT PRIMARY KEY AUTO_INCREMENT,
numero CHAR(16) NOT NULL,
validade VARCHAR(45) NOT NULL,
cvc CHAR(3) NOT NULL,
bandeira VARCHAR(45) NOT NULL,
tipo VARCHAR(45) NOT NULL,
cliente_pagamento_id INT NOT NULL,
CONSTRAINT chk_tipo_cartao CHECK(tipo IN ('Débito', 'Crédito')),
CONSTRAINT fk_cliente_pagamento_id_cartao FOREIGN KEY (cliente_pagamento_id)
	REFERENCES cliente_pagamento (id_cliente_pagamento)
);

CREATE TABLE pedido (
id_pedido INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
total DECIMAL(10,2) NULL,
frete DECIMAL(10,2) NOT NULL,
data_pedido DATETIME NOT NULL,
cliente_id INT NOT NULL,
forma_pagamento_id INT NOT NULL,
cliente_pagamento_id INT NULL,
detalhes_pagamento VARCHAR(45) NULL,
status_pedido VARCHAR(45) NOT NULL,
CONSTRAINT fk_cliente_id_pedido FOREIGN KEY (cliente_id)
	REFERENCES cliente (id_cliente),
CONSTRAINT fk_forma_pagamento_id_pedido FOREIGN KEY (forma_pagamento_id)
	REFERENCES forma_pagamento (id_forma_pagamento),
CONSTRAINT fk_cliente_pagamento_id_pedido FOREIGN KEY (cliente_pagamento_id)
	REFERENCES cliente_pagamento (id_cliente_pagamento),
CONSTRAINT chk_status_pedido CHECK(status_pedido IN ('Aguardando Pagamento', 'Pago', 'Em Separação', 'Enviado', 'Cancelado'))
);

CREATE TABLE entrega (
id_entrega INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
status_entrega VARCHAR(45) NOT NULL,
codigo VARCHAR(45) NOT NULL,
CONSTRAINT chk_status_entrega CHECK(status_entrega IN ('Pendente de envio', 'Postado', 'Em trânsito', 'Entregue', 'Extraviado', 'Cancelado'))
);

CREATE TABLE categoria (
id_categoria INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
descricao VARCHAR(45) NOT NULL
);

CREATE TABLE produto (
id_produto INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
nome VARCHAR(45) NOT NULL,
categoria_id INT NOT NULL,
valor_unitario DECIMAL(10,2),
avaliacao FLOAT NOT NULL,
CONSTRAINT fk_categoria_produto FOREIGN KEY (categoria_id)
	REFERENCES categoria (id_categoria)
);

CREATE TABLE estoque (
id_estoque INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
endereco_id INT NOT NULL,
CONSTRAINT fk_endereco_estoque FOREIGN KEY (endereco_id)
	REFERENCES endereco (id_endereco)
);

CREATE TABLE produto_estoque (
produto_id INT NOT NULL,
estoque_id INT NOT NULL,
quantidade INT NOT NULL,
CONSTRAINT pk_produto_estoque PRIMARY KEY(produto_id, estoque_id),
CONSTRAINT fk_produto_estoque FOREIGN KEY (produto_id)
	REFERENCES produto (id_produto),
CONSTRAINT fk_estoque_produto FOREIGN KEY (estoque_id)
	REFERENCES estoque (id_estoque)
);

CREATE TABLE terceiro (
id_terceiro INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
cnpj CHAR(11) NOT NULL,
razao_social VARCHAR(45) NOT NULL,
contato VARCHAR(11) NOT NULL,
CONSTRAINT unique_cnpj_terceiro UNIQUE(cnpj)
);

CREATE TABLE pedido_produto (
produto_id INT NOT NULL,
pedido_id INT NOT NULL,
quantidade INT NOT NULL,
preco_unitario_aplicado DECIMAL(10,2) NOT NULL,
entrega_id INT NOT NULL,
terceiro_id INT NOT NULL,
estoque_id INT NULL,
CONSTRAINT pk_pedido_produto PRIMARY KEY(produto_id,pedido_id),
CONSTRAINT fk_entrega_pedido_produto FOREIGN KEY(entrega_id)
	REFERENCES entrega (id_entrega),
CONSTRAINT fk_terceiro_pedido_produto FOREIGN KEY(terceiro_id)
	REFERENCES terceiro (id_terceiro),
CONSTRAINT fk_estoque_pedido_produto FOREIGN KEY(estoque_id)
	REFERENCES estoque (id_estoque)
);

CREATE TABLE produto_vendedor (
produto_id INT NOT NULL,
vendedor_id INT NOT NULL,
quantidade INT NOT NULL,
status_produto_vendedor VARCHAR(45) NOT NULL,
CONSTRAINT pk_produto_vendedor PRIMARY KEY(produto_id, vendedor_id),
CONSTRAINT chk_status_produto_vendedor CHECK(status_produto_vendedor IN('Disponível','Em Falta')),
CONSTRAINT fk_produto_vendedor FOREIGN KEY (produto_id)
	REFERENCES produto (id_produto),
CONSTRAINT fk_vendedor_produto FOREIGN KEY (vendedor_id) 
	REFERENCES terceiro (id_terceiro)
);

CREATE TABLE produto_fornecedor (
produto_id INT NOT NULL,
fornecedor_id INT NOT NULL,
status_produto_fornecedor VARCHAR(45) NOT NULL,
CONSTRAINT pk_produto_fornecedor PRIMARY KEY(produto_id, fornecedor_id),
CONSTRAINT chk_status_produto_fornecedor CHECK(status_produto_fornecedor IN('Disponível','Em Falta')),
CONSTRAINT fk_produto_fornecedor FOREIGN KEY (produto_id)
	REFERENCES produto (id_produto),
CONSTRAINT fk_fornecedor_produto FOREIGN KEY (fornecedor_id) 
	REFERENCES terceiro (id_terceiro)
);