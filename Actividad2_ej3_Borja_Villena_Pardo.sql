-- Sentencias apartado a)

ALTER TABLE erp.tb_machines 
	ADD COLUMN next_change INTEGER;
UPDATE erp.tb_machines AS mach
SET next_change = mach.last_change + mach.operating_hours
WHERE mach.last_change IS NOT NULL
	AND mach.operating_hours IS NOT NULL;
	
SELECT * FROM erp.tb_machines
WHERE next_change IS NOT NULL;

-- Sentencias apartado b) 

ALTER TABLE erp.tb_machines
	ADD CONSTRAINT manage_data CHECK (
		(type_structure = 'Part' AND part_id IS NOT NULL
								AND units IS NOT NULL) 
		OR 
		(type_structure <> 'Part' AND part_id IS NULL
								  AND units IS NULL)
		
		);

SELECT machine_id, type_structure, part_id, units FROM erp.tb_machines
WHERE type_structure = 'Part';

SELECT machine_id, type_structure, part_id, units FROM erp.tb_machines
WHERE type_structure <> 'Part';

-- Sentencias apartado c) 

CREATE VIEW erp.stock_valuation (part_id, name, supplier_id, 
			supplier_name, stock, price, stock_value) AS 
	(SELECT part.*, 
			sup.name AS supplier_name,
			(part.stock * part.price) AS stock_value
			
	FROM erp.tb_part AS part
	JOIN erp.tb_supplier AS sup ON part.supplier_id = sup.supplier_id
	WHERE part.stock > 0
	);

SELECT * FROM erp.stock_valuation


-- Sentencias apartado d) 

-- Fuentes consultadas: 
-- https://www.qualoom.es/blog/administracion-usuarios-roles-postgresql/ 
-- https://www.todopostgresql.com/crear-usuarios-en-postgresql/
-- https://www.pragma.com.co/academia/lecciones/como-conectarse-a-una-instancia-de-bd-con-pgadmin
-- https://es.stackoverflow.com/questions/520715/postgresql-crear-usuario-administrador-para-una-%C3%BAni
-- https://www.youtube.com/watch?v=yONxEvzuHR0 

CREATE USER John WITH PASSWORD '1234';
GRANT USAGE ON SCHEMA erp TO john;
GRANT ALL PRIVILEGES ON TABLE erp.tb_purchase_order_lin, erp.tb_purchase_order_cab TO john;
GRANT SELECT ON TABLE erp.tb_part, erp.tb_supplier TO john;








