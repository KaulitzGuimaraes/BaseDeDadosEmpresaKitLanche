/****** VIEWS DO BANCO DE DADOS KIT LANCHE ******/


-- Relatorio de compras não entregues

create view RELATORIO_COMPRAS_A_SEREM_ENTREGUES 
as
select valor, forma_pagamento, custo_produto, quantidade, data,f.nome_empresa, p.nome as 'nome Representante' , p.telefone, pr.descricao as 'produto'
from COMPRA as c
inner join FORNECEDOR as f
on f.codigo = c.cod_fornecedor
inner join PESSOA as p
on f.codigo = p.codigo
inner join PRODUTO as pr
on pr.codigo = c.cod_produto
where entregue = 'N'

-- Relatorio de compras não entregues

create view RELATORIO_PEDIDOS_A_SEREM_ENTREGUES 
as
select n_pedido, valor, nome as 'cliente'
from PEDIDO as p
left outer  join RECIBO as r
on p.n_pedido = r.cod_pedido
inner join CLIENTE as c
on c.codigo = p.cod_cliente
inner join PESSOA as pe
on c.codigo = pe.codigo
