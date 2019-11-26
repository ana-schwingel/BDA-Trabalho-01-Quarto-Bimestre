CREATE DATABASE UNIVERSIDADE_ANA999;
GO
USE UNIVERSIDADE_ANA999;
GO
CREATE TABLE CURSOS (
    ID INT NOT NULL PRIMARY KEY IDENTITY ,
	NOME VARCHAR(100), 
    DURACAO INT
);
GO

CREATE TABLE ALUNO (
   MATRICULA INT NOT NULL PRIMARY KEY,
   NOME VARCHAR(100) NOT NULL,
   SOBRENOME VARCHAR(100) NOT NULL,
   DATA_NASCIMENTO DATE NOT NULL,
   ANO INT,
   CURSOS_ID INT FOREIGN KEY(CURSOS_ID) REFERENCES CURSOS(ID)
);
GO
CREATE TABLE PROFESSOR( 
	MATRICULA INT NOT NULL PRIMARY KEY,
	NOME VARCHAR(100),
	SOBRENOME VARCHAR(100),
	DATA_NASCIMENTO DATE,
	DATA_CONTRATO DATE,
	AREA VARCHAR
);
GO
CREATE TABLE DISCIPLINA(
	ID INT NOT NULL PRIMARY KEY IDENTITY,
	CARGAHR INT NOT NULL,
	NOME VARCHAR(100),
	ANO INT NOT NULL,
	CURSOS_ID INT FOREIGN KEY(CURSOS_ID) REFERENCES CURSOS(ID),
	PROF_ID INT FOREIGN KEY(PROF_ID) REFERENCES PROFESSOR(MATRICULA)
);
GO
CREATE TABLE EXTENSAO(
	ID INT NOT NULL PRIMARY KEY IDENTITY,
	NOME VARCHAR(100),
	PROF_ID INT FOREIGN KEY(PROF_ID) REFERENCES PROFESSOR(MATRICULA),
	CURSOS_ID INT FOREIGN KEY(CURSOS_ID) REFERENCES CURSOS(ID)
);

--- CRIAÇÃO PROSIDURE ---

--- CRIAÇÃO DOS INSERTS NAS TABELAS --- 

--- CURSOS --- 
CREATE PROCEDURE CREATE_CURSO
	@nome_curso varchar(100), @duracao int
AS
BEGIN
	IF @nome_curso IS NOT NULL AND @duracao IS NOT NULL
		INSERT INTO CURSOS(NOME, DURACAO) VALUES(@nome_curso, @duracao);
END;
GO
--- ALUNOS ---
CREATE PROCEDURE CREATE_ALUNO
	@matricula int, @nome varchar(100), @sobrenome varchar(100), @data_nascimento date, @ano int, @curso_id int

AS
BEGIN
	IF @matricula IS NOT NULL AND @nome IS NOT NULL AND @data_nascimento IS NOT NULL AND @ano IS NOT NULL AND @curso_id IS NOT NULL
		INSERT INTO ALUNO(MATRICULA, NOME, SOBRENOME, DATA_NASCIMENTO, ANO, CURSOS_ID)
		VALUES(@matricula, @nome, @sobrenome, @data_nascimento, @ano, @curso_id);
END;
GO

--- PROFESSOR ---
CREATE PROCEDURE CREATE_PROFESSOR
	@matricula int, @nome varchar(100), @sobrenome varchar(100), @data_nascimento date, @data_contrato date, @area varchar(100)

AS
BEGIN
	IF @matricula IS NOT NULL AND @nome IS NOT NULL AND @data_nascimento IS NOT NULL AND @data_contrato IS NOT NULL AND @area IS NOT NULL
		INSERT INTO PROFESSOR(MATRICULA, NOME, SOBRENOME, DATA_NASCIMENTO, DATA_CONTRATO, AREA)
		VALUES(@matricula, @nome, @sobrenome, @data_nascimento, @data_contrato, @area);
END;
GO

--- DISCIPLINA ---
CREATE PROCEDURE CREATE_DISCIPLINA
	@cargahr int, @nome varchar(100), @ano int, @curso_id int, @prof_id int

AS
BEGIN
	IF @cargahr IS NOT NULL AND @nome IS NOT NULL AND @ano IS NOT NULL AND @curso_id IS NOT NULL AND @prof_id IS NOT NULL
		INSERT INTO DISCIPLINA(CARGAHR, NOME, ANO, CURSOS_ID, PROF_ID)
		VALUES(@cargahr, @nome, @ano, @curso_id, @prof_id);
