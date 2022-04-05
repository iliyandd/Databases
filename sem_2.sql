use movies;
select title, year, studioname, address
from movie
join studio on studioname = name
where incolor = 'y';


use pc;
select maker, laptop.model, price
from laptop
join product on laptop.model = product.model
where screen = 15;


use movies;
select m1.title
from movie m1, movie m2
where m2.title = 'Star Wars' and m1.length > m2.length;


use movies;
select name, title
from moviestar
join starsin on name = starname
join movie on movietitle = title and movieyear = year
where gender = 'F' and studioname = 'MGM';


use movies;
(select title, year
from movie
where incolor = 'y')
union
(select movietitle, movieyear
from starsin
where starname = 'Harrison Ford');


(select name, address
from moviestar
where gender = 'F')
intersect
(select name, address
from movieexec
where networth > 10000000);


use ships;
select distinct battle
from outcomes
where result = 'sunk';


