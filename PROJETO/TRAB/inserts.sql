exec cadastar_produto 1,'goiabinha',0
exec cadastar_produto 2,'suco de limao',0
exec cadastar_produto 3,'clube social',0
exec cadastar_produto 4,'suco de laranja',0

exec cadastrar_aux_montagem 1, 'Ellen', 'R luz e sombra,26', '11454788','A', '11:30', '16:30' 

exec montar_kit 'goiabinha','clube social','suco de limao', 6.00,2.70

exec cadastrar_cliente  2,'Lucas', 'R av,1', '5465','C', 11111, 2,3
exec cadastrar_pedido  20, 400, 2000, 2
	
 select *  from  KIT_lanche
 declare @desc_produto_1 name = 'goiabinha' 
 declare  @cod_1 int 
  exec buscar_produto  @desc_produto_1, @cod_1 OUTPUT
 print @cod_1
 exec cadastrar_caixa_kit_pedido 20,40,61432
select * from CAIXA_KIT

select * from produto
update produto
set qtd_estoque = 500
delete from CAIXA_KIT 

sp_help cadastrar_caixa_kit_pedido 

