USE [dbtest]
GO
/****** Object:  StoredProcedure [dbo].[dbcreate]    Script Date: 01/09/2022 16:40:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[dbcreate] (@nome SYSNAME)
	AS
	BEGIN
		DECLARE @dbname nvarchar(max), @sqlSel nvarchar (max), @sqlCreate nvarchar(max);
			
		SET @dbname = @nome;
		SELECT @sqlSel = N'SELECT * FROM '+cast(@dbname as nvarchar(max));
		SELECT @sqlCreate = N'CREATE TABLE '+cast(@dbname as nvarchar(max))+'(
					clienteid INTEGER PRIMARY KEY IDENTITY (1,1),
					cliente VARCHAR(250), 
					tipocliente VARCHAR(250), 
					nomecontato VARCHAR(250), 
					telefonecontato VARCHAR(250), 
					cidade VARCHAR(250), 
					bairro VARCHAR(250), 
					logradouro VARCHAR(250), 
					datacadastro VARCHAR(250), 
					dataatualizacao NVARCHAR(250)
				);';
				
		IF (select count(*) from information_schema.tables where table_name = @dbname) <= 0
			BEGIN
				exec sp_executesql @sqlCreate;
				print 'Banco de dados '+cast(@dbname as nvarchar)+' cadastrado com sucesso';
			END;
		ELSE
			BEGIN
				print 'Banco de dados '+cast(@dbname as nvarchar)+' já existente';
			END
	END;