END;
GO

--- EXTENSÃO ---
CREATE PROCEDURE CREATE_EXTENSAO
	@nome varchar(100), @curso_id int, @prof_id int

AS
BEGIN
	IF @nome IS NOT NULL AND @curso_id IS NOT NULL AND @prof_id IS NOT NULL
		INSERT INTO EXTENSAO(NOME,CURSOS_ID, PROF_ID)
		VALUES(@nome, @curso_id, @prof_id);
END;
GO

--- EXECUÇÕES DOS INSERTS ---
EXEC CREATE_CURSO @nome_curso = "SISTEMAS", @duracao = 4
GO
SELECT * FROM CURSOS
GO
EXEC CREATE_ALUNO @matricula = 1111004532, @nome = "ANA", @sobrenome = "LAURA", @data_nascimento = '1995-05-01 09:56:56', @ano = 2, @curso_id = 1
GO
SELECT * FROM ALUNO
EXEC CREATE_PROFESSOR @matricula = 112434, @nome = "RODRIGO", @sobrenome = "DORNEL", @data_nascimento = '1979-06-14 06:59:59', @data_contrato = '2011-01-31 00:00:00', @area = 'BDA';
GO
SELECT * FROM PROFESSOR
GO
EXEC CREATE_DISCIPLINA @cargahr = 144, @nome = "BDA", @ano = 2, @curso_id = 1, @prof_id = 112434;
GO
SELECT * FROM DISCIPLINA
GO
EXEC CREATE_EXTENSAO @nome = "PROJETO DE BANCO", @curso_id = 1, @prof_id = 112434;
GO
SELECT * FROM EXTENSAO
GO

--- CRIAÇÃO DOS UPDATES NA TABELA ---

--- CURSOS --- 
CREATE PROCEDURE UPDATE_CURSOS
	@id int, @nome_curso varchar(100), @duracao int
AS
BEGIN
	IF @id IS NOT NULL 
		IF @nome_curso IS NOT NULL AND @duracao IS NULL
			UPDATE CURSOS SET NOME = @nome_curso WHERE ID = @id
		ELSE 
			IF @duracao IS NOT NULL AND @nome_curso IS NULL
				UPDATE CURSOS SET DURACAO = @duracao WHERE ID = @id
			ELSE 
				IF @duracao IS NOT NULL AND @nome_curso IS NOT NULL
					UPDATE CURSOS SET DURACAO = @duracao, NOME = @nome_curso WHERE ID = @id
END;
GO
--- ALUNOS ---
CREATE PROCEDURE UPDATE_ALUNO
	@matricula int, @nome varchar(100), @sobrenome varchar(100), @data_nascimento date, @ano int, @curso_id int

AS
BEGIN
	IF @matricula IS NOT NULL 
		IF @nome IS NOT NULL AND @sobrenome IS NULL AND @data_nascimento IS NULL AND @ano IS NULL
			UPDATE ALUNO SET NOME = @nome WHERE MATRICULA = @matricula
		ELSE 
			IF @sobrenome IS NOT NULL AND @nome IS NULL AND @data_nascimento IS NULL AND @ano IS NULL 
				UPDATE ALUNO SET SOBRENOME = @sobrenome WHERE MATRICULA = @matricula
			ELSE 
				IF @data_nascimento IS NOT NULL AND @nome IS NULL AND @sobrenome IS NULL AND @ano IS NULL 
					UPDATE ALUNO SET DATA_NASCIMENTO = @data_nascimento WHERE MATRICULA = @matricula
				ELSE 
					IF @ano IS NOT NULL AND @nome IS NULL AND @sobrenome IS NULL AND @data_nascimento IS NULL 
						UPDATE ALUNO SET ANO = @ano WHERE MATRICULA = @matricula
					ELSE
						IF @ano IS NOT NULL AND @nome IS NOT NULL AND @sobrenome IS NOT NULL AND @data_nascimento IS NOT NULL
							UPDATE ALUNO SET NOME = @nome, SOBRENOME = @sobrenome, DATA_NASCIMENTO = @data_nascimento, ANO = @ano WHERE MATRICULA = @matricula
END;
GO

