create database ineuron_partition;
use ineuron_partition;

// partition:-
  in mostly query we search or compare every  row  to find the expected result
  
BUT in partition clause it help to search fastly it create sub-table internally and fetch record 
without checking every record

create table ineuron_course(
course_name varchar(50),
course_id int,
course_title varchar(50),
course_desc varchar(50),
launch_date date,
course_fee int,
course_mentor varchar(60),
course_launch_year int);

select * from ineuron_course;

insert into ineuron_course values('machine_learning' , 101 , 'ML', "this is ML course" ,'2019-07-07',3540,'sudhanshu',2019) ,

('aiops' , 101 , 'ML', "this is aiops course" ,'2019-07-07',3540,'sudhanshu',2019) ,
('dlcvnlp' , 101 , 'ML', "this is ML course" ,'2020-07-07',3540,'sudhanshu',2020) ,
('aws cloud' , 101 , 'ML', "this is ML course" ,'2020-07-07',3540,'sudhanshu',2020) ,
('blockchain' , 101 , 'ML', "this is ML course" ,'2021-07-07',3540,'sudhanshu',2021) ,
('RL' , 101 , 'ML', "this is ML course" ,'2022-07-07',3540,'sudhanshu',2022) ,
('Dl' , 101 , 'ML', "this is ML course" ,'2022-07-07',3540,'sudhanshu',2022) ,
('interview prep' , 101 , 'ML', "this is ML course" ,'2019-07-07',3540,'sudhanshu',2019) ,
('big data' , 101 , 'ML', "this is ML course" ,'2020-07-07',3540,'sudhanshu',2020) ,
('data analytics' , 101 , 'ML', "this is ML course" ,'2021-07-07',3540,'sudhanshu',2021) ,
('fsds' , 101 , 'ML', "this is ML course" ,'2022-07-07',3540,'sudhanshu',2022) ,
('fsda' , 101 , 'ML', "this is ML course" ,'2021-07-07',3540,'sudhanshu',2021) ,
('fabe' , 101 , 'ML', "this is ML course" ,'2022-07-07',3540,'sudhanshu',2022) ,
('java' , 101 , 'ML', "this is ML course" ,'2020-07-07',3540,'sudhanshu',2020) ,
('MERN' , 101 , 'ML', "this is ML course" ,'2019-07-07',3540,'sudhanshu',2019) 

select * from ineuron_course;

select * from ineuron_course where course_launch_year=2020;

 // its take more time to execute so thats why we use the partition------------
 
1.:- // --------- partition by range---------------------------------
 
 drop table ineuron_course1;
 
create table ineuron_course1(
course_name varchar(50),
course_id int,
course_title varchar(50),
course_desc varchar(50),
launch_date date,
course_fee int,
course_mentor varchar(60),
course_launch_year int)
partition by range (course_launch_year)(
partition p0  values less than (2019),
partition p1  values less than (2020),
partition p2  values less than (2021),
partition p3 values less than (2022),
partition p4 values less than (2023));


insert ignore into ineuron_course1 values('machine_learning' , 101 , 'ML', "this is ML course" ,'2019-07-07',3540,'sudhanshu',2019) ,

('aiops' , 101 , 'ML', "this is aiops course" ,'2019-07-07',3540,'sudhanshu',2019) ,
('dlcvnlp' , 101 , 'ML', "this is ML course" ,'2020-07-07',3540,'sudhanshu',2020) ,
('aws cloud' , 101 , 'ML', "this is ML course" ,'2020-07-07',3540,'sudhanshu',2020) ,
('blockchain' , 101 , 'ML', "this is ML course" ,'2021-07-07',3540,'sudhanshu',2021) ,
('RL' , 101 , 'ML', "this is ML course" ,'2022-07-07',3540,'sudhanshu',2022) ,
('Dl' , 101 , 'ML', "this is ML course" ,'2022-07-07',3540,'sudhanshu',2022) ,
('interview prep' , 101 , 'ML', "this is ML course" ,'2019-07-07',3540,'sudhanshu',2019) ,
('big data' , 101 , 'ML', "this is ML course" ,'2020-07-07',3540,'sudhanshu',2020) ,
('data analytics' , 101 , 'ML', "this is ML course" ,'2021-07-07',3540,'sudhanshu',2021) ,
('fsds' , 101 , 'ML', "this is ML course" ,'2022-07-07',3540,'sudhanshu',2022) ,
('fsda' , 101 , 'ML', "this is ML course" ,'2021-07-07',3540,'sudhanshu',2021) ,
('fabe' , 101 , 'ML', "this is ML course" ,'2022-07-07',3540,'sudhanshu',2022) ,
('java' , 101 , 'ML', "this is ML course" ,'2020-07-07',3540,'sudhanshu',2020) ,
('MERN' , 101 , 'ML', "this is ML course" ,'2019-07-07',3540,'sudhanshu',2019) 

