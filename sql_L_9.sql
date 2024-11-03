// ---------trigger--------------------
1. Its try to execute automatically.
2. use in the helpof validation.
3.invokes automatically.
4. trigger are applicable with insert update or delete 

//------------types of trigger--------------
1.before insert trigger.
2.after insert trigger
---------------------
3.before delete trigger.
4.after after trigger.
--------------------------
5.before update trigger.
6.after update trigger.
--------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------

create database trigger_;
use trigger_;

CREATE TABLE course1(
course_id int,
course_desc varchar(50),
course_mentor varchar(50),
course_price int,
course_discount int,
create_date date);

alter table course1 add column (user_info varchar (90));

create table course_update(
course_mentor_update varchar(50),
course_price_update int,
course_discount_update int);

------------ BEFORE INSERT------------------------------

delimiter //
create trigger COURSE_BEFORE_INSERT
BEFORE INSERT ON COURSE1 for each row
begin
set new.create_date=sysdate();
set new.user_info=system_user();

end;
//

select * from course1;

insert into course1(course_id,course_desc,course_mentor,course_price,course_discount) 
  values(101,"fsda",'parveen',4000,10);
  
  select * from course1;
  
  drop trigger COURSE_BEFORE_INSERT

//----------------- trigger in reference with other table-------------------

create table ref_course(
record_insert_date date,
record_insert_user varchar(50));

delimiter $$
create trigger reference_trigger
before insert on course1 for each row
begin
set new.create_date=sysdate();
set new.user_info=system_user();
insert into ref_course values(sysdate(),system_user());

end
$$


insert into course1(course_id,course_desc,course_mentor,course_price,course_discount) 
  values(101,"fsda",'parveen',4000,10);
  
  select * from course1
  select * from ref_course
  
  
  create table test1(
  c1 varchar(50),
  c2 date,
  c3 int);
  
  
  create table test3(
  c1 varchar(50),
  c2 date,
  c3 int);
  
  
  create table test2(
  c1 varchar(50),
  c2 date,
  c3 int);
  
  QUESTION:-- YOU HAVE to update in test2 and test3 when we are going to perform action in test1.----------
  
    delimiter $$
    create trigger test
    before insert on test1 for each row
    begin
    insert into test2 values("xyz",sysdate(),1182002);
        insert into test3 values("zxy",sysdate(),1642000);

  end
  $$
   
   insert  into test1 values("abc",sysdate(),94167);
   
   select * from test1
      select * from test2
         select * from test3
         
         drop trigger test;
         
         //----------- after insert ------------is same syntax as before--trigger------------------
		
         delimiter $$
         create trigger  test1
         after insert on test1 for each row
         begin
         update test2 set c1="parveen" where c1="xyz";
         delete from test3 where c1="zxy";
         
         end
         $$
         
         set session sql_mode='';
         set sql_safe_updates=0;
         
            insert  into test1 values("naveen",sysdate(),828828);
            
            drop trigger test1;
            
// ---- before and after delete trigger -------------------------------

delimiter $$
create trigger delete_trigger
after delete on test1 for each row
begin
insert into test3 values("punit",sysdate(),1642000);
end
$$

delete from test1 where c1="naveen";


//---------- same as before delete trigger -----------------------

drop trigger delete_trigger;


//-----------before update----------------------

delimiter $$
create trigger to_delete_obserev
after update on test1 for each row
begin
insert into test2(c1,c2,c3) values(old.c1,old.c2,old.c3);
insert into test3(c1,c2,c3) values(new.c1,new.c2,new.c3);

end
$$ 

drop trigger to_delete_obserev;

      select * from test1
      select * from test2
         select * from test3
         
         update test1 set c1="mukul" where c1="abc";
         
         
NOTE:-- If both trigger are connected with a table then before trigger execute first
            and after trigger execute second.
            
------------------------------------------------------------------------------------------------------            
------------------------------------------------------------------------------------------------------            
------------------------------------------------------------------------------------------------------            
------------------------------------------------------------------------------------------------------            
------------------------------------------------------------------------------------------------------            