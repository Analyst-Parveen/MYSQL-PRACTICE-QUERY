create database joins;
use joins;

CREATE TABle if not exists course(
course_id int,
course_name varchar(50),
course_desc varchar(50),
course_tag varchar(50));


create table if not exists student(
student_id int,
student_name varchar(50),
student_mobile int,
student_course_enroll varchar(50),
student_course_id int


insert into course values(101 , 'fsda' , 'full stack data analytics' , 'Analytics'),
(102 , 'fsds' , 'full stack data analytics' , 'Analytics'),
(103 , 'fsds' , 'full stack data science' , 'DS'),
(104 , 'big data' , 'full stack big data' , 'BD'),
(105 , 'mern' , 'web dev' , 'mern'),
(106 , 'blockchain' , 'full stack blockchain' , 'BC'),
(101 , 'java' , 'full stack java' , 'java'),
(102 , 'testing' , 'full testing ' , 'testing '),
(105 , 'cybersecurity' , 'full stack cybersecurity' , 'cybersecurity'),
(109 , 'c' , 'c language' , 'c'),
(108 , 'c++' , 'C++ language' , 'language')

insert into student values(301 , "sudhanshu", 3543453,'yes', 101),
(302 , "sudhanshu", 3543453,'yes', 102),
(301 , "sudhanshu", 3543453,'yes', 105),
(302 , "sudhanshu", 3543453,'yes', 106),
(303 , "sudhanshu", 3543453,'yes', 101),
(304 , "sudhanshu", 3543453,'yes', 103),
(305 , "sudhanshu", 3543453,'yes', 105),
(306 , "sudhanshu", 3543453,'yes', 107),
(306 , "sudhanshu", 3543453,'yes', 103)

select * from course;
select * from student;


select c.course_id,c.course_name,c.course_desc,s.student_name,s.student_course_id from 
course c join student s;

select c.course_id,c.course_name,c.course_desc,s.student_name,s.student_course_id from 
course c inner join student s;

select c.course_id,c.course_name,c.course_desc,s.student_name,s.student_course_id from 
course c cross join student s;

select c.course_id,c.course_name,c.course_desc,s.student_name,s.student_course_id from 
course c left join student s on c.course_id=s.student_course_id;


select c.course_id,c.course_name,c.course_desc,s.student_name,s.student_course_id from 
course c right join student s on c.course_id=s.student_course_id;



// ---------------union---------------------------
0:- its remove dublicate records.
 1:- no of column must be same.
2:- data-type od column can be vary
3:- use to add column vertically

select course_id,course_name  from course union select student_id,student_name from student;

// ---------------- union all----------------------------------
 1:- its not remove duplicate records.
 
 select course_id,course_name  from course union  all select student_id,student_name from student;


/// ----------------------INDEXING--------------------
  SHOW INDEX FROM COURSE
  1. ITS STORE DATA IN BTREE FOAM.
  2. LIKE GREATER VALUE AT RIGHT SIDE AND LOWER VALUE AT LEFT SIDE.
  3.ITS HELP TO FIND QUERY FASTLY.
  4. its highly optimize query in term of search operation.
  5. can create index with multiple column also.
  
  
  CREATE TABle if not exists course1(
course_id int,
course_name varchar(50),
course_desc varchar(50),
course_tag varchar(50),
INDEX(COURSE_id)
);


show index from course1;


insert into course1 values(101 , 'fsda' , 'full stack data analytics' , 'Analytics'),
(102 , 'fsds' , 'full stack data analytics' , 'Analytics'),
(103 , 'fsds' , 'full stack data science' , 'DS'),
(104 , 'big data' , 'full stack big data' , 'BD'),
(105 , 'mern' , 'web dev' , 'mern'),
(106 , 'blockchain' , 'full stack blockchain' , 'BC'),
(101 , 'java' , 'full stack java' , 'java'),
(102 , 'testing' , 'full testing ' , 'testing '),
(105 , 'cybersecurity' , 'full stack cybersecurity' , 'cybersecurity'),
(109 , 'c' , 'c language' , 'c'),
(108 , 'c++' , 'C++ language' , 'language')

select * from course1 where course_id=106 or course_name="fsda";

explain analyze select * from course1 where course_id=106 or course_name="fsda"
explain select * from course1 where course_id=106 or course_name="fsda"

desc course1

// ---------------------unique index------------------------------
1. its store distinct record.

CREATE TABle if not exists course2(
course_id int,
course_name varchar(50),
course_desc varchar(50),
course_tag varchar(50),
 unique INDEX(COURSE_id)
);


insert ignore into course2 values(101 , 'fsda' , 'full stack data analytics' , 'Analytics'),
(102 , 'fsds' , 'full stack data analytics' , 'Analytics'),
(103 , 'fsds' , 'full stack data science' , 'DS'),
(104 , 'big data' , 'full stack big data' , 'BD'),
(105 , 'mern' , 'web dev' , 'mern'),
(106 , 'blockchain' , 'full stack blockchain' , 'BC'),
(101 , 'java' , 'full stack java' , 'java'),
(102 , 'testing' , 'full testing ' , 'testing '),
(105 , 'cybersecurity' , 'full stack cybersecurity' , 'cybersecurity'),
(109 , 'c' , 'c language' , 'c'),
(108 , 'c++' , 'C++ language' , 'language')

select * from course2
select * from course1


//-------------CTE----(Ccomman table expression)---------------------------------------------
   its nothing but lets we have  tables table1 and table2, whatever data i have  fetch from table1.
   i trying to give alias  for that and based  on that i will be able to search something else
   from the same table.
   
   ---syntax---------
   
   with sample_cte  as
   (select * from course where course_name="big data" or course_id in(101,102,105))
   select * from sample_cte where course_tag="analytics";
   
with outcome_cross as 
(select c.course_id,c.course_name,s.student_id,s.student_name from course c cross join student s)
select * from outcome_cross where student_id=301

with ctest as
 (select 1 as coll1,2 as coll2 union select 3,4)
 select coll1 from ctest;
 
 
 //---------- recursive cte----------------------
 its call itself insie query
 
 with recursive cte(n) as
 (select 1 union all select n+2 from cte where n<11)
 select * from cte
 
 with recursive cte_test as 
 ( select 1 as n,1 as p, 2 as q union all select n+1,p+2,q+4 from cte_test where n<10 and p<10 or q<10)
 select * from cte_test;
 
 --------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------