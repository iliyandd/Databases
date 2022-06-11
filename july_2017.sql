use movies;

/* (11.07.2017) Задача 3.1. Попълнете липсващите части, обозначени с ___ така, че 
заявката да изведе за всяко студио името на студиото, заглавието и годината на филма,
излязъл последно на екран за това студио.
select studioname, title, year
from movie m 
where year = (select _____
			  from movie
              where _______________);*/

select studioname, title, year
from movie m
where year = (select max(year)
			  from movie
			  where studioname = m.studioname);


/* (11.07.2017) Задача 3.2. Попълнете липсващите части, обозначени с ___ така, че 
заявката да изведе име на продуцент и обща дължина на продуцираните от него филми,
за тези продуценти, които имат поне един филм преди 1980.
select name, __________
from movieexec join movie on producerc#=cert#
____________________
____________________;*/

select name, sum(length)
from movieexec
join movie on producerc# = cert#
where cert# in (select producerc#
				from movie
				where year < 1980)
group by name;


/* (11.07.2017) Задача 3.3. Попълнете липсващите части, обозначени с ___ така, че 
заявкада да изведе име на актьорите, участвали във филми на продуценти с най-големи
нетни активи, както и заглавие на филмите, в които са участвали, име на продуцент и
нетни активи.
select starname,title,name,networth
from starsin join movie on movietitle=title and movieyear=year
join (select cert#, networth, name
	  from movieexec
      where _______________)t
______________________________;*/

select starname, title, name, networth
from starsin
join movie on movietitle = title and movieyear = year
join (select cert#, networth, name
	  from movieexec
	  where networth = (select max(networth)
						from movieexec)) t on producerc# = t.cert#;
