#!/bin/bash

iana_ports_url="https://www.iana.org/assignments/service-names-port-numbers/service-names-port-numbers.csv"
file=""
wget=$(which wget)
db_name="test"
db_table="test"
db_user="asan"

#download file
function download_files() {
	echo "downloading files..."
	file=$($wget $iana_ports_url &>/dev/null && ls -1 *.csv)
	#parse the file
	#sed 1d means "delete 1 line data in $file"
	#sed -n '2,$p' means "show only 2~end_line data in $file"
	#cut -d means "i choose delimiter which is 'TAP'", cut -d "," means "i choose delimiter which is ','"
	#cut -d -f1,2,3,4 means "cut flied first, second, third, forth"
	cat $file | sed 1d | cut -d, -f1,2,3,4 | grep tcp | sed 's/^,/null,/g' > temp.csv
	mv temp.csv $file
}

function get_file() {
	echo "getting file..."
	cd /home/asan/asan/backend/upload/csv/
	file=$(ls -1 g_checklist_list.csv)
	#file=$(ls -1 *.csv)
	echo $file
}

#create database and create table
function setup_database() {
	echo "setting database..."
	echo -n "enter mysql password: "
	read adminpass
	mysql -u$db_user -p${adminpass} << MYSQL
CREATE DATABASE $db_name;
USE $db_name;
CREATE TABLE $db_table (id int NOT NULL AUTO_INCREMENT, service char(50), number varchar(50), port char(10), description varchar(255), PRIMARY KEY (id));
MYSQL
}

#import file into database
function import_data() {
	echo "import into table..."
	#IFS = ',' means "Internal Field Separator = shell split words(default ' ')
	cat "${file}" | while IFS=$',' read col1 col2 col3 col4
	do
		echo "INSERT INTO $db_table (id, service, number, port, description) VALUES (DEFAULT, '$col1', '$col2', '$col3', '$col4');"
	done | mysql -u$db_user -p${adminpass} $db_name
}

#################
#     MAIN      #
#################

get_file
#setup_database
#import_data
