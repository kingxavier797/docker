#/bin/ksh
USER=`/usr/bin/whoami`
MYSQLDBOWNER="root";
MYSQLDBOWNERPASS="1f0rg0t";
# Above change the mysql database root password to the right one
# Pease read mySQL_Setup.txt and README.TXT for more on how
# to setup mySQL and mailit.


# ----------------------- don't change anything below this line
DB="mailitdb";

if [ $USER != "root" ]
then
        echo "Must be root user to run this script!"
        echo "su - root! ... bye"
        exit 0
fi
echo
echo -n "Destroy database called ${DB} if any? [y/n]"
read ans
if [ $ans == "y" ]
then
        echo "Destroying database ${DB} !!"
        mysqladmin drop ${DB} -p
        echo "Creating the DB space called ${DB}"
        mysqladmin create ${DB} -p
else
        echo "${DB} database will not be destroyed!"
fi
echo
echo -n "Create the user apache as owner of the ${DB} Database [y/n]"
read ans1
if [ $ans1 == "y" ]
then
        echo "Creating web user: apache"
        mysql -u ${MYSQLDBOWNER} -p ${DB} < grant_apache_access_to_dbserver.sql
else
        echo "User apache will not be created!"
fi
echo
echo -n "Create ${DB} database's tables [y/n]"
read ans2
if [ $ans2 == "y" ]
then
        echo "Creating the ${DB} tables"
        mysql -u ${MYSQLDBOWNER} -p ${DB} < mailittables.sql
else
        echo "${DB} database will not be created!"
fi

echo
echo
echo
echo
echo
echo "Please don't forget to update on the webserver/webcontainer "
echo "/var/www/cgi-bin/mailit/admin/mysql_env.pl the variable \$DATABASESERVER"
echo "with right IP of the dbcontainer/dbserver:"
echo
ifconfig | grep -E -o "([0-9]{1,3}[\.]){3}[0-9]{1,3}"
echo
echo

