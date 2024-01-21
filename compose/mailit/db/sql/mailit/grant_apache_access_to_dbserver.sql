# 172.18.0.2 is the IP of the Web application  container: webserver
# 172.18.0.3 is the IP of the database container: dbserver
# Replace them with the right IP of your containers.
# mailitdb is the name of the application database instance


# Oracle mySQL ways of granting access to a database

create user 'apache'@'172.18.0.2' identified by 'apache12';
create user 'apache'@'webserver' identified by 'apache12';
create user 'apache'@'172.18.0.3' identified by 'apache12';
create user 'apache'@'dbserver' identified by 'apache12';

GRANT ALL ON *.* TO 'apache'@'172.18.0.2';
GRANT ALL ON *.* TO 'apache'@'webserver';
GRANT ALL ON *.* TO 'apache'@'172.18.0.3';
GRANT ALL ON *.* TO 'apache'@'dbserver';

GRANT ALL ON mailitdb.* TO 'apache'@'172.18.0.2';
GRANT ALL ON mailitdb.* TO 'apache'@'webserver';
GRANT ALL ON mailitdb.* TO 'apache'@'172.18.0.3';
GRANT ALL ON mailitdb.* TO 'apache'@'dbserver';

SHOW GRANTS FOR 'apache'@'172.18.0.2';
SHOW GRANTS FOR 'apache'@'172.18.0.3';
SHOW GRANTS FOR 'apache'@'webserver';
SHOW GRANTS FOR 'apache'@'dbserver';

# All Database way doing things, which no longer works for Oracle mySQL 8.0

#GRANT USAGE ON *.* TO 'apache'@'localhost';
#GRANT ALL PRIVILEGES ON mailitdb.* TO 'apache'@'localhost';
#GRANT SELECT, INSERT, UPDATE, DELETE ON 'mysqlcbt'.* TO 'apache'@'localhost';

#GRANT USAGE ON *.* TO 'apache'@'172.18.0.3';
#GRANT ALL PRIVILEGES ON mailitdb.* TO 'apache'@'172.18.0.3';
#GRANT SELECT, INSERT, UPDATE, DELETE ON 'mysqlcbt'.* TO 'apache'@'172.18.0.3';

#GRANT USAGE ON *.* TO 'apache'@'dbserver';
#GRANT ALL PRIVILEGES ON mailitdb.* TO 'apache'@'dbserver';
#GRANT SELECT, INSERT, UPDATE, DELETE ON 'mysqlcbt'.* TO 'apache'@'dbserver';

#GRANT USAGE ON *.* TO 'apache'@'172.18.0.2';
#GRANT ALL PRIVILEGES ON mailitdb.* TO 'apache'@'172.18.0.2';
#GRANT SELECT, INSERT, UPDATE, DELETE ON 'mysqlcbt'.* TO 'apache'@'172.18.0.2';

#GRANT USAGE ON *.* TO 'apache'@'webserver';
#GRANT ALL PRIVILEGES ON mailitdb.* TO 'apache'@'webserver';
#GRANT SELECT, INSERT, UPDATE, DELETE ON 'mysqlcbt'.* TO 'apache'@'webserver';

