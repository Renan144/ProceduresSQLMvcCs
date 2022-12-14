USE [dbtest]
GO
/****** Object:  StoredProcedure [dbo].[dbinsert]    Script Date: 31/08/2022 12:30:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[dbinsert] (@nome SYSNAME, @total INT)
	AS
	BEGIN
		declare @vi int = 1;
		declare @vt int = @total;
		DECLARE @dbname nvarchar (100), @sqlSel nvarchar (max), @sqlInsert nvarchar(max),  @sqlCreate nvarchar(max), 
				@sqlTemp NVARCHAR, 
				@datacadastro DATETIME, 
				@dataatualizacao DATETIME;;
		SET @datacadastro = '20100101 00:00:00';
		SET @dataatualizacao =DATEADD(hour, 1, @datacadastro);
				
		
		SET @dbname = 'clientes';
		SET @sqlInsert = N'INERT INTO '+ cast(@dbname as varchar(max));
		SET @datacadastro = '20100101 00:00:00';
		SET @dataatualizacao =DATEADD(hour, 1, @datacadastro);
		SELECT @sqlCreate = N'CREATE TABLE '+@dbname+'(
					clienteid INTEGER PRIMARY KEY IDENTITY (1,1),
					cliente VARCHAR(250), 
					tipocliente VARCHAR(250), 
					nomecontato VARCHAR(250), 
					telefonecontato VARCHAR(250), 
					cidade VARCHAR(250), 
					bairro VARCHAR(250), 
					logradouro VARCHAR(250), 
					datacadastro VARCHAR(250), 
					dataatualizacao NVARCVARCHAR(250)
				);';SET @sqlTemp = ' (clienteid,
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
							'+cast (@vi as varchar(max))+', 
							Teste'+ cast (@vi as varchar(max))+', 
							Ttipocliente'+ cast (@vi as varchar(max))+', 
							Nomecontato'+ cast (@vi as varchar(max))+', 
							Telefonecontato'+ cast (@vi as varchar(max))+', 
							Cidade'+ cast (@vi as varchar(max))+', 
							Bairro'+ cast (@vi as varchar(max))+', 
							Logradouro'+ cast (@vi as varchar(max))+', 
							'+ cast (@datacadastro as varchar(max))+', 
							'+ cast (@dataatualizacao as varchar(max))+'
						);';
		set @sqlInsert = @sqlInsert + cast (@sqlTemp as varchar(max));
		IF (select count(*) from information_schema.tables where table_name = @nome) > 0 AND (select count(*) from clientes) <=0
			BEGIN
				exec sp_executesql @sqlInsert;
				return exec sp_executesql @sqlSel;
			END;
		ELSE
			BEGIN
				exec sp_executesql @sqlCreate;
				exec sp_executesql @sqlInsert;
				return exec sp_executesql @sqlSel;
			END
	END;
/**/