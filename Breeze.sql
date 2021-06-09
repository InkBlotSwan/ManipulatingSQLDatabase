rem     BreezeCo Creation Script	
rem     Created 05/10/2019

rem     Author: PlaceStudent
rem

rem	-----------------------------------------------------------
rem	-----------------------------------------------------------
rem
rem     Please read through everything first.
rem	
rem	-----------------------------------------------------------
rem	-----------------------------------------------------------

rem     Note that this file will:
rem     Drop any tables that have previously been created called:
rem     BR_User, BR_AppUser, BR_App, BR_AppCategory, BR_Country
rem     If you do not want these to be deleted please adjust
rem	
rem     It will not run if there are any constraint names that are 
rem     already in use. Amend names if this occurs.


rem	.--------------------------------------------------------.
rem	|	To use this file within SQL*Plus do the          |
rem	|	following:                                       |
rem	|		1. Save the file in an appropriate       |
rem	|		   directory with an appropriate name    |
rem	|		   in the form of XXXX.sql               |
rem	|		2. At SQL> prompt, type START XXXX.sql   |
rem	.--------------------------------------------------------.


set echo off
set feedback off


prompt     Breeze Co. Set Up is starting
prompt
prompt
prompt     Dropping BR_User, BR_AppUser, BR_App, BR_AppCategory, BR_Country
prompt
prompt     Please wait...

alter session set NLS_DATE_FORMAT = 'DD-MON-RR';

set term off

DROP TABLE "BR_USER" cascade constraints
/
DROP TABLE "BR_APPUSER" cascade constraints
/
DROP TABLE "BR_APP" cascade constraints
/
DROP TABLE "BR_APPCATEGORY" cascade constraints
/
DROP TABLE "BR_COUNTRY" cascade constraints
/


set term on

prompt 
prompt Previous version of BR_User, BR_AppUser, BR_App, BR_AppCategory, BR_Country
prompt tables have been dropped.
prompt
prompt
prompt Creating BR_User, BR_AppUser, BR_App, BR_AppCategory, BR_Country tables
prompt
prompt Please wait...
prompt

set feedback on

CREATE TABLE "BR_COUNTRY"(
     "CountryId" NUMBER(3,0),
	 "CountryCode" VARCHAR2(3) CONSTRAINT "BR_COUNTRY_CODE_NN" NOT NULL ENABLE,
	 "CountryName" VARCHAR2(20),
	 CONSTRAINT "BR_COUNTRY_CODE_UNIQUE" UNIQUE("CountryCode"),
	 CONSTRAINT "BR_COUNTRY_PK" PRIMARY KEY ("CountryId") ENABLE
	 ) ORGANIZATION INDEX NOCOMPRESS 
/

CREATE TABLE "BR_USER"(
     "UserId" NUMBER(6,0),
	 "Username" VARCHAR2(35) CONSTRAINT "BR_USER_USERNAME_NN" NOT NULL ENABLE,
	 "FirstName" VARCHAR2(30),
	 "LastName" VARCHAR2(50) CONSTRAINT "BR_USER_LAST_NAME_NN" NOT NULL ENABLE,
	 "Email" VARCHAR2(100) CONSTRAINT "BR_USER_EMAIL_NN" NOT NULL ENABLE,
	 "Gender" VARCHAR2(3),
	 "JoinDate" DATE CONSTRAINT "BR_USER_JOINDATE_NN" NOT NULL ENABLE,
	 "DateOfBirth" DATE CONSTRAINT "BR_USER_DOB_NN" NOT NULL ENABLE,
	 "CountryId" NUMBER(3,0),
	 CONSTRAINT "BR_USER_EMAIL_CORRECT" CHECK ("Email" like '%@%'),
	 CONSTRAINT "BR_USER_EMAIL_UNIQUE" UNIQUE("Email"),
	 CONSTRAINT "BR_USER_ID_PK" PRIMARY KEY ("UserId") ENABLE
	 )
/
CREATE TABLE "BR_APPCATEGORY"(
	 "AppCategoryId" NUMBER(2,0),
	 "CategoryName" VARCHAR2(20) CONSTRAINT "BR_APPCATEGORY_NAME_NN" NOT NULL ENABLE,
	 "Description" VARCHAR2(100),
	 CONSTRAINT "BR_APPCATEGORY_PK" PRIMARY KEY ("AppCategoryId") ENABLE
)
/
CREATE TABLE "BR_APP"(
	 "AppId" NUMBER(4,0),
	 "AppName" VARCHAR2(100) CONSTRAINT "BR_APP_NAME_NN" NOT NULL ENABLE,
	 "AppCategoryId" NUMBER(2,0),
	 "LastUpdated" DATE, 
	 "CurrentVersion" VARCHAR2(6),
	 "ApprovedForRelease" VARCHAR2(1),
	 "OwnedById" NUMBER(4,0),
	 "ManagedById" NUMBER(4,0),
	 CONSTRAINT "BR_APP_FLAG_CHECK" CHECK("ApprovedForRelease" IN ('Y','N')) ENABLE,
	 CONSTRAINT "BR_APP_PK" PRIMARY KEY ("AppId") ENABLE
)
/
CREATE TABLE "BR_APPUSER"(
	 "AppUserId" NUMBER(6,0),
	 "AppId" NUMBER(4,0),
	 "UserId" NUMBER(6,0),
	 "DownloadDate" DATE,
	 "ActiveFl" VARCHAR2(1),
	 CONSTRAINT "BR_APPUSER_FLAG_CHECK" CHECK("ActiveFl" IN ('Y','N')) ENABLE,
	 CONSTRAINT "BR_APPUSER_PK" PRIMARY KEY ("AppUserId") ENABLE
)
/

