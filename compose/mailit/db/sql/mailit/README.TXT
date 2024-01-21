https://bobcares.com/blog/access-denied-for-user-rootlocalhost-using-password-yes-mysql/

- Make sure that the following are installed
Perl module:

use DBI;
use Mail::VRFY;

To Install these modules above below are the steps https://www.cpan.org/modules/INSTALL.html

[root@bunny ~]# which cpan
/usr/bin/which: no cpan in (/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/root/bin)
[root@bunny ~]# yum install -y cpan or dnf install -y cpan
[root@bunny ~]# cpan App:cpanminus 
Would you like to configure as much as possible automatically? [yes]
Be very patient this will take long to finish !!!!

[root@bunny ~]# which cpanm
/usr/local/bin/cpanm
[root@bunny ~]# cpanm Mail::VRFY
Be very patient too !!!

--> Working on Mail::VRFY
Fetching http://www.cpan.org/authors/id/J/JK/JKISTER/Mail-VRFY-1.01.tgz ... OK
Configuring Mail-VRFY-1.01 ... OK

! Installing Sys::Hostname::Long failed. See /root/.cpanm/work/1600161113.114699/build.log for details. Retry with --force to force install it.
! Installing the dependencies failed: Module 'Sys::Hostname::Long' is not installed
! Bailing out the installation for Mail-VRFY-1.01.

[root@bunny ~]# which instmodsh
/usr/bin/instmodsh
[root@bunny ~]# instmodsh m Mail::VRFY
Available commands are:
   l            - List all installed modules
   m <module>   - Select a module
   q            - Quit the program
cmd? m Mail::VRFY
Available commands are:
   f [all|prog|doc]   - List installed files of a given type
   d [all|prog|doc]   - List the directories used by a module
   v                  - Validate the .packlist - check for missing files
   t <tarfile>        - Create a tar archive of the module
   h                  - Display module help
   q                  - Quit the module
Mail::VRFY cmd? v
Mail::VRFY is not installed at /usr/bin/instmodsh line 134.



=====> The installation failed I tried to force install the module now


[root@bunny ~]# cpan
Loading internal null logger. Install Log::Log4perl for logging messages
Terminal does not support AddHistory.

cpan shell -- CPAN exploration and modules installation (v2.18)
Enter 'h' for help.

cpan[1]> force install Mail::VRFY
Reading '/root/.local/share/.cpan/Metadata'
  Database was generated on Tue, 15 Sep 2020 04:56:00 GMT
Running install for module 'Mail::VRFY'
Fetching with LWP:
http://www.cpan.org/authors/id/J/JK/JKISTER/Mail-VRFY-1.01.tgz

....

  JKISTER/Mail-VRFY-1.01.tgz
  /usr/bin/make install  -- OK

cpan[1]>
cpan[1]>
cpan[1]>
cpan[1]> force install DBI
Reading '/root/.local/share/.cpan/Metadata'
  Database was generated on Tue, 15 Sep 2020 04:56:00 GMT
Running install for module 'DBI'
Fetching with LWP:
http://www.cpan.org/authors/id/T/TI/TIMB/DBI-1.643.tar.gz

....

  TIMB/DBI-1.643.tar.gz
  /usr/bin/make install  -- OK
cpan[2]>
cpan[2]>
cpan[2]>
cpan[2]>
cpan[2]> cpan[2]> quit
Terminal does not support GetHistory.
Lockfile removed.
[root@hpi7vboel82 ~]#
[root@hpi7vboel82 ~]#
[root@hpi7vboel82 ~]#
[root@hpi7vboel82 ~]#
[root@hpi7vboel82 ~]# instmodsh
Available commands are:
   l            - List all installed modules
   m <module>   - Select a module
   q            - Quit the program
cmd? l
Installed modules are:
   App::cpanminus
   DBI
   Mail::VRFY
   Net::DNS
   Perl
   Sys::Hostname::Long
   Test::Simple
cmd? q

[root@hpi7vboel82 ~]#
[root@hpi7vboel82 ~]#


- Make sure that mySQL is installed



Test first if mysql is installed
# which mysql
/bin/mysql

Here mysql is installed, if it was not installed please use [ yum install -y mysql* or dnf install -y mysql*]

[root@hpi7vboel82 mailit]#
[root@hpi7vboel82 mailit]#
[root@hpi7vboel82 mailit]# dnf install -y --skip-broken --nobest mysql*
[root@hpi7vboel82 mailit]#
[root@hpi7vboel82 mailit]#

