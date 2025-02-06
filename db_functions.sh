#!/bin/bash
DB_DIR="./databases"
mkdir -p "$DB_DIR"

create_database() {
	read -p "Enter database name: " db_name
	[[ -z "$db_name" ]] && echo "Database name cannot be empty !" && return 
        [[ -d "$DB_DIR/$db_name" ]] && echo "Database already exists!" || mkdir "$DB_DIR/$db_name" && echo "Database '$db_name' created. "
}

list_databases() {
	echo "Available Databases:"
	ls "$DB_DIR"
}

connect_database() {
	read -p "Enter database name to connect: " db_name
	[[ -d "$DB_DIR/$db_name" ]] && db_menu "$db_name" || echo " Database does not exist!"
}


drop_database() {
	read -p "Enter database name to delete: " db_name
	[[ -d "$DB_DIR/$db_name" ]] && rm -r "$DB_DIR/$db_name"  && echo "Database '$db_name' deleted." || echo "Database does not exist!"
}


#parse_sql() {
#	echo "Enter SQL command (or type 'exit' to quit SQL mode):"
#	 read -r sql_command

#	 case "$sql_command" in 
#		 "CREATE DATABASE "*)
#			 db_name=$(echo "$sql_command" | awk '{print $3}')
#			 create_database "$db_name"
#			 ;;
#		 "CREATE TABLE "*)
#			 table_name=$(echo "$sql_command" | awk '{print $3}')
#			 columns=$(echo "$sql_command" | sed -n 's/.*(\(.*\)).*/\1/p')
#			 create_table "$table_name" "$columns"
#			 ;;
#		 "INSERT INTO "*)
#			 table_name=$(echo "$sql_command" | awk '{print $3}')
#			 values=$(echo "$sql_command" | sed -n 's/.*VALUES[[:space:]]*(\(.*\)).*/\1/p')
#			 insert_into_table "$table_name" "$values"
#			 ;;
#		"SELECT * FROM "*)
#			table_name=$(echo "$sql_command" | awk '{print $4}')
#			select_from_table "$table_name"
#			;;
#		"DELETE FROM "*)
#                	table_name=$(echo "$sql_command" | awk '{print $3}')
#			conditions=$(echo "$sql_command" | sed -n 's/.*WHERE[[:space:]]*\(.*\)/\1/p')
#			delete_from_table "$table_name" "$conditions"
#			;;
#		"UPDATE "*)
#			table_name=$(echo "$sql_command" | awk '{print $2}')
#			set_clause=$(echo "$sql_command" | sed -n 's/.*SET[[:space:]]*\(.*\)[[:space:]]WHERE.*/\1/P')
#			conditions=$(echo "$sql_command" | sed -n 's/.*WHERE[[:space:]]*\(.*\)/\1/p')
#			update_table "$table_name" "$set_clause" "$conditions"
#			;;
#		"DROP DATABASE "*)
#			db_name=$(echo "$sql_command" | awk '{print $3}')
#			drop_database "$db_name"
#			;;
#		"DROP TABLE "*)
#			table_name=$(echo "$sql_command" | awk '{print $3}')
#			drop_table "$table_name"
#			;;
#		"exit")
#			echo "Exiting SQL mode."
#			return 1
#			;;
#		*)
#			echo "ERROR: unsupported SQL command."
#			;;
#	esac
#	return 0
#}


		