prompt
prompt
prompt BR_User, BR_AppUser, BR_App, BR_AppCategory, BR_Country tables
prompt created.
prompt 
prompt 
prompt Populating BR_User, BR_AppUser, BR_App, BR_AppCategory, BR_Country tables
prompt

set term off

REM INSERTING into BR_COUNTRY
INSERT INTO BR_COUNTRY VALUES(1,'AR','Argentina')
/
INSERT INTO BR_COUNTRY VALUES(2,'AU','Australia')
/
INSERT INTO BR_COUNTRY VALUES(3,'BE','Belgium')
/
INSERT INTO BR_COUNTRY VALUES(4,'BR','Brazil')
/
INSERT INTO BR_COUNTRY VALUES(5,'CA','Canada')
/
INSERT INTO BR_COUNTRY VALUES(6,'CH','Switzerland')
/
INSERT INTO BR_COUNTRY VALUES(7,'CN','China')
/
INSERT INTO BR_COUNTRY VALUES(8,'DE','Germany')
/
INSERT INTO BR_COUNTRY VALUES(9,'DK','Denmark')
/
INSERT INTO BR_COUNTRY VALUES(10,'EG','Egypt'),
/
INSERT INTO BR_COUNTRY VALUES(11,'FR','France')
/
INSERT INTO BR_COUNTRY VALUES(12,'HK','HongKong')
/
INSERT INTO BR_COUNTRY VALUES(13,'IL','Israel')
/
INSERT INTO BR_COUNTRY VALUES(14,'IN','India')
/
INSERT INTO BR_COUNTRY VALUES(15,'IT','Italy')
/
INSERT INTO BR_COUNTRY VALUES(16,'JP','Japan')
/
INSERT INTO BR_COUNTRY VALUES(17,'KW','Kuwait')
/
INSERT INTO BR_COUNTRY VALUES(18,'MX','Mexico')
/
INSERT INTO BR_COUNTRY VALUES(19,'NG','Nigeria')
/
INSERT INTO BR_COUNTRY VALUES(20,'NL','Netherlands')
/
INSERT INTO BR_COUNTRY VALUES(21,'SG','Singapore')
/
INSERT INTO BR_COUNTRY VALUES(22,'UK','United Kingdom')
/
INSERT INTO BR_COUNTRY VALUES(23,'US','United States of America')
/
INSERT INTO BR_COUNTRY VALUES(24,'ZM','Zambia')
/
INSERT INTO BR_COUNTRY VALUES(25,'ZW','Zimbabwe')
/

