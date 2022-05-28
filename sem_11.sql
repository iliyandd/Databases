use movies;

-- 1.1
go
create view name_birthdates_of_actrices
as
select name, birthdate
from moviestar
where gender = 'F';
go


-- 1.2
go
create view actrices_number_of_movies
as
select name, count(movietitle) as movie_number
from moviestar
left join starsin on name = starname
group by name;
go


use pc;
-- 2.1, 2.2, 2.3
go
create view products_details
as
(select code, model, price, 'Laptop' as type, speed
from laptop)
union all
(select code, model, price, 'PC', speed
from pc)
union all
(select code, model, price, 'Printer', NULL
from printer);
go


use ships;
-- 3.1
go
create view british_ships_details
as
select distinct name, classes.class, type, numguns, bore, displacement, launched
from classes
join ships on classes.class = ships.class
where country = 'Gt.Britain';
go


-- 3.2
go
select distinct name, numguns, displacement
from british_ships_details
where type = 'BB' and launched < 1919;
go


-- complete this


