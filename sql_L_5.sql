// referential key and primary key and foreign keys ----------------------------

create database key_prim;
use key_prim; 

// -----primary key can be combination of multiple columns 
// it cant be null
// it cant be duplicate-----------


create table ineuron(
course_id int not null,
course_name varchar(30),
course_status varchar(30),
nimber_of_enroll int,
primary key(course_id));

select * from ineuron;

insert into ineuron values (01,'fssda','active',100),
(02,'fssda','active',100),
(03,'fssdc','in_active',200),
(04,'fssda','active',100),
(05,'fssde','in_active',400),
(06,'fsda','active',100);

select * from ineuron;

create table student_ineuron(
student_id int,
course_name varchar(50),
student_mail varchar(60),
student_status varchar(40),
course_id int,
foreign key(course_id) references ineuron(course_id));

// whenever we want to create a relation or establish a relation b/w two or
//   more table we use foreign key & primary key-----------------

// now there is a relation between both table and id which is of course_id in student_ineuron 
// table is must be in course id of ineuro table------------


insert into student_ineuron values(101,'fsda','test@gmail.com','active',03),
(102,'fsdc','test@gmail.com','active',01),
(103,'fsde','test1@gmail.com','in_active',02),
(104,'fsda','test2@gmail.com','inactive',05),
(101,'fsda','test4@gmail.com','inactive',04),
(106,'fsde','test5@gmail.com','active',02),
(105,'fsdi','test3@gmail.com','active',04),

truncate student_ineuron
select *from student_ineuron

//---- foreign key allow restriction in inserting data in case of if the data is not
//-- available in parents table of that key-----------

//- we can add multiple data with a single id with foreign key(one to may ) relationship-----
// if we daclare that key also a primary key then it show(one to one) relation 

//its help us to create a model 
// we can check it by tool--------
// click on-> home -> (>)-->create EER model from database ->save -> filename ->next->password-> next
//---> select database->next-->next--> execute.----------

create table payment(
course_name varchar(30),
course_id int,
course_live_status varchar(30),
course_launc_date varchar(30),
foreign key(course_id) references ineuron(course_id))

insert into payment values('fsda',01,'not active','7th aug'),
('fsde',01,'not active','8th aug'),
('fsdp',02,'active','9th aug'),
('fsdl',03,'not active','5th aug'),
('fsdi',03,'active','6th aug'),
('fsda',06,'not active','3th aug')

select * from payment;

// note--EER-- enhance entity relationship----------------

create table class(
course_id int,
class_name varchar(60),
class_topic varchar(60),
class_duration int,
primary key(course_id),
foreign key (course_id) references ineuron(course_id))

// here course_id behave as primary key as well as foreign key ---------------
// and cant add duplcate record--------------------


// we can make primary key is combination of column------

create table batch(
course_id int,
roomlass_name varchar(60),
room_topic varchar(60),
room_duration int,
primary key(course_id,room_duration),
foreign key (course_id) references ineuron(course_id))


select * from batch

/////--- NOTE- we cant perform alter and delete or update operation on a parent table while table is showing a
// relationship between them like------------->
//--> alter table ineuron add constraint test_prim primary key(course_id,course_name)
//---->alter table ineuron drop primary key
//--->delete from ineuron where coorse_id= 01

//-->we cant perform above query with parent table pr we can say 
//    with a table wfich is establishing the relation -------------------------------





// to perform these operation 2 methods
---> 1. firstly delete child table from relation and then apply operation
---> 2. on delete cascade or on update cascade---

// 2. method--> in this method we changed or apply query on one and related table is automatically update---

create table parent(
id int,
primary key(id))

insert into parent values(1),(2)
insert into parent values(2),(3),(4)

create table child(
id int,
parent_id int,
foreign key(parent_id) references parent(id) on delete cascade )

insert into child values(1,1),(1,2),(3,2),(2,2)

select * from parent
select * from child

// --> now we can apply delete  query--------

delete from parent where id=2
drop table child

// also we can use on update cascade-----------

create table child2(
id int,
parent_id int,
foreign key(parent_id) references parent(id) on update cascade )

insert into child2 values(1,1),(1,2),(3,2),(2,2),(2,3),(5,3),(6,4),(2,3),(3,3),(4,4)

update parent set id=9 where id=2
select * from child2
select * from parent


// ----> we can use both together on delete cascade and on update cascade-----------------

create table child3(
id int,
parent_id int,
foreign key(parent_id) references parent(id) on update cascade 
on delete cascade )