select * from ineuron_course1;

select * from ineuron_course1 where course_launch_year=2020;

select partition_name,table_name,table_rows from information_schema.partitions 
where table_name="ineuron_course1";


// partition by hash:-  
---its store the value by hash function 
---its divide the value with partition value and store on the behalf of remainder;
--- can be done with only integer values

create table ineuron_course2(
course_name varchar(50),
course_id int,
course_title varchar(50),
course_desc varchar(50),
launch_date date,
course_fee int,
course_mentor varchar(60),
course_launch_year int)
partition by hash(course_launch_year)
partitions 10;

insert ignore into ineuron_course2 values('machine_learning' , 101 , 'ML', "this is ML course" ,'2019-07-07',3540,'sudhanshu',2019) ,

('aiops' , 101 , 'ML', "this is aiops course" ,'2019-07-07',3540,'sudhanshu',2019) ,
('dlcvnlp' , 101 , 'ML', "this is ML course" ,'2020-07-07',3540,'sudhanshu',2020) ,
('aws cloud' , 101 , 'ML', "this is ML course" ,'2020-07-07',3540,'sudhanshu',2020) ,
('blockchain' , 101 , 'ML', "this is ML course" ,'2021-07-07',3540,'sudhanshu',2021) ,
('RL' , 101 , 'ML', "this is ML course" ,'2022-07-07',3540,'sudhanshu',2022) ,
('Dl' , 101 , 'ML', "this is ML course" ,'2022-07-07',3540,'sudhanshu',2022) ,
('interview prep' , 101 , 'ML', "this is ML course" ,'2019-07-07',3540,'sudhanshu',2019) ,
('big data' , 101 , 'ML', "this is ML course" ,'2020-07-07',3540,'sudhanshu',2020) ,
('data analytics' , 101 , 'ML', "this is ML course" ,'2021-07-07',3540,'sudhanshu',2021) ,
('fsds' , 101 , 'ML', "this is ML course" ,'2022-07-07',3540,'sudhanshu',2022) ,
('fsda' , 101 , 'ML', "this is ML course" ,'2021-07-07',3540,'sudhanshu',2021) ,
('fabe' , 101 , 'ML', "this is ML course" ,'2022-07-07',3540,'sudhanshu',2022) ,
('java' , 101 , 'ML', "this is ML course" ,'2020-07-07',3540,'sudhanshu',2020) ,
('MERN' , 101 , 'ML', "this is ML course" ,'2019-07-07',3540,'sudhanshu',2019) 


select partition_name,table_name,table_rows from information_schema.partitions
 where table_name="ineuron_course2";
 

// partition by key :-------
-- its store the data internally in partition byba different hash function which is md5()
select md5(2015);
select md5(2019);
select md5("mern");  

     create table ineuron_course3(
course_name varchar(50),
course_id int primary key,
course_title varchar(50),
course_desc varchar(50),
launch_date date,
course_fee int,
course_mentor varchar(60),
course_launch_year int)
partition by key()
partitions 10;


insert ignore into ineuron_course3 values('machine_learning' , 101 , 'ML', "this is ML course" ,'2019-07-07',3540,'sudhanshu',2019) ,

