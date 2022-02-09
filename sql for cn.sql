USE `bezn4osuklwvngtd4e5c`;

-- CRUD Operations
-- Create/Insert --------------------------------------------------------------------------------
INSERT INTO movies(movie_title, year, rating) 
VALUES 	("Death in Vegas", 1910, 5), 
		("Onomatopeia", 1961, 7),
		("The Mirror of Death", 1986, 10);

INSERT INTO 
	actors(fName, lName, film_id) 
VALUES 
	("Job", "Prendergast", (SELECT MIN(film_id) FROM movies WHERE movie_title = "Death in Vegas")),
	("Abraham", "Cheddarslice", (SELECT MIN(film_id) FROM movies WHERE movie_title = "Death in Vegas")),
	("Belial", "Golb-Consumes", (SELECT MIN(film_id) FROM movies WHERE movie_title = "Death in Vegas")),
	("Oberon", "deLaSupermarche", (SELECT MIN(film_id) FROM movies WHERE movie_title = "Death in Vegas"));

-- Read --------------------------------------------------------------------------------
 
SELECT 
    *
FROM
    actors;
    
    SELECT 
    fName, lName
FROM
    actors
WHERE
    fname LIKE '%on%';
    
    SELECT 
    *
FROM
    actors
WHERE
    film_id IN (SELECT 
            film_id
        FROM
            movies
        WHERE
            movie_title LIKE '%o%');

    
-- update
UPDATE actors 
SET 
    film_id = (SELECT 
            MIN(film_id) -- min is required to deal with duplicates, and to ensure that deleting duplicates doesn't make orphans
        FROM
            movies
        WHERE
            movie_title = 'Onomatopeia')
WHERE
    actor_id = 1;
    
    UPDATE movies 
SET 
    movies.movie_title = 'Chitty Chitty Bang Bang'
WHERE
    film_id = 7;

-- delete -------------------------------------------------------------------------

-- delete all duplicate movies that aren't the earliest entry, uses aliases
DELETE FROM movies 
WHERE
    movie_title = ANY (SELECT 
        *
    FROM
        (SELECT 
            movie_title
        FROM
            movies
        GROUP BY movie_title
        HAVING COUNT(*) > 1) hasDuplicates)
    AND film_id NOT IN (SELECT 
        *
    FROM
        (SELECT 
            MIN(film_id)
        FROM
            movies
        GROUP BY movie_title) wasEarliest);
        
	