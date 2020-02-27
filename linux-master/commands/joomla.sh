#!/bin/bash
#
#	Author: Jorgebc8
#	GitHub: https://github.com/Jorgebc8/
#	Date  : 25/02/2020
#
#	This install basic joomla
#

sudo su

echo "DB name :"
read dbname

echo "DB user :"
read dbuser

echo "DB password :"
read dbpassword

mysql -u root -p

SET GLOBAL validate_password_policy=LOW;

CREATE DATABASE $dbname
GRANT ALL PRIVILEGES ON $dbname.* TO \'$dbuser\' IDENTIFIED BY \'$dbpassword\';
FLUSH PRIVILEGES;
QUIT;

cd /tmp/
wget https://downloads.joomla.org/cms/joomla3/3-8-10/Joomla_3-8-10-Stable-Full_Package.zip

mkdir /var/www/html/joomla
unzip Joomla_3-8-10-Stable-Full_Package.zip -d /var/www/html/joomla

cp /var/www/html/joomla/htaccess.txt /var/www/html/joomla/.htaccess
chown -R www-data.www-data /var/www/html/joomla
chmod -R 755 /var/www/html/joomla

systemctl restart apache2

echo "FINISH install joomla visiting https://" + `hostname -I` + "/joomla"
echo "Database name: " + $dbname
echo "Database Username : " + $dbuser
echo "Database password : " + $dbpassword