('aiops' , 102 , 'ML', "this is aiops course" ,'2019-07-07',3540,'sudhanshu',2019) ,
('dlcvnlp' , 103 , 'ML', "this is ML course" ,'2020-07-07',3540,'sudhanshu',2020) ,
('aws cloud' , 104 , 'ML', "this is ML course" ,'2020-07-07',3540,'sudhanshu',2020) ,
('blockchain' , 105 , 'ML', "this is ML course" ,'2021-07-07',3540,'sudhanshu',2021) ,
('RL' , 106 , 'ML', "this is ML course" ,'2022-07-07',3540,'sudhanshu',2022) ,
('Dl' , 107 , 'ML', "this is ML course" ,'2022-07-07',3540,'sudhanshu',2022) ,
('interview prep' , 108 , 'ML', "this is ML course" ,'2019-07-07',3540,'sudhanshu',2019) ,
('big data' , 109 , 'ML', "this is ML course" ,'2020-07-07',3540,'sudhanshu',2020) ,
('data analytics' , 110 , 'ML', "this is ML course" ,'2021-07-07',3540,'sudhanshu',2021) ,
('fsds' , 111 , 'ML', "this is ML course" ,'2022-07-07',3540,'sudhanshu',2022) ,
('fsda' , 112 , 'ML', "this is ML course" ,'2021-07-07',3540,'sudhanshu',2021) ,
('fabe' , 113 , 'ML', "this is ML course" ,'2022-07-07',3540,'sudhanshu',2022) ,
('java' , 114 , 'ML', "this is ML course" ,'2020-07-07',3540,'sudhanshu',2020) ,
('MERN' , 115 , 'ML', "this is ML course" ,'2019-07-07',3540,'sudhanshu',2019) 

select partition_name,table_name,table_rows from information_schema.partitions where table_name="ineuron_course3";


// partition by list:--------------------------------------------------------------------------------
  --- values for partition is must be have integer values---------------
  
       create table ineuron_course4(
course_name varchar(50),
course_id int,
course_title varchar(50),
course_desc varchar(50),
launch_date date,
course_fee int,
course_mentor varchar(60),
course_launch_year int)
partition by list(course_launch_year)(
partition p0 values in (2019,2020),
partition p1 values in (2021,2022),
partition p2 values in (2023,2024))




insert ignore into ineuron_course4 values('machine_learning' , 101 , 'ML', "this is ML course" ,'2019-07-07',3540,'sudhanshu',2019) ,

('aiops' , 102 , 'ML', "this is aiops course" ,'2019-07-07',3540,'sudhanshu',2019) ,
('dlcvnlp' , 103 , 'ML', "this is ML course" ,'2020-07-07',3540,'sudhanshu',2020) ,
('aws cloud' , 104 , 'ML', "this is ML course" ,'2020-07-07',3540,'sudhanshu',2020) ,
('blockchain' , 105 , 'ML', "this is ML course" ,'2021-07-07',3540,'sudhanshu',2021) ,
('RL' , 106 , 'ML', "this is ML course" ,'2022-07-07',3540,'sudhanshu',2022) ,
('Dl' , 107 , 'ML', "this is ML course" ,'2022-07-07',3540,'sudhanshu',2022) ,
('interview prep' , 108 , 'ML', "this is ML course" ,'2019-07-07',3540,'sudhanshu',2019) ,
('big data' , 109 , 'ML', "this is ML course" ,'2020-07-07',3540,'sudhanshu',2020) ,
('data analytics' , 110 , 'ML', "this is ML course" ,'2021-07-07',3540,'sudhanshu',2021) ,
('fsds' , 111 , 'ML', "this is ML course" ,'2022-07-07',3540,'sudhanshu',2022) ,
('fsda' , 112 , 'ML', "this is ML course" ,'2021-07-07',3540,'sudhanshu',2021) ,
('fabe' , 113 , 'ML', "this is ML course" ,'2022-07-07',3540,'sudhanshu',2022) ,
('java' , 114 , 'ML', "this is ML course" ,'2020-07-07',3540,'sudhanshu',2020) ,
('MERN' , 115 , 'ML', "this is ML course" ,'2019-07-07',3540,'sudhanshu',2019) 


