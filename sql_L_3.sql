use sales
 select * from sales2

// its ignore the lttle bit error-----------------
SET SESSION sql_mode = ''
// for safe sql mode ---------------
set sql_safe_updates=0;


 
 create table sales1(
 date_id varchar(100)
 ,Open_s varchar(100)
 ,High varchar(100)
 ,Low varchar(100)
 ,Close_id varchar(100)
 ,Adj_Close varchar(100)
 ,Volume varchar(100)
 )
 
 load data infile 'C:/sales_dataset.csv'
 into table sales1
 fields terminated by ','
 enclosed by '"'
 lines terminated by '\n'
 ignore 1 rows
 
 
 
 create table sales2(
 date_id varchar(100)
 ,Open_s varchar(100)
 ,High varchar(100)
 ,Low varchar(100)
 ,Close_id varchar(100)
 ,Adj_Close varchar(100)
 ,Volume varchar(100)
 )
 
 
 
 create table sales3(DATE_no varchar(50),CBBTCUSD int)
 
 load data infile 'C:/date_dataset3.csv'
 into table sales3
 fields terminated by ','
 enclosed by '"'
 lines terminated by '\n'
 ignore 1 rows
 
 //  to modify the culum datatye---------------------------------
 alter table sales3 modify cbbtcusd float
truncate sales3 
 select * from sales1
  select * from sales2
  select * from sales3
  
 // to change the datatype of date string to date---------
  select str_to_date(date_id,'%d-%m-%Y') from sales1
 select str_to_date(date_id,'%d-%m-%Y') from sales2

 select str_to_date(date_no,'%d-%m-%y') from sales3
 select month(date_id)  as change_date from sales1

  
  // to add a column ---------
   alter table sales3 add column date_new date after cbbtcusd
   
   // to add values in new table
   // use small 'y' for current year and use capital 'Y' for existing year of dataset------------
   
  update sales3 set date_new= str_to_date(date_no,'%d-%m-%Y')
  -----------------------------------------------------------------------------------------
  alter table sales1 add column date_new date after date_id
  update sales1 set date_new= str_to_date(date_id,'%d-%m-%Y')
  
  --------------------------------------------------------------
  alter table sales2 add column date_new date after date_id
   update sales2 set date_new= str_to_date(date_id,'%d-%m-%Y')
   
   // safe sql mode is used when we want update in column without using where clause(doing with two diff. datatype)
   // we use safe sql mode 
   // to start -------------
    set sql_safe_updates =0;
    
    // to close -----------------
   set sql_safe_updates =1;
   
   
   // some practice queryies
   select * from sales1  where date_new='2011-12-28'
   
      select * from sales1  where date_new>'2011-12-28'
         select * from sales1  where date_new<'2011-12-28'
            select * from sales1  where date_new<'2011-12-28' and  date_new >'2011-12-20'
            select * from sales1  where date_new between  '2011-12-20'and'2011-12-28' 
            select * from sales1  where date_new >'2011-12-20'and date_new<'2011-12-28' 


//  some basic function for ----------
// current time ,cureent date , current time and date 

// its shows the cuurent date and time---------------
   select now()
   
   // to show only current date--------
   select curdate()

// to show current time only ----------
select curtime()

///// question be like ------------------------------------------
// find anything from table(either sales, volume etc,) done upto  before one week or 1 month or 1 year 

select * from sales1

select volume from sales1 where date_new < date_sub(curdate(), interval 12 year)
  
  // its gives data of cuurent minus interval value--------------
   select date_sub(now(), interval 1 week)

///////---- Question --
// create 3 more columns name as 1- year_new,2-month_new,3- day_new and store year in year and month in  month 
// and day in day in integer form from sales1-------------------

// answer---------------------

alter table sales1 add column year_new int
// here we need to solve safe mode problem---------
set sql_safe_updates=0
update sales1 set year_new= year(date_new)
-------------------------------------------------------------------

alter table sales1 add column month_new int
update sales1 set month_new= month(date_new)
--------------------------------------------------------------------------

alter table sales1 add column day_new int
update sales1 set day_new= day(date_new)

-------------- question solved is above-----------------------------------------------

// question-- create  column and put value in it 5 percent of day----
alter table sales1 add column day_percent float
update sales1 set day_percent= (day_new * 5/10)

//-------------------same on the behalf of logic we can create many columns------------------------------------

//// we can give a temporary name to any calumns while selecting it ---------
// using as -------------------------


// question --
// we want count that how many records have more then 8 day_percent and how many less then 8 day_percent---

// answer------------------

// if function be like
// if(condition> value , 'yes', 'no') if condition is true its store 'yes' and if false its store no----------

alter table sales1 add column flag_percent varchar(30)
update sales1 set flag_percent= if(day_percent>8, 'yes','no')

select * from sales1

select  flag_percent,count(*) from sales1 group by flag_percent
-----------or--------------------------------
select flag_percent, count(*) from sales1 where flag_percent='yes'
select flag_percent,count(*) from sales1 where flag_percent='no'

----------------------or-------------------------------

select flag_percent,count(*) from sales1 where day_percent>8
select  flag_percent,count(*) from sales1 where day_percent<8 or day_percent=8


//----------- some other function are --------------------
//   ------1-- dayname()
//--------2--- year()

select dayname(now())
select dayname('2024-05-7')

// we can  find the day of future of past present and future---------------

select year(now())

----------------------------------------------------------------------------------------------------------


