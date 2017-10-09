/*********** ÍNDICES DO BANCO DE DADOS KIT LANCHE ***********/

-- Indices da tabela Pedido

create index cli_code
on PEDIDO(cod_cliente)

-- Indices da tabela Nota fiscal

create index order_code
on NOTA_FISCAL(cod_pedido)

-- Indices da tabela Caixa Kit

create index t_kit_code
on CAIXA_KIT(tipo_kit)

create index c_order_code
on CAIXA_KIT(cod_pedido)


-- Indices da tabela Recibo

create  index r_order
on RECIBO(cod_pedido)

create  index r_shipping_code
on RECIBO(cod_transportadora)

-- Indices da tabela Compra

create  index c_product
on COMPRA(cod_Produto)

create  index c_supplier
on COMPRA(cod_fornecedor)

-- Indices da tabela Montagem Kit

create index m_t_kit_code
on MONTAGEM_KIT(tipo_kit)

create  index c_supplier
on MONTAGEM_KIT(cod_aux)