select * from information_schema.partitions where table_name ="ineuron_course4";


// partitions by columns:--------------------------------------------------
    ---- can use string as well as integer values.
    ------------types-----------
    1:- partition by range columns
    2:- partition by list columns
    
    
    (a):--- partition by range columns----------------------
    
create table ineuron_course5(
course_name varchar(50),
course_id int,
course_title varchar(50),
course_desc varchar(50),
launch_date date,
course_fee int,
course_mentor varchar(60),
course_launch_year int)
partition by range columns ( course_name,course_id,course_launch_year)(
partition p0  values less than ("aiops",102,2019),
partition p1  values less than ("fsda",103,2021),
partition p2  values less than ("fsde",105,2022),
partition p3 values less than ("mern",109,2023));


NOTE:--- while inserting if its shows error table has no partition for values from columns_list
             use ignore while inserting data.
-----------------partition p0  values less than ("aiops",102,2019),
its work like "aiops" or 102 or 2019 ---- if either of them atch then it will insert that row in partiton.

  insert ignore into ineuron_course5 values('machine_learning' , 101 , 'ML', "this is ML course" ,'2019-07-07',3540,'sudhanshu',2019) ,

('aiops' , 102 , 'ML', "this is aiops course" ,'2019-07-07',3540,'sudhanshu',2019) ,
('dlcvnlp' , 103 , 'ML', "this is ML course" ,'2020-07-07',3540,'sudhanshu',2020) ,
('aws cloud' , 104 , 'ML', "this is ML course" ,'2020-07-07',3540,'sudhanshu',2020) ,
('blockchain' , 105 , 'ML', "this is ML course" ,'2021-07-07',3540,'sudhanshu',2021) ,
('RL' , 106 , 'ML', "this is ML course" ,'2022-07-07',3540,'sudhanshu',2022) ,
('Dl' , 107 , 'ML', "this is ML course" ,'2022-07-07',3540,'sudhanshu',2022) ,
('interview prep' , 108 , 'ML', "this is ML course" ,'2019-07-07',3540,'sudhanshu',2019) ,
('big data' , 109 , 'ML', "this is ML course" ,'2020-07-07',3540,'sudhanshu',2020) ,
('data analytics' , 110 , 'ML', "this is ML course" ,'2021-07-07',3540,'sudhanshu',2021) ,
('fsds' , 111 , 'ML', "this is ML course" ,'2022-07-07',3540,'sudhanshu',2022) ,
('fsda' , 112 , 'ML', "this is ML course" ,'2021-07-07',3540,'sudhanshu',2021) ,
('fabe' , 113 , 'ML', "this is ML course" ,'2022-07-07',3540,'sudhanshu',2022) ,
('java' , 114 , 'ML', "this is ML course" ,'2020-07-07',3540,'sudhanshu',2020) ,
('MERN' , 115 , 'ML', "this is ML course" ,'2019-07-07',3540,'sudhanshu',2019) 


//---------- partition by list columns--------------
create table ineuron_course6(
course_name varchar(50),
course_id int,
course_title varchar(50),
course_desc varchar(50),
launch_date date,
course_fee int,
course_mentor varchar(60),
course_launch_year int)
partition by list columns (course_name)(
partition p0  values in  ('aiops','data analytics','dl','rl'),
partition p1  values  in ('fsda','bigdata','blockchain'),
partition p2  values in ('mern','java','interview prep','fsde'));



  insert ignore into ineuron_course6 values('machine_learning' , 101 , 'ML', "this is ML course" ,'2019-07-07',3540,'sudhanshu',2019) ,

