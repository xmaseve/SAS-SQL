

data google;
input name $ residence $16.;
datalines;
John Columbia, SC
Laura Cambridge, MA
Melissa Los Angeles, CA
Michael Orlando, FL
Joseph London, England
Melissa Los Angeles, CA
Mark Napierville, IL
John Washington, DC
;
run;


data bing;
input name $ city $17.;
datalines;
Mark Napierville, IL
Joseph London, England
Michael Orlando, FL
Melissa Los Angeles, CA
VG Yerevan, Armenia
;
run;

proc sql;
select * from google
except
select * from bing;
quit;


proc sql;
select * from google
except all
select * from bing;
quit;

proc sql;
select * from google
except corr
select * from bing;
quit;


proc sql;
select * from google
except corr all
select * from bing;
quit;


proc sql;
select * from google
intersect
select * from bing; 
quit;


proc sql;
select * from google
intersect all
select * from bing; 
quit;


proc sql;
select * from google
intersect corr
select * from bing; 
quit;


proc sql;
select * from google
intersect all corr
select * from bing; 
quit;


proc sql;
select * from google
union
select * from bing; 
quit;


proc sql;
select * from google
union all
select * from bing; 
quit;


proc sql;
select * from google
union corr
select * from bing; 
quit;


proc sql;
select * from google
union all corr
select * from bing; 
quit;


proc sql;
select * from google
outer union
select * from bing; 
quit;


proc sql;
select * from google
outer union corr
select * from bing; 
quit;