NOW THAT mySQL IS INSTALLED WE CAN INSTALL DBD::mysql Module WHICH I MISTAKENLY TOOK FOR DBI



[root@hpi7vboel82 mailit]#
[root@hpi7vboel82 mailit]# cpan
Loading internal null logger. Install Log::Log4perl for logging messages
Terminal does not support AddHistory.

cpan shell -- CPAN exploration and modules installation (v2.18)
Enter 'h' for help.

cpan[1]>
cpan[1]>
cpan[1]>
cpan[1]>
cpan[1]> force install DBD:mysql
Reading '/root/.local/share/.cpan/Metadata'
  Database was generated on Tue, 15 Sep 2020 04:56:00 GMT
Fetching with LWP:
http://www.cpan.org/authors/01mailrc.txt.gz
Reading '/root/.local/share/.cpan/sources/authors/01mailrc.txt.gz'


......... be patient this will take time



Appending installation info to /usr/lib64/perl5/perllocal.pod
  DVEEDEN/DBD-mysql-4.050.tar.gz
  /usr/bin/make install  -- OK

cpan[2]>
cpan[2]>
cpan[2]>
cpan[2]>
cpan[2]>
cpan[2]> exit
Terminal does not support GetHistory.
Lockfile removed.



[root@hpi7vboel82 mailit]#
[root@hpi7vboel82 mailit]#
[root@hpi7vboel82 mailit]#
[root@hpi7vboel82 mailit]#
[root@hpi7vboel82 mailit]#
[root@hpi7vboel82 mailit]# instmodsh
Available commands are:
   l            - List all installed modules
   m <module>   - Select a module
   q            - Quit the program
cmd? l
Installed modules are:
   App::cpanminus
   Capture::Tiny
   DBD::mysql
   DBI
   Devel::CheckLib
   Mail::VRFY
   Math::BigInt
   Math::BigRat
   Mock::Config
   Net::DNS
   Perl
   Proc::ProcessTable
   Sys::Hostname::Long
   Test::Deep
   Test::Simple
   bignum
cmd? exit
Available commands are:
   l            - List all installed modules
   m <module>   - Select a module
   q            - Quit the program
cmd? q
[root@hpi7vboel82 mailit]#
[root@hpi7vboel82 mailit]#

<<<<<<<<<< 
<<<<<<<<<< PLEASE NOW FOLLOW THE SETUP ON mySQL_Setup.txt TO SETUP mySQL
<<<<<<<<<< WHEN YOU ARE DONE COME BACK TO THIS POINT TO PROCEED.
<<<<<<<<<< 

#####
#####
##### NOW THAT ALL PREREQUISTES ARE IN PLACE LET US CREATE OUR
##### mailitdb AND START ROCKING ROLLING.
#####
#####

- Run the doitall.ksh to create the Database.
Note: If the user apache has been already created in your database no need to
create that user again, just get the password of it and use it to login into
the database

[root@bunny mailit]# ./doitall.ksh

Destroy database called mailitdb if any? [y/n]y
Destroying database mailitdb !!
Dropping the database is potentially a very bad thing to do.
Any data stored in the database will be destroyed.

Do you really want to drop the 'mailitdb' database [y/N] y
Database "mailitdb" dropped
Creating the DB space called mailitdb

Create the user apache as owner of the mailitdb Database [y/n]n
User apache will not be created!

Create mailitdb database's tables [y/n]y
Creating the mailitdb tables

NOTE: Let test to make sure we can login into the database as apache and
apache12 comme mot de passe.

[root@bunny mailit]# ls
create_apache.sql  doitall.ksh  mailittables.sql

[root@bunny mailit]# mysql -u apache -p mailitdb
Enter password:
Reading table information for completion of table and column names
You can turn off this feature to get a quicker startup with -A

Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 3142 to server version: 3.23.54

Type 'help;' or '\h' for help. Type '\c' to clear the buffer.

mysql> show tables;
+--------------------+
| Tables_in_mailitdb |
+--------------------+
| USPS               |
| addressbook        |
| admins             |
| assigned           |
| attachments        |
| attachmentspages   |
| clists             |
| customers          |
| depotcontents      |
| depots             |
| evolutions         |
| oncall             |
| requests           |
| status             |
| status1            |
| techteam           |
+--------------------+
16 rows in set (0.01 sec)

mysql> quit
Bye
[root@bunny mailit]#
