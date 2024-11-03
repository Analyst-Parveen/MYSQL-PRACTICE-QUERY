use sales
show tables
select * from sales1
select * from sales2
select * from sales3

// Function in sql 
// syntax ----------------
   // declare a int ----- to declare a ocal variable ---------------------------------------
   subtract
   
   delimiter &&
   create function add_with(a int)
   returns int
   deterministic
   begin
   declare b int;
   set b =a+10;
   return b;
   end &&
   
   select add_with(15)
   
    delimiter $$
   create function add_to(a int)
   returns int
   deterministic
   begin
   declare b int;
   set b =a+10;
   return b;
   end$$
   
   
    delimiter $$
   create function circle_area(a int)
   returns int
   deterministic
   begin
   declare b int;
   set b =22/7*(a*a);
   return b;
   end $$
   
   select circle_area(2)
   
   delimiter $$
   create function cir_radius(a float)
   returns float
   deterministic
   begin
   declare b float;
   set b =(3.14)*(a*a);
   return b;
   end $$
select cir_radius(2)

select * from sales1
   select add_with(year_new) from sales1
   
   
   // function like take two input of integer and return substraction of them ----------
   
   delimiter $$
   create function subtracts( a int, b int)
   returns int
   deterministic 
   begin
   declare c int;
   set c= (a-b);
   return c;
   end $$
   
   select subtracts(10,5)
   select subtracts(day_new,month_new) from sales1 
   
   
   // create a function which convert the integer into string -------------
    
    delimiter $$
    create function integer_to_string(a int)
    returns varchar(30)
    deterministic 
   begin
   declare b varchar(30);
   set b=a;
   return b;
   end $$
   select integer_to_string(day_new) from sales1
   
   // is else statment in sql-------------------------------
   
   delimiter $$
   create function set_flag(a int)
   returns varchar(30)
   deterministic
   begin
   declare flag varchar(30);
   if a>0 and a<=10 then
   set flag="super affordable";
   elseif a<=20 then
   set flag ="affordable";
   elseif a<=25 then 
   set flag="moderate";
   else 
   set flag= "expensive";
   end if;
   return flag;
   end $$
   
   select set_flag(day_new) from sales1
   
   delimiter &&
   create function flag_no(day_new int)
   returns int
   deterministic
   begin
   declare b int;
   if day_new>0 and day_new<=10 then
   set b=0;
   elseif day_new<=20 then 
   set b=1;
   elseif day_new<=25 then 
   set b=2;
   else set b=3;
   end if;
   return b;
   end &&
   
   select * from sales1
      select day_new,flag_no(day_new) from sales1

   
   //--- we can change the function property by clicking the tool button on function----------
-----------------------------------------
-------------------------------------

// -procedure--- it call the query-
//--we can return sql query statement over these
// when we call it it call inside it selected query------


// function
------ it always behave like a action 
//---- function return value all the time ---------

---
-
-
-
--/// loop in sql --------------------------------
// declaring global variable ---------
//--set @var 10

counting:loop
set @var=@var+1;
if @var=100 then
leave counting;
end if;
end loop counting;

//how to use a loop-------------
create table test(s_no int)

 delimiter &&
 create procedure loop_table()
 begin 
 set @var=10;
 loop_start:loop
 insert into test values(@var);
 set @var = @var+1;
 if @var=100 then
 leave loop_start;
 end if;
 end loop loop_start;
 end &&
 
   select *from test
   call loop_table ()
   
   
   //// quetion-- add the no in table by looping between 1-100 which is divisible by 3--------- 
   
   create table divsible_by_3(num int
   create table test2(s_no int)
   
   delimiter $$
   create procedure loop_no()
   begin 
   set @variable =1;
   start_loop:loop
       set @variable= @variable+1;
    if @variable % 3=0 then
 insert into test2 values(@variable);
   elseif @variable =100 then
   leave start_loop;
   end if;
   end loop start_loop;
   end $$
   
    
   select * from test2
     call loop_no ()
   
   // create a loop for a table to insert a record into a table for the column you have to insert data b/w 
   // 1-100 and in second cloumn you have to insert a square of the first column----------
   
   create table task1(num int, square int)
   
   delimiter $$
   create procedure add_square_num()
   begin
   set @var=0;
   add_loop_num:loop
   set @var=@var+1;
   insert into task1 values(@var,(@var*@var));
   if @var=100 then
   leave add_loop_num;
   end if;
   end loop add_loop_num;
   end $$
   
   select * from task1
call  add_square_num()

// create a udf function to find out a log base 10 of any given number ------------

delimiter $$
create function logarize(a int)
returns float
deterministic
begin
declare var float;
set var=log10(a);
return var;

end $$

// ---create a udf function ehich will be able to checm the total no. of record available in  your table---

delimiter $$
create function records_count()
returns int
deterministic
begin
declare var int;
select count(*) into var from sales1;
return var;
end $$

select * from sales1
select records_count() 


delimiter $$
create procedure record_count()
begin
  select  count(*) from sales1;
end $$

call record_count();

select * from sales1


//--- create a procedure the second higest value ina column -------------

delimiter &&
create procedure highest()
begin 
select distinct(day_new) from sales1 order by day_new desc limit 4,1;
end &&


call highest()

