/** Procedures de dados KIT_LANCHE_BD **/
use KIT_LANCHE_BD
/****************************************** CADASTRO ***************************************** */

--Cadastrar Pessoa
create proc cadastrar_pessoa
@codigo code,
@nome name,
@endereco adress,
@telefone tel,
@tipo type
as
insert PESSOA
values (@codigo,@nome,@endereco,@telefone,@tipo)
return @@ROWCOUNT

-- Cadastrar Cliente
create proc cadastrar_cliente
@codigo code,
@nome name,
@endereco adress,
@telefone tel,
@tipo type,
@cnpj doc_type,
@inscr_municipal doc_type,
@inscr_estadual doc_type
as
begin transaction
declare @retorno int
    exec @retorno =  cadastrar_pessoa @codigo,@nome,@endereco,@telefone,@tipo
if @retorno >0
	begin
	insert CLIENTE
	values (@codigo,@cnpj,@inscr_municipal ,@inscr_estadual)
	if @@ROWCOUNT > 0
		begin
		commit transaction
		return  0
		end
	else
		begin
		rollback transaction
		return 1
		end
	end
else
	begin
	rollback transaction
	return 1
	end


--cadastrar Aux_Montagem

create proc cadastrar_aux_montagem
@codigo code,
@nome name,
@endereco adress,
@telefone tel,
@tipo type,
@hora_saida time,
@hora_entrada time
as
begin transaction
exec cadastrar_pessoa @codigo,@nome,@endereco,@telefone,@tipo
if @@ROWCOUNT = 1
	begin
	insert AUX_MONTAGEM
	values (@codigo,@hora_saida,@hora_entrada)
	if @@ROWCOUNT = 1
		begin
		commit transaction
		return 1
		end
	else
		begin
		rollback transaction
		return  0
		end
	end
else
	begin
	rollback transaction
	return  0
	end


--cadastrar Fornecedor

create proc cadastrar_fornecedor
@codigo code,
@nome name,
@endereco adress,
@telefone tel,
@tipo type,
@nome_empresa name
as
begin transaction
declare @retorno int
exec  @retorno =  cadastrar_pessoa @codigo,@nome,@endereco,@telefone,@tipo
if @retorno >0
	begin
	insert FORNECEDOR
	values (@codigo,@nome_empresa)
	if @@ROWCOUNT > 0
		begin
		commit transaction
		return  @@ROWCOUNT
		end
	else
		begin
		rollback transaction
		return  @@ROWCOUNT
		end
	end
else
	begin
	rollback transaction
	return  @@ROWCOUNT
	end


--Cadastrar Pedido

create proc cadastrar_pedido
@n_pedido code,
@qtd_kit quantity,
@valor value,
@cnpj code
as
insert PEDIDO
values(@n_pedido,@qtd_kit,@valor,@cnpj)

--Cadastrar NF

create proc cadastrar_nota_fiscal
@n_nota code,
@solicitante name,
@GED name,
@n_folha_servico small_quantity,
@cod_pedido code
as
insert NOTA_FISCAL
values(@n_nota,@solicitante,@GED,@n_folha_servico,@cod_pedido)


-- Buscar transportadora

create procedure buscar_transportadora
@nome_entregador name,
@codigo code output
as
select @codigo = codigo
from TRANSPORTADORA
where nome_motorista like '%' + @nome_entregador + '%'

--Cadastrar Caixa_transportadora

create proc cadastrar_transportadora
@codigo code,
@nome_motorista name,
@frete value
as
insert TRANSPORTADORA
values(@codigo,@nome_motorista,@frete)




--Cadastrar Recibo

create proc cadastrar_recibo
@codigo code,
@data date,
@hora time,
@cod_pedido code,
@nome_entregador name
as
declare @cod_transportadora code
exec buscar_transportadora @nome_entregador, @cod_transportadora output
insert RECIBO
values (@codigo,@data,@hora,@cod_pedido,@cod_transportadora)


create proc random_number
@codigo code OUTPUT
as
DECLARE @Random INT;

DECLARE @Upper INT;

DECLARE @Lower INT

---- This will create a random number between 1 and 999

SET @Lower = 1 ---- The lowest random number

SET @Upper = 99999 ---- The highest random number

SELECT @Random = ROUND(((@Upper - @Lower -1) * RAND() + @Lower), 0)

SELECT @codigo =  @Random


--cadastrar caixa_kit_pedido

create proc cadastrar_caixa_kit_pedido
@codigo_pedido code,
@volume_caixa quantity,
@tipo_kit code
as
declare @code code = @codigo_pedido
declare @qtd_caixa quantity =  ((select qtd_kit
									from PEDIDO
									where n_pedido = @code)/ @volume_caixa)
