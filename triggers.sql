use ships;


--Да се направи така, че при добавяне на нов клас
--автоматично да се добавя и нов кораб със същото
--име и с година на пускане на вода = null
go
create trigger tr1
on classes
after insert
as
	insert into ships(name, class)
	select class, class
	from inserted;
go

drop trigger tr1;

INSERT INTO Classes VALUES ('Test 1', 'bb', 'Bulgaria', 20, 20, 50000);

SELECT *
FROM Ships
WHERE name LIKE 'Test %';
--------------------------------


--При изтриване на кораб автоматично да се изтрива и
--неговият клас, ако няма повече кораби от този клас
go
create trigger tr2
on ships
after delete
as
	delete from classes
	where class not in (select class
						from ships)
		  and class in (select class
						from deleted);
go

drop trigger tr2;

DELETE FROM Ships
WHERE name LIKE 'Test %';

SELECT *
FROM Classes
WHERE class LIKE 'Test %';
---------------------------


--Да се направи така, че ако при добавяне на кораб годината му на
--пускане е по-голяма от текущата година, то годината да бъде променена на null
go
create trigger tr3
on ships
instead of update
as
	insert into ships(name, class, launched)
	select name, class,
	case
		when launched > year(getdate()) then null
		else launched
	end
	from inserted;
go

drop trigger tr3;

INSERT INTO Ships VALUES ('Test', 'Iowa', 2250);

SELECT * FROM Ships WHERE name = 'Test';

DELETE FROM Ships WHERE name = 'Test';
-------------------------------


use movies;
--При промяна на черно-бял филм на цветен съответният продуцент да получава $100000.
--Ако в една UPDATE заявка са били променени няколко филма на един продуцент, той да получи само веднъж 100000.
go
create trigger tr4
on movie
after update
as
	update movieexec
	set networth = networth + 100000
	where cert# in (select i.producerc#
				   from deleted d
				   join inserted i on i.title = d.title and i.year = d.year
				   where d.incolor = 'N' and i.incolor = 'Y');
go

drop trigger tr4;

SELECT * FROM MovieExec WHERE cert# IN (SELECT producerC# FROM Movie WHERE inColor = 'N');

UPDATE Movie SET inColor = 'Y';

SELECT * FROM MovieExec;

UPDATE Movie SET inColor = 'N' WHERE year = 2001;

SELECT * FROM MovieExec; -- няма промяна
-----------------------------------------


use ships;
---> Даден кораб не може да участва в битка, преди да бъде пуснат на вода.
---> Да не се допуска промяна на данните в Outcomes, ако промените водят до нарушаването на горното изискване
---> Aко се добавят/обновяват няколко реда и поне един от тях нарушава условието за коректност, цялата операция да бъде отменена
go
create trigger tr5
on outcomes
after insert, update
as
	if exists (select *
			   from inserted
			   join ships on ship = ships.name
			   join battles on battle = battles.name
			   where launched > year(battles.date))
		begin
			raiserror('Error: Ship is launched after the battle', 16, 10);
			rollback;
		end;
go

drop trigger tr5;

INSERT INTO Outcomes(ship, battle, result) VALUES ('Iowa', 'North Atlantic', 'sunk');

SELECT * FROM Outcomes WHERE ship = 'Iowa';
-----------------------------------------


---> С помощта на INSTEAD OF тригерите може да се изпълняват INSERT, UPDATE и DELETE заявки върху всеки изглед.
---> Пример: Да се създаде изглед, който за всеки потънал кораб извежда името му и името на битката, в която е потънал
--   Изгледът трябва да позволява INSERT.
go
create view SunkShips
as
	select ship, battle
	from outcomes
	where result = 'sunk';
go

go
create trigger tr6
on SunkShips
instead of insert
as
	insert into outcomes(ship, battle, result)
	select ship, battle, 'sunk'
	from inserted;
go

drop trigger tr6;



use movies;
-- 1.1
insert into moviestar values('Bruce Willis', 'somewhere', 'M', '2020-01-01');

go
create trigger t
on movie
after insert
AS  
    insert into STARSIN(movietitle, movieyear, STARNAME)
    select title, year, 'Bruce Willis'
    from inserted
    where title like '%save%' or title like '%world%';
go
 
insert into movie
values('Armageddon, save, world', 1998, 120, 'y', 'MGM', 123);
 
select * from starsin;
 
drop trigger t;


-- 1.2
go
create trigger highNetworth
on movieexec
instead of insert, update, delete
as
	if 500000 > (select avg(networth)
				 from movieexec)
		begin
			raiserror('You can not do this operation because average networth is under 500000', 16, 10);
			rollback;
		end;
go

drop trigger highNetworth;


-- 1.4
go
create trigger saveStarsinInsert
on starsin
instead of insert
as
	
go
