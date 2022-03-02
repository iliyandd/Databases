-- Task 1
select address
from STUDIO
where name = 'MGM';

-- Task 2
select birthdate
from moviestar
where name = 'Sandra Bullock';

-- Task 3
select starname
from starsin
where MOVIEYEAR = 1980 and MOVIETITLE like '%Empire%';