declare @codigo numeric(6,0)
declare @i  int
set @i = 0
begin try
begin transaction
while (@i  < @qtd_caixa)
begin
	exec random_number  @codigo output
	insert CAIXA_KIT
	values(@codigo,@volume_caixa,@tipo_kit,@codigo_pedido)
	set @i = @i + 1
	if @@ROWCOUNT = 0
		rollback transaction
		end
	if @i = @qtd_caixa
		commit transaction
end try
begin catch
	  SELECT
        ERROR_NUMBER() AS ErrorNumber,
        ERROR_SEVERITY() AS ErrorSeverity,
        ERROR_STATE() AS ErrorState,
        ERROR_PROCEDURE() AS ErrorProcedure,
        ERROR_LINE() AS ErrorLine,
        ERROR_MESSAGE() AS ErrorMessage
end catch;




-- Cadastrar Produto

create proc cadastrar_produto
@codigo code,
@descricao description,
@qtd_estoque quantity
as
insert PRODUTO
values(@codigo,@descricao ,@qtd_estoque)



-- Cadastrar Compra

create proc cadastrar_compra
@codigo code,
@valor  value,
@forma_pagamento type,
@custo_produto value,
@data  char(15),
@quantidade quantity,
@prazo_entrega char(15),
@entregue type,
@cod_fornecedor code,
@cod_produto code
as
insert COMPRA
values(@codigo,@valor,@forma_pagamento,@custo_produto,@data,
@quantidade,@prazo_entrega,@entregue,
@cod_fornecedor,@cod_produto)


create procedure buscar_produto
@descricao name,
@codigo code output
as
select @codigo = codigo
from PRODUTO
where descricao like '%' + @descricao + '%'

create proc montar_kit
@desc_produto_1 name,
@desc_produto_2 name,
@desc_produto_3 name,
@preco_venda value,
@preco_bruto value
as
declare @cod_1 code
declare @cod_2 code
declare @cod_3 code
exec buscar_produto  @desc_produto_1, @cod_1 OUTPUT
exec buscar_produto  @desc_produto_2, @cod_2 OUTPUT
exec buscar_produto  @desc_produto_3, @cod_3 OUTPUT
declare @codigo code
exec random_number @codigo OUTPUT
begin try
	begin transaction
	insert KIT_LANCHE
	values(@codigo,@preco_venda,@preco_bruto)
	insert ITEM_KIT
	values (@codigo,@cod_1)
	insert ITEM_KIT
	values (@codigo,@cod_2)
	insert ITEM_KIT
	values (@codigo,@cod_3)
	if @@ROWCOUNT>0
	commit transaction
	else
	rollback transaction
end try
begin catch
	  SELECT
        ERROR_NUMBER() AS ErrorNumber,
        ERROR_SEVERITY() AS ErrorSeverity,
        ERROR_STATE() AS ErrorState,
        ERROR_PROCEDURE() AS ErrorProcedure,
		 ERROR_LINE() AS ErrorLine,
        ERROR_MESSAGE() AS ErrorMessage
end catch;



-- Cadastrar pagamento_func

create proc cadastrar_pagamento
@qtd_kit small_quantity,
@cod_aux code,
@tipo_kit code
as
insert MONTAGEM_KIT
values(@qtd_kit,@cod_aux,@tipo_kit)


--Atualizar entrega

create proc atualizar_entrega_compra
@data_entrega char(15),
@nome_produto name
as 
declare @cod_prod code
exec buscar_produto @nome_produto, @cod_prod OUTPUT
update COMPRA
set entregue = 'S'
where cod_produto = @cod_prod and prazo_entrega = @data_entrega


create proc buscar_fornecedor
@nome name,
@codigo code output
as
select @codigo = codigo
from PESSOA
where nome like '%' + @nome + '%' and tipo = 'F'

create proc cadastrar_compra_2
@forma_pg type,
@custo_prod value,
@data date,
@qtd quantity,
@prazo date,
@entregue type,
@nome_fornecedor name,
@nome_produto name
as
begin try
declare @codigo code 
declare @cod_prod code
declare @cod_fornecedor code
declare @valor value  = @custo_prod * @qtd
exec random_number @codigo OUTPUT
exec buscar_fornecedor @nome_fornecedor,@cod_fornecedor OUTPUT
exec buscar_produto @nome_produto, @cod_prod OUTPUT
exec cadastrar_compra @codigo,@valor,@forma_pg,@custo_prod,@data,@qtd,@prazo,@entregue,@cod_fornecedor,@cod_prod
end try
begin catch
	  SELECT
        ERROR_NUMBER() AS ErrorNumber,
        ERROR_SEVERITY() AS ErrorSeverity,
        ERROR_STATE() AS ErrorState,
        ERROR_PROCEDURE() AS ErrorProcedure,
		 ERROR_LINE() AS ErrorLine,
        ERROR_MESSAGE() AS ErrorMessage
end catch;

