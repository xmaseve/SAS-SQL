proc sql; 
create table lab2012
(Client char(20), Email char(25), Degree char(8), USC char(1), Dept char(20), Date num format=mmddyy10. label='Date of First Contact', Gratis char(1), Consultant char(10));
quit;


proc sql; 
describe table lab2012; 
quit; 


data lab2011;
input client $20. @14 email $25. @34 degree $8. @43 usc $1. @45 dept $20. @66 date mmddyy10. 
      @77 gratis $1. @79 consultant $10.;
	  format date date9.;
datalines;
Joe Bridges  BridgesJ@dnr.sc.gov External N SCDNR                12/03/2011 N John Grego
Gina White   whiteg@biol.sc.edu  Faculty  Y Biology              12/05/2011 Y Wilma Sims
Matthew King kingm3@email.sc.edu Doctoral Y Library & Info. Sci. 12/15/2011 Y John Grego
Wenkuan Zhao zhaow@email.sc.edu  Faculty  Y Medical School       12/16/2011 Y Wilma Sims
;
run;

proc sql; 
create table lab2012
like lab2011;
quit;

proc sql; 
describe table lab2012;
quit;

proc sql; 
insert into lab2012
set client='Jane Lipschitz', email='lipschitzj@dnr.sc.gov', degree='External', USC='N', Dept='SCDNR', date='25Jan2012'd, Gratis='Y', Consultant='John Grego' 
set client='Gerry Bainbridge', email='bainbrid@email.sc.edu', degree='Faculty', USC='Y', Dept='School of Music', date='31Jan2012'd, Gratis='Y', Consultant='John Grego'; 
select * from lab2012; 
quit;


proc sql; 
insert into work.lab2012
values('Scott Tyler', 'tylers@jonesctr.org', 'External', 'N', 'JERC', '17Jan2012'd, 'N', 'John Grego');
select * from work.lab2012; 
quit;

proc sql; 
insert into work.lab2012
select * from lab2011 where month(date)=12;
select * from work.lab2012; 
quit;

proc sql; create table work.lab2012
(Client char(12) primary key, Email char(19), Degree char(8), USC char(1) check(USC in ('N' 'Y' 'y' 'n')), Dept char(20), Date num format=mmddyy10. check(date between '01Jan2012'd and '31Dec2012'd), Gratis char(1), Consultant char(10) check(Consultant in ('John Grego','Wilma Sims')));
quit;


proc sql;
describe table constraints work.lab2012;
quit;


*Wrong date;
proc sql; 
insert into work.lab2012
values('Erin Merrick','merrickj@email.sc.edu' ,'Masters', 'Y',  'Environment','07Jan2011'd,'Y','Wilma Sims');
quit;

*See constraint labels;
proc sql;
describe table constraints work.lab2012;
quit;

proc sql; create table work.lab2012
(Client char(12) primary key, Email char(19), Degree char(8), USC char(1), Dept char(20), Date num 
format=mmddyy10., Gratis char(1), Consultant char(10), constraint Check_USC check(USC in ('N' 'Y' 'y' 'n')) );
quit;

proc sql;
describe table constraints work.lab2012;
quit;


data lab2011pay;
input client $12. @14 Hrs 2.0 @17 Rate comma3.0 @21 Consultant $8.;
datalines;
SCDDT         5 $50 Grad 
SCDDT        10 $80 Director
LCHS         15 $50 Manager
CK LLC        1 $80 Director
;
run;

proc sql; create table lab2012pay like
lab2011pay;
quit;

proc sql;
insert into lab2012pay
values('SCDFE',40,50,'Grad')
values('SCDFE',10,50,'Manager')
values('CTN',3.5,80,'Director');
quit;

proc sql;
update lab2012pay
set rate=rate*1.05;
select * from lab2012pay; 
quit;

proc sql;
update lab2012pay
set rate=rate*1.0013 where consultant='Director';
select * from lab2012pay; 
quit;

proc sql;
update lab2012pay
set rate=rate*case
when consultant='Director' then 1.05
when consultant='Manager' then 1.0375
else 1.045
end;
select * from lab2012pay; quit;


proc sql;
update lab2012pay
set rate=rate*case consultant
when 'Director' then 1.05
when 'Manager' then 1.0375
else 1.045
end;
select * from lab2012pay; quit;

proc print data=lab2012pay; run;

delete from lab2012
where date lt '01Jan2012'd; 
select * from work.lab2012; 
quit;


proc sql;
alter table lab2012
add College char(20) label='College or School', time num format=hour4.1
modify date format=weekdate31.;
select * from lab2012;
quit;


proc sql;
drop table admin.lab2011;
quit;
