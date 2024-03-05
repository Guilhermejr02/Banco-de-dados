/*
CREATE TABLE OFICINA(
ID INT PRIMARY KEY IDENTITY(1,1),
NOME VARCHAR(30)
)
DELETE FROM TESTE
INSERT INTO TESTE VALUES('TESTE3')
SET IDENTITY_INSERT Ordem_Servico ON
*/

--CONSULTA POR QUANTIDDE DO PRODUTO
SELECT ID_Produto,Nome_Produto,Valor_Produto,Quantidade_Produto
FROM Produto 
WHERE Quantidade_Produto > 50

--CONSULTA POR NOME DO PRODUTO
SELECT ID_Produto,Nome_Produto,Valor_Produto,Quantidade_Produto
FROM Produto 
WHERE Nome_Produto LIKE '%L'

--VIEW DE PRODUTOS
CREATE VIEW PRODUTO_GERAL AS
SELECT*FROM PRODUTO_GERAL

--PROCEDURE DE CADASTRAR PRODUTOS
CREATE PROCEDURE SP_CADASTRO_PRODUTO_SP
@Nome_Produto_X VARCHAR(40),
@Valor_Produto_X MONEY,
@Quantidade_Produto_X INT
AS
BEGIN
INSERT INTO Produto(Nome_Produto,Valor_Produto,Quantidade_Produto)
VALUES(@Nome_Produto_X,@Valor_Produto_X,@Quantidade_Produto_X)
END

EXEC SP_CADASTRO_PRODUTO_SP 'Óleo De Motor',54,32

--PROCEDURE DE EXCLUIR PRODUTOS
CREATE PROCEDURE SP_EXCLUSÃO_PRODUTO_SP
@ID_PRODUTO_X INT
AS
BEGIN
DELETE FROM Produto 
WHERE ID_Produto = @ID_PRODUTO_X
END

EXEC SP_EXCLUSÃO_PRODUTO_SP 22

--TRIGER DE ATUALIZAR ESTOQUE
--DROP TRIGER ATUALIZAR_ESTOQUE
CREATE TRIGGER ATUALIZAR_ESTOQUE
ON Venda_Produto
AFTER INSERT
AS BEGIN
	SET NOCOUNT ON
UPDATE Produto
SET Quantidade_Produto = P.Quantidade_Produto - I.Quantidade_Produto
FROM Produto P
INNER JOIN inserted i ON P.ID_Produto = I.COD_Produto
END



--CONSULTA POR DATA DO SERVIÇO
SELECT C.Nome,OS.Hora_Entrada,A.ID_Automovel,A.Modelo,S.Nome_Servico,P.Nome_Produto,POS.Valor_Servico,POS.Valor_Produto_Unitario,OS.Valor_Total
FROM Produto_OrdemServico_Servico POS
INNER JOIN Ordem_Servico OS ON OS.ID_Ordem_Servico = POS.COD_Ordem_Servico 
INNER JOIN Cliente C ON C.ID_Cliente = OS.COD_Cliente
INNER JOIN Servico S ON S.ID_Servico = POS.COD_Servico
INNER JOIN Automovel A ON A.ID_Automovel = OS.COD_Automovel
LEFT JOIN Produto P ON P.ID_Produto= POS.COD_Produto
WHERE OS.Hora_Entrada = '2023-04-24'

--CONSULTA POR ID DO CLIENTE
SELECT C.Nome,OS.Hora_Entrada,A.ID_Automovel,A.Modelo,S.Nome_Servico,P.Nome_Produto,POS.Valor_Servico,POS.Valor_Produto_Unitario,OS.Valor_Total
FROM Produto_OrdemServico_Servico POS
INNER JOIN Ordem_Servico OS ON OS.ID_Ordem_Servico = POS.COD_Ordem_Servico 
INNER JOIN Cliente C ON C.ID_Cliente = OS.COD_Cliente
INNER JOIN Servico S ON S.ID_Servico = POS.COD_Servico
INNER JOIN Automovel A ON A.ID_Automovel = OS.COD_Automovel
INNER JOIN Produto P ON P.ID_Produto = POS.COD_Produto
WHERE C.ID_Cliente = 2

