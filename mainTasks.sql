use ships;

-- Имената и годините на пускане на всички кораби, които имат същото име като своя клас
select name, launched
from ships
where class = name;

-- Имената на всички кораби, за които едновременно са изпълнени следните условия: 
-- (1) участвали са в поне една битка и (2) имената им (на корабите) започват с C или K.
select distinct ship
from outcomes
where ship like 'C%' or ship like 'K%';


-- Всички държави, които имат потънали в битка кораби.
select distinct country
from classes
join ships on classes.class = ships.class
join outcomes on name = ship
where result = 'sunk';


-- Всички държави, които нямат потънали в битка кораби.
select distinct country
from classes
join ships on classes.class = ships.class
left join outcomes on name = ship
where ship is null;


-- Имената на класовете, за които няма кораб, пуснат на вода
-- (launched) след 1921 г. Ако за класа няма пуснат никакъв кораб, той също трябва да излезе в резултата
select distinct classes.class
from classes
left join ships on classes.class = ships.class
where name is null or classes.class not in (select class
											from ships
											where year(launched) > 1921);


use movies;

--Всички филми, чието заглавие съдържа едновременно думите 'Star' и 'Trek' (не
--непременно в този ред). Резултатите да се подредят по година (първо най-новите
--филми), а филмите от една и съща година - по азбучен ред
select *
from movie
where title like '%Star%' and title like '%Trek%'
order by year desc, title;


--Заглавията и годините на филмите, в които са играли звезди, родени между
--1.1.1970 и 1.7.1980.
select movietitle, movieyear
from starsin
join moviestar on starname = name
where birthdate >= '1970-01-01' and birthdate <= '1980-07-01';


use pc;

--Компютрите, които са по-евтини от всеки лаптоп на същия производител.
select pc.*
from pc
join product p1 on pc.model = p1.model
where price > all(select price
					 from laptop
					 join product p2 on laptop.model = p2.model
					 where p1.maker = p2.maker);


--Компютрите, които са по-евтини от всеки лаптоп и принтер на същия
--производител.
select pc.*
from pc
join product p1 on pc.model = p1.model
where price < all (select price
					from laptop
					join product p2 on laptop.model = p2.model
					where p1.maker = p2.maker)
	and price < all (select price
					from printer
					join product p2 on printer.model = p2.model
					where p1.maker = p2.maker);

