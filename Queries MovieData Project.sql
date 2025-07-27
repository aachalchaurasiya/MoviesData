                             --- BASIC QUERY ---

--- 1. Write a query to list all directors with their full names and nationality.

SELECT CONCAT(First_Name,' ',Last_Name) AS FULL_Name , Nationality FROM Directors;

---2. Write a query to find all movies released after 2010.

SELECT * FROM Movies WHERE Release_Date > '2010-01-01';

---3.Write a query to list all actors born before 1990.

SELECT * FROM Actors WHERE Date_of_Birth < '1990-01-01';

                               ---- JOINS ----

---Write a query to list all movies along with their director's full name.

SELECT CONCAT(d.First_Name,' ', d.Last_Name) AS FullName,  mo.Movie_ID,mo.Movie_Name
FROM Movies mo
JOIN Directors d ON mo.Director_ID = d.Director_ID;

--- Write a query to list all actors in a particular movie (given Movie_ID or Movie_NAME).

SELECT  Concat(ac.First_Name,' ',ac.Last_Name) AS Full_Name ,mo.Movie_ID, mo.Movie_Name
FROM Movies mo 
JOIN Movie_Actors  ma ON ma.Movie_ID = mo.Movie_ID
JOIN Actors ac on ac.Actor_ID = ma.Actor_ID
WHERE Movie_Name = 'Bajirao Mastani';

--- Write a query to find total revenue (domestic + international) for each movie.

SELECT mr.Domestic_Takings, mr.International_Takings, (mr.Domestic_Takings+mr.International_Takings) AS TotalRevenue,
mo.Movie_Name
FROM Movies mo 
JOIN Movie_Revenue mr ON mo.Movie_ID = mr.Movie_ID
WHERE mr.Domestic_Takings IS NOT NULL AND mr.International_Takings IS NOT NULL;

--- ANOTHER WAY OF DOING

SELECT mo.Movie_ID,mo.Movie_NAME,
COALESCE(mr.Domestic_Takings, 0) + COALESCE(mr.International_Takings, 0) AS Total_Revenue
FROM Movies mo LEFT JOIN Movie_Revenue mr ON mo.Movie_ID = mr.Movie_ID;

--- Write a query to find the top 3 highest-grossing movies.

SELECT mr.Domestic_Takings, mr.International_Takings, (mr.Domestic_Takings+mr.International_Takings) AS TotalRevenue,
mo.Movie_Name
FROM Movies mo 
JOIN Movie_Revenue mr ON mo.Movie_ID = mr.Movie_ID
WHERE mr.Domestic_Takings IS NOT NULL AND mr.International_Takings IS NOT NULL
ORDER BY TotalRevenue DESC LIMIT 3;

SELECT mo.Movie_ID,mo.Movie_NAME,
COALESCE(mr.Domestic_Takings, 0) + COALESCE(mr.International_Takings, 0) AS Total_Revenue
FROM Movies mo LEFT JOIN Movie_Revenue mr ON mo.Movie_ID = mr.Movie_ID
ORDER BY Total_Revenue DESC LIMIT 3;

--- Write a query to get the count of movies directed by each director.

SELECT COUNT(mo.Movie_ID)AS MovieCount, CONCAT(d.First_Name,' ', d.Last_Name) AS DirectorNames
FROM Movies mo 
JOIN Directors d ON mo.Director_ID = d.Director_ID
GROUP BY d.Director_ID, d.First_Name,d.Last_Name
ORDER BY MovieCount;

/* Write a query to display the Director ID, first name, last name, and movie name 
for all directors, including those who haven’t directed any movie yet. */



SELECT d.Director_ID,d.First_Name,d.Last_Name,mo.Movie_Name FROM Directors d
LEFT JOIN Movies mo ON d.Director_ID = mo.Director_ID;

/* Write a query to display all movies along with their director’s name. Ensure that movies without an assigned director
are also included in the result. */

SELECT d.Director_ID,d.First_Name,d.Last_Name,mo.Movie_Name FROM Directors d
RIGHT JOIN Movies mo ON d.Director_ID = mo.Director_ID
ORDER BY Director_ID;

/* Write a query to display all directors and all movies, including:
Directors who haven't directed any movies.
Movies that don't have an assigned director.*/

SELECT d.Director_ID,d.First_Name,d.Last_Name,mo.Movie_Name FROM Directors d
FULL JOIN Movies mo ON d.Director_ID = mo.Director_ID;

                 --- Aggregate Functions & Grouping ---

--- Write a query to find the average length of movies by language.

SELECT Movie_Lang, AVG(Movie_Length) 
FROM Movies
GROUP BY Movie_Lang;

--- Write a query to count how many actors have worked in more than 3 movies.

