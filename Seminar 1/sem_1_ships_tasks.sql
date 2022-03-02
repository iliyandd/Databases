-- Task 1
select class, country
from classes
where numguns > 10;

-- Task 2
select name as shipName
from ships
where launched < 1918;

-- Task 3
select ship, battle
from outcomes
where result = 'sunk';

-- Task 4
select name
from ships
where name = class;

-- Task 5
select name
from ships
where name like 'R%';

-- Task 6
select name
from ships
where name like '% %' and name not like '% % %';