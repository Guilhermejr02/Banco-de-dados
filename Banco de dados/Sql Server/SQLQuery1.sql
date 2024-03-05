DROP DATABASE OFICINA
GO
CREATE DATABASE OFICINA
GO
USE OFICINA
GO

CREATE TABLE Cliente (
    ID_Cliente INT PRIMARY KEY IDENTITY(1,1),
    Nome VARCHAR (100),
    Telefone CHAR (14),
    Cpf VARCHAR (40) UNIQUE,
    Endereco VARCHAR (200)
)
GO

CREATE TABLE Automovel (
    ID_Automovel INT PRIMARY KEY IDENTITY(1,1),
    Cor VARCHAR (40),
    Ano VARCHAR (40),
    Placa VARCHAR (8) UNIQUE,
    Marca VARCHAR (40),
    Data_Cadastro DATE,
	Modelo VARCHAR(60)
)
GO

CREATE TABLE Ordem_Servico (
    ID_Ordem_Servico INT PRIMARY KEY IDENTITY(1,1),
    COD_Cliente INT,
    COD_Automovel INT,
    COD_Vendedor INT,
    Hora_Entrada DATE,
    Hora_Saida DATE,
    Estatus BINARY,
    Valor_Total_Produto MONEY,
    Valor_Total_Servico MONEY,
    Valor_Total MONEY
)
GO

CREATE TABLE Produto (
    ID_Produto INT PRIMARY KEY IDENTITY(1,1),
    Nome_Produto VARCHAR (40),
    Valor_Produto MONEY,
    Quantidade_Produto INT
)
GO

CREATE TABLE Venda_Produto (
    COD_Produto INT,
    COD_Venda INT,
    Nome_Produto VARCHAR  (40),
    Valor_Produto_Unitario MONEY,
    Quantidade_Produto INT,
    Valor_Total MONEY
)
GO

CREATE TABLE Produto_OrdemServico_Servico (
    COD_Ordem_Servico INT,
    COD_Servico INT,
    COD_Produto INT,
    COD_Especialista INT,
	Horas_Gastas INT,
    Valor_Servico MONEY,
    Quantidade_Produto INT,
    Valor_Produto_Unitario MONEY,
    Valor_Total_Produto MONEY
)
GO

CREATE TABLE Servico (
	ID_Servico INT PRIMARY KEY IDENTITY(1,1),
    Nome_Servico VARCHAR (40),
    Valor_Hora MONEY,
    Descricao_Servico VARCHAR (200)
)
GO

CREATE TABLE Venda (
    ID_Venda INT PRIMARY KEY IDENTITY(1,1),
    COD_Cliente INT,
	COD_Vendedor INT,
    Data_Venda DATE,
    Valor_Venda MONEY
)
GO

CREATE TABLE Vendedor (
    ID_Vendedor INT PRIMARY KEY IDENTITY(1,1),
    Nome VARCHAR (40),
    Cpf VARCHAR (40) UNIQUE,
    Telefone CHAR (14),
    Endereco VARCHAR (200)
)
GO

CREATE TABLE Especialista (
    ID_Especialista INT PRIMARY KEY IDENTITY(1,1),
    Profisao VARCHAR (40),
    Nome VARCHAR (100),
    Cpf VARCHAR (40) UNIQUE,
    Telefone CHAR (14),
    Endereco VARCHAR (200)
)
GO

ALTER TABLE Ordem_Servico ADD CONSTRAINT FK_Ordem_Servico_Automovel
    FOREIGN KEY (COD_Automovel)REFERENCES Automovel (ID_Automovel)
GO
 
ALTER TABLE Ordem_Servico ADD CONSTRAINT FK_Ordem_Servico_Cliente
    FOREIGN KEY (COD_Cliente)REFERENCES Cliente (ID_Cliente)
GO
 
ALTER TABLE Ordem_Servico ADD CONSTRAINT FK_Ordem_Servico_Vendedor
    FOREIGN KEY (COD_Vendedor)REFERENCES Vendedor (ID_Vendedor)
GO

 ALTER TABLE Venda ADD CONSTRAINT FK_Venda_Cliente
    FOREIGN KEY (COD_Cliente)REFERENCES Cliente(ID_Cliente)
GO

ALTER TABLE Venda ADD CONSTRAINT FK_Venda_Vendedor
    FOREIGN KEY (COD_Vendedor)REFERENCES Vendedor(ID_Vendedor)
GO

ALTER TABLE Venda_Produto ADD CONSTRAINT FK_Venda_Produto_Venda
    FOREIGN KEY (COD_Venda)REFERENCES Venda(ID_Venda)
GO

