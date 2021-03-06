-- 1.1
use movies;
select name
from MOVIESTAR
where gender = 'F' and name in (
select name
from MOVIEEXEC
where NETWORTH > 10000000);


-- 1.2
select name
from MOVIESTAR
where name not in (
select name
from MOVIEEXEC);


-- 2.1
use pc;
select maker
from product
where product.model in (
select pc.model
from pc
where speed >= 500);


-- 2.2
select code, model
from laptop
where laptop.speed < all(
select speed
from pc);


-- 2.3
select distinct model
from (select model, price
		from pc
		union all
		select model, price
		from laptop
		union all
		select model, price
		from printer) AllProducts
where price >= all (select price
					from pc
					union all
					select price
					from laptop
					union all
					select price
					from printer);


-- 2.4
select maker
from product
where model in (
select model
from printer
where color = 'y' and price <= all(
select price
from printer
where color = 'y'));


-- 2.5
use pc;
select maker
from product
where product.model in (
	(select pc.model
	from pc
	where ram <= all(
		select ram
		from pc))
	union
	(select pc.model
	from pc
	where speed >= all(
		select speed
		from pc)));


-- 3.1
use ships;
select c1.country
from classes c1
where c1.numguns >= all(
	select c2.numguns
	from classes c2);


-- 3.2
select name
from ships
where class in (
	select class
	from classes
	where bore = 16);


-- 3.3
select battle
from outcomes
where ship in (
	select name
	from ships
	where ships.class in (
		select class
		from classes
		where class = 'Kongo'));


-- 3.4
select name from ships
where ships.class in (
	select class
	from classes c1
	where c1.numguns >= all(
		select c2.numguns
		from classes c2));