REM INSERTING into BR_USER
INSERT INTO BR_USER VALUES(100,'observebug','Bary','Hyatt','bhyatt0@ucoz.ru','M',to_date('13-Jan-19','DD-MON-RR'),to_date('02-May-06','DD-MON-RR'),(SELECT "CountryId" FROM BR_COUNTRY WHERE "CountryCode" ='AU'))
/
INSERT INTO BR_USER VALUES(101,'defilingelevator','Leanora','Brasier','lbrasier1@ustream.tv','F',to_date('02-Feb-17','DD-MON-RR'),to_date('25-Jun-65','DD-MON-RR'),(SELECT "CountryId" FROM BR_COUNTRY WHERE "CountryCode" ='IL'))
/
INSERT INTO BR_USER VALUES(102,'tidbitmend','Robin','Mantripp','rmantripp2@digg.com','NB',to_date('01-Aug-18','DD-MON-RR'),to_date('31-Aug-96','DD-MON-RR'),(SELECT "CountryId" FROM BR_COUNTRY WHERE "CountryCode" ='ZW'))
/
INSERT INTO BR_USER VALUES(103,'bipsobject','Neda','Brayne','nbrayne3@arizona.edu','F',to_date('19-Apr-19','DD-MON-RR'),to_date('04-Apr-78','DD-MON-RR'),(SELECT "CountryId" FROM BR_COUNTRY WHERE "CountryCode" ='CA'))
/
INSERT INTO BR_USER VALUES(104,'eatsnightjar','Alair','Benjamin','abenjamin4@answers.com','M',to_date('16-Mar-19','DD-MON-RR'),to_date('03-Feb-88','DD-MON-RR'),(SELECT "CountryId" FROM BR_COUNTRY WHERE "CountryCode" ='FR'))
/
INSERT INTO BR_USER VALUES(105,'mooingillfated','Jasper','Wisdish','jwisdish5@epa.gov','M',to_date('03-Feb-17','DD-MON-RR'),to_date('10-Nov-91','DD-MON-RR'),(SELECT "CountryId" FROM BR_COUNTRY WHERE "CountryCode" ='AU'))
/
INSERT INTO BR_USER VALUES(106,'butterytrolly','Essie','Eastby','eeastby6@archive.org','F',to_date('18-Dec-18','DD-MON-RR'),to_date('15-Jul-89','DD-MON-RR'),(SELECT "CountryId" FROM BR_COUNTRY WHERE "CountryCode" ='US'))
/
INSERT INTO BR_USER VALUES(107,'tricepsphalanges','Chauncey','Alwin','calwin7@sogou.com','NB',to_date('01-Jan-19','DD-MON-RR'),to_date('12-May-02','DD-MON-RR'),(SELECT "CountryId" FROM BR_COUNTRY WHERE "CountryCode" ='IT'))
/
INSERT INTO BR_USER VALUES(108,'friendwaves','Leighton','Rumble','lrumble8@sourceforge.net','U',to_date('05-May-18','DD-MON-RR'),to_date('10-Jul-06','DD-MON-RR'),(SELECT "CountryId" FROM BR_COUNTRY WHERE "CountryCode" ='CH'))
/
INSERT INTO BR_USER VALUES(109,'sulfurozone','Elsinore','Grosvener','egrosvener9@cam.ac.uk','F',to_date('17-Aug-19','DD-MON-RR'),to_date('07-Sep-95','DD-MON-RR'),(SELECT "CountryId" FROM BR_COUNTRY WHERE "CountryCode" ='NL'))
/
INSERT INTO BR_USER VALUES(110,'evacuateorphean','Mitchell','Thairs','mthairsa@nydailynews.com','M',to_date('12-Aug-18','DD-MON-RR'),to_date('04-Jun-99','DD-MON-RR'),(SELECT "CountryId" FROM BR_COUNTRY WHERE "CountryCode" ='NL'))
/
INSERT INTO BR_USER VALUES(111,'excellentminnie','Francis','Chillcot','fchillcotb@noaa.gov','M',to_date('06-Aug-19','DD-MON-RR'),to_date('17-Oct-85','DD-MON-RR'),(SELECT "CountryId" FROM BR_COUNTRY WHERE "CountryCode" ='IT'))
/
INSERT INTO BR_USER VALUES(112,'clawjovial','Jeno','Panchin','jpanchinc@latimes.com','M',to_date('23-Feb-18','DD-MON-RR'),to_date('26-Sep-92','DD-MON-RR'),(SELECT "CountryId" FROM BR_COUNTRY WHERE "CountryCode" ='JP'))
/
INSERT INTO BR_USER VALUES(113,'winstonmobile','Raff','Benting','rbentingd@technorati.com','M',to_date('07-Oct-18','DD-MON-RR'),to_date('24-Aug-91','DD-MON-RR'),(SELECT "CountryId" FROM BR_COUNTRY WHERE "CountryCode" ='US'))
/
INSERT INTO BR_USER VALUES(114,'graypertrevor','Tremayne','Palfree','tpalfreee@amazon.de','F',to_date('31-Aug-19','DD-MON-RR'),to_date('21-Nov-01','DD-MON-RR'),(SELECT "CountryId" FROM BR_COUNTRY WHERE "CountryCode" ='DE'))
/
INSERT INTO BR_USER VALUES(115,'simmeringzodiac','Carmine','Ivons','civonsf@cisco.com','F',to_date('03-Aug-19','DD-MON-RR'),to_date('27-Jun-81','DD-MON-RR'),(SELECT "CountryId" FROM BR_COUNTRY WHERE "CountryCode" ='UK'))
/
INSERT INTO BR_USER VALUES(116,'conicalbellied','Kelci','Eshelby','keshelbyg@exblog.jp','NB',to_date('21-Feb-18','DD-MON-RR'),to_date('18-Mar-69','DD-MON-RR'),(SELECT "CountryId" FROM BR_COUNTRY WHERE "CountryCode" ='CA'))
/
INSERT INTO BR_USER VALUES(117,'youngindication','Nero','Sertin','nsertinh@narod.ru','M',to_date('19-Sep-19','DD-MON-RR'),to_date('06-Sep-73','DD-MON-RR'),(SELECT "CountryId" FROM BR_COUNTRY WHERE "CountryCode" ='CA'))
/
INSERT INTO BR_USER VALUES(118,'mossycrevice','Dennet','Woodyer','dwoodyeri@businessinsider.com','M',to_date('18-Oct-18','DD-MON-RR'),to_date('11-Jun-05','DD-MON-RR'),(SELECT "CountryId" FROM BR_COUNTRY WHERE "CountryCode" ='AU'))
/
INSERT INTO BR_USER VALUES(119,'quailjuvenile','Bucky','Haryngton','bharyngtonj@hao123.com','M',to_date('14-Aug-17','DD-MON-RR'),to_date('22-Oct-89','DD-MON-RR'),(SELECT "CountryId" FROM BR_COUNTRY WHERE "CountryCode" ='UK'))
/
INSERT INTO BR_USER VALUES(120,'talkativeaptly','Iggie','Freak','ifreakk@people.com.cn','F',to_date('02-May-19','DD-MON-RR'),to_date('11-Jan-94','DD-MON-RR'),(SELECT "CountryId" FROM BR_COUNTRY WHERE "CountryCode" ='AU'))
/
INSERT INTO BR_USER VALUES(121,'storeentertain','Mandi','Brockie','mbrockiel@pen.io','F',to_date('03-Jul-19','DD-MON-RR'),to_date('19-Jun-01','DD-MON-RR'),(SELECT "CountryId" FROM BR_COUNTRY WHERE "CountryCode" ='CA'))
/
INSERT INTO BR_USER VALUES(122,'spinnerwrongly','Grant','MacSweeney','gmacsweeneym@devhub.com','M',to_date('16-Jan-18','DD-MON-RR'),to_date('15-Dec-75','DD-MON-RR'),(SELECT "CountryId" FROM BR_COUNTRY WHERE "CountryCode" ='UK'))
/
INSERT INTO BR_USER VALUES(123,'subsidemasculine','Minny','Jouanot','mjouanotn@apache.org','F',to_date('14-Nov-19','DD-MON-RR'),to_date('28-Mar-61','DD-MON-RR'),(SELECT "CountryId" FROM BR_COUNTRY WHERE "CountryCode" ='CN'))
/
INSERT INTO BR_USER VALUES(124,'graspdeep','Pollyanna','Thorpe','pthorpeo@google.pl','F',to_date('08-Dec-18','DD-MON-RR'),to_date('13-Sep-80','DD-MON-RR'),(SELECT "CountryId" FROM BR_COUNTRY WHERE "CountryCode" ='CA'))
/
INSERT INTO BR_USER VALUES(125,'mogulknuckles','Teodoro','Kennally','tkennallyp@nih.gov','M',to_date('16-May-19','DD-MON-RR'),to_date('01-Aug-70','DD-MON-RR'),(SELECT "CountryId" FROM BR_COUNTRY WHERE "CountryCode" ='FR'))
/
INSERT INTO BR_USER VALUES(126,'digbystudent','Elvira','MacSkeaghan','emacskeaghanq@about.me','F',to_date('23-Aug-18','DD-MON-RR'),to_date('01-Jan-70','DD-MON-RR'),(SELECT "CountryId" FROM BR_COUNTRY WHERE "CountryCode" ='US'))
/
INSERT INTO BR_USER VALUES(127,'nemesisoversight','Linnell','Farnon','lfarnonr@yellowbook.com','U',to_date('20-Nov-18','DD-MON-RR'),to_date('22-Mar-00','DD-MON-RR'),(SELECT "CountryId" FROM BR_COUNTRY WHERE "CountryCode" ='AU'))
/
INSERT INTO BR_USER VALUES(128,'instancegating','Dimitri','Knuckles','dknuckless@51.la','M',to_date('25-Aug-19','DD-MON-RR'),to_date('06-Jan-89','DD-MON-RR'),(SELECT "CountryId" FROM BR_COUNTRY WHERE "CountryCode" ='IL'))
/
INSERT INTO BR_USER VALUES(129,'wrenchbaritone','Thom','Grimwad','tgrimwadt@spotify.com','M',to_date('24-Nov-18','DD-MON-RR'),to_date('11-May-96','DD-MON-RR'),(SELECT "CountryId" FROM BR_COUNTRY WHERE "CountryCode" ='AU'))
/
INSERT INTO BR_USER VALUES(130,'casanovamural','Rolfe','Wilsey','rwilseyu@google.nl','M',to_date('02-Dec-18','DD-MON-RR'),to_date('01-Jul-85','DD-MON-RR'),(SELECT "CountryId" FROM BR_COUNTRY WHERE "CountryCode" ='ZM'))
/
INSERT INTO BR_USER VALUES(131,'resistantrave','Nevsa','Sazio','nsaziov@google.com.hk','F',to_date('31-Jan-19','DD-MON-RR'),to_date('18-Sep-99','DD-MON-RR'),(SELECT "CountryId" FROM BR_COUNTRY WHERE "CountryCode" ='CN'))
/
INSERT INTO BR_USER VALUES(132,'fryerprissy','Florry','Balsom','fbalsomw@woothemes.com','F',to_date('22-Jul-18','DD-MON-RR'),to_date('07-Oct-90','DD-MON-RR'),(SELECT "CountryId" FROM BR_COUNTRY WHERE "CountryCode" ='BE'))
/
INSERT INTO BR_USER VALUES(133,'curedimpled','Rab','Lettley','rlettleyx@archive.org','M',to_date('20-Jan-19','DD-MON-RR'),to_date('08-Feb-64','DD-MON-RR'),(SELECT "CountryId" FROM BR_COUNTRY WHERE "CountryCode" ='IT'))
/
INSERT INTO BR_USER VALUES(134,'chirdwater','Barbi','Chavez','bchavezy@odnoklassniki.ru','F',to_date('28-Feb-19','DD-MON-RR'),to_date('21-Feb-91','DD-MON-RR'),(SELECT "CountryId" FROM BR_COUNTRY WHERE "CountryCode" ='FR'))
/
INSERT INTO BR_USER VALUES(135,'sharegig','Bonnee','Bergstram','bbergstramz@pagesperso-orange.fr','F',to_date('30-Sep-19','DD-MON-RR'),to_date('12-Apr-01','DD-MON-RR'),(SELECT "CountryId" FROM BR_COUNTRY WHERE "CountryCode" ='UK'))
/
INSERT INTO BR_USER VALUES(136,'unreadflock','Niles','Muff','nmuff10@gravatar.com','M',to_date('16-Apr-18','DD-MON-RR'),to_date('10-Apr-05','DD-MON-RR'),(SELECT "CountryId" FROM BR_COUNTRY WHERE "CountryCode" ='FR'))
/
INSERT INTO BR_USER VALUES(137,'equatorlight','Stevie','Firminger','sfirminger11@dagondesign.com','F',to_date('09-Jul-19','DD-MON-RR'),to_date('03-Feb-76','DD-MON-RR'),(SELECT "CountryId" FROM BR_COUNTRY WHERE "CountryCode" ='IT'))
/
INSERT INTO BR_USER VALUES(138,'parsnipusher','Wyatan','Labrow','wlabrow12@issuu.com','M',to_date('31-Oct-19','DD-MON-RR'),to_date('28-Dec-67','DD-MON-RR'),(SELECT "CountryId" FROM BR_COUNTRY WHERE "CountryCode" ='US'))
/
INSERT INTO BR_USER VALUES(139,'affcommon','Timmi','Tabard','ttabard13@engadget.com','M',to_date('21-May-18','DD-MON-RR'),to_date('19-Aug-88','DD-MON-RR'),(SELECT "CountryId" FROM BR_COUNTRY WHERE "CountryCode" ='AU'))
/
INSERT INTO BR_USER VALUES(140,'gaitheadpiece','Tommie','Harvatt','tharvatt14@ucoz.com','M',to_date('30-Nov-18','DD-MON-RR'),to_date('06-Jul-06','DD-MON-RR'),(SELECT "CountryId" FROM BR_COUNTRY WHERE "CountryCode" ='UK'))
/
INSERT INTO BR_USER VALUES(141,'exponentstory','Caresa','Schaffler','cschaffler15@cocolog-nifty.com','F',to_date('20-Jun-19','DD-MON-RR'),to_date('02-Oct-85','DD-MON-RR'),(SELECT "CountryId" FROM BR_COUNTRY WHERE "CountryCode" ='CA'))
/
INSERT INTO BR_USER VALUES(142,'doorsteplips','Cherey','Bariball','cbariball16@eepurl.com','F',to_date('08-Aug-18','DD-MON-RR'),to_date('01-Apr-60','DD-MON-RR'),(SELECT "CountryId" FROM BR_COUNTRY WHERE "CountryCode" ='NL'))
/
INSERT INTO BR_USER VALUES(143,'browbeatbread','Timofei','Gyurkovics','tgyurkovics17@jimdo.com','M',to_date('09-Sep-19','DD-MON-RR'),to_date('22-Mar-88','DD-MON-RR'),(SELECT "CountryId" FROM BR_COUNTRY WHERE "CountryCode" ='JP'))
/
INSERT INTO BR_USER VALUES(144,'bandtying','Rennie','Mackro','rmackro18@eepurl.com','U',to_date('07-Jul-17','DD-MON-RR'),to_date('11-Apr-63','DD-MON-RR'),(SELECT "CountryId" FROM BR_COUNTRY WHERE "CountryCode" ='IL'))
/
INSERT INTO BR_USER VALUES(145,'ceetlawrencium','Graham','Jenik','gjenik19@google.pl','M',to_date('12-Apr-18','DD-MON-RR'),to_date('20-Jul-62','DD-MON-RR'),(SELECT "CountryId" FROM BR_COUNTRY WHERE "CountryCode" ='US'))
/
INSERT INTO BR_USER VALUES(146,'hoverwrist','Rubina','Kenforth','rkenforth1a@msn.com','F',to_date('19-Feb-19','DD-MON-RR'),to_date('14-Aug-63','DD-MON-RR'),(SELECT "CountryId" FROM BR_COUNTRY WHERE "CountryCode" ='UK'))
/
INSERT INTO BR_USER VALUES(147,'popinjaygudgeon','Linnea','Ible','lible1b@typepad.com','F',to_date('13-Mar-18','DD-MON-RR'),to_date('04-Aug-65','DD-MON-RR'),(SELECT "CountryId" FROM BR_COUNTRY WHERE "CountryCode" ='UK'))
/
INSERT INTO BR_USER VALUES(148,'obeisantmedium','Brittni','Richings','brichings1c@home.pl','F',to_date('15-Nov-18','DD-MON-RR'),to_date('30-Nov-86','DD-MON-RR'),(SELECT "CountryId" FROM BR_COUNTRY WHERE "CountryCode" ='FR'))
/
INSERT INTO BR_USER VALUES(149,'blacketfasting','Kip','Sharma','ksharma1d@washington.edu','F',to_date('15-Dec-18','DD-MON-RR'),to_date('31-Dec-73','DD-MON-RR'),(SELECT "CountryId" FROM BR_COUNTRY WHERE "CountryCode" ='US'))
/


