/** Triggers de dados KIT_LANCHE_BD **/
use KIT_LANCHE_BD

-- Atualizar Produto

create trigger autalizar_qtd_produto
	on  COMPRA
	for update 
		as
		if update (entregue)
		begin
		update  PRODUTO
		set qtd_estoque = qtd_estoque + ( select quantidade
										from inserted)
		where codigo = (select cod_produto
							from inserted)
	 if @@ROWCOUNT = 0
		rollback transaction
		end
create trigger autalizar_qtd_produto_1
	on  COMPRA
	for delete
		as
		update  PRODUTO
		set qtd_estoque = qtd_estoque - ( select quantidade
										from deleted)
		where codigo = (select cod_produto
							from deleted)
	 if @@ROWCOUNT = 0
		rollback transaction


 create trigger autalizar_qtd_produto_3
	on  CAIXA_KIT
	for insert
		as
		update  PRODUTO
		set qtd_estoque = qtd_estoque - ( select volume
										from inserted)
		where codigo in (select it.cod_produto
							from inserted
							inner join KIT_LANCHE as k
							on tipo_kit = k.codigo
							inner join ITEM_KIT as it
							on it.tipo_kit = k.codigo)
	 if @@ROWCOUNT = 0
		rollback transaction

create trigger autalizar_qtd_produto_4
	on  CAIXA_KIT
	for delete
		as
		update  PRODUTO
		set qtd_estoque = qtd_estoque + ( select  sum(volume)
										from deleted)

		where codigo in (select it.cod_produto
							from deleted
							inner join KIT_LANCHE as k
							on tipo_kit = k.codigo
							inner join ITEM_KIT as it
							on it.tipo_kit = k.codigo)
	 if @@ROWCOUNT = 0
		rollback transaction

create trigger autalizar_qtd_produto_5
	on  CAIXA_KIT
	for update
		as
		if update(volume)
		begin
		update  PRODUTO
		set qtd_estoque = qtd_estoque + ( select  sum(i.volume) - sum(d.volume)
										  from deleted as d inner join inserted as i
										  on d.codigo = i.codigo)

		where codigo in (select it.cod_produto
							from inserted
							inner join KIT_LANCHE as k
							on tipo_kit = k.codigo
							inner join ITEM_KIT as it
							on it.tipo_kit = k.codigo)
		end
	 if @@ROWCOUNT = 0
		rollback transaction
