SELECT*
FROM production.productlistpricehistory
ORDER BY modifieddate DESC;


-- a
BEGIN;

UPDATE production.productlistpricehistory AS priceHistory
SET listprice = priceHistory.listprice * 1.1
FROM production.product AS Product
WHERE priceHistory.productid = Product.productid AND Product.productid = 680;

COMMIT;

--b
BEGIN;

DELETE FROM production.product
WHERE productid = 707;

ROLLBACK;

--c
BEGIN WORK;

INSERT INTO Production.Product ( name, productnumber,makeflag,finishedgoodsflag,color,safetystocklevel,reorderpoint, standardcost, listprice,size,sizeunitmeasurecode,weightunitmeasurecode,weight,daystomanufacture,productline,class,style,productsubcategoryid,productmodelid,sellstartdate,sellenddate,discontinueddate,rowguid) 
VALUES ('DO SPRAWDZENIA', 'KOS12', 0, 0, 'CZARNY', 8, 11, 15.00, 17.00, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), NULL, NULL, NEWID());

COMMIT;

