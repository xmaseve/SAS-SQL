proc sql;
create table student (
id char(3),
student_no num,
student_name char(10),
subj_no char(5),
subj_name char(10),
score num
);
quit;

proc sql;
insert into student
values('1', 201601, 'Allen', '0001', 'Math', 98)
values('2', 201601, 'Allen', '0002', 'Chemistry', 66)
values('3', 201602, 'Bob', '0001', 'Math', 60)
values('4', 201602, 'Bob', '0003', 'English', 78)
values('5', 201603, 'Cathy', '0001', 'Math', 90)
values('6', 201603, 'Cathy', '0002', 'Chemistry', 91)
values('7', 201603, 'Cathy', '0003', 'English', 92);
quit;

proc sql;
select student_name
from student
group by student_name
having min(score) > 80;
quit;

proc sql;
create table one as
select *
from student
where 1 = 2;
quit;

proc sql;
update student
set score = score -
case when student_name like 'C%' then 5
else -5
end;
quit;

