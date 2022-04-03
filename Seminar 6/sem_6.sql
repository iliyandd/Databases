--Без повторение заглавията и годините на всички филми, заснети преди 1982, в които е играл
--поне един актьор (актриса), чието име не съдържа нито буквата 'k', нито 'b'. Първо да се изведат
--най-старите филми
use movies;

select distinct title, year
from movie
join starsin on title = movietitle and year = movieyear
where movieyear = 1982 and starname not in (select starname
											from starsin
											where starname like '%b%' and starname like '%k%')
order by year;
