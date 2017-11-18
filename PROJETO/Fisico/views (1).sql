/****** VIEWS DO BANCO DE DADOS KIT LANCHE ******/

use KIT_LANCHE_BD
-- Relatorio de compras

create view RELATORIO_COMPRAS
as
select c.codigo as 'Codigo da compra', valor as 'Valor da Compra Total',custo_produto, descricao as 'Produto',
 nome as 'Fornecedor', telefone as 'Contato', nome_empresa as 'Nome Empresa'
from COMPRA as c
inner join FORNECEDOR as f
on f.codigo = c.cod_fornecedor
inner join PESSOA as p
on f.codigo = p.codigo
inner join PRODUTO as pr
on pr.codigo = c.cod_produto




-- Relatorio de pedidos
create view RELATORIO_PEDIDOS
as
select n_pedido, valor, nome as 'cliente', r.codigo as  'n_recibo'
from PEDIDO as p
left outer  join RECIBO as r
on p.n_pedido = r.cod_pedido
inner join PESSOA as pe
on p.cod_cliente = pe.codigo


-- Produtos por tipo de kit
create view  PRODUTOS_POR_KIT
as
select distinct k.codigo as 'Tipo KIT',p.codigo as 'Codigo Produto',descricao, preco_venda,
 preco_bruto
from kIT_LANCHE as k
inner join ITEM_KIT as i
on i.tipo_kit = k.codigo
inner join PRODUTO as p
on i.cod_produto = p.codigo

-- Relatorio Estoque

create  view  RELATORIO_DE_ESTOQUE
as
select *
from PRODUTO


--Relatorio Folha pagamento

Create view  FOLHA_PAGAMENTO
as
select nome,hora_entrada,hora_saida, qtd_kit as 'qtd kit montada',qtd_kit * (preco_bruto *0.05) as 'pagamento'
from PESSOA as p
inner join AUX_MONTAGEM as a
on p.codigo = a.codigo
inner join MONTAGEM_KIT as m
on p.codigo = cod_aux
inner join KIT_LANCHE as k
on  k.codigo = m.tipo_kit