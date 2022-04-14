use movies;

--Напишете заявка, която извежда заглавие и година на всички филми, които са
--по-дълги от 120 минути и са снимани преди 2000 г. Ако дължината на филма е
--неизвестна, заглавието и годината на този филм също да се изведат.
select title, year
from movie
where (length is null or length > 120) and year < 2000;


--Напишете заявка, която извежда име и пол на всички актьори (мъже и жени),
--чието име започва с 'J' и са родени след 1948 година. Резултатът да бъде
--подреден по име в намаляващ ред.

select name, gender
from moviestar
where name like 'J%' and birthdate > 1948
order by name desc;


--Напишете заявка, която извежда име на студио и брой на актьорите,
--участвали във филми, които са създадени от това студио.

select studioname, count(distinct starname)
from movie
join starsin on title = movietitle and year = movieyear
group by studioname;


--Напишете заявка, която за всеки актьор извежда име на актьора и броя на
--филмите, в които актьорът е участвал.

select starname, count(distinct title)
from starsin
join movie on title = movietitle and year = movieyear
group by starname;


--Напишете заявка, която за всяко студио извежда име на студиото и заглавие
--на филма, излязъл последно на екран за това студио.

select studioname, max(year)
from movie
group by studioname;


--Напишете заявка, която извежда името на най-младия актьор (мъж).

select name
from moviestar
where gender = 'M' and birthdate >= all(select birthdate
									   from moviestar
									   where gender = 'M');


use ships;

--Напишете заявка, която извежда имената на всички кораби без повторения,
--които са участвали в поне една битка и чиито имена започват с C или K.

select distinct ship
from outcomes
where ship like 'C%' or ship like 'K%';


--Напишете заявка, която извежда име и държава на всички кораби, които
--никога не са потъвали в битка (може и да не са участвали).

select name, country
from ships
join classes on ships.class = classes.class
join outcomes on name = ship
where name not in (select ship
				   from outcomes) or name not in (select ship
												  from outcomes
												  where result like 'sunk');


--Напишете заявка, която извежда държавата и броя на потъналите кораби за
--тази държава. Държави, които нямат кораби или имат кораб, но той не е
--участвал в битка, също да бъдат изведени.

select country, count(ship)
from classes
left join ships on ships.class = classes.class
left join outcomes on ship = name and result = 'sunk'
group by country;
