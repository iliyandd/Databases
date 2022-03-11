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
--select maker
--from product
--where model in (
--select model
--from pc
--where);