-- Apartado a)

-- Fuente consultada:

-- https://www-postgresql-org.translate.goog/docs/current/
-- rangetypes.html?_x_tr_sl=en&_x_tr_tl=es&_x_tr_hl=es&_x_tr_pto=rq#RANGETYPES-BUILTIN

-- Los tipos de rango en PostgreSQL son tipos de datos que representan un rango de 
-- valores de algún tipo de elemento (denominado subtipo del rango). Los tipos de rango 
-- son útiles porque representan muchos valores de elementos en un único valor de rango 
-- y porque conceptos como rangos superpuestos se pueden expresar con claridad.
-- Cada tipo de rango tiene un tipo multirango correspondiente. Un multirango es una 
-- lista ordenada de rangos no contiguos, no vacíos y no nulos. La mayoría de los operadores 
-- de rango también funcionan en multirango y tienen algunas funciones propias.

-- PostgreSQL viene con los siguientes tipos de rango integrados:

--  int4range— Rango de integer, int4multirange— Multirango correspondiente
--  int8range— Rango de bigint, int8multirange— Multirango correspondiente
--  numrange— Rango de numeric, nummultirange— Multirango correspondiente
--  tsrange— Rango de timestamp without time zone, tsmultirange— Multirango correspondiente
--  tstzrange— Rango de timestamp with time zone, tstzmultirange— Multirango correspondiente
--  daterange— Rango de date, datemultirange— Multirango correspondiente

-- Además, podemos definir nuestros propios tipos de rango, para ello podemos consultar la 
-- siguiente fuente:

-- https://www-postgresql-org.translate.goog/docs/current/
-- sql-createtype.html?_x_tr_sl=en&_x_tr_tl=es&_x_tr_hl=es&_x_tr_pto=rq



-- Apartado b)

CREATE TABLE erp.tb_production_agenda(
	production_agenda_id INTEGER NOT NULL,
	period_range TSRANGE NOT NULL,
	PRIMARY KEY (production_agenda_id)
	);

INSERT INTO erp.tb_production_agenda
VALUES (1, '[11-08-2024 00:00, 11-08-2024 15:00]'::tsrange),
       (2, '[11-08-2024 17:00, 11-08-2024 24:00]'::tsrange);

-- Consulta de 14:00 - 14:30

SELECT period_range, 'Producción' AS tipo_operacion
FROM erp.tb_production_agenda
WHERE period_range && '[11-08-2024 14:00, 11-08-2024 14:30]'::tsrange;

-- Consulta de 15:30 - 16:00

SELECT period_range, 'Producción' AS tipo_operacion
FROM erp.tb_production_agenda
WHERE period_range && '[2024-08-11 15:30, 2024-08-11 16:00]'::tsrange;
