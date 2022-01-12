#!/bin/bash

iana_ports_url="https://www.iana.org/assignments/service-names-port-numbers/service-names-port-numbers.csv"
file="g_checklist_list.csv"
file_name="g_checklist_list.csv"
file_path="/home/asan/asan/backend/upload/csv/"
wget=$(which wget)
db_name="asancloud"
db_table="g_checklist_list"
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

function set_file() {
	echo "setting file..."
	cd $file_path
	
	#file=$(ls -1 $file_path | grep $file_name)
	
	cat $file_name | sed 1d > temp.csv
	mv temp.csv $file
}

#create database and create table
function setup_database() {
	echo "setting database..."
	echo -n "enter mysql password: "
	read adminpass
	mysql -u$db_user -p${adminpass} << MYSQL
USE $db_name;
TRUNCATE $db_table;
MYSQL
}

#import file into database
function import_data() {
	echo "import into table..."
	#IFS = ',' means "Internal Field Separator = shell split words(default ' ')
	cat "${file_path}${file_name}" | while IFS=$',' read col1 col2 col3 col4
	do
		echo "INSERT INTO $db_table VALUES (DEFAULT, '$col1', '$col2', '$col3', '$col4');"
	done | mysql -u$db_user -p${adminpass} $db_name
}

#################
#     MAIN      #
#################

set_file
setup_database
import_data
