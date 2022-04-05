-- Task 1
select model, speed as MHz, hd as GB
from pc
where price < 1200;

-- Task 2
select model, price / 1.1 as euro
from laptop
order by price;

-- Task 3
select model, hd, screen
from laptop
where price > 1000;

-- Task 4
select *
from printer
where color = 'y';

-- Task 5
select model, speed, hd
from pc
where (cd = '12x' or cd = '16x') and price < 2000;

-- Task 6
select code, model, (speed + ram + 10*screen) as rating
from laptop
order by rating desc, code;