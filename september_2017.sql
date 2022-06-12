use ships;


/* (09.09.2017) Задача 3.1. Попълнете липсващите части, обозначени с ______ така, 
че заявката да изведе име и държава на корабите, които никога не са потъвали в 
битка (може и да не са участвали).
select name, country
from ships _____ outcomes on name=ship
		   _____ classes on ships.class=classes.class
where ____________________;*/

select name, country
from ships
left join outcomes on name = ship
join classes on ships.class = classes.class
where result is NULL or result <> 'sunk';


/* (09.09.2017) Задача 3.2. Попълнете липсващите части, обозначени с ______ така, 
че заявката да изведе име, водоизместимост и брой оръдия на най-леките кораби 
с най-много оръдия. */
/*select name,displacement,numguns
from classes s 
join ships s on s.class=c.class
where displacement = (select __________
					  from classes) and 
	  numguns = (select __________
				 from classes c1
                 where ______________________);*/

select name, displacement, numguns
from classes c
join ships s on s.class = c.class
where displacement = (select min(displacement)
					  from classes) and numguns = (select max(numguns)
												   from classes c1
												   where c1.class = c.class);


/* (09.09.2017) Задача 3.3. Попълнете липсващите части, обозначени с ______ така, че заявката да изведе име на 
битките, в които е участвал един кораб.
select battle
from outcomes o1
where _____ (select* 
			 from outcomes o2
             where ______________________); */

select battle
from outcomes o1
where  (select *
	       from outcomes o2
		   where ...);

select battle
from outcomes
group by battle
having count(ship) = 1;
