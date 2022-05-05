USE [AdventureWorks]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[MaterilaizedView]
WITH
	SCHEMABINDING
AS
	SELECT Sales.Customer.CustomerID, Person.Person.FirstName AS CustomerName, YEAR(Sales.SalesOrderHeader.OrderDate) AS Year, SUM(Sales.SalesOrderDetail.LineTotal) AS Total, COUNT_BIG(*) AS Count
	FROM Sales.SalesOrderDetail INNER JOIN Sales.SalesOrderHeader ON Sales.SalesOrderDetail.SalesOrderID = Sales.SalesOrderHeader.SalesOrderID
		INNER JOIN Sales.Customer ON Sales.SalesOrderHeader.CustomerID = Sales.Customer.CustomerID
		INNER JOIN Person.Person ON Sales.Customer.PersonID = Person.Person.BusinessEntityID
	GROUP BY  Sales.Customer.CustomerID, Person.Person.FirstName, YEAR(Sales.SalesOrderHeader.OrderDate), Sales.SalesOrderHeader.CustomerID
GO

CREATE UNIQUE CLUSTERED INDEX [MaterilaizedView_Index] ON [dbo].[MaterilaizedView]
(
	[CustomerID] ASC,
	[Year] ASC
) 
GO



