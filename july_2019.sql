use movies;


/* (09.07.2019) Задача 4.2. Да се напише заявка,която да изведе имената на всички
продуценти с минимален нетен актив.*/

select distinct name
from movieexec
where networth <= all(select networth
					  from movieexec);
