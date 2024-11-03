// creating a database

 create database school
 use school
  
  create table student2(school varchar(30)
,sex varchar(30)
,age  varchar(30)
,address varchar(30)
,famsize varchar(30)
,Pstatus varchar(30)
,Medu varchar(30)
,Fedu varchar(30)
,Mjob varchar(30)
,Fjob varchar(30)
,reason varchar(30)
,guardian varchar(30)
,traveltime varchar(30)
,studytime varchar(30)
,failures varchar(30)
,schoolsup varchar(30)
,famsup varchar(30)
,paid varchar(30)
,activities varchar(30)
,nursery varchar(30)
,higher varchar(30)
,internet varchar(30)
,romantic varchar(30)
,famrel varchar(30)
,freetime varchar(30)
,goout varchar(30)
,Dalc varchar(30)
,Walc varchar(30)
,health varchar(30)
,absences varchar(30)
,G1 varchar(30)
,G2 varchar(30)
,G3 varchar(30)
)

{

load data infile'D:/sql_transfer/dataset/bulk.csv.csv'
 into table student2
fields terminated by ','
 enclosed by '"'
lines terminated by '\n'
ignore 1 rows;
}

select * from student2

// instead of above query use table icon right click on it then table data import wizard
// then browse and then select according you;


select* from student;


//  creating a table using constraints ---------------------
// auto_increment----------

create table if not exists test(
test_id int auto_increment,
test_name varchar(30),
test_mailid varchar(30),
test_address varchar(30),
primary key(test_id)
)

select * from test

insert into test(test_name,test_mailid,test_address)  values('parveen','par@mail.com','bapor')
insert into test(test_id,test_name,test_mailid,test_address)  values(22,'parveen','par@mail.com','bapor')

// NOTE--- there can only be  one auto_increment it must be primary key 

// Another constraints is check -------------
// its check the condition if its true then excute else display some error violated
// we can use more then one check


create table if not exists test2(
test_id int auto_increment,
test_name varchar(30),
test_mailid varchar(30),
test_address varchar(30),
test_sallary int check(test_sallary>10000),
primary key(test_id)
)

insert into test2(test_id,test_name,test_mailid,test_address,test_sallary)  values(22,'parveen','par@mail.com','bapora',50000)

create table if not exists test3(
test_id int auto_increment,
test_name varchar(30),
test_mailid varchar(30),
test_address varchar(30) check(test_address='bhiwani'),
test_sallary int check(test_sallary>10000),
primary key(test_id)
)

insert into test3(test_id,test_name,test_mailid,test_address,test_sallary)  values(22,'parveen','par@mail.com','bhiwani',50000)

select * from test3

// after creation of table we want apply the constraints--------------------
// by using alter method 

alter table test3 add check(test_name='parveen')


///// DEFAULT constraints---------------
// use to give default values to the fields-------------

// UNIQUE constraints ------------------
// check all values are to be unique----------

// NOT NULL constraints 
// check that no values remains null------------------





------------- primary key
==> only one primary key is possible inside a table
==> it is used in modelling or create a relationship between tables
==> it can not be null

----------------- UNIQUE key---------
==>it can be more then one 
==>can be null


// combine example of all the constraints

create table if not exists test4(
test_id int not null auto_increment,
test_name varchar(30) not null default 'unknown',
test_mailid varchar(30) unique not null,
test_address varchar(30) check(test_address='bhiwani') not null,
test_sallary int check(test_sallary>10000),
primary key(test_id)
)

select * from test4

insert into test4(test_id,test_name,test_mailid,test_address,test_sallary) 
 values(100,'parveen','par@mail.com','bhiwani',50000)
 
insert into test4(test_name,test_mailid,test_address,test_sallary) 
 values('parveen','par1@mail.com','bhiwani',50000)
 
 insert into test4(test_id,test_name,test_mailid,test_address) 
 values(10,'parveen','par2@mail.com','bhiwani')
 
 insert into test4(test_id,test_name,test_address,test_sallary,test_mailid) 
 values(102,'parveen','bhiwani',50000,'pun@.mail')
 
 insert into test4(test_address,test_sallary,test_mailid) 
 values('bhiwani',35000,'pun1@.mail')
 
 
 
 select * from test4





