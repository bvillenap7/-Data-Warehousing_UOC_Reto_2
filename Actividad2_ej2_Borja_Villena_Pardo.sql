-- Consulta apartado a)

SELECT part_id, name, stock, price
FROM erp.tb_part
WHERE supplier_id IN ('S01', 'S04')
	AND stock > 0
	AND price BETWEEN 400 AND 1300
ORDER BY price DESC;

-- Consulta apartado b)

SELECT cab.order_number, part.name, cab.order_date, lin.part_id, 
		lin.units, lin.unit_price, lin.subtotal
FROM erp.tb_purchase_order_cab AS cab
JOIN erp.tb_purchase_order_lin AS lin ON lin.purchase_order_cab_id = cab.purchase_order_cab_id
JOIN erp.tb_part AS part ON lin.part_id = part.part_id
WHERE order_number = '2024-0003'
ORDER BY lin.part_id ASC;

-- Consulta apartado c)

SELECT mach.machine_id, mach.part_id, mach.name, mach.units, mach.counter_id
FROM erp.tb_machines AS mach
WHERE mach.type_structure = 'Part' 
	AND mach.part_id LIKE '_002'
	AND mach.units = 2
ORDER BY mach.part_id ASC, mach.machine_id DESC

-- Consulta apartado d)

SELECT part.part_id, part.name, sup.name, part.price
FROM erp.tb_part AS part
JOIN erp.tb_supplier AS sup ON part.supplier_id = sup.supplier_id
WHERE part.price > (SELECT AVG(price) FROM erp.tb_part)
ORDER BY part.price ASC;

-- Consulta apartado e)

SELECT part.part_id, part.name, mach.units, part.stock
FROM erp.tb_part AS part
JOIN erp.tb_machines AS mach ON part.part_id = mach.part_id
JOIN erp.tb_counter AS contar ON mach.counter_id = contar.counter_id
WHERE (mach.last_change + mach.operating_hours > contar.hours)
	AND mach.units > part.stock
ORDER BY mach.units DESC;




