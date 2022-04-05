-- 1. Без повторение заглавията и годините на всички филми, заснети преди 1982, в които е играл
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


--2. Заглавията и дължините в часове (length е в минути) на всички филми, които са от същата
--година, от която е и филмът Terms of Endearment, но дължината им е по-малка или неизвестна.

select title, (length / 60) hours
from movie m1
where m1.year in (select year
				  from movie m2
				  where m2.title = 'Terms of Endearment' and (m1.length < m2.length or m1.length is null));


-- 3. Имената на всички продуценти, които са и филмови звезди и са играли в поне един филм
-- преди 1980 г. и поне един след 1985 г

select name
from movieexec
where name in (select starname
			   from starsin
			   join movie on movietitle = title and movieyear = year
			   where year < 1980
			   union
			   select starname
			   from starsin
			   join movie on movietitle = title and movieyear = year
			   where year > 1985);


-- 4. Всички черно-бели филми, записани преди най-стария цветен филм (InColor='y'/'n') на същото
-- студио.

select * 
from movie m1
where m1.incolor = 'y/n' and m1.year < (select min(m2.year)
										  from movie m2
										  where m2.incolor = 'y' and
										  m1.studioname = m2.studioname);