SELECT  Concat(ac.First_Name,' ',ac.Last_Name) AS Full_Name ,count(mo.Movie_ID)
FROM Movies mo 
JOIN Movie_Actors  ma ON ma.Movie_ID = mo.Movie_ID
JOIN Actors ac on ac.Actor_ID = ma.Actor_ID
GROUP BY ac.First_Name,ac.Last_Name,ac.Actor_ID;

--- Write a query to find the total domestic takings by nationality of directors.

SELECT SUM(mr.Domestic_Takings) AS Total_Domestic_Takings,d.Nationality
FROM Directors d
JOIN Movies mo ON d.Director_ID = mo.Director_ID
JOIN Movie_Revenue mr ON mo.Movie_ID = mr.Movie_ID
GROUP BY d.Nationality;

--- Write a query to list actors who have acted in movies with an age certificate of 'PG-13'.
SELECT mo.Movie_ID,mo.Movie_Name,mo.Age_Certificate, CONCAT(First_Name,' ',Last_Name) AS ActorsName
FROM Movies mo 
JOIN Movie_Actors ma ON mo.Movie_ID = ma.Movie_ID
JOIN Actors ac ON ma.Actor_ID = ac.Actor_ID
WHERE mo.Age_Certificate = 'PG-13';

--- How many Directors are there per Nationality?

SElECT COUNT(Director_ID),Nationality
FROM Directors
GROUP BY Nationality;

--- What is the sum total movie length for each age certificate and movie language cominatn

SELECT Age_Certificate,Movie_Lang,SUM(Movie_Length)
FROM Movies
GROUP BY Age_Certificate,Movie_Lang;


                 --- Filtering & Sorting ---

--- Write a query to list movies longer than 120 minutes and released in English.

SELECT * FROM Movies WHERE Movie_Length > 120 AND Movie_Lang ='English';

--- Write a query to find movies where the director is from 'American' and the movie revenue is more than 320 dollars domestically.

SELECT mo.Movie_ID,mo.Movie_Name FROM Directors d
JOIN Movies mo ON mo.Director_ID = d.Director_ID
JOIN Movie_Revenue mr ON mo.Movie_ID = mr.Movie_ID
WHERE d.Nationality = 'American' AND Domestic_Takings > 320;

--- Write a query to get all movies sorted by release date descending.

SELECT * FROM Movies ORDER BY Release_Date DESC; 

                    --- Data Modification ---

---  Write a query to update the nationality of a director.

--- Write a query to delete an actor who has not acted in any movie.

--- Write a query to insert a new movie and associate it with an existing director.

                     ---  PRACTICE QUESTIONS ---

--- Write a query to find the average age of actors for each movie.

SELECT CONCAT(ac.First_Name,' ',ac.Last_Name) AS ActorNames, AVG(EXTRACT(YEAR FROM AGE(mo.Release_Date, ac.Date_of_Birth))) AS AverageAge, 
mo.Movie_ID,mo.Movie_Name
FROM Movies mo 
JOIN Movie_Actors ma ON  mo.Movie_ID = ma.Movie_ID
JOIN Actors ac ON ma.Actor_Id = ac.Actor_ID
GROUP BY mo.Movie_ID,mo.Movie_Name,ac.First_Name,ac.Last_Name;
---  CURRENT AGE
SELECT CONCAT(ac.First_Name,' ',ac.Last_Name) AS ActorNames, EXTRACT(YEAR FROM AGE(CURRENT_DATE, ac.Date_of_Birth)) AS NormalAge, 
mo.Movie_ID,mo.Movie_Name
FROM Movies mo 
JOIN Movie_Actors ma ON  mo.Movie_ID = ma.Movie_ID
JOIN Actors ac ON ma.Actor_Id = ac.Actor_ID
ORDER BY mo.Movie_ID;

--- Write a query to find directors who have directed movies in multiple languages.

SELECT d.Director_ID,CONCAT(d.First_Name,' ',d.Last_Name) AS DircetorName,
COUNT(DISTINCT(mo.Movie_Lang)) FROM Movies mo
JOIN Directors d ON mo.Director_ID = d.Director_ID
GROUP BY d.Director_ID,d.First_Name,d.Last_Name;


--- Write a query to list actors who have worked with a specific director.

SELECT mo.Movie_ID,mo.Movie_Name,d.First_Name, CONCAT(ac.First_Name,' ',ac.Last_Name) AS ActorsName 
FROM Directors d 
JOIN Movies mo ON mo.Director_ID = d.Director_ID
JOIN Movie_Actors ma ON ma.Movie_ID = mo.Movie_ID
JOIN Actors ac ON ac.Actor_ID = ma.Actor_ID
WHERE d.First_Name = 'Sanjay';
