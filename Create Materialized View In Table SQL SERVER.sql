USE [AdventureWorks]
GO


IF (EXISTS (SELECT *
FROM INFORMATION_SCHEMA.TABLES
WHERE  TABLE_NAME = 'MaterilaizedTable'))
BEGIN
	DROP TABLE MaterilaizedTable;
END

SELECT Sales.Customer.CustomerID, Person.Person.FirstName AS CustomerName
, YEAR(Sales.SalesOrderHeader.OrderDate) AS Year, 
SUM(Sales.SalesOrderDetail.LineTotal) AS Total, 
COUNT_BIG(*) AS Count
INTO MaterilaizedTable
FROM Sales.SalesOrderDetail INNER JOIN Sales.SalesOrderHeader ON Sales.SalesOrderDetail.SalesOrderID = Sales.SalesOrderHeader.SalesOrderID
	INNER JOIN Sales.Customer ON Sales.SalesOrderHeader.CustomerID = Sales.Customer.CustomerID
	INNER JOIN Person.Person ON Sales.Customer.PersonID = Person.Person.BusinessEntityID
GROUP BY  Sales.Customer.CustomerID, Person.Person.FirstName, YEAR(Sales.SalesOrderHeader.OrderDate), Sales.SalesOrderHeader.CustomerID
GO

CREATE UNIQUE CLUSTERED INDEX [MaterilaizedTable_Index] ON [dbo].[MaterilaizedTable]
(
	[CustomerID] ASC,
	[Year] ASC
) 
GO