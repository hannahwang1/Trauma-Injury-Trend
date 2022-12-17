*Import the data*;

proc import file="/home/u58161476/Trauma Report/Registry Report - ALLAges2017-2021.xlsx"
out=trauma 
dbms=xlsx replace;
SHEET="Sheet2"; 
getname=yes;
run;

proc print data=trauma (obs=5);
run;

*catergorize data*;

data cat;
set trauma;
if age < 1 then agegrp = '<1 year';
if age >= 1 and age <5 then agegrp = '1 to 4 years';
if age > 4 and age <10 then agegrp = '5 to 9 years';
if age > 9 and age <15 then agegrp = '10 to 14 years';
if age > 14 and age <20 then agegrp = '15 to 19 years';
if age > 19 and age <25 then agegrp = '20 to 24 years';
if age > 24 and age <35 then agegrp = '25 to 34 years';
if age > 34 and age <45 then agegrp = '35 to 44 years';
if age > 44 and age <55 then agegrp = '45 to 54 years';
if age > 54 and age <65 then agegrp = '55 to 64 years';
if age > 64 and age <75 then agegrp = '65 to 74 years';
if age > 74 and age <85 then agegrp = '75 to 84 years';
if age > 84 then agegrp = '85+ years';
if age = '*BL' then agegrp = 'NA';
if age <= 14 then catage = 1;
if age >= 15 and age <= 64 then catage = 2;
if age >= 65 then catage =3;
if "Cause of Injury"n = 'ASSAULT' then MOI = 'ASSAULT';
if "Cause of Injury"n = 'BICYCLE' then MOI = 'BICYCLE';
if "Cause of Injury"n = 'BOAT' then MOI = 'BOAT';
if "Cause of Injury"n = 'CHEMICAL' then MOI = 'BURN';
if "Cause of Injury"n = 'CONTACT' then MOI = 'BURN';
if "Cause of Injury"n = 'CRUSH' then MOI = 'OTHER';
if "Cause of Injury"n = 'DIVING' then MOI = 'OTHER';
if "Cause of Injury"n = 'DROWNING' then MOI = 'DROWNING';
if "Cause of Injury"n = 'ELECTRIC' then MOI = 'BURN';
if "Cause of Injury"n = 'EXPLOSION' then MOI = 'BURN';
if "Cause of Injury"n = 'FALL-FROM' then MOI = 'FALL';
if "Cause of Injury"n = 'FALL-HIGH' then MOI = 'FALL';
if "Cause of Injury"n = 'FALL-HIGH (>15FT)' then MOI = 'FALL';
if "Cause of Injury"n = 'FALL-FROM HEIGHT >15 FEET' then MOI = 'FALL';
if "Cause of Injury"n = 'FALL-LEVEL' then MOI = 'FALL';
if "Cause of Injury"n = 'FALL-LEVEL SURFACE' then MOI = 'FALL';
if "Cause of Injury"n = 'FALL-LOW' then MOI = 'FALL';
if "Cause of Injury"n = 'FALL-STAIRS' then MOI = 'FALL';
if "Cause of Injury"n = 'FALLS' then MOI = 'FALL';
if "Cause of Injury"n = 'FIREWORKS' then MOI = 'BURN';
if "Cause of Injury"n = 'FOREIGN BODY' then MOI = 'OTHER';
if "Cause of Injury"n = 'FOUND DOWN' then MOI = 'OTHER';
if "Cause of Injury"n = 'GSW' then MOI = 'ASSAULT';
if "Cause of Injury"n = 'HANGING' then MOI = 'HANGING';
if "Cause of Injury"n = 'INHALATION' then MOI = 'OTHER';
if "Cause of Injury"n = 'JUMP/PUSH/FALL FROM MOVING VEH' then MOI = 'OTHER';
if "Cause of Injury"n = 'MACHINERY' then MOI = 'OTHER';
if "Cause of Injury"n = 'MCA' then MOI = 'OTHER';
if "Cause of Injury"n = 'MCC' then MOI = 'MCC';
if "Cause of Injury"n = 'MVC FRONTAL IMPACT' then MOI = 'MVC';
if "Cause of Injury"n = 'MVC OPP PT' then MOI = 'MVC';
if "Cause of Injury"n = 'MVC OPP PT SIDE IMPACT' then MOI = 'MVC';
if "Cause of Injury"n = 'MVC PT SID' then MOI = 'MVC';
if "Cause of Injury"n = 'MVC PT SIDE IMPACT' then MOI = 'MVC';
if "Cause of Injury"n = 'MVC REAR IMPACT' then MOI = 'MVC';
if "Cause of Injury"n = 'MVC RESTRAINED ROLLOVER' then MOI = 'MVC';
if "Cause of Injury"n = 'MVC UNRESTRAINED ROLLOVER' then MOI = 'MVC';
if "Cause of Injury"n = 'MVC-FI' then MOI = 'MVC';
if "Cause of Injury"n = 'MVC-IM-UNK' then MOI = 'MVC';
if "Cause of Injury"n = 'MVC-RI' then MOI = 'MVC';
if "Cause of Injury"n = 'MVC-ROLLOVER' then MOI = 'MVC';
if "Cause of Injury"n = 'MVC-T-OP SIDE' then MOI = 'MVC';
if "Cause of Injury"n = 'MVC-T-PT SIDE' then MOI = 'MVC';
if "Cause of Injury"n = 'MVC-T-UNK' then MOI = 'MVC';
if "Cause of Injury"n = 'OTHER' then MOI = 'OTHER';
if "Cause of Injury"n = 'PED STRUCK' then MOI = 'PED STRUCK';
if "Cause of Injury"n = 'PEDALCYCLE' then MOI = 'PEDALCYCLE';
if "Cause of Injury"n = 'PLANE CRASH' then MOI = 'OTHER';
if "Cause of Injury"n = 'SPORTS' then MOI = 'SPORTS';
if "Cause of Injury"n = 'STAB' then MOI = 'ASSAULT';
if "Cause of Injury"n = 'STEAM/VAPOR/SCALD' then MOI = 'BURN';
if "Cause of Injury"n = 'STRUCK BY VEHICLE' then MOI = 'STRUCK BY';
if "Cause of Injury"n = 'THERMAL' then MOI = 'BURN';
if "Cause of Injury"n = 'THERMAL' then MOI = 'BURN';
if "Cause of Injury"n = 'WORK INJURY' then MOI = 'WORK INJURY';
if "Cause of Injury"n = '*BL' then MOI = 'NA';
run;

PROC PRINT data=cat ;
var "Cause of Injury"n MOI;
where MOI = " ";
RUN;

proc freq data=cat;
table "Cause of Injury"n MOI;
run;

proc freq data=cat;
table MOI*agegrp;
run;

proc sort data=cat;
by age;
run; 

data numeric;
set cat; 
if agegrp = 'NA' then delete; 
if 
run; 

proc freq;
table age; 
run; 

proc univariate;
var MOI; 
run; 

PROC SGPLOT ;
   VBOX age
   / category = MOI;
run;

proc contents data = numeric; 
run; 

ods excel file='C:\Users\krist\OneDrive - stonybrookmedicine\IPOC\Reports\cdctable.xlsx';
proc freq data=cat;
tables MOI*agegrp/norow nopercent nocol out=freq;
run;
ods excel close;

/*export data to file called clean.csv*/
proc export data=cat
    outfile="/home/u58161476/Trauma Report/clean.csv"
    dbms=csv
    replace;
run;

data year; 
set cat; 
*if 'Adm date'n =: '2016' then year = 2016;
if index('Adm date'n, '2016')>0 then year = 2016;
run;