REM INSERTING into BR_APPCATEGORY
INSERT INTO BR_APPCATEGORY VALUES(10, 'Games', 'Game applications')
/
INSERT INTO BR_APPCATEGORY VALUES(20, 'Family', 'Apps suitable for all ages')
/
INSERT INTO BR_APPCATEGORY VALUES(30, 'News', 'Apps for news purposes')
/
INSERT INTO BR_APPCATEGORY VALUES(40, 'Social', 'Social media')
/
INSERT INTO BR_APPCATEGORY VALUES(50, 'Dating', 'Dating apps')
/

REM INSERTING into BR_APP
INSERT INTO BR_APP VALUES(20,'Daily Bugle',30,to_date('01-Nov-19','DD-MON-RR'),'1.2.14','Y',11,11)
/
INSERT INTO BR_APP VALUES(21,'Daily Planet',30,to_date('31-Aug-19','DD-MON-RR'),'2.0.1','Y',16,16)
/
INSERT INTO BR_APP VALUES(22,'Sudoku101',10,to_date('01-Jan-19','DD-MON-RR'),'1.5.6','Y',8,8)
/
INSERT INTO BR_APP VALUES(23,'PocketRicks',10,to_date('20-Dec-18','DD-MON-RR'),'1.0.2','Y',11,11)
/
INSERT INTO BR_APP VALUES(24,'Ultimate Solitaire',10,to_date('09-Mar-19','DD-MON-RR'),'1.8.0','Y',20,20)
/
INSERT INTO BR_APP VALUES(25,'My Simulation',10,to_date('03-Feb-19','DD-MON-RR'),'2.2.31','Y',2,2)
/
INSERT INTO BR_APP VALUES(26,'ABCs',20,to_date('16-Oct-19','DD-MON-RR'),'3.0.0','Y',6,6)
/
INSERT INTO BR_APP VALUES(27,'123s',20,to_date('12-Sep-18','DD-MON-RR'),'2.0.5','N',4,4)
/
INSERT INTO BR_APP VALUES(28,'Colours and Shapes',20,to_date('08-Nov-19','DD-MON-RR'),'1.5.16','Y',18,15)
/
INSERT INTO BR_APP VALUES(29,'ChatMe',40,to_date('05-May-19','DD-MON-RR'),'1.9.9','Y',18,3)
/
INSERT INTO BR_APP VALUES(30,'WhysApp',40,to_date('17-Nov-19','DD-MON-RR'),'2.3.6','Y',4,4)
/
INSERT INTO BR_APP VALUES(31,'Kindling',50,to_date('10-Aug-19','DD-MON-RR'),'1.4.3','N',8,8)
/
INSERT INTO BR_APP VALUES(32,'OkEros',50,to_date('23-Oct-19','DD-MON-RR'),'2.6.8','Y',4,2)
/

