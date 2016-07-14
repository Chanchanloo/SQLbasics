# SQLbasics_SELECT

#Find the country that start with Y
SELECT name FROM world
  WHERE name LIKE 'Y%';
  
#Find the countries that end with y
SELECT name FROM world
  WHERE name LIKE '%y';
  
#Luxembourg has an x - so does one other country. List them both.Find the countries that contain the letter x
SELECT name FROM world
  WHERE name LIKE '%x%';
  
  
#Iceland, Switzerland end with land - but are there others? Find the countries that end with land
SELECT name FROM world
  WHERE name LIKE '%land';
  
#Columbia starts with a C and ends with ia - there are two more like this.Find the countries that start with C and end with ia
SELECT name FROM world
  WHERE name LIKE 'C%ia';
  
#Greece has a double e - who has a double o? Find the country that has oo in the name
SELECT name FROM world
  WHERE name LIKE '%oo%';

#Bahamas has three a - who else? Find the countries that have three or more a in the name  
SELECT name FROM world
  WHERE name LIKE '%a%a%a%';
  
#India and Angola have an n as the second character. You can use the underscore as a single character wildcard.
#Find the countries that have "t" as the second character. 
SELECT name FROM world
 WHERE name LIKE '_t%'
ORDER BY name;

#Lesotho and Moldova both have two o characters separated by two other characters.
#Find the countries that have two "o" characters separated by two others.
SELECT name FROM world
 WHERE name LIKE '%o__o%';
 
#Cuba and Togo have four characters names.
#Find the countries that have exactly four characters. 
SELECT name FROM world
 WHERE name LIKE '____';
 
#The capital of Luxembourg is Luxembourg. Show all the countries where the capital is the same as the name of the country
#Find the country where the name is the capital city.
SELECT name 
  FROM world
 WHERE name = capital;
 
#The capital of Mexico is Mexico City. Show all the countries where the capital has the country together with the word "City".
#Find the country where the capital is the country plus "City".
SELECT name
  FROM world
 WHERE capital LIKE concat(name, '%City');
 
#Find the capital and the name where the capital includes the name of the country.
SELECT capital, name From world
WHERE capital LIKE concat("%",name,"%");

#Find the capital and the name where the capital is an extension of name of the country.
#You should include Mexico City as it is longer than Mexico. You should not include Luxembourg as the capital is the same as the country.
SELECT name, capital FROM world
where  capital LIKE concat(name, "_%");

#For Monaco-Ville the name is Monaco and the extension is -Ville.
#Show the name and the extension where the capital is an extension of name of the country.
SELECT name, 
REPLACE(capital, name, "") as ext
FROM world
WHERE capital LIKE concat(name, "_%");

#Give the name and the per capita GDP for those countries with a population of at least 200 million.
SELECT name, (gdp/population) as per_capita_gdp
FROM world 
WHERE population >= 200000000;

#Show the name and population in millions for the countries of the continent 'South America'. 
#Divide the population by 1000000 to get population in millions.
SELECT name, (population/1000000) as pop_million
FROM world
WHERE continent = 'South America';

# Show the name and population for France, Germany, Italy
SELECT name, population 
FROM world
WHERE name IN('France', 'Germany', 'Italy');

#Show the countries which have a name that includes the word 'United'
SELECT name FROM world
WHERE name LIKE '%United%';

#Two ways to be big: A country is big if it has an area of more than 3 million sq km or it has a population of more than 250 million.
#Show the countries that are big by area or big by population. Show name, population and area.
SELECT name, population, area FROM world
WHERE area>3000000 OR population>250000000;

#Show the countries that are big by area or big by population but not both. Show name, population and area.
SELECT name, population, area FROM world
WHERE area>3000000 XOR population>250000000;

#For South America show population in millions and GDP in billions to 2 decimal places.
SELECT name, ROUND(population/1000000,2), ROUND(GDP/1000000000,2) 
FROM world
WHERE continent = 'South America';

#Show per-capita GDP for the trillion dollar countries to the nearest $1000.
SELECT name, ROUND(gdp/population,-3) 
FROM world
WHERE gdp>=1000000000000;

