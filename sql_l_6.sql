// windowing function:- 1.aggregating windowing function(sum,min,max,avg,count)
                       2.analytical windowing function (row_number,rank,dens rank etc)
                       
it is the function which is work on the subset of dataset;

 create database win_fun;
use win_fun;

create table ineuron_students(
student_id varchar(50),
student_batch varchar(50),
student_name varchar(50),
student_stream varchar(50),
student_marks int,
student_mail_id varchar(50))

insert into ineuron_students values(100 ,'fsda' , 'saurabh','cs',80,'saurabh@gmail.com'),
(102 ,'fsda' , 'sanket','cs',81,'sanket@gmail.com'),
(103 ,'fsda' , 'shyam','cs',80,'shyam@gmail.com'),
(104 ,'fsda' , 'sanket','cs',82,'sanket@gmail.com'),
(105 ,'fsda' , 'shyam','ME',67,'shyam@gmail.com'),
(106 ,'fsds' , 'ajay','ME',45,'ajay@gmail.com'),
(106 ,'fsds' , 'ajay','ME',78,'ajay@gmail.com'),
(108 ,'fsds' , 'snehal','CI',89,'snehal@gmail.com'),
(109 ,'fsds' , 'manisha','CI',34,'manisha@gmail.com'),
(110 ,'fsds' , 'rakesh','CI',45,'rakesh@gmail.com'),
(111 ,'fsde' , 'anuj','CI',43,'anuj@gmail.com'),
(112 ,'fsde' , 'mohit','EE',67,'mohit@gmail.com'),
(113 ,'fsde' , 'vivek','EE',23,'vivek@gmail.com'),
(114 ,'fsde' , 'gaurav','EE',45,'gaurav@gmail.com'),
(115 ,'fsde' , 'prateek','EE',89,'prateek@gmail.com'),
(116 ,'fsde' , 'mithun','ECE',23,'mithun@gmail.com'),
(117 ,'fsbc' , 'chaitra','ECE',23,'chaitra@gmail.com'),
(118 ,'fsbc' , 'pranay','ECE',45,'pranay@gmail.com'),
(119 ,'fsbc' , 'sandeep','ECE',65,'sandeep@gmail.com')

select * from ineuron_students;

// aggregate windowing function---------
 select student_batch,sum(student_marks)  from  ineuron_students group by student_batch;
 select student_batch,min(student_marks)  from  ineuron_students group by student_batch;
 select student_batch,max(student_marks)  from  ineuron_students group by student_batch;
 select student_batch,count(student_marks)  from  ineuron_students group by student_batch;
 select student_batch,avg(student_marks)  from  ineuron_students group by student_batch;

set session sql_mode='';
// Analytical windwoing function----------------------------------------------------------------

QUESTION:-Find the name of student which has highest marks according to student_batch ?
select student_name from ineuron_students where student_marks in (
select max(student_marks) from ineuron_students group by student_batch);

QUESTION:- Name who recieved Second highest marks according to batch ??

select * from ineuron_students where student_batch= "fsda"  order by student_marks desc limit 1,1

QUESTION:- Name who recieved third  highest marks according to batch ??

select * from ineuron_students where student_batch= "fsda"  order by student_marks desc limit 2,1


QUESTION:-  all Name who recieved third  highest marks according to batch ??
select student_name from ineuron_students where student_marks =(
select min(student_marks) from
(select distinct student_marks from ineuron_students where 
student_batch="fsda" order by student_marks desc limit 3) as temp);


// windowing statement------------------------------------------------------------
---------------------------------------------------------------------------------
1(a):- Row_number()  ---

--- It create a seperate row 1-n and create whole data in a single window

select student_id,student_name, student_batch,student_stream, 
student_marks,row_number() over(order by student_marks desc) `row_number` from ineuron_students;


1(b):- partition by --
      its create a seperate row and there is different window according to particition 
      and row start 1-n,1-n for eac particition.

select student_id,student_name, student_batch,student_stream, 
student_marks,row_number() over( partition by student_batch order by student_marks desc) as `row_number`
 from ineuron_students;

// QUESTION:- FIND THE topper from the each batch 
  -- now we can easily find the topper 
  
  select * from (select student_id,student_name, student_batch,student_stream, 
student_marks,row_number() over( partition by student_batch order by student_marks desc) as `row_number`
 from ineuron_students) as final  where `row_number`=1

// QUESTION:- FIND THE second_highest from the each batch 
   
select * from (select student_id,student_name, student_batch,student_stream, 
student_marks,row_number() over( partition by student_batch order by student_marks desc) as  `row_number`
 from ineuron_students) as final  where `row_number`=2


// now there is problem this row_number is fail if there is more than one topper in dataset
its gives a single result to us ----------
soultion of its is rank() and dens rank() function.-----------


2(a):-  rank() -------------------
 It gives rank of column but internal it behave like row_number function.
 or
 we can say when it gives consecutive same number then next will adopt row number;


  select student_id,student_name, student_batch,student_stream, 
student_marks,rank() over(order by student_marks desc) as  row_rank from ineuron_students;

2(b):- partition by 
select * from (select student_id,student_name, student_batch,student_stream, 
student_marks,rank() over( partition by student_batch order by student_marks desc) as row_rank
 from ineuron_students) as final  where row_rank= 3

3:- dense_rank() -----------------------------------
    It gives consecutive rank valuesit cant skip any value or number 

 select student_id,student_name, student_batch,student_stream, 
student_marks,dense_rank() over(order by student_marks desc) as  row_rank from ineuron_students;
    
3(b):- partition by in dense_rank():-------
     
     select * from (select student_id,student_name, student_batch,student_stream, 
student_marks,dense_rank() over( partition by student_batch order by student_marks desc) as row_rank
 from ineuron_students) as final  where row_rank= 4
 
 
 // to find data between in particular ranks like in 1,2,3 ranks use 
 
 select * from (select student_id,student_name, student_batch,student_stream, 
student_marks,rank() over( partition by student_batch order by student_marks desc) as row_rank
 from ineuron_students) as final  where row_rank in(1,2,3)
 
 select * from (select student_id,student_name, student_batch,student_stream, 
student_marks,rank() over( partition by student_batch order by student_marks desc) as row_rank
 from ineuron_students) as final  where row_rank between 1 and 3


// we can aslo use all together --------------------------------------------

select student_id,student_name, student_batch,student_stream, 
student_marks,row_number() over(order by student_marks desc) as `row_number`,
rank() over(order by student_marks desc) as  row_rank,
dense_rank() over(order by student_marks desc) as  row_rank2
 from ineuron_students;


or

  select * from
  (select student_id,student_name, student_batch,student_stream, 
student_marks,row_number() over(order by student_marks desc) as `row_number`,
rank() over(order by student_marks desc) as  row_rank,
dense_rank() over(order by student_marks desc) as  row_rank2
 from ineuron_students) as test2 where row_rank=3
 
 
 -------------------------------------------------------------------------------------------------------
 -----------------------------------------------------------------------------------------------------
 -------------------------------------------------------------------------------------------------------
 -------------------------------------------------------------------------------------------------------

