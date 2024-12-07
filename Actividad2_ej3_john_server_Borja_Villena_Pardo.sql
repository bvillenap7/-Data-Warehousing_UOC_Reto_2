-- Consultas para comprobar privilegios y restricciones de usuario John
-- Conexión john_server

-- Consulta de permisos de lectura

SELECT * FROM erp.tb_purchase_order_lin;
SELECT * FROM erp.tb_purchase_order_cab;

-- Consulta de permisos de escritura

INSERT INTO erp.tb_purchase_order_cab
VALUES (111111, '2024-11-08', 'TEST-john', 'S02');

INSERT INTO erp.tb_purchase_order_lin
VALUES (111111, 111111, 'Test', 1, 1000.11, 1000.11, '2024-11-08');

-- Consulta de permisos de modificación

UPDATE erp.tb_purchase_order_lin
SET units = 111
WHERE part_id = 'Test';

UPDATE erp.tb_purchase_order_cab
SET supplier_id = 'S01'
WHERE order_number = 'TEST-john';

-- Consulta de restricciones
-- Permiso lectura tablas tb_part y tb_supplier

SELECT * FROM erp.tb_part;
SELECT * FROM erp.tb_supplier;

-- Restricción de permisos de escritura

INSERT INTO erp.tb_part
VALUES (1111, 'Test', 1, 'S02', 1000.11);

INSERT INTO erp.tb_supplier
VALUES ('S02', 'Test', 1);

-- Restricción de permisos de modificación

UPDATE erp.tb_part
SET stock = 111
WHERE part_id = 'Test';

UPDATE erp.tb_supplier
SET supplier_id = 'S01'
WHERE name = 'Test';
