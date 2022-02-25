use movies;

select * 
from movie;

select *
from starsin;

select studioName, title
from movie;

select title, length / 60 as hours
from movie;

select *
from movie
where studioName = 'Disney' and year = 1990;

select *
from movie
where title like 'Star %_';

-- with "<" we can compare strings

select *
from MovieStar
where birthdate > '1970-06-01';

select name, year(birthdate) as born
from MovieStar
where month(birthdate) = 7;

select *
from movie
where length is null;

select title, year, length
from movie
where length > 60
order by length desc, title;