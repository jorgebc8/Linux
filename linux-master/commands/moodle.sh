#!/bin/bash
#
#	Author: Jorgebc8
#	GitHub: https://github.com/Jorgebc8/
#	Date  : 25/02/2020
#
#	This install basic Moodle
#

sudo su

apt-get install git

mkdir /var/www/html/moodle
cd /var/www/html/moodle
git cline git://git.moodle.org/moodle.git

chown -R root /var/www/html/moodle
chmod -R 0755 /var/www/html/moodle
find /var/www/html/moodle -type f -exec chmod 0644 {} \;

chown -R www-data /var/www/html/moodle

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

mkdir /var/www/html/moodledata
chmod 0777 /var/www/html/moodledata

chmod -R www-data /var/www/html/moodledata
chmod -R `whoami` /var/www/html/moodledata

systemctl restart apache2

echo "FINISH install moodle visiting https://" + `hostname -I` + "/moodle"
echo "Database name: " + $dbname
echo "Database Username : " + $dbuser
echo "Database password : " + $dbpassword