#Show the name - but substitute Australasia for Oceania - for countries beginning with N.
SELECT name,
       CASE WHEN continent='Oceania' THEN 'Australasia'
            ELSE continent END
  FROM world
 WHERE name LIKE 'N%'
 
 #Show the name and the continent - but substitute Eurasia for Europe and Asia; substitute America - 
 #for each country in North America or South America or Caribbean. Show countries beginning with A or B
 SELECT name, 
   CASE WHEN continent IN ('Europe','Asia') THEN 'Eurasia'
        WHEN continent IN ('North America', 'South America', 'Caribbean') THEN 'America'
        ELSE continent END
FROM world
WHERE name LIKE 'A%' OR name LIKE 'B%';

#Put the continents right...
#Oceania becomes Australasia
#Countries in Eurasia and Turkey go to Europe/Asia
#Caribbean islands starting with 'B' go to North America, other Caribbean islands go to South America
#Order by country name in ascending order
#Show the name, the original continent and the new continent of all countries.
 SELECT name, continent, 
   CASE WHEN continent = 'Oceania' THEN 'Australasia'
        WHEN continent = 'Eurasia' THEN 'Europe/Asia' 
        WHEN name = 'Turkey' THEN continent = 'Europe/Asia'
        WHEN continent = 'Caribbean' 
             AND name LIKE "B%"
        THEN 'North America'
        WHEN continent = 'Caribbean' 
              AND name NOT LIKE 'B%'
        THEN 'South America'        
        ELSE continent END
FROM world
ORDER BY name;

#Show the countries in Europe with a per capita GDP greater than 'United Kingdom'.
SELECT name FROM world
  WHERE (gdp/population) >
     (SELECT gdp/population FROM world
      WHERE name='United Kingdom')
  AND continent = 'Europe';
  
  
#List the name and continent of countries in the continents containing either Argentina or Australia. Order by name of the country.
SELECT name, continent FROM world
WHERE continent IN 
    (SELECT continent FROM world WHERE name = 'Argentina' OR name = 'Australia')
ORDER BY name;

#Which country has a population that is more than Canada but less than Poland? Show the name and the population.
SELECT name, population FROM world
WHERE population > 
     (SELECT population FROM world WHERE name = 'Canada') 
    AND population < 
     (SELECT population FROM world WHERE name = 'Poland');
     
  
#Show the name and the population of each country in Europe. Show the population as a percentage of the population of Germany.  
SELECT name, 
(CONCAT(
  ROUND(population*100/(SELECT population FROM world WHERE name = 'Germany'), 0), '%')
) AS percentage
FROM world
WHERE continent = 'Europe';



#Which countries have a GDP greater than every country in Europe? [Give the name only.] (Some countries may have NULL gdp values)
SELECT name FROM world
 WHERE gdp > ALL(SELECT gdp FROM world
              WHERE continent = 'Europe' AND gdp>0);
              
       
#Find the largest country (by area) in each continent, show the continent, the name and the area:
SELECT continent, name, area FROM world x
  WHERE area >= ALL
    (SELECT area FROM world y
        WHERE y.continent=x.continent
          AND area>0)
          
#List each continent and the name of the country that comes first alphabetically.          
SELECT continent, name FROM world x
WHERE name <= ALL
    (SELECT name FROM world y 
        WHERE y.continent = x.continent)
        
SELECT continent, MIN(name) AS name FROM world 
GROUP BY continent
ORDER by continent


#Find the continents where all countries have a population <= 25000000. Then find the names of the countries associated with these continents. Show name, continent and population.

SELECT name, continent, population FROM world  x
WHERE 25000000>= ALL(SELECT population FROM world y 
                WHERE x.continent = y.continent 
                    AND population > 0)
                    
      
              
#Some countries have populations more than three times that of any of their neighbours (in the same continent). Give the countries and continents               

SELECT name, continent FROM world x
WHERE x.population > ALL (
  SELECT population*3 FROM world y
  WHERE x.continent = y.continent
  AND x.name != y.name);
