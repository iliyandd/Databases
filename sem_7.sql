-- 1.1
use movies;

insert into moviestar (name, birthdate)
values ('Nicole Kidman', '1967-06-20');

begin transaction

-- 1.2
delete from movieexec
where networth < 10000000;

-- 1.3
delete from moviestar
where address is null;

-- 1.4
update movieexec
set name = 'Pres. ' + name
where cert# in (select presc# from studio);

-- 2.1
use pc;

-- ...

rollback transaction


-