('aiops' , 102 , 'ML', "this is aiops course" ,'2019-07-07',3540,'sudhanshu',2019) ,
('dlcvnlp' , 103 , 'ML', "this is ML course" ,'2020-07-07',3540,'sudhanshu',2020) ,
('aws cloud' , 104 , 'ML', "this is ML course" ,'2020-07-07',3540,'sudhanshu',2020) ,
('blockchain' , 105 , 'ML', "this is ML course" ,'2021-07-07',3540,'sudhanshu',2021) ,
('RL' , 106 , 'ML', "this is ML course" ,'2022-07-07',3540,'sudhanshu',2022) ,
('Dl' , 107 , 'ML', "this is ML course" ,'2022-07-07',3540,'sudhanshu',2022) ,
('interview prep' , 108 , 'ML', "this is ML course" ,'2019-07-07',3540,'sudhanshu',2019) ,
('big data' , 109 , 'ML', "this is ML course" ,'2020-07-07',3540,'sudhanshu',2020) ,
('data analytics' , 110 , 'ML', "this is ML course" ,'2021-07-07',3540,'sudhanshu',2021) ,
('fsds' , 111 , 'ML', "this is ML course" ,'2022-07-07',3540,'sudhanshu',2022) ,
('fsda' , 112 , 'ML', "this is ML course" ,'2021-07-07',3540,'sudhanshu',2021) ,
('fabe' , 113 , 'ML', "this is ML course" ,'2022-07-07',3540,'sudhanshu',2022) ,
('java' , 114 , 'ML', "this is ML course" ,'2020-07-07',3540,'sudhanshu',2020) ,
('MERN' , 115 , 'ML', "this is ML course" ,'2019-07-07',3540,'sudhanshu',2019) 

select partition_name,table_name,table_rows from information_schema.partitions 
where table_name="ineuron_course6";


// ---------------------sub_partition:----------------------
            ---------partition inside partition--------- is basically known as sub_partition
            
create table ineuron_course7(
course_name varchar(50),
course_id int,
course_title varchar(50),
course_desc varchar(50),
launch_date date,
course_fee int,
course_mentor varchar(60),
course_launch_year int)
partition by list columns (course_id)
subpartition by hash(course_launch_year)
subpartitions 10 (
partition p0  values in  (101,102,103),
partition p1  values  in (104,105,106),
partition p2  values in (107,108,109,110)
);

            

  insert ignore into ineuron_course7 values('machine_learning' , 101 , 'ML', "this is ML course" ,'2019-07-07',3540,'sudhanshu',2019) ,

('aiops' , 102 , 'ML', "this is aiops course" ,'2019-07-07',3540,'sudhanshu',2019) ,
('dlcvnlp' , 103 , 'ML', "this is ML course" ,'2020-07-07',3540,'sudhanshu',2020) ,
('aws cloud' , 104 , 'ML', "this is ML course" ,'2020-07-07',3540,'sudhanshu',2020) ,
('blockchain' , 105 , 'ML', "this is ML course" ,'2021-07-07',3540,'sudhanshu',2021) ,
('RL' , 106 , 'ML', "this is ML course" ,'2022-07-07',3540,'sudhanshu',2022) ,
('Dl' , 107 , 'ML', "this is ML course" ,'2022-07-07',3540,'sudhanshu',2022) ,
('interview prep' , 108 , 'ML', "this is ML course" ,'2019-07-07',3540,'sudhanshu',2019) ,
('big data' , 109 , 'ML', "this is ML course" ,'2020-07-07',3540,'sudhanshu',2020) ,
('data analytics' , 110 , 'ML', "this is ML course" ,'2021-07-07',3540,'sudhanshu',2021) ,
('fsds' , 111 , 'ML', "this is ML course" ,'2022-07-07',3540,'sudhanshu',2022) ,
('fsda' , 112 , 'ML', "this is ML course" ,'2021-07-07',3540,'sudhanshu',2021) ,
('fabe' , 113 , 'ML', "this is ML course" ,'2022-07-07',3540,'sudhanshu',2022) ,
('java' , 114 , 'ML', "this is ML course" ,'2020-07-07',3540,'sudhanshu',2020) ,
('MERN' , 115 , 'ML', "this is ML course" ,'2019-07-07',3540,'sudhanshu',2019)


select partition_name,table_name,table_rows from information_schema.partitions 
where table_name="ineuron_course7";

NOTE:--- Parent query execute first and after that child query will execute.-----------


--------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------