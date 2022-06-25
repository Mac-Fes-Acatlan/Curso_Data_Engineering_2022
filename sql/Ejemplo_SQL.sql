
--Ejemplo Select 

SELECT * FROM tbl_maintenance;

SELECT maintenance_id,price_maintenance FROM tbl_maintenance;

--Ejemplo Where

SELECT * FROM tbl_maintenance
WHERE price_maintenance > 0.0;

SELECT * FROM tbl_maintenance
WHERE price_maintenance = 0.0;

--Ejemplo Count/Distinct

SELECT COUNT(*) FROM tbl_maintenance;

SELECT COUNT(*) FROM tbl_operations_maintenance;

SELECT DISTINCT(maintenance_id) FROM tbl_maintenance;

SELECT COUNT(DISTINCT(maintenance_id)) FROM tbl_operations_maintenance;

--Ejemplo Between

--Error

SELECT * FROM tbl_operations_maintenance
WHERE mtn_start_date BETWEEN CAST(mtn_start_date AS DATE)='2021-01-01' 
AND CAST(mtn_start_date AS DATE)='2021-12-31';

SELECT CAST(mtn_start_date AS DATE) FROM tbl_operations_maintenance;

--Busqueda del error

SELECT * FROM tbl_operations_maintenance
WHERE  mtn_start_date = 'NULL';

--Ejemplo Between con limpieza

WITH ejemplo_between AS (
	SELECT 
    CASE 
   	WHEN mtn_start_date <> 'NULL' THEN CAST(mtn_start_date AS DATE)
  	ELSE null
    END AS mtn_start_date
    FROM tbl_operations_maintenance
)
SELECT * FROM ejemplo_between;

SELECT * FROM 
(
	SELECT 
    CASE 
   	WHEN mtn_start_date <> 'NULL' THEN CAST(mtn_start_date AS DATE)
  	ELSE null
    END AS mtn_start_date
    FROM tbl_operations_maintenance
) AS ejemplo_between

--Ejemplo Union

SELECT 'maintenance' AS name,COUNT(*) AS conteo
FROM tbl_maintenance
UNION 
SELECT 'maintenance-operations' AS name,COUNT(*) AS conteo
FROM tbl_operations_maintenance;

--Ejemplo Join

SELECT * 
FROM tbl_maintenance AS mtn
LEFT JOIN cat_type_maintenance AS cat
ON mtn.type_id = cat.type_id;

--Ejemplo Group by 

SELECT package_id,COUNT(*)
FROM tbl_maintenance
GROUP BY package_id;

SELECT type_id,SUM(price_maintenance)
FROM tbl_maintenance
GROUP BY type_id;

--Ejemplo Having

SELECT type_id,SUM(price_maintenance)
FROM tbl_maintenance
GROUP BY type_id
HAVING SUM(price_maintenance) > 8196;

SELECT maintenance_id, COUNT(*)
FROM tbl_maintenance
GROUP BY maintenance_id
HAVING COUNT(*) > 1;

SELECT maintenance_id, COUNT(*)
FROM tbl_operations_maintenance
GROUP BY maintenance_id
HAVING COUNT(*) > 1;

--Ejemplo Rank

SELECT * , 
RANK() OVER(PARTITION BY package_name ORDER BY date)
FROM cat_type_package;