ALTER TABLE Venda_Produto ADD CONSTRAINT FK_Venda_Produto_Produto
    FOREIGN KEY (COD_Produto)REFERENCES Produto(ID_Produto)
GO

ALTER TABLE Produto_OrdemServico_Servico ADD CONSTRAINT FK_Produto_OrdemServico_Servico_Produto
    FOREIGN KEY (COD_Produto)REFERENCES Produto(ID_Produto)
GO

ALTER TABLE Produto_OrdemServico_Servico ADD CONSTRAINT FK_Produto_OrdemServico_Servico_Ordem_Servico
    FOREIGN KEY (COD_Ordem_Servico)REFERENCES Ordem_Servico(ID_Ordem_Servico)
GO

ALTER TABLE Produto_OrdemServico_Servico ADD CONSTRAINT FK_Produto_OrdemServico_Servico_Servico
    FOREIGN KEY (COD_Servico)REFERENCES Servico(ID_Servico)
GO

ALTER TABLE Produto_OrdemServico_Servico ADD CONSTRAINT FK_Produto_OrdemServico_Servico_Especialista
    FOREIGN KEY (COD_Especialista)REFERENCES Especialista(ID_Especialista)
GO

--TABELA CLIENTE--
INSERT INTO Cliente VALUES('Genivon','(63)99124-9261','066.418.072 - 01','Rua B, Lote 31, Quadra 18, Jardim Dos Ipês'),
('Erisvaldo','(63)99124-9262','066.418.072 - 02','Rua F, Lote 27, Quadra 02, Costa Esmeralda'),
('Rodolfo','(63)99124-9263','066.418.072 - 03','Rua T, Lote 28, Quadra 03, Ceú Azul'),
('Bruno','(63)99124-9264','066.418.072 - 04','Rua P, Lote 29, Quadra 04, Bairro São João'),
('Lucas','(63)99124-9265','066.418.072 - 05','Rua A, Lote 30, Quadra 05, Senador')

SELECT*FROM Cliente

--TABELA ESPECIALISTA--
INSERT INTO Especialista VALUES('Eletrisista','Alex','941.456.176 - 01','(63)99124-9261','Rua A, Lote 31, Quadra 18, Setor Senador'),
('Mecânico','Vitor','941.456.176 - 02','(63)99124-9262','Rua B, Lote 32, Vila Azul'),
('Lanterneiro','Gabriel','066.418.072 - 03','(63)99124-9263','Rua C, Lote 28, Quadra 03, Ceú Azul'),
('Capoteiro','Vicente','066.418.072 - 04','(63)99124-9264','Rua D, Lote 29, Quadra 04, Setor Cimba'),
('Funileiro','José','066.418.072 - 05','(63)99124-9265','Rua E, Lote 30, Quadra 05, Jardim Das Flores'),
('Vidraceiro','Vanderlei','066.418.072 - 06','(63)99124-9266','Rua F, Lote 33, Quadra 06, Jardim Das Flores')

SELECT * FROM Especialista

--TABELA PRODUTO--
INSERT INTO Produto VALUES('Bateria',2000,20),
('Pneu',250,20),
('Lâmpada de teste',25,15),
('Furadeira',80,18),
('Compressor de ar',100,22),
('Freios',110,40),
('Motor',15000,35),
('Espelhos retrovisores',40,60),
('Para-choque dianteiro',200,40),
('Para-choque traseiro',200,40),
('Para-choque Lateral',200,40),
('Lata de Tinta epóxi',150,50),
('Lata de Tinta acrílica',159.90,50),
('Lata de Tinta Metálica',169.97,50),
('Airbags',257.88,37),
('Volante',140,58),
('Conjunto de Cintos de segurança',70,90),
('Para-brisa',80,66),
('Jogo De Tapetes',60,22),
('Vidro Dianteiro',300,20),
('Vidro Traseiro',300,22),
('Vidro Láteral',200,32)

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

SELECT*FROM Produto

--TABELA AUTOMOVEL--
INSERT INTO Automovel VALUES('Prata','2000','Rwo7653','Ford',GETDATE(),'Mustang'),
('Branco','2015','Tyr3455','Toyota',GETDATE(),'Corola'),
('Preto','2022','Bnu8905','Bmw',GETDATE(),'M3'),
('Vermelho','1999','Bph9971','Nissan',GETDATE(),'Gtr'),
('Vermelho','2021','Jwh6789','Jeep',GETDATE(),'Compass')

SELECT*FROM Automovel

--TABELA VENDEDOR--
INSERT INTO Vendedor VALUES('Gustavo','098.765.724 - 20','(63)99210-2601','Rua A, Lote 31, Quadra 18, Setor Senador'),
('Fernando','098.765.724 - 21','(63)99210-2602','Rua M, Lote 35, Quadra 02, Setor Maracanã'),
('Dione','098.765.724 - 22','(63)99210-2603','Rua T, Lote 36, Quadra 06, Bairro São João')

