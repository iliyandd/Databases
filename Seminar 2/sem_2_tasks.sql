-- 1.1
use movies;
select name
from moviestar
join STARSIN on name = starname
where gender = 'F' and movietitle = 'Terms of Endearment';

-- 1.2
select name
from moviestar
join starsin on name = starname
join movie on title = movietitle and year = movieyear
where studioname = 'MGM' and year = 1995;

-- 2.1
use pc;
select maker, speed
from laptop
join product on laptop.model = product.model
where hd > 9;

-- 2.2
(select p.model, price
from product p
join laptop on p.model = laptop.model
where maker = 'B')
union
(select p.model, price
from product p
join pc on p.model = pc.model
where maker = 'B')
union
(select p.model, price
from product p
join printer on p.model = printer.model
where maker = 'B')
order by price desc;

-- 2.3
select distinct p1.hd
from pc p1
join pc p2 on p1.hd = p2.hd and p1.code <> p2.code;

-- 2.4
select pc1.model, pc2.model
from pc pc1
join pc pc2 on pc1.hd = pc2.hd and pc1.speed = pc2.speed
where pc1.model < pc2.model;

-- 3.1
use ships;
select name
from ships
join classes on ships.class = classes.class
where DISPLACEMENT > 35000;

-- 3.2
select ships.name, bore, numguns
from ships
join classes on ships.class = classes.class
join outcomes on ship = name
where battle like '%Guadalcanal%';

-- 3.3
(select country
from classes
where type = 'bb')

intersect

(select country
from classes
where type = 'bc');

-- 3.4
select o1.ship
from outcomes o1
join battles b1 on b1.name = o1.battle
join outcomes o2 on o1.ship = o2.ship
join battles b2 on b2.name = o2.battle
where o1.result = 'damaged' and b1.date < b2.date;
