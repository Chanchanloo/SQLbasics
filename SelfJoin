#How many stops are in the database.
  SELECT COUNT(*) 
    FROM stops
      
#Find the id value for the stop 'Craiglockhart'
  SELECT id FROM stops
    WHERE name = "Craiglockhart"


#Give the id and the name for the stops on the '4' 'LRT' service.
  SELECT stops.id, stops.name FROM stops JOIN route ON stops.id = route.stop
     WHERE num = '4' AND company = "LRT"

#The query shown gives the number of routes that visit either London Road (149) or Craiglockhart (53). 
#Run the query and notice the two services that link these stops have a count of 2
  SELECT company, num, COUNT(*)
      FROM route WHERE stop=149 OR stop=53
  GROUP BY company, num
  HAVING COUNT(*) =2
  
#Show the services from Craiglockhart to London Road
  SELECT a.company, a.num, a.stop, b.stop
    FROM route a JOIN route b ON
        (a.company=b.company AND a.num=b.num)
    WHERE a.stop=53 AND b.stop = (SELECT id FROM stops WHERE name = "London Road")
    
    
 #Change the query so that the services between 'Craiglockhart' and 'London Road' are shown.
    SELECT a.company, a.num, stopa.name, stopb.name
        FROM route a JOIN route b ON (a.company=b.company AND a.num=b.num)
            JOIN stops stopa ON (a.stop=stopa.id)
            JOIN stops stopb ON (b.stop=stopb.id)
        WHERE stopa.name='Craiglockhart' AND stopb.name = "London Road"
        
 #Give a list of all the services which connect stops 115 and 137 
    SELECT DISTINCT a.company, a.num FROM route a JOIN route b 
            ON  a.num = b.num AND a.company = b.company
     WHERE a.stop = 115 AND b.stop = 137
     
     
 # Give a list of the services which connect the stops 'Craiglockhart' and 'Tollcross'
     SELECT a.company, a.num FROM route a JOIN route b
            ON a.num = b.num AND a.company = b.company
        JOIN stops stopsa ON stopsa.id = a.stop 
        JOIN  stops stopsb ON stopsb.id = b.stop
      WHERE stopsa.name = 'Craiglockhart' AND stopsb.name = "Tollcross"
      
      
  #Give a distinct list of the stops which may be reached from 'Craiglockhart' by taking one bus, including 'Craiglockhart' itself, 
  # offered by the LRT company. Include the company and bus no. of the relevant services.
      SELECT DISTINCT stopsb.name, a.company, a.num 
        FROM route a JOIN route b 
              ON a.num = b.num AND a.company = b.company
          JOIN stops stopsa ON stopsa.id = a.stop
          JOIN stops stopsb ON stopsb.id = b.stop
      WHERE stopsa.name = "Craiglockhart" AND a.company = 'LRT'


#Find the routes involving two buses that can go from Craiglockhart to Sighthill.
#Show the bus no. and company for the first bus, the name of the stop for the transfer,
  and the bus no. and company for the second bus.  
 SELECT DISTINCT route1.num, route1.company, stops2.name, route3.num, route3.company FROM 
        route route1 JOIN route route2 ON route1.company = route2.company AND route1.num = route2.num
    JOIN stops stops1 ON stops1.id = route1.stop
    JOIN stops stops2 ON stops2.id = route2.stop
    JOIN route route3 ON route3.stop = route2.stop
    JOIN route route4 ON route4.company = route3.company AND route4.num= route3.num
    JOIN stops stops3 ON stops3.id= route4.stop
  WHERE stops1.name = "Craiglockhart" AND stops3.name = "Sighthill"
