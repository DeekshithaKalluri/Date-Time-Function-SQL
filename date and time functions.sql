use INDIAN_BANK

--1) getdate()
select getdate() as todaysdate         --2022-12-19 17:35:24.940
select getdate()-1 as yesterdaysdate   --2022-12-18 17:35:06.360
select getdate()+1 as trwsdate         --2022-12-20 17:36:04.210

select acid, name, cbalance, getdate() as todaysdate
from AccountMaster

--convert()
select convert (varchar, getdate()) --Dec 19 2022  5:38PM
select convert (varchar, getdate(), 1) --12/19/22
select convert (varchar, getdate(), 2) --22.12.19

--2) datediff()
select DATEDIFF(hh, '2019/3/23', getdate())

--what is my age?
select DATEDIFF(yy, '2002/10/12', getdate()) as myage

update AccountMaster
set doo = '2021/12/19'
where acid = 109

--list out the accounts opened in the current year
select acid, name, cbalance, doo, datediff(yy, doo, getdate()) as Ageofaccount
from AccountMaster
where datediff(yy, doo, getdate()) = 1

--list out the accounts opened today
select *--acid, name, cbalance, doo, datediff(yy, doo, getdate()) as Ageofaccount
from AccountMaster
where datediff(yy, doo, getdate()) = 0

--list out accounts opened in last 3 years
select *
from AccountMaster
where datediff(yy, doo, getdate()) <= 3

--3) datepart()
-- it returns the part of the date. it returns alaways an integer. it takes 2 arguments.
select datepart(yy, '2018/4/18') as yrno

select datepart(dd, getdate()) as currentday
select datepart(mm, getdate()) as currentmonth
select datepart(yy, getdate()) as currentyear
select datepart(ww, getdate()) as currentweek
select datepart(hh, getdate()) as currenthour
select datepart(mi, getdate()) as currentminute

--yearwise no of accounts opened
select datepart(yy, doo), count(*) as cnt
from AccountMaster
group by datepart(yy, doo) 
order by 1 desc

--list accounts opened in 2019
select acid, name, cbalance, datepart(yy, doo) as yearno
from AccountMaster
where datepart(yy, doo) = 2019

--list accounts opeend on 2019/01/17
--not recommended
select acid, name, cbalance, doo, DATEPART(yy, doo) as yrno
from AccountMaster
where doo = '2019/1/17' --it wont work if time is other than 00:00:00

--recommended
select acid, name, cbalance, doo, DATEPART(yy, doo) as yrno
from AccountMaster
where datepart(yy, doo) = 2019 and datepart(mm, doo) = 1 and datepart(dd, doo) = 17

--4) datename()
--It returns the name of the day or month. It always returns the sring. It takes 2 argument.
select datename(mm, getdate()) as monthname
select datename(dw, getdate()) as dayname

--5) dateadd()
--it adds/subracts days (OR) months (OR) years to the given date and returns the future/past date.
--it takes 3 arguments

select dateadd (dd, -40, getdate())
select dateadd (yy, -180, '2020/3/22')

--6) EOmonth()
--It gives us last day from the given date. it takes 1 argument 

select EOmonth('2020/5/12')

--find out month-wise no of accounts opened, year 2019

select datepart(mm, doo) as monthno, count(*) as cnt
from AccountMaster
where datepart(yy, doo) = 2019
group by datepart(mm, doo)

--
select datename(mm, doo) as mntname, count(*) as cnt
from AccountMaster
where datepart(yy, doo) = 2019
group by datepart(mm, doo), datename(mm, doo) 
order by datepart(mm, doo) asc
