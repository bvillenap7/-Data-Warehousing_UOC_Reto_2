-- Database: dbdw_pec2

-- DROP DATABASE IF EXISTS dbdw_pec2;

CREATE DATABASE dbdw_pec2
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'Spanish_Spain.1252'
    LC_CTYPE = 'Spanish_Spain.1252'
    LOCALE_PROVIDER = 'libc'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;

COMMENT ON DATABASE dbdw_pec2
    IS 'Creación BBDD Actividad2_ej1_Borja_Villena_Pardo.sql ';

-- Creamos el Esquema erp

CREATE SCHEMA erp
	AUTHORIZATION postgres

-- Creamos la tabla tb_supplier; proveedores de piezas

CREATE TABLE erp.tb_supplier(
	supplier_id CHAR(3) NOT NULL,
	name VARCHAR(30) NOT NULL,
	days_to_server_order INTEGER NOT NULL DEFAULT 0,
	PRIMARY KEY (supplier_id)
	);

-- Creamos la tabla tb_part; información de piezas

CREATE TABLE erp.tb_part(
	part_id CHAR(4) NOT NULL,
	name VARCHAR(50) NOT NULL UNIQUE,
	stock INTEGER NOT NULL DEFAULT 0,
	supplier_id CHAR(3) NOT NULL,
	price NUMERIC(8, 2) NOT NULL DEFAULT 0,
	PRIMARY KEY (part_id),
	FOREIGN KEY (supplier_id) REFERENCES erp.tb_supplier(supplier_id)
	);

-- Creamos la tabla tb_counter; información de los contadores

CREATE TABLE erp.tb_counter(
	counter_id INTEGER NOT NULL,
	name VARCHAR(25) NOT NULL,
	last_update_date DATE NOT NULL,
	hours INTEGER NOT NULL,
	PRIMARY KEY (counter_id)
	);

-- Creamos la tabla tb_machines; información de las instalaciones

CREATE TABLE erp.tb_machines(
	machine_id INTEGER NOT NULL,
	name VARCHAR(50) NOT NULL,
	parent_id INTEGER,
	type_structure VARCHAR(20) NOT NULL, 
	part_id CHAR(4),
	counter_id INTEGER,
	operating_hours INTEGER,
	units INTEGER,
	last_change INTEGER,
	PRIMARY KEY(machine_id),
	FOREIGN KEY(parent_id) REFERENCES erp.tb_machines(machine_id),
	FOREIGN KEY(part_id) REFERENCES erp.tb_part(part_id),
	FOREIGN KEY(counter_id) REFERENCES erp.tb_counter(counter_id),
	CHECK(type_structure IN ('Machine', 'Installation part', 'Part'))
	);

-- Creamos la tabla tb_purchase_order_cab  
-- información de los datos comunes de los pedidos a proveedores.

CREATE TABLE erp.tb_purchase_order_cab(
	purchase_order_cab_id INTEGER NOT NULL,
	order_date DATE NOT NULL DEFAULT CURRENT_DATE,
	order_number CHAR(9) UNIQUE NOT NULL,
	supplier_id CHAR(3) NOT NULL,
	PRIMARY KEY(purchase_order_cab_id),
	FOREIGN KEY(supplier_id) REFERENCES erp.tb_supplier(supplier_id)
	);

-- Creamos la tabla tb_purchase_order_lin
-- información del detalle de las piezas incluidas en cada pedido.

CREATE TABLE erp.tb_purchase_order_lin(
	purchase_order_lin_id INTEGER NOT NULL,
	purchase_order_cab_id INTEGER NOT NULL,
	part_id CHAR(4) NOT NULL,
	units INTEGER NOT NULL, 
	unit_price NUMERIC(8, 2) NOT NULL,
	subtotal NUMERIC(10, 2) NOT NULL,
	delivery_date DATE NOT NULL,
	PRIMARY KEY(purchase_order_lin_id),
	FOREIGN KEY(purchase_order_cab_id) REFERENCES erp.tb_purchase_order_cab(purchase_order_cab_id),
	FOREIGN KEY(part_id) REFERENCES erp.tb_part(part_id)
	);


	
	