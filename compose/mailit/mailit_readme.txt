In this lab, we are to create an educational website, once your register and login with the right credentials, you should be able to access the list of Online Classes offered at the website.

[asokone@hpi7vboel82 mailit]$ docker-compose up --build -d

[asokone@hpi7vboel82 mailit]$ docker-compose ps
    Name                  Command                  State                          Ports
----------------------------------------------------------------------------------------------------------
dbcontainer    /entrypoint.sh --default-a ...   Up (healthy)   0.0.0.0:3306->3306/tcp
webcontainer   /bin/sh -c /usr/sbin/httpd ...   Up             0.0.0.0:8443->443/tcp, 0.0.0.0:8000->80/tcp

[asokone@hpi7vboel82 mailit]$
[asokone@hpi7vboel82 mailit]$

LET US SETUP THE DATABASE SERVER READY TO HANDLE THE WEB APPLICATION RESQUEST


[asokone@hpi7vboel82 mailit]$
[asokone@hpi7vboel82 mailit]$ docker container exec -it dbcontainer bash
bash-4.2#
bash-4.2#
bash-4.2# cd /var/www/sql/mailit
bash-4.2# 
bash-4.2# ls
README.TXT   grant_apache_access_to_dbserver.sql  mySQL_Password_Encryption.txt  postoffices2006-05-30.sql
code         logs                             mySQL_Setup.txt  doitall.ksh  mailittables.sql                     mysql_history.txt
bash-4.2#
bash-4.2#
bash-4.2#
bash-4.2# ./newdoitall.ksh

Destroy database called mailitdb if any? [y/n]y
Destroying database mailitdb !!
Enter password:
Dropping the database is potentially a very bad thing to do.
Any data stored in the database will be destroyed.

Do you really want to drop the 'mailitdb' database [y/N] y
Database "mailitdb" dropped
Creating the DB space called mailitdb
Enter password:

Create the user apache as owner of the mailitdb Database [y/n]y
Creating web user: apache
Enter password:
ERROR 1396 (HY000) at line 1: Operation CREATE USER failed for 'apache'@'172.18.0.2'

Create mailitdb database's tables [y/n]y
Creating the mailitdb tables by  root
Enter password:

bash-4.2#
bash-4.2#
bash-4.2#
bash-4.2#
bash-4.2#
bash-4.2#
bash-4.2# mysql -u root -p
Enter password:
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 166
Server version: 8.0.21 MySQL Community Server - GPL

Copyright (c) 2000, 2020, Oracle and/or its affiliates. All rights reserved.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql> show databases;
+--------------------+
| Database           |
+--------------------+
| information_schema |
| mailitdb           |
| mysql              |
| performance_schema |
| sys                |
+--------------------+
5 rows in set (0.02 sec)

mysql>
mysql> use mailitdb;
Reading table information for completion of table and column names
You can turn off this feature to get a quicker startup with -A

Database changed
mysql>
mysql>
mysql> show tables;
+--------------------+
| Tables_in_mailitdb |
+--------------------+
| addressbook        |
| admins             |
| assigned           |
| attachments        |
| attachmentspages   |
| bulkmails          |
| clists             |
| credittransactions |
| customers          |
| depotcontents      |
| depots             |
| evolutions         |
| funds              |
| oncall             |
| payedrequests      |
| postoffices        |
| requests           |
| status             |
| techteam           |
+--------------------+
19 rows in set (0.00 sec)

mysql>
mysql>
mysql> quit
Bye
bash-4.2# 
bash-4.2# 
bash-4.2# 
bash-4.2# hostname
dbserver

bash-4.2# 
bash-4.2# 

