-- ***************************************************************************
-- List of database tables that I will use to keep track of all our customers 
-- and what they have submitted, who amount our "employees" has taken care of
-- that customer's request and so on.
-- ***************************************************************************
create table admins (
		-- Admins login to see the work load
		-- Only admins people are to assign
		-- ticket to the techteam
	aemail		varchar(255) NOT NULL UNIQUE,
		-- We use admin's email to identify
		-- them on our database.
	apassword	varchar(255) NOT NULL,
		-- password.
	aquestion	varchar(100) NOT NULL,
	aanswer		varchar(100) NOT NULL,
	afname		varchar(20) NOT NULL,
	alname		varchar(20) NOT NULL,
	aophone		varchar(100) NOT NULL,
	ahphone		varchar(100),
	acell		varchar(100),
	apager		varchar(100),
	aepager		varchar(100),
	aaddress1	varchar(255) NOT NULL,
	aaddress2	varchar(255),
	acity		varchar(100) NOT NULL,
	astate		varchar(100) NOT NULL,
	azipcode	varchar(25),
	acountry	varchar(100) NOT NULL
);
-- ***************************************************************************
create table techteam (
		-- The support team of people
		-- qualified to print the requests
		-- from the customers, put in envelopes
		-- and mail it.
	temail		varchar(255) NOT NULL UNIQUE,
		-- We use techteam's email to identify
		-- them on our database.
	tpassword	varchar(25) NOT NULL,
		-- password.
	tquestion	varchar(100) NOT NULL,
	tanswer		varchar(100) NOT NULL,
	tfname		varchar(20) NOT NULL,
	tlname		varchar(20) NOT NULL,
	tophone		varchar(100) NOT NULL,
	thphone		varchar(100),
	tcell		varchar(100),
	tpager		varchar(100),
	tepager		varchar(100),
	taddress1	varchar(255) NOT NULL,
	taddress2	varchar(255),
	tcity		varchar(100) NOT NULL,
	tstate		varchar(100) NOT NULL,
	tzipcode	varchar(25),
	tcountry	varchar(100) NOT NULL
);
-- ***************************************************************************
create table clists (
		-- For each customer to collect a
		-- list of correspondees.
	cemail		varchar(255) NOT NULL,
		-- We use customer's email to identify
		-- them on our database.
	newclist	varchar(25) NOT NULL UNIQUE,
		-- List is a group of addresses.
	ccountry 	varchar(100) NOT NULL
);
ALTER TABLE clists ADD CONSTRAINT unique_clists UNIQUE (cemail, newclist);
-- This to make sure we don't have duplicated (cemail, newclist) entries!
-- ***************************************************************************
create table addressbook (
		-- For each customer to collect a
		-- list of correspondees.
	id		BIGINT PRIMARY KEY NOT NULL AUTO_INCREMENT,
		-- BIGINT:  0 to 18446744073709551615 
		-- SMALLINT:  0 to 65535 
		-- MEDIUMINT:  0 to 16777215 
		-- To identify a list
	cemail		varchar(255) NOT NULL,
		-- We use customer's email to identify
		-- them on our database.
	clist		varchar(25) NOT NULL,
		-- List is a group of addresses.
	ofname		varchar(20) NOT NULL,
	olname		varchar(20) NOT NULL,
	onickname	varchar(20) NOT NULL,
	oaddress1	varchar(255) NOT NULL,
	oaddress2	varchar(255),
	ocity		varchar(100) NOT NULL,
	ostate		varchar(100) NOT NULL,
	ozipcode	varchar(25),
	ocountry	varchar(100) NOT NULL
);
-- ***************************************************************************
create table oncall (
		-- this table is for who amount the
		-- techteam people to assign a 
		-- request first, since they are on call.
		-- This is if we are overwelmed.
	oemail		varchar(255) NOT NULL,
	issue		varchar(30) NOT NULL,
		-- issue: oracle, unix, sas, dba, syncsort, etc..
		-- from the table issues.
	sdate		datetime,
		-- datetime is of format: "1960-06-15 23:56:02"
	edate		datetime
		-- start date and end date
);
-- ***************************************************************************
create table customers (
		-- Those are the one that submit work
		-- to be printed and mailed out
	cemail		varchar(255) NOT NULL UNIQUE,
		-- We use customer's email to identify
		-- them on our database.
	cpassword	varchar(255) NOT NULL,
		-- password.
	cquestion	varchar(100) NOT NULL,
	canswer		varchar(100) NOT NULL,
	cfname		varchar(20) NOT NULL,
	clname		varchar(20) NOT NULL,
	cophone		varchar(100) NOT NULL,
	chphone		varchar(100),
	ccell		varchar(100),
	cpager		varchar(100),
	cepager		varchar(100),
	caddress1	varchar(255) NOT NULL,
	caddress2	varchar(255),
	ccity		varchar(100) NOT NULL,
	cstate		varchar(100) NOT NULL,
	czipcode	varchar(25),
	ccountry	varchar(100) NOT NULL
);
-- ***************************************************************************
create table requests (
		-- to keep track of all requests
	cemail		varchar(255) NOT NULL,
		-- We use customer's email to identify
		-- them on our database.
	rnum		varchar(15) NOT NULL,
		-- This will be of format YYYYMMDDHHMMSS
		-- NOTE: Any uploaded documents should have for
		-- name starting with rnum.
	day		datetime,
		-- date the request is submitted to our web
	postingmode 	varchar(50),
		-- USPS posting mode: Express / Priority / Standard Mail
	tocountry	varchar(50),
		-- The country the mail is going to.
	tostate		varchar(50),
		-- The state/province/regions the mail is going to.
	tozipcode	varchar(50),
		-- The zipcode the mail is going to.
	mailoutdate	datetime,
		-- the date the customers would like to see
		-- his mail posted to the USPS.
	description	text
		-- decription if customer has a word to add
		-- to his request
);
ALTER TABLE requests ADD CONSTRAINT unique_requests UNIQUE (cemail, rnum);
-- This to make sure we don't have duplicated (cemail, rnum) entries!
-- ***************************************************************************
create table status (
		-- admins will use this for ticket on "opened"
		-- status to assing them to a techteam.
	cemail		varchar(255) NOT NULL,
		-- We use customer's email to identify
		-- them on our database.
	rnum            varchar(15) PRIMARY KEY UNIQUE NOT NULL,
                -- This will be of format YYYYMMDDHHMMSS
	day             datetime,
		-- This will be of format YYYY-MM-DD 22:10:59
	status		varchar(10) NOT NULL,
		-- This will be "opened|closed|pending"
	why		text
		-- to explain why the request is on that status.
		-- and also to keep track of what going on.
);
-- ***************************************************************************
create table assigned (
		-- to keep track of assignment of requests
		-- to techteam.
	rnum		varchar(15) NOT NULL,
	day		datetime,
		-- This will be of format YYYY-MM-DD 22:10:59
	assignedto	varchar(25)
		-- This will be the userid who work on that issue
);
-- ***************************************************************************
create table attachments (
		-- to keep track of requests attachments filename.
	cemail		varchar(255) NOT NULL,
		-- We use customer's email to identify
		-- them on our database.
	rnum		varchar(15) NOT NULL,
	attachment	varchar(255),
		-- The full path to the locaction of upload.
	day		datetime,
		-- This will be of format YYYY-MM-DD 22:10:59
	originalname	varchar(255)
		-- The full path to the locaction of upload.
);
-- ***************************************************************************
create table attachmentspages (
		-- to keep track of requests attachments filename.
	cemail		varchar(255) NOT NULL,
		-- We use customer's email to identify
		-- them on our database.
	rnum		varchar(15) NOT NULL,
	attachment	varchar(255),
		-- The full path to the locaction of upload.
	numofpages 	MEDIUMINT,
		-- MEDIUMINT:  0 to 16777215
		-- This will be of format YYYY-MM-DD 22:10:59
	originalname	varchar(255)
		-- The full path to the locaction of upload.
);
-- ***************************************************************************
create table bulkmails (
		-- to keep track of bulk requests attachments filename.
	cemail		varchar(255) NOT NULL,
		-- We use customer's email to identify
		-- them on our database.
	rnum		varchar(15) NOT NULL,
	attachment	varchar(255),
		-- The full path to the locaction of upload.
	numofaddressees	MEDIUMINT,
		-- MEDIUMINT:  0 to 16777215
	numofpages 	MEDIUMINT,
		-- MEDIUMINT:  0 to 16777215
		-- this should not be more than 45 pages
		-- to be conform to the USPS max number of
		-- page per letter.
	originalname	varchar(255)
		-- The full path to the locaction of upload.
);
ALTER TABLE bulkmails ADD CONSTRAINT unique_bulkmails UNIQUE (cemail, rnum);
-- ***************************************************************************
create table evolutions (
		-- To keep track the status/evolution
		-- of the requests at a certain time.
	cemail		varchar(255) NOT NULL,
		-- We use customer's email to identify
		-- them on our database.
	rnum            varchar(15) NOT NULL,
	day             datetime,
		-- This will be of format YYYY-MM-DD 22:10:59
	who        	varchar(25),
		-- ... who did it.
	event		text
		-- Will contain what's done at that time and date ....
		-- text will be size of 2^16
		-- longtext is size 2^32 and mediumtext is size 2^24
);
-- ***************************************************************************
create table depots (
	cemail		varchar(255) NOT NULL UNIQUE,
		-- customer's email
	depot		varchar(25)  NOT NULL
		-- customers upload base directory.
);
-- ***************************************************************************
create table depotcontents (
	cemail		varchar(255) NOT NULL,
		-- customer's email
	day		datetime,
	rnum		varchar(15)
		-- customers upload sub directory for that day.
);
-- ***************************************************************************
create table postoffices (
		-- To handle US postal services and prices.
		-- Do the same thing for another country.
		-- There is an associate array that show
		-- each country Postal Services Code.
	pbarcode	varchar(255) NOT NULL UNIQUE,
	pservice	varchar(100) NOT NULL,
	pcountry	varchar(100) NOT NULL,
	pminnumofpage	integer NOT NULL,
	pmaxnumofpage	integer NOT NULL,
	punitprice	float NOT NULL
);
-- ***************************************************************************
create table payedrequests (
		-- to keep track of all payments
        cemail          varchar(255) NOT NULL,
                -- We use customer's email to identify
                -- them on our database.
        rnum            varchar(15) NOT NULL,
                -- This will be of format YYYYMMDDHHMMSS
                -- NOTE: Any uploaded documents should have for
                -- name starting with rnum.
        day             datetime NOT NULL,
                -- date the request is payed.
	amount		float NOT NULL
);
ALTER TABLE payedrequests ADD CONSTRAINT paid_requests UNIQUE (cemail, rnum);
-- This to make sure we don't have duplicated (cemail, rnum) entries!
-- ***************************************************************************
create table credittransactions (
		-- to keep track of all payments
        cemail          varchar(255) NOT NULL,
                -- We use customer's email to identify
                -- them on our database.
        rnum            varchar(15) NOT NULL,
                -- This will be of format YYYYMMDDHHMMSS
                -- NOTE: Any uploaded documents should have for
                -- name starting with rnum.
	-- Now let us collect the credit card transaction errors
	-- here for further reference.
	r_ordernum 	varchar(100),
		-- Order number from the Linkpoint.com
	r_error 	varchar(100),
		-- error from Linkpoint.com
	r_time 		varchar(100),
		-- time from Linkpoint.com
	r_approved 	 varchar(15),
		-- status /APPROVED/FRAUD/DECLINED
        day             datetime NOT NULL,
                -- date the request is payed.
	amount		float NOT NULL
);
ALTER TABLE credittransactions ADD CONSTRAINT credit_trans UNIQUE (cemail, rnum);
-- This to make sure we don't have duplicated (cemail, rnum) entries!
-- ***************************************************************************
create table funds (
		-- to keep track of funds available for payments
        cemail          varchar(255) NOT NULL UNIQUE,
                -- We use customer's email to identify
                -- them on our database.
	cpassword	varchar(255) NOT NULL,
		-- password.
	amount		float NOT NULL
);
-- ***************************************************************************
