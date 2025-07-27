CREATE TABLE Directors(
Director_ID SERIAL PRIMARY KEY,
First_Name VARCHAR(50),
Last_Name VARCHAR (50) NOT NULL,
Date_of_Birth DATE,
Nationality VARCHAR(30)
);

--- INSERTING DATA MANUALLY BY WRITING QUERY

INSERT INTO Directors(First_Name,Last_Name,Date_of_Birth,Nationality) VALUES
('Rajkumar','Hirani','1962-11-20','Indian'),
('Anurag','Kashyap','1972-09-10','Indian'),
('Zoya','Akhtar','1972-10-14','Indian'),
('Mani','Ratnam','1956-06-02','Indian'),
('SS','Rajamouli','1973-10-10','Indian'),
('Sanjay','Leela Bhansali','1963-02-24','Indian'),
('Karan','Johar','1972-05-25','Indian'),
('Rohit','Shetty','1973-03-14','Indian'),
('Mira','Nair','1957-10-15','Indian-American'),
('Christopher','Nolan','1970-07-30','British-American'),
('Steven','Spielberg','1946-12-18','American'),
('Martin','Scorsese','1942-11-17','American'),
('Quentin','Tarantino','1963-03-27','American'),
('James','Cameron','1954-08-16','Canadian'),
('Ridely','Scott','1937-11-30','British'),
('Clint','Eastwood','1930-05-31','American'),
('David','Fincher','1962-08-04','American'),
('Greta','Gerwig','1983-08-04','American'),
('Taika','Waititi','1975-08-16','New Zealand'),
('Ava','DuVernay','1972-08-24','American'),
('Bong','Joon-ho','1969-09-14','South Korean'),
('Jane','Champion','1954-04-30','New Zealand'),
('Anna','Muylaert','1964-10-02','Brazilian'),
('Denis','Villeneuve','1967-10-03','Canadian'),
('Isabel','Coixet','1960-04-09','Spanish'),
('Sarah','Polley','1979-01-08','Canadian'),
('Hirokazu','Kore-eda','1962-06-06','Japanese'),
('Jia','Zhang','1970-05-24','Chinese'),
('Steve','McQueen','1969-10-09','British'),
('Rohit','Shetty','1974-03-14','Indian');

SELECT * FROM Directors;

CREATE TABLE Actors(
Actor_ID SERIAL PRIMARY KEY,
First_Name VARCHAR(50),
Last_Name VARCHAR(50),
Gender CHAR(10),
Date_of_Birth DATE
);

--- IMPORTING DATA USING PGADMIN TOOL

SELECT * FROM Actors;

CREATE TABLE Movies(
Movie_ID SERIAL PRIMARY KEY,
Movie_NAME VARCHAR(50) NOT NULL,
Movie_Length INT,
Movie_Lang VARCHAR(30),
Release_Date DATE,
Age_Certificate VARCHAR(10),
Director_ID INT REFERENCES Directors (Director_ID)
);


SELECT * FROM Movies;

CREATE TABLE Movie_Revenue(
Revenue_ID SERIAL PRIMARY KEY,
Movie_ID INT REFERENCES Movies(Movie_ID),
Domestic_Takings NUMERIC(6,2),
International_Takings NUMERIC(6,2)
);


SELECT * FROM Movie_Revenue;

CREATE TABLE Movie_Actors(
Movie_ID INT REFERENCES Movies(Movie_ID),
Actor_ID INT REFERENCES Actors(Actor_ID),
PRIMARY KEY(Movie_ID,Actor_ID)
);

SELECT * FROM Movie_Actors;

