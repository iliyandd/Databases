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