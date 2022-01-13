#!/bin/bash

file="schedule.csv"
file_name="schedule.csv"
file_path="/home/asan/asan/backend/upload/csv/"
db_name="asancloud"
db_table_g_checklist="g_checklist"
db_table_g_checklist_list="g_checklist_list"
db_user="asan"
	
function setup_database() {
	echo "setting database..."
	echo -n "enter mysql password: "
	read db_password
	mysql -u$db_user -p${db_password} << MYSQL
USE $db_name;
TRUNCATE $db_table_g_checklist;
TRUNCATE $db_table_g_checklist_list;
MYSQL
}

function import_data() {
	echo "import into table..."
	cat "${file_path}${file_name}" | sed 1,2d | while read line 
	do
		#echo "$line"
		g_checklist__name=$(echo $line | cut -f 1 -d ',')
		g_checklist__update_time=$(echo $line | cut -f 2 -d ',')
		g_checklist__stb_sn=$(echo $line | cut -f 3 -d ',')
		g_checklist_list__name=$(echo $line | cut -f 4 -d ',')
		g_checklist_list__update_time=$(echo $line | cut -f 5 -d ',')
		g_checklist_list__checklist_stb_sn=$(echo $line | cut -f 6 -d ',')
		g_checklist_list__value=$(echo $line | cut -f 7 -d ',')

		if [ -n "$g_checklist__name" ] && [ -n "$g_checklist__update_time" ] && [ -n "$g_checklist__stb_sn" ]; then
			#echo ""
			#echo "${g_checklist__name}/${g_checklist__update_time}/${g_checklist__stb_sn}"
			echo "INSERT INTO $db_table_g_checklist VALUES (DEFAULT, '$g_checklist__name', '$g_checklist__update_time', '$g_checklist__stb_sn');"
		fi

	        if [ -n "$g_checklist_list__name" ] && [ -n "$g_checklist_list__update_time" ] && [ -n "$g_checklist_list__checklist_stb_sn" ] && [ -n "$g_checklist_list__value" ]; then
			#echo ""
			#echo "${g_checklist_list__name}/${g_checklist_list__update_time}/${g_checklist_list__checklist_stb_sn}/${g_checklist_list__value}"
			echo "INSERT INTO $db_table_g_checklist_list VALUES (DEFAULT, '$g_checklist_list__name', '$g_checklist_list__update_time', '$g_checklist_list__checklist_stb_sn', '$g_checklist_list__value');"
		fi
	done | mysql -u$db_user -p${db_password} $db_name
}

#################
#     MAIN      #
#################

setup_database
import_data
