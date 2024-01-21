#/bin/ksh
USER=`/usr/bin/whoami`
echo
echo
echo "Updating - mysql_env.pl environment variables for perl DBI."
echo "/var/www/cgi-bin/mailit/admin/mysql_env.pl the variable DBCONTAINERDB"
echo "with right IP of the dbcontainer/dbserver:"
echo "and /var/www/sql/mailit/grant_apache_access_to_dbserver.sql the variable "
echo "with right IP of the dbcontainer/dbserver:"
echo
echo
sudo docker inspect dbcontainer > /tmp/docker_inspect_dbcontainer.txt
DBCONTAINERIP=`cat /tmp/docker_inspect_dbcontainer.txt | grep "\"IPAddress\":" | grep -v \"\" | awk -F: '{print $2}' | sed -e 's/\"//g' -e 's/\,//g' -e 's/ //g'`
sudo docker inspect webcontainer > /tmp/docker_inspect_webcontainer.txt
WEBCONTAINERIP=`cat /tmp/docker_inspect_webcontainer.txt | grep "\"IPAddress\":" | grep -v \"\" | awk -F: '{print $2}' | sed -e 's/\"//g' -e 's/\,//g' -e 's/ //g'`
echo
echo export DBCONTAINERIP=$DBCONTAINERIP
echo export WEBCONTAINERIP=$WEBCONTAINERIP
echo
echo "DBCONTAINERIP=$DBCONTAINERIP - WEBCONTAINERIP=$WEBCONTAINERIP"

echo
echo "====== Update /var/www/sql/mailit/grant_apache_access_to_dbserver.sql inside dbcontainer with $DBCONTAINERIP"
echo
echo "sudo docker container exec -it --env WORKDIR=/var/www/sql/mailit dbcontainer sed -e 's/DBCONTAINERIP/$DBCONTAINERIP/g' -i /var/www/sql/mailit/grant_apache_access_to_dbserver.sql"
sudo docker container exec -it --env WORKDIR=/var/www/sql/mailit dbcontainer sed -e 's/DBCONTAINERIP/'$DBCONTAINERIP'/g' -i /var/www/sql/mailit/grant_apache_access_to_dbserver.sql
echo
echo "====== Update /var/www/sql/mailit/grant_apache_access_to_dbserver.sql inside dbcontainer with $WEBCONTAINERIP"
echo
echo "sudo docker container exec -it --env WORKDIR=/var/www/sql/mailit dbcontainer  sed -e 's/WEBCONTAINERIP/$WEBCONTAINERIP/g' -i /var/www/sql/mailit/grant_apache_access_to_dbserver.sql"
sudo docker container exec -it --env WORKDIR=/var/www/sql/mailit dbcontainer  sed -e 's/WEBCONTAINERIP/'$WEBCONTAINERIP'/g' -i /var/www/sql/mailit/grant_apache_access_to_dbserver.sql
echo
echo "====== Update  /var/www/cgi-bin/mailit/admin/mysql_env.pl inside webcontainer with $DBCONTAINERIP"
echo
echo "sudo docker container exec -it --env WORKDIR=/var/www/cgi-bin/mailit/admin webcontainer sed -e 's/DBCONTAINERIP/$DBCONTAINERIP/g' -i /var/www/cgi-bin/mailit/admin/mysql_env.pl"
sudo docker container exec -it --env WORKDIR=/var/www/cgi-bin/mailit/admin webcontainer sed -e 's/DBCONTAINERIP/'$DBCONTAINERIP'/g' -i /var/www/cgi-bin/mailit/admin/mysql_env.pl
