-- 1.- Crear base de datos
CREATE DATABASE peliculas;
-- 1.1- Ingresar a base de datos posts
\c peliculas;

-- creacion de tablas
CREATE TABLE pelicula(
id INT PRIMARY KEY,
pelicula VARCHAR(80),
anio_estreno INT,
director VARCHAR(30)
);

CREATE TABLE reparto (
id_pel INT,
id SERIAL PRIMARY KEY,
nombre VARCHAR(30),
FOREIGN KEY (id_pel) REFERENCES pelicula(id)
);

--2. Cargar ambos archivos a su tabla correspondiente.
--Esta instruccion copia en forma correcta la informacion dentro de la base de datos
\copy pelicula (id, pelicula, anio_estreno, director) FROM './peliculas.csv' csv header ENCODING 'UTF-8';
\copy reparto (id_pel, nombre) FROM './reparto.csv' csv  ENCODING 'UTF-8';


--3. Id de pelicula Titanic
SELECT id FROM pelicula WHERE pelicula ILIKE '%TITANIC%';

--4. Actores de Titanic
SELECT nombre FROM reparto WHERE id_pel=2;

--5 Consultar en cuántas películas del top 100 participa Harrison Ford.
SELECT COUNT(*) FROM reparto WHERE nombre='Harrison Ford';
-- SELECT nombre, id_pel FROM reparto WHERE nombre='Harrison Ford';
-- SELECT pelicula FROM pelicula WHERE id IN (48, 59, 63, 67, 69, 87, 88, 97);
-- SELECT id_pel, pelicula, nombre FROM pelicula, reparto WHERE pelicula.id=reparto.id_pel AND nombre ILIKE 'Harrison Ford';

--6. Indicar las películas estrenadas entre los años 1990 y 1999 ordenadas por título de manera ascendente.
SELECT anio_estreno,pelicula FROM pelicula WHERE anio_estreno BETWEEN 1990 AND 1999
ORDER BY anio_estreno ASC;

--7. Hacer una consulta SQL que muestre los títulos con su longitud, la longitud debe ser nombrado para la consulta como “longitud_titulo”.
SELECT pelicula, LENGTH(pelicula) longitud_titulo FROM pelicula;

--8. Consultar cual es la longitud más grande entre todos los títulos de las películas.
SELECT pelicula, MAX(LENGTH(pelicula)) longitud_titulo FROM pelicula
GROUP BY pelicula
ORDER BY MAX(LENGTH(pelicula)) DESC
LIMIT 1;

