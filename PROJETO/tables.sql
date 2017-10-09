/** Tabelas do banco de dados KIT_LANCHE_BD **/


/****************************************** ENTIDADES ******************************************/

-- Tabela Pedido

create table PEDIDO (
	n_pedido code,
	qtd_kit quantity,
	valor value,
	cod_cliente code,
	primary key (n_pedido),
	foreign key (cod_cliente) references CLIENTE
)

-- Tabela Nota Fiscal

create table NOTA_FISCAL (
	n_nota code,
	solicitante name,
	GED name,
	n_folha_servico small_quantity not null,
	cod_pedido code,
	primary key (n_nota),
	foreign key (cod_pedido) references PEDIDO
)

-- Tabela Transportadora

create table TRANSPORTADORA(
	codigo code,
	nome_motorista name,
	frete value,
	primary key (codigo)
)
 
-- Tabela Kit Lanche

create table KIT_LANCHE (
	codigo code,
	preco_venda value,
	primary key (codigo),
)

-- Tabela  Caixa Kit Lanche

create table CAIXA_KIT (
	codigo code,
	volume quantity,
	tipo_kit code,
	cod_pedido code,
	primary key (codigo),
	foreign key (tipo_kit) references KIT_LANCHE,
	foreign key (cod_pedido) references PEDIDO
)

-- Tabela  Produto

create table PRODUTO (
	codigo code,
	descricao description,
	qtd_estoque quantity,
	primary key (codigo)
)

-- Tabela  Pessoa

create table PESSOA (
	codigo code,
	nome name,
	endereco adress,
	telefone tel,
	tipo type, -- tipo A (Aux de montagem) , C (Cliente), F ( Fornecedor)
	primary key (codigo)
)

--Tabela Cliente 

create table CLIENTE (
	codigo code,
	cnpj doc_type,
	inscr_municipal doc_type,
	inscr_estadual doc_type,
	primary key (codigo),
	unique (cnpj),
	foreign key (codigo) references PESSOA
)

--Tabela Aux Montagem 

create table AUX_MONTAGEM (
	codigo code,
	hora_saida time,
	hora_entrada time,
	primary key (codigo),
	foreign key (codigo) references PESSOA
)


-- Tabela  Fornecedor

create table FORNECEDOR (
	codigo code,
	nome_empresa name,
	primary key (codigo),
	foreign key (codigo) references PESSOA
)

/****************************************** AGREGAÇÕES ******************************************/

-- Tabela Recibo 
 create table RECIBO(
	codigo code,
	data date,
	hora time,
	cod_pedido code,
	cod_transportadora code,
	primary key (codigo), 
	foreign key (cod_pedido) references PEDIDO,
	foreign key (cod_transportadora) references TRANSPORTADORA 
 )

-- tabela Compra 

 create table COMPRA(
	codigo code,
	valor  value,
	forma_pagamento type, -- tipo D (dinheiro), C (cartao),  X (cheque)
	custo_produto value,
	data  date,
	quantidade quantity,
	prazo_entrega date,
	entregue type default 'N', -- tipo N (não entregue), S (entregue)
	cod_fornecedor code,
	cod_produto code, 
	primary key (codigo), 
	foreign key (cod_fornecedor) references FORNECEDOR,
	foreign key (cod_produto) references PRODUTO 
 )
 
/****************************************** RELACIONAMENTOS N-M******************************************/
--Tabela relacionament entre kit e produto
 create table ITEM_KIT(
	tipo_kit code,
	cod_produto code,
	primary key (tipo_kit, cod_produto),
	foreign key (tipo_kit) references KIT_LANCHE,
	foreign key (cod_produto) references PRODUTO 
 )
--Tabela relacionament entre kit e aux_montagem
 create table MONTAGEM_KIT(
	pagamento value,
	qtd_kit small_quantity,
	cod_aux code,
	tipo_kit code,
	foreign key (tipo_kit) references KIT_LANCHE,
	foreign key (cod_aux) references AUX_MONTAGEM 
 )

