data condition1;
input x1 $3.;
cards;
001 
002
003
;
run;

data condition2;
input x2 $3.;
cards;
005
006 
008
;
run;
/*the dataset we need to identify which the values in it come from*/
data test;
input ID $3.;
cards;
001 
002
003
005
006
007
008
;
run;

proc sql;
 create table all as
  select  * , "condition1" as data_set_s  from test
    where ID  in (select  x1  from condition1)
         union
  select  * , "condition2" as data_set_s  from test
     where ID in (select x2 from condition2)
         union
  select  * , "other" as  data_set_s  from test
    where ID not in
     (select x1 as x from condition1 
         union 
     select x2 as x from condition2); 
quit;

proc print data=all;run;

proc sql;
select x1  from condition1 
         union 
     select x2 from condition2;
quit;