--- PROFESSOR ---
CREATE PROCEDURE UPDATE_PROFESSOR
	@matricula int, @nome varchar(100), @sobrenome varchar(100), @data_nascimento date, @data_contrato date, @area varchar(100)

AS
BEGIN
	IF @matricula IS NOT NULL 
		IF @nome IS NOT NULL AND @sobrenome IS NULL AND @data_nascimento IS NULL AND @data_contrato IS NULL AND @area IS NULL
			UPDATE PROFESSOR SET NOME = @nome WHERE MATRICULA = @matricula
		ELSE 
			IF @sobrenome IS NOT NULL AND @nome IS NULL AND @data_nascimento IS NULL AND @data_contrato IS NULL AND @area IS NULL
				UPDATE PROFESSOR SET SOBRENOME = @sobrenome WHERE MATRICULA = @matricula
			ELSE 
				IF @data_nascimento IS NOT NULL AND @nome IS NULL AND @sobrenome IS NULL AND @data_contrato IS NULL AND @area IS NULL
					UPDATE PROFESSOR SET DATA_NASCIMENTO = @data_nascimento WHERE MATRICULA = @matricula
				ELSE 
					IF @data_contrato IS NOT NULL AND @nome IS NULL AND @sobrenome IS NULL AND @data_nascimento IS NULL AND @area IS NULL
						UPDATE PROFESSOR SET DATA_CONTRATO = @data_contrato WHERE MATRICULA = @matricula
					ELSE
						IF @area IS NOT NULL AND @nome IS NULL AND @sobrenome IS NULL AND @data_nascimento IS NULL AND @data_contrato IS NULL
							UPDATE PROFESSOR SET AREA = @area WHERE MATRICULA = @matricula
						ELSE
							IF @area IS NOT NULL AND @nome IS NOT NULL AND @sobrenome IS NOT NULL AND @data_nascimento IS NOT NULL AND @data_contrato IS NULL
								UPDATE PROFESSOR SET NOME = @nome, SOBRENOME = @sobrenome, DATA_NASCIMENTO = @data_nascimento, DATA_CONTRATO = @data_contrato, AREA = @area
END;
GO

--- DISCIPLINA ---
CREATE PROCEDURE UPDATE_DISCIPLINA
	@id int, @cargahr int, @nome varchar(100), @ano int, @curso_id int, @prof_id int

AS
BEGIN
	IF @id IS NOT NULL 
		IF @cargahr IS NOT NULL AND @nome IS NULL AND @ano IS NULL AND @prof_id IS NULL AND @curso_id IS NULL
			UPDATE DISCIPLINA SET CARGAHR = @cargahr WHERE ID = @id;
		ELSE 
			IF @nome IS NOT NULL AND @cargahr IS NULL AND @ano IS NULL AND @prof_id IS NULL AND @curso_id IS NULL
				UPDATE DISCIPLINA SET NOME = @nome WHERE ID = @id;
			ELSE 
				IF @ano IS NOT NULL AND @cargahr IS NULL AND @nome IS NULL AND @prof_id IS NULL AND @curso_id IS NULL
					UPDATE DISCIPLINA SET ANO = @ano WHERE ID = @id;
				ELSE 
					IF @prof_id IS NOT NULL AND @cargahr IS NULL AND @nome IS NULL AND @ano IS NULL AND @curso_id IS NULL
						UPDATE DISCIPLINA SET PROF_ID = @prof_id WHERE ID = @id;
					ELSE 
						IF @curso_id IS NOT NULL AND @cargahr IS NULL AND @nome IS NULL AND @ano IS NULL AND @prof_id IS NULL
							UPDATE DISCIPLINA SET CURSOS_ID = @curso_id WHERE ID = @id;
						ELSE
							IF @curso_id IS NOT NULL AND @cargahr IS NOT NULL AND @nome IS NOT NULL AND @ano IS NOT NULL AND @prof_id IS NOT NULL
								UPDATE DISCIPLINA SET CARGAHR = @cargahr, NOME = @ano, ANO = @ano, CURSOS_ID = @curso_id, PROF_ID = @prof_id WHERE ID = @id;
END;
GO

--- EXTENSÃO ---
CREATE PROCEDURE UPDATE_EXTENSAO
	@id int, @nome varchar(100), @curso_id int, @prof_id int
