

SELECT * FROM regions;
SELECT * FROM species;
SELECT * FROM climate;
SELECT * FROM observations;


-- MISSION 1;
SELECT * FROM observations LIMIT 10;
--  Your query here;

-- MISSION 2;
SELECT DISTINCT region_id FROM observations;
-- Your query here;


-- MISSION 3;
SELECT COUNT(DISTINCT species_id) FROM observations;
-- Your query here;


-- MISSION 4;
SELECT COUNT(region_id) FROM observations WHERE region_id = 2;
-- Your query here;


-- MISSION 5;
SELECT * FROM observations WHERE observation_date = "1998-08-08";
-- Your query here;


-- MISSION 6;
SELECT *, MAX(region_id) FROM observations;
-- Your query here;


-- MISSION 7;
SELECT * FROM observations GROUP BY species_id ORDER BY count DESC LIMIT 5;
-- Your query here;


-- MISSION 8;
SELECT species_id FROM observations GROUP BY species_id  HAVING COUNT(*) < 5;
-- Your query here;

--MISSION 9;
SELECT observer, COUNT(*) FROM observations GROUP BY observer ORDER BY COUNT(count) DESC;

--MISSION 10;
SELECT regions.name FROM observations INNER JOIN regions ON observations.region_id = regions.id;

--MISSION 11;
SELECT species.scientific_name FROM observations INNER JOIN species ON observations.species_id = species.id;

--MISSION 12;

SELECT 
    species_by_city.city, 
    species_by_city.scientific_name, 
    species_by_city.total

FROM (
    --Subconsulta 1: species_by_city
    --Agrupamos las observaciones por ciudad y especie, y contamos cuántas veces aparece cada especie.
    SELECT 
        regions.name AS city, 
        species.scientific_name, 
        COUNT(*) AS total
    FROM 
        observations
        INNER JOIN regions ON observations.region_id = regions.id
        INNER JOIN species ON observations.species_id = species.id
    GROUP BY 
        regions.name, 
        species.scientific_name
) AS species_by_city 

INNER JOIN (
    --Subconsulta 2: max_species_by_city
    --Calcula el máximo número de observaciones por especie en cada ciudad

    SELECT 
        city, 
        MAX(total) AS max_total
    FROM (
        --Subconsulta 3: grouped
        --Repite la lógica de species_by_city para alimentar el cálculo del máximo
        SELECT 
            regions.name AS city, 
            species.scientific_name, 
            COUNT(*) AS total
        FROM 
            observations
            INNER JOIN regions ON observations.region_id = regions.id
            INNER JOIN species ON observations.species_id = species.id
        GROUP BY 
            regions.name, 
            species.scientific_name
    ) AS grouped
    GROUP BY 
        city
) AS max_species_by_city

--Unión por ciudad y filtro por el máximo
ON species_by_city.city = max_species_by_city.city
WHERE species_by_city.total = max_species_by_city.max_total;

--species_by_city  ->  todas las especies por ciudad con su total--

--max_species_by_city  ->  máximo total por ciudad--

--JOIN por ciudad  ->  conecta ambas tablas--

--WHERE total = max_total  ->  filtra solo las especies top--

--resultado final  ->  especies más observadas por ciudad--;

--MISSION 13;
INSERT INTO observations (species_id, region_id, observer, observation_date, latitude, longitude, count) 
VALUES(269, 26,'obsr123','1992-10-10', -66.666666, 666.66666, 66);

--MISSION 14;
UPDATE species 
SET scientific_name = 'Acanthagenys rufogularis'
WHERE scientific_name = 'Anthochaera rufogularis';

--MISSION 15;
DELETE FROM observations
WHERE id = 500;