bash-4.2# ifconfig
eth0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 172.25.0.3  netmask 255.255.0.0  broadcast 172.25.255.255
        ether 02:42:ac:19:00:03  txqueuelen 0  (Ethernet)
        RX packets 1872  bytes 20505772 (19.5 MiB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 1361  bytes 109424 (106.8 KiB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

lo: flags=73<UP,LOOPBACK,RUNNING>  mtu 65536
        inet 127.0.0.1  netmask 255.0.0.0
        loop  txqueuelen 1000  (Local Loopback)
        RX packets 8  bytes 952 (952.0 B)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 8  bytes 952 (952.0 B)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

bash-4.2#
bash-4.2#
bash-4.2# ifconfig eth0 | grep inet | awk '{print $2}’        THIS IP IS NEED TO GRANT APACHE ACCESS TO THE DATABASE
172.25.0.3

bash-4.2#
bash-4.2#



Now, let us access, the webserver, to update, the application, environment variables,  to access the database.


[asokone@hpi7vboel82 mailit]$
[asokone@hpi7vboel82 mailit]$ docker container exec -it webcontainer bash

[root@webserver mailit]#
[root@webserver mailit]#

Now, that we are, inside the container, let us try, to access the database: mailitdb instance, as user:  apache/apache12

[root@webserver mailit]#
[root@webserver mailit]#
[root@webserver mailit]#
[root@webserver mailit]# mysql -u apache -p -h 172.25.0.3 -D mailitdb
Enter password: apache12
Reading table information for completion of table and column names
You can turn off this feature to get a quicker startup with -A

Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 171
Server version: 8.0.21 MySQL Community Server - GPL

Copyright (c) 2000, 2020, Oracle and/or its affiliates. All rights reserved.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql>
mysql> quit
Bye
[root@webserver mailit]#
[root@webserver mailit]#

Please don't forget to update on the webserver/webcontainer the file /var/www/cgi-bin/mailit/admin/mysql_env.pl the variable $DATABASESERVER with right IP of the dbcontainer/dbserver:


After the update of mysql_env.pl you can access, the mailitdb instance, as apache user, from the webserver, is working, therefore, we can access, our web application thru:
 http://192.168.0.164:8000/mailit/index.html to proceed with the rest of the lab.
--> Create an account
--> Login to acess the list of classes available


Let us cleanup 

[asokone@hpi7vboel82 mailit]$ docker-compose ps
    Name                  Command                  State                          Ports
----------------------------------------------------------------------------------------------------------
dbcontainer    /entrypoint.sh --default-a ...   Up (healthy)   0.0.0.0:3306->3306/tcp
webcontainer   /bin/sh -c /usr/sbin/httpd ...   Up             0.0.0.0:8443->443/tcp, 0.0.0.0:8000->80/tcp
[asokone@hpi7vboel82 mailit]$
[asokone@hpi7vboel82 mailit]$

[asokone@hpi7vboel82 mailit]$ docker images
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
oraclelinux         8.2                 43dca3232798        6 hours ago         2.46GB
oraclelinux         7-slim              755b41323b7d        6 hours ago         685MB
oraclelinux         <none>              03c22334cf5a        7 days ago          131MB
oraclelinux         <none>              c23ddcc8aacf        7 days ago          440MB
[asokone@hpi7vboel82 mailit]$
[asokone@hpi7vboel82 mailit]$

[asokone@hpi7vboel82 mailit]$ docker volume ls
DRIVER              VOLUME NAME
local               1b0b9e76be5c87aa814c55a8ec07b8ff6173c0f75739774f543cb3f5cb6b532e
[asokone@hpi7vboel82 mailit]$
[asokone@hpi7vboel82 mailit]$

[asokone@hpi7vboel82 mailit]$ docker-compose down

Removing dbcontainer  ... done
Removing webcontainer ... Done

Removing network mailit_default
[asokone@hpi7vboel82 mailit]$
[asokone@hpi7vboel82 mailit]$

[asokone@hpi7vboel82 mailit]$ docker rmi -f 43dca3232798 755b41323b7d 03c22334cf5a c23ddcc8aacf

[asokone@hpi7vboel82 mailit]$ docker volume prune
WARNING! This will remove all local volumes not used by at least one container.
Are you sure you want to continue? [y/N] y
Deleted Volumes:
1b0b9e76be5c87aa814c55a8ec07b8ff6173c0f75739774f543cb3f5cb6b532e

Total reclaimed space: 193.7MB
[asokone@hpi7vboel82 mailit]$
[asokone@hpi7vboel82 mailit]$

