data bbstats;
label atbats="At Bats";
input Player $19. atbats Hits BB;
datalines;
Christian Walker     271 97 36
Scott Wingo          240 81 44
Brady Thomas         231 73 23
Evan Marzilli        220 64 25
Robert Beary         211 61 12
Adrian Morales       249 70 30
Peter Mooney         254 71 44
Jake Williams        209 56 21
Jackie Bradley Jr.   162 40 22
;
run;

proc sql;
 select player,  hits/atbats as avg label='Hit Rate' format percent8.2 
 from bbstats
 having avg > 0.2;
quit;

proc sql;
select player, hits/atbats as avg label='Hit Rate'
from bbstats
where calculated avg > 0.2;
quit;

proc sql;
 select player, atbats
 from bbstats
 where upcase(Player) contains 'IA'; 
quit;

data bbstats;
label atbats="At Bats";
input Player $19. Position $ atbats Hits BB;
datalines;
Christian Walker     Infield  271 97 36
Scott Wingo          Infield  240 81 44
Brady Thomas         Infield  231 73 23
Evan Marzilli        Outfield 220 64 25
Robert Beary         Infield  211 61 12
Adrian Morales       Infield  249 70 30
Peter Mooney         Infield  254 71 44
Jake Williams        Outfield 209 56 21
Jackie Bradley Jr.   Outfield 162 40 22
;
run;

proc sql;
 select position, sum(atbats) as totalatbats, sum(hits) as totalhits from bbstats
group by position
having totalhits >
   (select sum(hits) 
   from bbstats where position="Outfield"); 
 quit;

 data AtBats;
input Player $11. atbats;
datalines;
Walker      271
Wingo       240
Thomas      231
Marzilli    220
Beary       211
Morales     249
Mooney      254
Williams    209
Bradley Jr. 162
;
run;

data Playerposition;
input Player $11. Position $ ;
datalines;
Walker      Infield
Wingo       Infield
Thomas      Infield
Marzilli    Outfield
Beary       Infield
Morales     Infield
Mooney      Infield
Williams    Outfield
Bradley Jr. Outfield
;
run;

proc sql;
 select player, atbats from atbats
 where "Infield"=
    (select position
      from playerposition
      where atbats.player=playerposition.player);
      quit;

proc sql;
select playerposition.player, position
from playerposition inner join atbats
on atbats.player=playerposition.player;
quit;

data a;
input name $ quiz;
datalines;
Brad 7
Amy 9
Li 9
;
run;

data b;
input name $ test;
datalines;
Amy 87
Li 86
Sean 54
Sophie 92
;
run;

proc sql;
select *
from a,b;
quit;

proc sql;
select a.name as quizname, b.name as testname, quiz, test from a, b
where quizname=testname;
quit;

proc sql;
select a.name, quiz, test from a, b
where a.name=b.name;
quit;

proc sql;
select a.name, quiz, test
from a inner join b
on a.name=b.name;
quit;

proc sql;
select a.name, quiz, test
from a left join b
on a.name=b.name;
quit;

proc sql;
select a.name, quiz, test
from a left join b
on a.name=b.name
where b.name is null;
quit;

proc sql;
select *
from a full outer join b
on a.name=b.name;
quit;

proc sql;
select coalesce(a.name,b.name) as name, quiz, test
from a full join b
on a.name=b.name;
quit;

proc sql;
select coalesce(a.name,b.name) as name, quiz, test
from a full join b
on a.name=b.name
where a.name is null or b.name is null;
quit;

data hospitnew;
input patient date date9. pulse temp bps lastname $10.;
datalines;
2004101 03NOV2005 73 98.3 88 Jones
2004101 10NOV2005 77 98.5 82 Jones
2004101 17NOV2005 75 98.2 85 Jones
2004102 03NOV2005 83 98.0 98 Montgomery
2004102 10NOV2005 81 98.5 94 Montgomery
2004103 27OCT2005 77 99.3 78 Thomas
2004103 03NOV2005 76 98.5 79 Thomas
2004103 17NOV2005 79 99.2 75 Thomas
2004104 10NOV2005 72 98.9 83 Darhouse
;
run;

data dosing;
input patient date date9. @19 med $5. doses amt unit $2.;
datalines;
2004102 03NOV2005 Med A 3 1.4 mg
2004102 10NOV2005 Med A 2 2.4 mg
2004103 02NOV2005 Med B 2 2.5 mg
2004103 09NOV2005 Med B 1 3.1 mg
2004103 16NOV2005 Med B 3 2.8 mg
2004104 10NOV2005 Med A 3 3.6 mg
2004105 01NOV2005 Med B 2 2.5 mg
2004105 08NOV2005 Med B 2 1.9 mg
2004105 15NOV2005 Med B 1 3.7 mg
;
run;

proc sql;
create table both as
select a.patient, a.date format date7. as date, a.pulse, 
      b.med, b.doses, b.amt format=4.1
from hospitnew a inner join dosing b
on (a.patient=b.patient) and (a.date=b.date)
order by patient,date;

select * from both;
quit;

proc sql;
select a.date format date7. as date, avg(a.pulse) label="Average Daily Pulse" as avgPulse, 
     count(b.patient) label="No. of Patients", sum(b.doses) label="Total Daily Doses" as NumDose, sum(b.amt) format=4.1 label="Total Amount (mg)" as Totamt 
from hospitnew a inner join dosing b
on (a.patient=b.patient) and (a.date=b.date)
group by a.date
order by a.date;
quit;

proc sql;
select a.name, quiz, test from a 
left join b
on a.name=b.name
where b.test is null;
quit;

data a;
input Name $ Major $18.;
datalines;
Shan Statistics
Iris Biostatistics
Tim Actuarial Sciences
;
run;

data b;
input Name $ School $31.;
datalines;
Iris University of Missouri
Tim University of New Mexico
Shan North Carolina State University
;
run;

proc sort data=a; by name; run;
proc sort data=b; by name; run;

data c; 
merge a b; 
by name; 
run;

proc print data=c;
run;

proc sql;
title "Table Merged";
select coalesce(a.name, b.name) as name, major, school
from a full join b
on a.name=b.name;
quit;

title;
proc sql; 
select a.name, major, school from a full join b 
on a.name=b.name 
order by name;
quit;


data lib;
input LibSys $12. State $ TotCirc LocGvt;
datalines;
Haleyville   AL 67031 12822
Jasper       AL 187072 74289
Suniton      AL 39401 12026
Ashland City AL 60994 21350
Athens       IL 27366 22976
Freeburg     IL 218749 26519
Pembroke     IL 19200 526
Heermance    NY 160316 48199
Greenville   NY 131019 60863
Haines Falls NY 38734 11471
;
proc sql;
select state, avg(LocGvt) as average, sum(TotCirc>150000) 
as large, sum(TotCirc<150000) 
as small from lib group by state;
quit;

proc sql;
select state, average  
label="Mean Local Government Support" format=dollar12.2, small/(small+large) as prop format=percent5.2 label= "Small Library Percentage" 
from (select state, avg(LocGvt) as average, sum(TotCirc>150000) 
as large, sum(TotCirc<150000) 
as small from lib group by state)
order by average;
quit;

