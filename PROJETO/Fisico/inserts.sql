exec cadastar_produto 1,'goiabinha',0
exec cadastar_produto 2,'suco de limao',0
exec cadastar_produto 3,'clube social',0
exec cadastar_produto 4,'suco de laranja',0

exec cadastrar_aux_montagem 1, 'Ellen', 'R luz e sombra,26', '11454788','A', '11:30', '16:30' 
exec montar_kit 'goiabinha','clube social','suco de limao', 6.00,2.70

exec cadastrar_cliente  2,'Lucas', 'R av,1', '5465','C', 11111, 2,3
exec cadastar_fornecedor 3,'Roberta', 'R av,3', '1000','F','emp2' 

 exec cadastrar_compra_2 'D',0.48,'10/10/2017',400,'13/10/2017','N','Roberta','goiabinha'
 exec cadastrar_compra_2 'C',1.50,'10/09/2017',400,'17/10/2017','N','Roberta','suco de limao'
 exec cadastrar_compra_2'X',1.50,'10/09/2017',400,'17/10/2017','N','Roberta','clube social'
 exec atualizar_entrega_compra '17/10/2017','suco de limao'
 exec atualizar_entrega_compra '17/10/2017','clube social'
 exec atualizar_entrega_compra '13/10/2017','goiabinha'
exec cadastrar_pedido  20, 400, 1500, 2
exec cadastrar_pedido  10, 100, 350, 2
exec cadastar_transportadora 1,'Carlos',50.00
exec cadastar_recibo 2,'21/10/2017','12:00',10,'Carlos'
exec cadastrar_compra_2 'C',0.69,'20/10/2017',500,'17/11/2017','N','Roberta','suco de laranja'

exec atualizar_entrega_compra '17/11/2017','suco de laranja'


exec cadastrar_caixa_kit_pedido 20,40,66350
select * from CAIXA_KIT
exec cadastar_pagamento 400,1,66350


select * from RELATORIO_DE_ESTOQUE
select * from RELATORIO_COMPRAS
select * from RELATORIO_PEDIDOS
select * from FOLHA_PAGAMENTO
select * from PRODUTOS_POR_KIT

delete from Compra
where codigo = ?

delete from CAIXA_KIT
where cod_pedido = 20

