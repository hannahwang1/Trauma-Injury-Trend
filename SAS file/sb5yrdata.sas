*Import the data*;

proc import file="/home/u58161476/Trauma Report/sb5yrdata.xlsx"
out=sb5yr 
dbms=xlsx replace;
SHEET="BAL-JANE"; 
getname=yes;
run;

proc freq data=sb5yr; 
table MOI; 
run;

data moi;
set sb5yr;
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
if MOI = 'ASSAULT' then MOI = 'ASSAULT';
if MOI = 'BICYCLE' then MOI = 'BICYCLE';
if MOI = 'BOAT' then MOI = 'BOAT';
if MOI = 'CHEMICAL' then MOI = 'BURN';
if MOI = 'CONTACT' then MOI = 'BURN';
if MOI = 'CRUSH' then MOI = 'OTHER';
if MOI = 'DIVING' then MOI = 'OTHER';
if MOI = 'DROWNING' then MOI = 'DROWNING';
if MOI = 'ELECTRIC' then MOI = 'BURN';
if MOI = 'EXPLOSION' then MOI = 'BURN';
if MOI = 'FALL-FROM' then MOI = 'FALL';
if MOI = 'FALL-HIGH' then MOI = 'FALL';
if MOI = 'FALL-HIGH (>15FT)' then MOI = 'FALL';
if MOI = 'FALL-FROM HEIGHT >15 FEET' then MOI = 'FALL';
if MOI = 'FALL-LEVEL' then MOI = 'FALL';
if MOI = 'FALL-LEVEL SURFACE' then MOI = 'FALL';
if MOI = 'FALL-LOW' then MOI = 'FALL';
if MOI = 'FALL-STAIRS' then MOI = 'FALL';
if MOI = 'FALLS' then MOI = 'FALL';
if MOI = 'FIREWORKS' then MOI = 'BURN';
if MOI = 'FOREIGN BODY' then MOI = 'OTHER';
if MOI = 'FOUND DOWN' then MOI = 'OTHER';
if MOI = 'GSW' then MOI = 'ASSAULT';
if MOI = 'HANGING' then MOI = 'HANGING';
if MOI = 'INHALATION' then MOI = 'OTHER';
if MOI = 'JUMP/PUSH/FALL FROM MOVING VEH' then MOI = 'OTHER';
if MOI = 'MACHINERY' then MOI = 'OTHER';
if MOI = 'MCA' then MOI = 'OTHER';
if MOI = 'MCC' then MOI = 'MCC';
if MOI = 'MVC FRONTAL IMPACT' then MOI = 'MVC';
if MOI = 'MVC OPP PT' then MOI = 'MVC';
if MOI = 'MVC OPP PT SIDE IMPACT' then MOI = 'MVC';
if MOI = 'MVC PT SID' then MOI = 'MVC';
if MOI = 'MVC PT SIDE IMPACT' then MOI = 'MVC';
if MOI = 'MVC REAR IMPACT' then MOI = 'MVC';
if MOI = 'MVC RESTRAINED ROLLOVER' then MOI = 'MVC';
if MOI = 'MVC UNRESTRAINED ROLLOVER' then MOI = 'MVC';
if MOI = 'MVC-FI' then MOI = 'MVC';
if MOI = 'MVC-IM-UNK' then MOI = 'MVC';
if MOI = 'MVC-RI' then MOI = 'MVC';
if MOI = 'MVC-ROLLOVER' then MOI = 'MVC';
if MOI = 'MVC-T-OP SIDE' then MOI = 'MVC';
if MOI = 'MVC-T-PT SIDE' then MOI = 'MVC';
if MOI = 'MVC-T-UNK' then MOI = 'MVC';
if MOI = 'OTHER' then MOI = 'OTHER';
if MOI = 'PED STRUCK' then MOI = 'PED STRUCK';
if MOI = 'PEDALCYCLE' then MOI = 'PEDALCYCLE';
if MOI = 'PLANE CRASH' then MOI = 'OTHER';
if MOI = 'SPORTS' then MOI = 'SPORTS';
if MOI = 'STAB' then MOI = 'ASSAULT';
if MOI = 'STEAM/VAPOR/SCALD' then MOI = 'BURN';
if MOI = 'STRUCK BY VEHICLE' then MOI = 'STRUCK BY';
if MOI = 'THERMAL' then MOI = 'BURN';
if MOI = 'THERMAL' then MOI = 'BURN';
if MOI = 'WORK INJURY' then MOI = 'WORK INJURY';
if MOI = '*ND' then MOI = 'NA';
if HomeZip = '*NA' then HomeZip = '';
if HomeZip = '*ND' then HomeZip = '';
if InjuryZip = '*BL' then InjuryZip = '';
if InjuryZip = '*ND' then InjuryZip = '';
run;

proc freq data=moi; 
table MOI; 
run; 

/*export data to file called sb5yr.csv*/
proc export data=moi
    outfile="/home/u58161476/Trauma Report/sb5yr.csv"
    dbms=csv
    replace;
run;

proc import file="/home/u58161476/Trauma Report/sb5yr.csv"
out=cat 
dbms=csv replace;
run;

proc freq data=cat; 
table MOI; 
run; 