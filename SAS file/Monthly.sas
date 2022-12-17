*Import the data*;

proc import file="/home/u58161476/Trauma Report/Monthly MOIs.csv" 
out=month2 
dbms=csv REPLACE;
run;

proc print data=month2 (obs=5);
where 'age in years'n = .;
run;

proc freq data=month2; 
table 'Zip of Injury'n;
run;

*catergorize data*;

data age;
set month2;
if 'age in years'n < 1 then agegrp = '<1 year';
if 'age in years'n >= 1 and 'age in years'n <5 then agegrp = '1 to 4 years';
if 'age in years'n > 4 and 'age in years'n <10 then agegrp = '5 to 9 years';
if 'age in years'n > 9 and 'age in years'n <15 then agegrp = '10 to 14 years';
if 'age in years'n > 14 and 'age in years'n <20 then agegrp = '15 to 19 years';
if 'age in years'n > 19 and 'age in years'n <25 then agegrp = '20 to 24 years';
if 'age in years'n > 24 and 'age in years'n <35 then agegrp = '25 to 34 years';
if 'age in years'n > 34 and 'age in years'n <45 then agegrp = '35 to 44 years';
if 'age in years'n > 44 and 'age in years'n <55 then agegrp = '45 to 54 years';
if 'age in years'n > 54 and 'age in years'n <65 then agegrp = '55 to 64 years';
if 'age in years'n > 64 and 'age in years'n <75 then agegrp = '65 to 74 years';
if 'age in years'n > 74 and 'age in years'n <85 then agegrp = '75 to 84 years';
if 'age in years'n > 84 then agegrp = '85+ years';
if 'age in years'n = '*BL' then agegrp = 'NA';
if 'age in years'n = . then delete;
if 'age in years'n <= 14 then catage = 1;
if 'age in years'n >= 15 and 'age in years'n <= 64 then catage = 2;
if 'age in years'n >= 65 then catage =3;
run;

proc freq data=age; 
table month;
*table 'month-year'n; 
run;

PROC PRINT data=age;
RUN;

proc print data=age (obs=5); 
where 'COI-Category'n = ' ';
run;

proc sort;
by 'age in years'n; 
run; 

proc contents data = age; 
run;

proc freq data=age;
table 'COI-Category'n*agegrp;
run;

ods excel file='/home/u58161476/Trauma Report/COI.xlsx';
proc freq data=age;
tables 'COI-Category'n*agegrp/norow nopercent nocol out=freq;
run;
ods excel close;

data year; 
set age;
length Month_Year $ 8;
Month_Year = catx('-', Year, Month);
put _all_;
if Year = 2016 then delete;
run;

proc freq; 
table Month_Year; 
run;

proc freq; 
table 'COI-Category'n*Month_Year/norow nopercent nocol out=freq; 
where catage=2 and 'COI-Category'n = 'MCC';
run; 

proc sort; 
by Month_Year;
run; 

ods excel file='/home/u58161476/Trauma Report/Month_Year.xlsx';
proc freq data=year;
tables 'COI-Category'n*Month_Year/norow nopercent nocol out=freq;
run;
ods excel close;

ods excel file='/home/u58161476/Trauma Report/Year.xlsx';
proc freq data=year;
tables 'COI-Category'n*Year/norow nopercent nocol out=freq;
run;
ods excel close;

/*Draft*/
PROC SGPLOT data= age;
   VBOX 'age in years'n
   / category = 'COI-Category'n;
run;

proc sgplot data=age;                                                                                                                     
   hbar 'age in years'n
   /response='COI-Category'n datalabel;                                                                                                              
   yaxis display=(nolabel);                                                                                                                       
   xaxis label='Response values';                                                                                                        
run; 

proc gchart data=age;                                                                                                                     
   hbar 'age in years'n / maxis=axis1 raxis=axis2 nostats                                                                                        
                 sumvar=respvar annotate=annobars;                                                                                      
run;                                                                                                                                    
quit; 

data category;
set age; 
if 'COI-Category'n = 'FALL' then MOI = 13;
if 'COI-Category'n = 'MVC' then MOI = 12;
if 'COI-Category'n = 'BURN' then MOI = 11;
if 'COI-Category'n = 'MCC' then MOI = 10;
if 'COI-Category'n = 'OTHER' then MOI = 9;
if 'COI-Category'n = 'STRUCK/OVEREXERTION' then MOI = 8;
if 'COI-Category'n = 'ASSAULT' then MOI = 7;
if 'COI-Category'n = 'PEDAL' then MOI = 6;
if 'COI-Category'n = 'GSW/STAB' then MOI = 5;
if 'COI-Category'n = 'SPORTS' then MOI = 4;
if 'COI-Category'n = 'MACHINERY' then MOI = 3;
if 'COI-Category'n = 'OTHER-TRANSPORT' then MOI = 2;
if 'COI-Category'n = 'DROWNING' then MOI = 1;
RUN;

Proc freq; 
table MOI;
run; 


proc reg data=category;
   model MOI = 'age in years'n;
run;

ods graphics on;

proc logistic data=category descending;
  class MOI / param=ref ;
  model MOI = 'age in years'n;
run;