
WITH HighestSalary AS (
    SELECT 
        P.FirstName,
        P.LastName,
        P.BusinessEntityID,
        H.Rate
    FROM person.Person AS P
    JOIN humanresources.EmployeePayHistory AS H ON P.BusinessEntityID = H.BusinessEntityID
    WHERE H.Rate = (SELECT MAX(Rate) FROM humanresources.EmployeePayHistory)
)
SELECT *
INTO TempEmployeeInfo
FROM HighestSalary;



WITH Territory AS (
    SELECT 
        C.customerid,
        C.territoryid,
        S.name
    FROM sales.customer AS C
    JOIN sales.salesterritory AS S ON S.territoryid = C.territoryid
)
SELECT *
FROM Territory;