REM INSERTING into BR_APPUSER
INSERT INTO BR_APPUSER VALUES(301,20,101,to_date('19-Apr-18','DD-MON-RR'),'N')
/
INSERT INTO BR_APPUSER VALUES(302,20,105,to_date('14-Dec-18','DD-MON-RR'),'Y')
/
INSERT INTO BR_APPUSER VALUES(303,20,107,to_date('10-Nov-18','DD-MON-RR'),'Y')
/
INSERT INTO BR_APPUSER VALUES(304,20,111,to_date('30-Aug-19','DD-MON-RR'),'Y')
/
INSERT INTO BR_APPUSER VALUES(305,20,115,to_date('18-Aug-18','DD-MON-RR'),'N')
/
INSERT INTO BR_APPUSER VALUES(306,20,128,to_date('22-Apr-19','DD-MON-RR'),'Y')
/
INSERT INTO BR_APPUSER VALUES(307,20,132,to_date('02-Apr-18','DD-MON-RR'),'N')
/
INSERT INTO BR_APPUSER VALUES(308,20,133,to_date('06-Dec-18','DD-MON-RR'),'Y')
/
INSERT INTO BR_APPUSER VALUES(309,20,149,to_date('04-Nov-18','DD-MON-RR'),'Y')
/
INSERT INTO BR_APPUSER VALUES(310,20,136,to_date('01-Aug-19','DD-MON-RR'),'N')
/
INSERT INTO BR_APPUSER VALUES(311,20,145,to_date('19-Feb-18','DD-MON-RR'),'N')
/
INSERT INTO BR_APPUSER VALUES(312,20,122,to_date('10-Aug-18','DD-MON-RR'),'Y')
/
INSERT INTO BR_APPUSER VALUES(313,21,104,to_date('20-Aug-18','DD-MON-RR'),'Y')
/
INSERT INTO BR_APPUSER VALUES(314,21,105,to_date('12-Nov-19','DD-MON-RR'),'N')
/
INSERT INTO BR_APPUSER VALUES(315,21,116,to_date('20-Feb-18','DD-MON-RR'),'N')
/
INSERT INTO BR_APPUSER VALUES(316,21,117,to_date('25-Apr-18','DD-MON-RR'),'N')
/
INSERT INTO BR_APPUSER VALUES(317,21,123,to_date('27-Jun-19','DD-MON-RR'),'N')
/
INSERT INTO BR_APPUSER VALUES(318,21,127,to_date('08-Apr-18','DD-MON-RR'),'N')
/
INSERT INTO BR_APPUSER VALUES(319,21,129,to_date('28-Apr-18','DD-MON-RR'),'Y')
/
INSERT INTO BR_APPUSER VALUES(320,21,141,to_date('22-Dec-18','DD-MON-RR'),'Y')
/
INSERT INTO BR_APPUSER VALUES(321,22,103,to_date('18-Aug-19','DD-MON-RR'),'Y')
/
INSERT INTO BR_APPUSER VALUES(322,22,112,to_date('27-Aug-19','DD-MON-RR'),'N')
/
INSERT INTO BR_APPUSER VALUES(323,22,122,to_date('03-Apr-19','DD-MON-RR'),'N')
/
INSERT INTO BR_APPUSER VALUES(324,22,135,to_date('03-Dec-18','DD-MON-RR'),'Y')
/
INSERT INTO BR_APPUSER VALUES(325,22,141,to_date('12-Mar-19','DD-MON-RR'),'Y')
/
INSERT INTO BR_APPUSER VALUES(326,23,110,to_date('26-Oct-18','DD-MON-RR'),'Y')
/
INSERT INTO BR_APPUSER VALUES(327,23,119,to_date('29-Jun-19','DD-MON-RR'),'Y')
/
INSERT INTO BR_APPUSER VALUES(328,23,129,to_date('19-Oct-19','DD-MON-RR'),'Y')
/
INSERT INTO BR_APPUSER VALUES(329,23,142,to_date('14-Jun-19','DD-MON-RR'),'N')
/
INSERT INTO BR_APPUSER VALUES(330,23,134,to_date('27-Mar-18','DD-MON-RR'),'Y')
/
INSERT INTO BR_APPUSER VALUES(331,23,136,to_date('01-Nov-19','DD-MON-RR'),'Y')
/
INSERT INTO BR_APPUSER VALUES(332,23,138,to_date('18-Jul-19','DD-MON-RR'),'N')
/
INSERT INTO BR_APPUSER VALUES(333,23,148,to_date('03-Oct-18','DD-MON-RR'),'Y')
/
INSERT INTO BR_APPUSER VALUES(334,23,139,to_date('22-Mar-19','DD-MON-RR'),'N')
/
INSERT INTO BR_APPUSER VALUES(335,24,101,to_date('23-Jun-19','DD-MON-RR'),'N')
/
INSERT INTO BR_APPUSER VALUES(336,24,110,to_date('22-Feb-19','DD-MON-RR'),'N')
/
INSERT INTO BR_APPUSER VALUES(337,24,135,to_date('15-Apr-18','DD-MON-RR'),'Y')
/
INSERT INTO BR_APPUSER VALUES(338,24,140,to_date('15-Feb-19','DD-MON-RR'),'Y')
/
INSERT INTO BR_APPUSER VALUES(339,24,148,to_date('30-Jun-18','DD-MON-RR'),'N')
/
INSERT INTO BR_APPUSER VALUES(340,25,101,to_date('25-Sep-18','DD-MON-RR'),'Y')
/
INSERT INTO BR_APPUSER VALUES(341,25,106,to_date('19-May-19','DD-MON-RR'),'Y')
/
INSERT INTO BR_APPUSER VALUES(342,25,109,to_date('09-Dec-18','DD-MON-RR'),'N')
/
INSERT INTO BR_APPUSER VALUES(343,25,111,to_date('02-Apr-19','DD-MON-RR'),'Y')
/
INSERT INTO BR_APPUSER VALUES(344,25,114,to_date('27-Oct-18','DD-MON-RR'),'Y')
/
INSERT INTO BR_APPUSER VALUES(345,25,115,to_date('28-Jul-18','DD-MON-RR'),'N')
/
INSERT INTO BR_APPUSER VALUES(346,25,117,to_date('23-Dec-18','DD-MON-RR'),'Y')
/
INSERT INTO BR_APPUSER VALUES(347,25,124,to_date('06-Nov-19','DD-MON-RR'),'N')
/
INSERT INTO BR_APPUSER VALUES(348,25,141,to_date('02-Jan-18','DD-MON-RR'),'N')
/
INSERT INTO BR_APPUSER VALUES(349,25,132,to_date('07-Feb-19','DD-MON-RR'),'N')
/
INSERT INTO BR_APPUSER VALUES(350,25,137,to_date('19-Jul-19','DD-MON-RR'),'Y')
/
INSERT INTO BR_APPUSER VALUES(351,25,149,to_date('26-Sep-18','DD-MON-RR'),'Y')
/
INSERT INTO BR_APPUSER VALUES(352,26,101,to_date('10-Apr-19','DD-MON-RR'),'N')
/
INSERT INTO BR_APPUSER VALUES(353,26,106,to_date('18-Jan-18','DD-MON-RR'),'Y')
/
INSERT INTO BR_APPUSER VALUES(354,26,119,to_date('04-Feb-19','DD-MON-RR'),'N')
/
INSERT INTO BR_APPUSER VALUES(355,26,130,to_date('07-Mar-18','DD-MON-RR'),'Y')
/
INSERT INTO BR_APPUSER VALUES(356,26,131,to_date('14-Sep-19','DD-MON-RR'),'Y')
/
INSERT INTO BR_APPUSER VALUES(357,26,134,to_date('11-Jul-18','DD-MON-RR'),'Y')
/
INSERT INTO BR_APPUSER VALUES(358,26,135,to_date('16-Sep-18','DD-MON-RR'),'N')
/
INSERT INTO BR_APPUSER VALUES(359,26,140,to_date('07-Aug-18','DD-MON-RR'),'Y')
/
INSERT INTO BR_APPUSER VALUES(360,26,142,to_date('06-Mar-19','DD-MON-RR'),'Y')
/
INSERT INTO BR_APPUSER VALUES(361,28,112,to_date('05-Oct-18','DD-MON-RR'),'N')
/
INSERT INTO BR_APPUSER VALUES(362,28,124,to_date('04-Jan-18','DD-MON-RR'),'N')
/
INSERT INTO BR_APPUSER VALUES(363,28,126,to_date('29-May-19','DD-MON-RR'),'Y')
/
INSERT INTO BR_APPUSER VALUES(364,28,128,to_date('06-Jul-18','DD-MON-RR'),'N')
/
INSERT INTO BR_APPUSER VALUES(365,28,132,to_date('12-Nov-18','DD-MON-RR'),'Y')
/
INSERT INTO BR_APPUSER VALUES(366,28,140,to_date('04-May-18','DD-MON-RR'),'N')
/
INSERT INTO BR_APPUSER VALUES(367,28,134,to_date('22-Feb-18','DD-MON-RR'),'Y')
/
INSERT INTO BR_APPUSER VALUES(368,28,139,to_date('10-Mar-19','DD-MON-RR'),'N')
/
INSERT INTO BR_APPUSER VALUES(369,28,146,to_date('14-Jan-18','DD-MON-RR'),'Y')
/
INSERT INTO BR_APPUSER VALUES(370,28,148,to_date('22-May-18','DD-MON-RR'),'N')
/
INSERT INTO BR_APPUSER VALUES(371,29,104,to_date('13-Aug-19','DD-MON-RR'),'N')
/
INSERT INTO BR_APPUSER VALUES(372,29,105,to_date('18-Jan-19','DD-MON-RR'),'Y')
/
INSERT INTO BR_APPUSER VALUES(373,29,112,to_date('09-Apr-19','DD-MON-RR'),'N')
/
INSERT INTO BR_APPUSER VALUES(374,29,116,to_date('04-Jul-19','DD-MON-RR'),'Y')
/
INSERT INTO BR_APPUSER VALUES(375,29,121,to_date('06-Nov-19','DD-MON-RR'),'N')
/
INSERT INTO BR_APPUSER VALUES(376,29,123,to_date('24-Oct-18','DD-MON-RR'),'N')
/
INSERT INTO BR_APPUSER VALUES(377,29,124,to_date('01-Jul-18','DD-MON-RR'),'N')
/
INSERT INTO BR_APPUSER VALUES(378,29,135,to_date('11-Mar-18','DD-MON-RR'),'N')
/
INSERT INTO BR_APPUSER VALUES(379,29,138,to_date('02-Aug-18','DD-MON-RR'),'Y')
/
INSERT INTO BR_APPUSER VALUES(380,29,139,to_date('14-Jun-18','DD-MON-RR'),'Y')
/
INSERT INTO BR_APPUSER VALUES(381,29,144,to_date('11-Aug-19','DD-MON-RR'),'Y')
/
INSERT INTO BR_APPUSER VALUES(382,29,148,to_date('06-Feb-18','DD-MON-RR'),'N')
/
INSERT INTO BR_APPUSER VALUES(383,30,103,to_date('10-May-18','DD-MON-RR'),'N')
/
INSERT INTO BR_APPUSER VALUES(384,30,149,to_date('13-Jan-18','DD-MON-RR'),'N')
/
INSERT INTO BR_APPUSER VALUES(385,30,104,to_date('29-Oct-18','DD-MON-RR'),'Y')
/
INSERT INTO BR_APPUSER VALUES(386,30,111,to_date('27-Feb-18','DD-MON-RR'),'Y')
/
INSERT INTO BR_APPUSER VALUES(387,30,133,to_date('17-Feb-19','DD-MON-RR'),'N')
/
INSERT INTO BR_APPUSER VALUES(388,30,117,to_date('24-Apr-19','DD-MON-RR'),'N')
/
INSERT INTO BR_APPUSER VALUES(389,30,135,to_date('06-Aug-19','DD-MON-RR'),'N')
/
INSERT INTO BR_APPUSER VALUES(390,30,129,to_date('06-Mar-19','DD-MON-RR'),'Y')
/
INSERT INTO BR_APPUSER VALUES(391,30,137,to_date('19-Aug-19','DD-MON-RR'),'Y')
/
INSERT INTO BR_APPUSER VALUES(392,30,140,to_date('02-Oct-18','DD-MON-RR'),'N')
/
INSERT INTO BR_APPUSER VALUES(393,30,142,to_date('13-May-19','DD-MON-RR'),'Y')
/
INSERT INTO BR_APPUSER VALUES(394,30,143,to_date('01-Apr-19','DD-MON-RR'),'N')
/
INSERT INTO BR_APPUSER VALUES(395,32,113,to_date('18-Mar-18','DD-MON-RR'),'Y')
/
INSERT INTO BR_APPUSER VALUES(396,32,131,to_date('01-Jul-19','DD-MON-RR'),'N')
/
INSERT INTO BR_APPUSER VALUES(397,32,132,to_date('17-Oct-18','DD-MON-RR'),'N')
/
INSERT INTO BR_APPUSER VALUES(398,32,135,to_date('05-Jan-19','DD-MON-RR'),'Y')
/
INSERT INTO BR_APPUSER VALUES(399,32,137,to_date('21-Feb-18','DD-MON-RR'),'Y')
/
INSERT INTO BR_APPUSER VALUES(400,32,139,to_date('06-Mar-18','DD-MON-RR'),'N')
/






