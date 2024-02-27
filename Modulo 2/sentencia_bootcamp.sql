CREATE TABLE users(
    id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    age INT NOT NULL, 
    username VARCHAR(50) NOT NULL,
    password VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(50) NOT NULL,
    country VARCHAR(10) NOT NULL,
    cp VARCHAR(10) NOT NULL,
    gender ENUM("male","female") NOT NULL DEFAULT "female",
    create_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO users(name, email, country, cp) VALUES("Eduardo",
"info@codigofacilito.com","MXN","00017");

-- GESTOR(MySQL)
-- BASE DE DATOS
-- TABLAS
-- SQL > Lenguaje de Consultas

UPDATE users SET last_name="Garcia", password="123" WHERE id=1;

DELETE FROM users; --elimina los registro de la tabla

TRUNCATE users; --reinicia la tabla al id 

""" ¡¡¡ IMPORTANTE !!! COMO PROGRAMADORES NUESTRA CONSULTA DEBEN DE SER MAS RAPIDA DE LO HABITUAL """

-- DISTINCT -- para que nos de un dato unico
-- IN -- para que nos agregue varios datos para consutar.

-- COUNT() --para contar valores.
-- AVG()    --para sacar el promedio.
--GROUP BY -- para agruparlo ej: SELECT gender, count(*) FROM users GROUP BY gender;

-- ejemplo: SELECT COUNT(*) FROM (SELECT DISTINCT country FROM users) AS result;

-- SELECT username from users WHERE gender = "femele" IN(country = "canada" and age >=20); 
-- SELECT country(informacion), COUNT(*)(ACCION) as total FROM users | GROUP BY country | ORDER BY total DESC LIMIT 3;
-- SELECT country FROM users ORDER BY age DESC LIMIT 1   (CONOCER EL PAIS DE LA PERSONA MAS VIEJA).
-- SELECT country, AVG(age) FROM users GROUP BY country ORDER BY age DESC LIMIT 1