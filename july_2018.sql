use movies;


/* (13.07.2013) Задача 4.1. Да се напише заявка, която да изведе име на студио, 
година на първия филм за това студио, година на последния филм за това студио и броя
на всички филми за това студио, само за тези студиа започващи с буквата 'M'.*/

select studioname, min(year), max(year), count(*)
from movie
where studioname like 'M%'
group by studioname;


/* (13.07.2013) Задача 4.2. Да се напише заявка, която да изведе името на актрисата,
участвала в най-много филми, и броя на филмите, в които е участвала.*/

select starname, count(movietitle)
from starsin
join moviestar on starname = name
where gender = 'F'
group by starname
having count(movietitle) >= all(select count(*)
								from starsin
								join moviestar on starname = name
								where gender = 'F'
								group by starname);