ALTER TABLE "BR_APPUSER" ADD CONSTRAINT "BR_AppUser_App_FK" FOREIGN KEY ("AppId") 
	 REFERENCES "BR_APP"("AppId") ENABLE
/

ALTER TABLE "BR_APPUSER" ADD CONSTRAINT "BR_AppUser_User_FK" FOREIGN KEY ("UserId")
	 REFERENCES "BR_USER" ("UserId") ENABLE
/

ALTER TABLE "BR_APP" ADD CONSTRAINT "BR_App_Category_FK" FOREIGN KEY ("AppCategoryId")
	 REFERENCES "BR_APPCATEGORY" ("AppCategoryId") ENABLE
/

ALTER TABLE "BR_USER" ADD CONSTRAINT "BR_User_Country_FK" FOREIGN KEY ("CountryId")
	 REFERENCES "BR_COUNTRY" ("CountryId") ENABLE
/






set term on
set feedback on
prompt
prompt BR_Country, BR_User, BR_AppCategory, BR_App
prompt and BR_AppUser tables populated.
prompt
prompt
prompt


prompt The BR_Country table columns:
Desc BR_COUNTRY
prompt 

prompt The BR_Country table data:
prompt
select * 
from BR_COUNTRY
/


prompt
prompt The BR_User table columns:
Desc BR_USER
prompt

prompt The BR_User table data:
prompt
select *
from BR_USER
/


prompt
prompt The BR_AppCategory table columns:
Desc BR_APPCATEGORY
prompt

prompt The BR_AppCategory table data:
prompt
select * 
from BR_APPCATEGORY
/


prompt
prompt The BR_App table columns:
Desc BR_APP
prompt

prompt The BR_App table data:
prompt
select *
from BR_APP
/


prompt 
prompt The BR_AppUser table columns:
Desc BR_APPUSER
prompt

prompt The BR_AppUser table data:
prompt 
select *
from BR_APPUSER
/

prompt BreezeCo_tab.sql last amended by B. Cox/18-NOV-19.
prompt
prompt BreezeCo Creation Script Set Up has Finished.
prompt
prompt
prompt      
prompt
prompt
prompt      
prompt
prompt
prompt      
