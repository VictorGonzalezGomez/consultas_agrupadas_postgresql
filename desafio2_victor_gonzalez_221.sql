-- crear la base de datos --
CREATE DATABASE desafio2_victor_gonzalez_221;
--acceder a la base de datos--
\c desafio2_victor_gonzalez_221
-- crear la tabla --
CREATE TABLE IF NOT EXISTS INSCRITOS(cantidad INT, fecha DATE, fuente VARCHAR);
-- ingresar datos a la tabla --
INSERT INTO INSCRITOS(cantidad, fecha, fuente) VALUES ( 44, '01/01/2021', 'Blog' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente) VALUES ( 56, '01/01/2021', 'Página' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente) VALUES ( 39, '01/02/2021', 'Blog' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente) VALUES ( 81, '01/02/2021', 'Página' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente) VALUES ( 12, '01/03/2021', 'Blog' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente) VALUES ( 91, '01/03/2021', 'Página' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente) VALUES ( 48, '01/04/2021', 'Blog' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente) VALUES ( 45, '01/04/2021', 'Página' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente) VALUES ( 55, '01/05/2021', 'Blog' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente) VALUES ( 33, '01/05/2021', 'Página' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente) VALUES ( 18, '01/06/2021', 'Blog' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente) VALUES ( 12, '01/06/2021', 'Página' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente) VALUES ( 34, '01/07/2021', 'Blog' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente) VALUES ( 24, '01/07/2021', 'Página' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente) VALUES ( 83, '01/08/2021', 'Blog' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente) VALUES ( 99, '01/08/2021', 'Página' );
-- ¿Cuántos registros hay?--
SELECT COUNT(*) FROM INSCRITOS;
-- 16
--¿Cuántos inscritos hay en total?--
SELECT SUM(cantidad) FROM INSCRITOS;
--  774
--¿Cuál o cuáles son los registros de mayor antigüedad?--
SELECT * FROM INSCRITOS WHERE fecha = (SELECT MIN(fecha) FROM INSCRITOS);
-- 3.- 44 2021-01-01 Blog, 56 2021-01-01 Página
--¿Cuántos inscritos hay por día? (entendiendo un día como una fecha distinta de ahora en adelante)--
SELECT fecha, SUM (cantidad) FROM INSCRITOS GROUP BY fecha ORDER BY fecha ASC;
-- 22-01-01 100,
-- 22-01-02 120,
-- 22-01-03 103,
-- 22-01-04 93,
-- 22-01-05 88,
-- 22-01-06 30,
-- 22-01-07 58,
-- 22-01-08 182
-- ¿Cuántos inscritos hay por fuente?--
SELECT fuente, SUM (cantidad) FROM INSCRITOS GROUP BY fuente;
-- Blog 333, Página 441
-- ¿Qué día se inscribieron la mayor cantidad de personas y cuántas personas se inscribieron en ese día?--
SELECT fecha, SUM(cantidad) AS users FROM INSCRITOS GROUP BY fecha ORDER BY users DESC LIMIT 1;
-- 2021-08-01 182
-- ¿Qué días se inscribieron la mayor cantidad de personas utilizando el blog y cuántas personas fueron?
SELECT * FROM INSCRITOS WHERE cantidad = (SELECT MAX(cantidad) FROM INSCRITOS WHERE fuente = 'Blog') ORDER BY fecha ASC LIMIT 1;
-- 83 2021-08-01 Blog
-- ¿Cuántas personas en promedio se inscriben en un día? --
SELECT AVG(users_per_day) AS promedio FROM (SELECT fecha, SUM (cantidad) AS users_per_day FROM INSCRITOS GROUP BY fecha) AS results;
-- 96.75
-- ¿Qué días se inscribieron más de 50 personas? --
SELECT fecha, SUM(cantidad) FROM INSCRITOS GROUP BY fecha HAVING SUM(cantidad) > 50;
-- 2021-02-01 120,
-- 2021-08-01 182,
-- 2021-05-01 88,
-- 2021-04-01 93,
-- 2021-07-01 58,
-- 2021-03-01 103,
-- 2021-01-01 100
--¿Cuántas personas se registraron en promedio cada día a partir del tercer día?--
SELECT AVG(users_per_day) FROM (SELECT SUM(cantidad) AS users_per_day FROM inscritos WHERE fecha >= '01-03-2021' GROUP BY fecha) AS avg_from_third_day;
-- 92.3333333