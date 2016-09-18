data secscores;
input date mmddyy11. @12 wteam $17. @30 wscore lteam $17. lscore;
format date worddate18.;
datalines;
11/19/2011 Alabama           45 Georgia Southern  21
11/19/2011 Arkansas          44 Mississippi State 17
11/19/2011 LSU               52 Ole Miss           3
11/19/2011 Tennessee         27 Vanderbilt        21
11/12/2011 South Carolina    17 Florida           12
11/12/2011 Vanderbilt        38 Kentucky           8
11/12/2011 Georgia           45 Auburn             7
11/12/2011 Arkansas          49 Tennessee          7
11/12/2011 LSU               42 Western Kentucky   9
11/12/2011 Louisiana Tech    27 Ole Miss           7
11/5/2011  Florida           26 Vanderbilt        21
11/5/2011  Georgia           63 New Mexico State  16
11/5/2011  Kentucky          30 Ole Miss          13
11/5/2011  Tennessee         24 Middle Tennessee   0
11/5/2011  Arkansas          44 South Carolina    28
11/5/2011  Mississippi State 55 Tennessee-Martin  17
11/5/2011  LSU                9 Alabama            6
10/29/2011 Arkansas          31 Vanderbilt        28
10/29/2011 Georgia           24 Florida           20
10/29/2011 Auburn            41 Ole Miss          23
10/29/2011 Mississippi State 28 Kentucky          16
10/29/2011 South Carolina    14 Tennessee          3
;
run;

proc sql;
title "Winning and Losing Teams with 2011 Matching Scores";
select winner.wscore label="Matching Score", winner.date format=worddate18. label="Date", winner.wteam label="Team with Winning Score", loser.date format=worddate18. label="Date", loser.lteam	label="Team with Losing Score"
from secscores as winner, secscores as loser
where winner.wscore=loser.lscore;
quit;
title;

proc sql;
title "Winning and Losing Teams with Winning Score less than Losing Score";
select winner.wscore label="Winning Score", winner.date format=worddate18. label="Date", winner.wteam label="Team with Winning Score", loser.lscore label="Losing Score", loser.date format=worddate18. label="Date", loser.lteam	label="Team with Losing Score"
from secscores as winner, secscores as loser
where winner.wscore lt loser.lscore;
quit;
title;

proc sql;
title "Winning Teams with Scores greater than Maximum Losing Score";
select distinct winner.wscore label="Winning Score", winner.date format=worddate18. label="Date", winner.wteam label="Team with Winning Score" from secscores as winner 
where winner.wscore gt all(select lscore from secscores);
quit;
title;