SELECT*FROM Vendedor

--TABELA SERVICO--
INSERT INTO Servico VALUES('Troca De Pneu',70,'Pneus Dianteiros Furados'),
('Troca De Para-brisa',50,'Para-brisas quebrados'),
('Revisão De Freios',20,'Freios com um possivel defeito')
SELECT*FROM Servico

--CONSULTA POR DATA DO SERVIÇO
SELECT C.Nome,OS.Hora_Entrada,A.ID_Automovel,A.Modelo,S.Nome_Servico,P.Nome_Produto ,POS.Valor_Servico,POS.Valor_Produto_Unitario,OS.Valor_Total
FROM Produto_OrdemServico_Servico POS
INNER JOIN Ordem_Servico OS ON OS.ID_Ordem_Servico = POS.COD_Ordem_Servico 
INNER JOIN Cliente C ON C.ID_Cliente = OS.COD_Cliente
INNER JOIN Servico S ON S.ID_Servico = POS.COD_Servico
INNER JOIN Automovel A ON A.ID_Automovel = OS.COD_Automovel
LEFT JOIN Produto P ON P.ID_Produto = POS.COD_Produto
WHERE OS.Hora_Entrada = '2023-04-24'

--CONSULTA POR ID DO CLIENTE
SELECT C.Nome,OS.Hora_Entrada,A.ID_Automovel,A.Modelo,S.Nome_Servico,P.Nome_Produto,POS.Valor_Servico,POS.Valor_Produto_Unitario,OS.Valor_Total
FROM Produto_OrdemServico_Servico POS
INNER JOIN Ordem_Servico OS ON OS.ID_Ordem_Servico = POS.COD_Ordem_Servico 
INNER JOIN Cliente C ON C.ID_Cliente = OS.COD_Cliente
INNER JOIN Servico S ON S.ID_Servico = POS.COD_Servico
INNER JOIN Automovel A ON A.ID_Automovel = OS.COD_Automovel
INNER JOIN Produto P ON P.ID_Produto= POS.COD_Produto
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
SELECT*FROM Servico

--TABELA ORDEM_SERVICO--
INSERT INTO Ordem_Servico VALUES(1,2,2,GETDATE(),NULL,0,0,0,0),
(2,1,3,GETDATE(),NULL,0,0,0,0),
(3,3,1,GETDATE(),NULL,0,0,0,0)
--DELETE FROM Ordem_Servico

UPDATE Ordem_Servico SET Hora_Saida = '2023-04-20' WHERE ID_Ordem_Servico = 1
UPDATE Ordem_Servico SET Estatus = 1 WHERE ID_Ordem_Servico = 1
UPDATE Ordem_Servico SET Hora_Saida = '2023-04-20' WHERE ID_Ordem_Servico = 2
UPDATE Ordem_Servico SET Estatus = 1 WHERE ID_Ordem_Servico = 2

SELECT*FROM Ordem_Servico

--TABELA PRODUTO_ORDEMSERVICO_SERVICO--
INSERT INTO Produto_OrdemServico_Servico (COD_Ordem_Servico,COD_Servico,COD_Produto,COD_Especialista,Horas_Gastas,Valor_Servico,Quantidade_Produto, Valor_Produto_Unitario, Valor_Total_Produto) 
VALUES (1,1,2,2,2,70,2,250,(2 * 250)),
(2,2,18,3,3,50,2,80,(2 * 80)),
(3,3,NULL,1,2,20,0,0,(0 * 20))
--DELETE FROM Produto_OrdemServico_Servico

--TRIGER PARA ATUALIZAR PRODUTO COM SERVICO
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

SELECT*FROM Ordem_Servico
SELECT*FROM Produto_OrdemServico_Servico
SELECT*FROM Servico
SELECT*FROM Produto

--TABELA VENDA--
INSERT INTO Venda VALUES(1,2,GETDATE(),0),
(2,3,GETDATE(),0)
--DELETE FROM Venda
SELECT*FROM Venda

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

SELECT*FROM Venda

--TABELA VENDA_PRODUTO--
INSERT INTO Venda_Produto(COD_Produto,COD_Venda,Nome_Produto,Valor_Produto_Unitario,Quantidade_Produto,Valor_Total) 
VALUES (1,1,'Bateria',2000,2,(2 * 2000)),
(4,2,'Furadeira',80,3,(3 * 80))
DELETE FROM Venda_Produto

SELECT*FROM Venda
SELECT*FROM Venda_Produto
SELECT*FROM Produto