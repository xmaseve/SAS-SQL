
data books;
	input bookid    : 1.
              title     & $28.
              published : mmddyy10.
              author    & $15.
              stock     : 1.;
	format published date9.;
datalines;
1 Scion of Ikshvaku  06/22/2015 Amish Tripathi  2
2 The lost Symbol  07/22/2010 Dan Brown  3
3 Who Will Cry When You Die?  06/15/2006 Robin Sharma  4
4 Inferno  05/05/2014  Dan Brown  3
5 The Fault in our Stars  01/03/2015 John Green  3
;
proc print data=books;
run;

data members;
	input memberid firstname $ lastname $;
datalines;
1 Sue Mason
2 Ellen Horton
3 Henry Clarke
4 Mike Willis
5 Lida Tyler
;
proc print data=members;
run;

data borrowings;
	input id bookid memberid borrowdate mmddyy10. +1returndate mmddyy10.;
	format borrowdate returndate date9.;
datalines;
1 1 3 01/20/2016 03/17/2016
2 2 4 01/19/2016 03/23/2016
3 1 1 02/17/2016 05/18/2016
4 4 2 12/15/2015 04/13/2016
5 2 2 02/18/2016 04/19/2016
6 3 5 02/29/2016 04/11/2016
;
proc print data=borrowings;
run;

proc sql;
select *
from books
where author='Dan Brown';
quit;

proc sql;
select title, returndate
from books join borrowings
on books.bookid = borrowings.bookid
where author='Dan Brown';
quit;

proc sql;
select firstname, lastname, count(*) as Number 'Number of books borrowed'
from borrowings b join members m
on b.memberid = m.memberid
join books
on b.bookid = books.bookid
where author='Dan Brown'
group by firstname, lastname;
quit;

proc sql;
select author, sum(stock) as Total
from books
group by author;
quit;

proc sql;
select *
from (select author, sum(stock) as Total
      from books
      group by author)
where author='Robin Sharma';
quit;

proc sql;
select bookid, title
from books
where author in (select author
                 from (select author, sum(stock) as Total
                       from books
                       group by author) as result
		where Total > 3);
quit;