AS
BEGIN
	IF @id IS NOT NULL 
		IF @nome IS NOT NULL AND @curso_id IS NULL AND @prof_id IS NULL
			UPDATE EXTENSAO SET NOME = @nome WHERE ID = @id
		ELSE 
			IF @curso_id IS NOT NULL AND @nome IS NULL AND @prof_id IS NULL
				UPDATE EXTENSAO SET CURSOS_ID = @curso_id WHERE ID = @id
			ELSE 
				IF @prof_id IS NOT NULL AND @nome IS NULL AND @curso_id IS NULL
					UPDATE EXTENSAO SET PROF_ID = @prof_id WHERE ID = @id
			ELSE 
				IF @nome IS NOT NULL AND @curso_id IS NOT NULL AND @prof_id IS NOT NULL
					UPDATE EXTENSAO SET NOME = @nome, CURSOS_ID = @curso_id, PROF_ID = @prof_id WHERE ID = @id
END;
GO

--- EXECUÇÃO DO UPDATE --- 
EXEC UPDATE_CURSOS @id = 1, @nome_curso = "SISTEMAS DE INFORMAÇÃO", @duracao = 4
GO
SELECT * FROM CURSOS
GO
EXEC UPDATE_ALUNO @matricula = 1111004532, @nome = "ANA", @sobrenome = "LAURA", @data_nascimento = '1996-05-01 09:56:56', @ano = 3, @curso_id = 1
GO
SELECT * FROM ALUNO
EXEC UPDATE_PROFESSOR @matricula = 112434, @nome = "RODRIGO", @sobrenome = "DORNEL", @data_nascimento = '1979-06-14 06:59:59', @data_contrato = '2011-01-30 00:00:00', @area = 'BDA';
GO
SELECT * FROM PROFESSOR
GO
EXEC UPDATE_DISCIPLINA @id = 1, @cargahr = 144, @nome = "BDA", @ano = 2, @curso_id = 1, @prof_id = 112434;
GO
SELECT * FROM DISCIPLINA
GO
EXEC UPDATE_EXTENSAO @id = 1, @nome = "PROJETO DE BANCO", @curso_id = 1, @prof_id = 112434;
GO
SELECT * FROM EXTENSAO
GO

--- CRIAÇÃO DOS DELETE NA TABELA---

--- CURSOS --- 
CREATE PROCEDURE DELETE_CURSO
	@id int
AS
BEGIN
	IF @id IS NOT NULL
		DELETE FROM CURSOS WHERE ID = @id
END;
GO
--- ALUNOS ---
CREATE PROCEDURE DELETE_ALUNO
	@matricula int

AS
BEGIN
	IF @matricula IS NOT NULL
		DELETE FROM ALUNO WHERE MATRICULA = @matricula
		
END;
GO

--- PROFESSOR ---
CREATE PROCEDURE DELETE_PROFESSOR
	@matricula int

AS
BEGIN
	IF @matricula IS NOT NULL 
		DELETE FROM PROFESSOR WHERE MATRICULA = @matricula
END;
GO

--- DISCIPLINA ---
CREATE PROCEDURE DELETE_DISCIPLINA
	@id int

AS
BEGIN
	IF @id IS NOT NULL
		DELETE FROM DISCIPLINA WHERE ID = @id
END;
GO

--- EXTENSÃO ---
CREATE PROCEDURE DELETE_EXTENSAO
	@id int

AS
BEGIN
	IF @id IS NOT NULL
		DELETE FROM EXTENSAO WHERE ID = @id
END;
GO


-- FUNÇÃO PARA TRAZER O ANO QUE O ALUNO ESTÁ-- 
CREATE FUNCTION RETORNO_ALUNO(@matricula VARCHAR(100))
RETURNS int
AS
  BEGIN
  DECLARE @ano int
  SELECT @ano = ANO FROM ALUNO WHERE MATRICULA = @matricula;
      RETURN @ano

END
GO
SELECT dbo.RETORNO_ALUNO('1111004532')

--- CRIAÇÃO DE VIEW ---
CREATE VIEW GRADE AS SELECT CARGAHR, NOME FROM DISCIPLINA WHERE ANO = 2;
GO

-- CRIAÇÃO DA TRIGGER ---
CREATE TRIGGER trgDELETE_CURSOS
ON dbo.CURSOS
FOR DELETE
AS
BEGIN
INSERT dbo.cusos_audit SELECT *,[TRG_OPERACAO] = 'DELETE',[TRG_DATA]=GETDATE(),[TRG_FLAG]='OLD' FROM Deleted
END;
