use ships;

select country, name
from classes
join ships on classes.class = ships.class
left join outcomes on name = ship
where outcomes.ship is null;

select distinct classes.class, battle
from classes
left join ships on classes.class = ships.class
join outcomes on name = ship
where country = 'Gt.Britain';

--За всеки клас да се изведат името му, държавата и имената 
--на всички негови кораби, пуснати през 1916 г.
select classes.class, country, name
from classes
join ships on classes.class = ships.class
where launched = 1916;


--За всеки клас да се изведат името му, държавата и имената 
--на всички негови кораби, пуснати през 1916 г. Ако за някой клас няма кораб пуснат през 1916г., 
-- срещу тях да пише NULL
select classes.class, country, name
from classes
left join ships on classes.class = ships.class and launched = 1916;


-- 1.1
use movies;

select title, year, name, address
from studio
join movie on studioname = name
where length > 120;


-- 1.2
select distinct studioname, starname
from movie
join starsin on movietitle = title and movieyear = year
order by studioname;


-- 1.3
select distinct name
from movie
join starsin on movietitle = title and movieyear = year
join movieexec on PRODUCERC# = CERT#
 where starname = 'Harrison Ford';


-- 1.4
select starname
from movie
join STARSIN on movietitle = title and movieyear = year
join moviestar on moviestar.name = starname
where gender = 'F' and studioname = 'MGM';


-- 1.5
select name, title 
from movie
join movieexec on producerc# = cert#
where cert# in (select PRODUCERC#
				from movie
				where title = 'Star wars');


-- 1.6
select distinct name
from moviestar
left join starsin on name = starname
where starname is null;


-- 2.1
use pc;

select distinct product.model, price
from product
left join pc on pc.model = product.model
where type = 'PC';


-- 2.2
select maker, p.model, type
from product p
left join (select model from pc
			union all
			select model from laptop
			union all
			select model from printer) t
	on p.model = t.model
where t.model is null;

-- OR
select maker, model, type
from product
where model not in (select model from pc)
	and model not in (select model from laptop)
	and model not in (select model from printer);


-- 3.1
use ships;

select name, country, numguns, launched
from ships
join classes on ships.class = classes.class;


-- 3.2
select distinct ship
from outcomes
join battles on name = battle
where year(date) = 1942;