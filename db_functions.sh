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




