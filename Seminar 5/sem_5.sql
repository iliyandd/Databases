use movies;

select year(birthdate), gender, count(*)
from moviestar
group by year(birthdate), gender;

-- !!!  Не можем да използваме агрегатни функции в WHERE клауза !!!

select *
from movie
where length = (select max(length)
				from movie);


select studioname, sum(length)
from movie
group by studioname
having count(*) >= 2;

-- За всяка филмова звезда да се изведе броят на 
-- филмите, в които се е снимала.
--Ако за дадена звезда не знаем какви филми има, за нея да се изведе 0.

select name, count(starname) as moviesCount
from moviestar
left join starsin on name = starname
group by name;


-- 1.1
use pc;

select avg(speed)
from pc;

-- 1.2
select avg(screen)
from product
join laptop on product.model = laptop.model
group by maker;

-- 1.3
select avg(speed)
from laptop
where price > 1000;

-- 1.4
select avg(price)
from pc
join product on pc.model = product.model
where maker = 'A';

-- 1.5
select avg(price)
from
(
	select price
	from product p join pc
	on p.model=pc.model 
	where maker='B'

	union all

	select price
	from product p join laptop l
	on p.model=l.model 
	where maker='B'
) AllPrices;

-- 1.6
select avg(price)
from pc
group by speed;

-- 1.7
select maker
from product
where type = 'PC'
group by maker
having count(*) >= 3;

-- 1.8
select distinct maker
from product
join pc on product.model = pc.model
where price = (select max(price) from pc);

-- 1.9
select speed, avg(price)
from pc
where speed > 800
group by speed;

-- 1.10
select avg(hd)
from pc
join product on pc.model = product.model
where maker in (select maker
				from product
				where type='Printer');

-- 1.11
select (max(price) - min(price)) as priceDiff
from laptop
group by screen;

-- 2.1
use ships;

select class, count(*) as Number
from ships
group by class;

-- 2.2
select avg(numguns)
from ships
join classes on ships.class = classes.class;

-- 2.3
select classes.class, min(launched) as firstYear, max(launched) as lastYear
from classes
join ships on classes.class = ships.class
group by classes.class;

-- 2.4
select classes.class, count(*) as destroyedShips
from classes
join ships on ships.class = classes.class
join outcomes on ship = ships.name
where result = 'sunk'
group by classes.class;

-- 2.5
select count(name)
from ships
join outcomes on name = ship
where result = 'sunk' and class in (select class
									from ships
									group by class
									having count(*) > 4)
group by class;

-- 2.6
select avg(displacement)
from classes
group by country;
