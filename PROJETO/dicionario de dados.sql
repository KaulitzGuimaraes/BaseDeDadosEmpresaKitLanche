/** Dicionario de dados do banco de dados KIT_LANCHE_BD **/

-- Tipo padrao para codigo
sp_addtype code,'numeric(6,0)', NONULL

-- Tipo padrao para nome
sp_addtype name,'varchar(35)', NONULL


-- Tipo padrao para endererco
sp_addtype adress,'varchar(300)', NULL

-- Tipo padrao para valor monetario
sp_addtype value,'money', NULL

-- Tipo padrao para grandes quantidades

sp_addtype quantity,'numeric (10,0)', NULL

-- Tipo padrao para descricao
sp_addtype description,'varchar(80)', NONULL

-- Tipo padrao para telefone
sp_addtype tel,'numeric(10,0)', NULL

-- Tipo padrao para tipos restritivos
sp_addtype type,'char(1)', NONULL

-- Tipo padrao para CNPJ
sp_addtype doc_type,'numeric(20,0)', NONULL


-- Tipo padrao para pequenas quantidades

sp_addtype small_quantity,'int', NULL


