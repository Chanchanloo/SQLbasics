#List all the continents - just once each
SELECT continent FROM world
GROUP BY continent;

#Give the total GDP of Africa
SELECT SUM(gdp) FROM world
WHERE continent = 'Africa';

#How many countries have an area of at least 1000000
SELECT COUNT(name) FROM world 
WHERE area >= 1000000;

#What is the total population of ('France','Germany','Spain')
SELECT SUM(population) FROM world
   WHERE name IN ('France','Germany','Spain');
   

#For each continent show the continent and number of countries.
SELECT continent, COUNT(name) FROM world
GROUP BY continent;

#For each continent show the continent and number of countries with populations of at least 10 million.
SELECT continent, COUNT(name) FROM world
WHERE population >= 10000000
GROUP BY continent 

#List the continents that have a total population of at least 100 million
SELECT continent FROM world
GROUP BY continent
HAVING SUM(population) >= 100000000；

#List each subject - just once
SELECT DISTINCT(subject) FROM nobel；

#Show the total number of prizes awarded for Physics.
SELECT COUNT(winner) FROM nobel
WHERE subject = 'Physics';

#For each subject show the subject and the number of prizes.
SELECT subject, COUNT(winner) FROM nobel
GROUP BY subject;


#For each subject show the first year that the prize was awarded.
SELECT subject, MIN(yr) FROM nobel
GROUP BY subject；


#For each subject show the number of prizes awarded in the year 2000.
SELECT subject, COUNT(winner) FROM nobel
WHERE  yr = 2000
GROUP BY subject

#Show the number of different winners for each subject.
SELECT subject, COUNT(DISTINCT(winner)) FROM  nobel
GROUP BY subject

#For each subject show how many years have had prizes awarded.
SELECT subject, COUNT(DISTINCT(yr)) FROM nobel
GROUP BY subject



