create table student(
	RegID numeric(10,0),
	Ayear numeric(4,0),
	Asem numeric(2,0),
	PYS numeric(4,0),
	CourseCode VARCHAR(10),
	CourseName VARCHAR(200),
	Credits numeric(5),
	RegNo numeric(6,0),
	Grade varchar(2),
	Dept numeric(2)
);
create table gradePoints(
	grade varchar(2),
	points numeric(2,0)
);
insert into gradepoints(grade,points)
values 
	('EX', 10),
	('A', 9),
	('B', 8),
	('C', 7),
	('D', 6),
	('P', 5),
	('F', 0),
	('X', 0),
	('I', 0),
	('W', 0);

COPY student(regID,Ayear,Asem,PYS,CourseCode,CourseName,Credits,RegNo,Grade,Dept)
FROM 'Student-Data-2025.csv' --path to csv file here(removed while uploading)
DELIMITER ','
CSV HEADER;



select * from student
order by regno

create temp table std_sgpa as
select s.regno,s.pys,sum(s.credits*gp.points) as SGP,sum(s.credits) as SC, round(sum(s.credits*gp.points)/sum(s.credits),2) as SGPA
from student as s join gradepoints as gp on gp.grade=s.grade
group by s.regno,s.pys
order by s.regno,s.pys

-- drop table std_sgpa
-- select regno from std_sgpa
-- group by regno
select * from std_sgpa

CREATE EXTENSION IF NOT EXISTS tablefunc;

-- select * from crosstab(
-- 	'select std_sgpa.regno,std_sgpa.sgpa,std_sgpa.pys from std_sgpa order by std_sgpa.regno,std_sgpa.pys',
-- 	'select distinct std_sgpa.pys from std_sgpa order by std_sgpa.pys'
-- )as ct(regno numeric(10,0),SGPA_11 numeric(4,2),SGPA_12 numeric(4,2),SGPA_21 numeric(4,2),SGPA_22 numeric(4,2),SGPA_31 numeric(4,2),SGPA_32 numeric(4,2),
-- SGPA_41 numeric(4,2),SGPA_42 numeric(4,2))	


create temp table cgpa_all as 
select std_sgpa.regno,round(sum(std_sgpa.sgp)/sum(std_sgpa.sc),2) as CGPA
from std_sgpa 
group by std_sgpa.regno
order by std_sgpa.regno

-- drop table cgpa_all
select * from cgpa_all

