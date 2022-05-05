SET STATISTICS TIME ON;
select *
from MaterilaizedView


DROP VIEW [MaterilaizedView_Index];

SELECT Sales.Customer.CustomerID,
    Person.Person.FirstName AS CustomerName,
    YEAR(Sales.SalesOrderHeader.OrderDate) AS Year,
    SUM(Sales.SalesOrderDetail.LineTotal) AS Total,
    COUNT_BIG(*) AS Count
FROM Sales.SalesOrderDetail INNER JOIN Sales.SalesOrderHeader 
ON Sales.SalesOrderDetail.SalesOrderID = Sales.SalesOrderHeader.SalesOrderID
    INNER JOIN Sales.Customer ON Sales.SalesOrderHeader.CustomerID = Sales.Customer.CustomerID
    INNER JOIN Person.Person ON Sales.Customer.PersonID = Person.Person.BusinessEntityID
GROUP BY  Sales.Customer.CustomerID, Person.Person.FirstName,
 YEAR(Sales.SalesOrderHeader.OrderDate), Sales.SalesOrderHeader.CustomerID;