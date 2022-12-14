USE [dbtest]
GO
/****** Object:  StoredProcedure [dbo].[dbinsert]    Script Date: 01/09/2022 14:11:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[dbinsert] (@nome nvarchar(max), @total INT)
	AS
	BEGIN
		declare @vi int = 1;
		declare @vt int = @total;
		declare @vtemp int;
		DECLARE @dbname sysname,
				@sqlSel nvarchar (max),
				@sqlInsert nvarchar(max),
				@sqlInsert1 nvarchar(max),
				@sqlCreate nvarchar(max), 
				@sqlTemp NVARCHAR(max), 
				@cliente NVARCHAR(max) = 'Teste', 
				@tipocliente NVARCHAR(max) = 'Tipo cliente', 
				@nomecontato NVARCHAR(max) = 'Nome contato', 
				@cidade NVARCHAR(max) = 'Cidade cliente', 
				@bairro NVARCHAR(max) = 'Bairo cliente', 
				@logradouro NVARCHAR(max) = 'Logradouro cliente', 
				@datacadastro DATETIME, 
				@dataatualizacao DATETIME;
		SET @dbname = @nome;
		SET @sqlSel = 'SELECT * FROM '+cast(@dbname as nvarchar(max));
		SET @sqlInsert1 = N'INSERT INTO '+ cast(@dbname as nvarchar(max));
		SET @datacadastro = '20200101 00:00:00';
		SET @dataatualizacao =DATEADD(hour, 1, @datacadastro);

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
			END;

		while @vi <= @vt
			begin
				SET @vtemp = right (@vi, 1);
				SET @sqlTemp = ' (
							cliente, 
							tipocliente, 
							nomecontato, 
							telefonecontato, 
							cidade, 
							bairro, 
							logradouro, 
							datacadastro, 
							dataatualizacao
						) VALUES (
							'''+@cliente+ cast (@vi as varchar(max))+''', 
							'''+@tipocliente+ cast (@vi as varchar(max))+''', 
							'''+@Nomecontato+ cast (@vi as varchar(max))+''',
							'''+cast(@vtemp as varchar(max))+cast(@vtemp as varchar(max))+cast(@vtemp as varchar(max))+
							cast(@vtemp as varchar(max))+cast(@vtemp as varchar(max))+'-'+cast(@vtemp as varchar(max))+
							cast(@vtemp as varchar(max))+cast(@vtemp as varchar(max))+cast(@vtemp as varchar(max))+''', 
							'''+@Cidade + cast (@vi as varchar(max))+''', 
							'''+@Bairro + cast (@vi as varchar(max))+''', 
							'''+@Logradouro + cast (@vi as varchar(max))+''', 
							'''+ cast (@datacadastro as varchar(max))+''', 
							'''+ cast (@dataatualizacao as varchar(max))+'''
							);';

				SET @datacadastro = DATEADD(day, 1, @datacadastro);
				SET @dataatualizacao =DATEADD(hour, @vi, @datacadastro);
				set @sqlInsert = @sqlInsert1 + cast (@sqlTemp as varchar(max));
	
				exec sp_executesql @sqlInsert;
				set @vi = @vi+1
			end

		return exec sp_executesql @sqlSel;
	END;
/* */