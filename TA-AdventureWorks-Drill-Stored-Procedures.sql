USE [AdventureWorks2014]
GO
/****** Object:  StoredProcedure [dbo].[findEmail]    Script Date: 12/10/2018 4:42:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[findEmail] @Fname VARCHAR(50) = NULL, @Lname VARCHAR(50) = NULL, @Phone VARCHAR(50) = NULL
AS
BEGIN
	BEGIN TRY
		SELECT FirstName, LastName, EmailAddress
			 FROM Person.EmailAddress 
			 INNER JOIN Person.Person ON Person.BusinessEntityID = EmailAddress.BusinessEntityID
			 INNER JOIN Person.PersonPhone ON PersonPhone.BusinessEntityID = EmailAddress.BusinessEntityID
			 WHERE FirstName = ISNULL(@Fname,FirstName)
			 AND PhoneNumber = ISNULL(@Phone,PhoneNumber)
			 AND LastName = ISNULL(@Lname,LastName)
	END TRY

	BEGIN CATCH
		SELECT ERROR_MESSAGE() AS ErrorMessage;
	END CATCH
	
END