--CONSULTA POR NÚMERO DO SERVIÇO
SELECT C.Nome,OS.Hora_Entrada,A.ID_Automovel,A.Modelo,S.Nome_Servico,P.Nome_Produto,POS.Valor_Servico,POS.Valor_Produto_Unitario,OS.Valor_Total
FROM Produto_OrdemServico_Servico POS
INNER JOIN Ordem_Servico OS ON OS.ID_Ordem_Servico = POS.COD_Ordem_Servico 
INNER JOIN Cliente C ON C.ID_Cliente = OS.COD_Cliente
INNER JOIN Servico S ON S.ID_Servico = POS.COD_Servico
INNER JOIN Automovel A ON A.ID_Automovel = OS.COD_Automovel
INNER JOIN Produto P ON P.ID_Produto= POS.COD_Produto
WHERE S.ID_Servico = 1

--TRIGGER DE ATUALIZAR SERVICO
--DROP TRIGGER ATUALIZAR_SERVICO
CREATE TRIGGER ATUALIZAR_SERVICO
ON Produto_OrdemServico_Servico
AFTER INSERT
AS BEGIN
	SET NOCOUNT ON
UPDATE Ordem_Servico
SET Valor_Total_Produto = OS.Valor_Total_Produto+ I.Valor_Total_Produto
FROM Ordem_Servico OS
INNER JOIN inserted i ON OS.ID_Ordem_Servico = I.COD_Ordem_Servico
UPDATE Ordem_Servico
SET Valor_Total_Servico = Valor_Total_Servico + (I.Horas_Gastas * I.Valor_Servico)
FROM Ordem_Servico OS
INNER JOIN inserted i ON OS.ID_Ordem_Servico = I.COD_Ordem_Servico
UPDATE Ordem_Servico
SET Valor_Total = OS.Valor_Total + I.Valor_Servico + I.Valor_Total_Produto
FROM Ordem_Servico OS
INNER JOIN inserted i ON OS.ID_Ordem_Servico = I.COD_Ordem_Servico
END



CREATE TRIGGER ATUALIZAR_PRODUTO_SERVICO
ON Produto_OrdemServico_Servico
AFTER INSERT
AS BEGIN
	SET NOCOUNT ON
UPDATE Produto
SET Quantidade_Produto = P.Quantidade_Produto - I.Quantidade_Produto
FROM Produto P
INNER JOIN inserted i ON P.ID_Produto = I.COD_Produto
END



--CONSULTA DE VENDA POR NOME DO CLIENTE
SELECT C.Nome,V.Data_Venda,VP.Nome_Produto,VP.Quantidade_Produto,VP.Valor_Produto_Unitario,VP.Valor_Total
FROM Venda V
INNER JOIN Cliente C ON C.ID_Cliente = V.COD_Cliente
INNER JOIN Venda_Produto VP ON V.ID_Venda = VP.COD_Venda
WHERE C.Nome LIKE '%N'

--CONSULTA POR NÚMERO DA VENDA
SELECT C.Nome,V.Data_Venda,VP.Nome_Produto,VP.Quantidade_Produto,VP.Valor_Produto_Unitario,VP.Valor_Total
FROM Venda V
INNER JOIN Cliente C ON C.ID_Cliente = V.COD_Cliente
INNER JOIN Venda_Produto VP ON V.ID_Venda = VP.COD_Venda
WHERE V.ID_Venda = 2

--CONSULTA POR DATA DA VENDA
SELECT C.Nome,V.Data_Venda,VP.Nome_Produto,VP.Quantidade_Produto,VP.Valor_Produto_Unitario,VP.Valor_Total
FROM Venda V
INNER JOIN Cliente C ON C.ID_Cliente = V.COD_Cliente
INNER JOIN Venda_Produto VP ON V.ID_Venda = VP.COD_Venda
WHERE V.Data_Venda = '2023-04-24'

--TRIGGER DE VENDAS
--DROP TRIGGER ATUALIZAR_VENDA
CREATE TRIGGER ATUALIZAR_VENDA
ON Venda_Produto
AFTER INSERT
AS BEGIN
	SET NOCOUNT ON
UPDATE Venda
SET Valor_Venda = V.Valor_Venda + I.Valor_Total
FROM Venda V
INNER JOIN inserted i ON V.ID_Venda = I.COD_Venda
END