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
