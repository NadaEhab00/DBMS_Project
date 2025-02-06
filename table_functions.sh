#!/bin/bash
create_table() {
	local db_name=$1
	read -p "Enter table name : " table_name
	[[ -f "$DB_DIR/$db_name/$table_name" ]] && { echo "Tbale exists!" ; return; } 
	read -p "Enter coulmn names (comma-separated ,frist column is PRIMARY KEY): " columns
	echo "id,$columns" > "$DB_DIR/$db_name/$table_name"
	echo "Table '$table_name' created."
}


list_tables() {
	local db_name=$1
	 echo "Tables in '$db_name' :"
	 ls "$DB_DIR/$db_name"
 }

drop_table() {
	local db_name=$1
	read -p "Enter table name to drop: " table_name
	[[ -f  "$DB_DIR/$db_name/$table_name" ]] && rm "$DB_DIR/$db_name/$table_name" && echo "Table deleted." || echo "Table not found!"
}

insert_into_table() {
	local db_name=$1
	read -p "Enter table name: " table_name 
	[[ ! -f "$DB_DIR/$db_name/$table_name" ]] && echo "Table not found!" && return 
	local columns=$(head -n 1 "$DB_DIR/$db_name/$table_name" | tr -d '[:space:]')
	IFS="," read -ra cols <<< "$columns"
	new_row=""


	for col in "${cols[@]}"; do
         read -p "Enter value for $col: " value
	 new_row+="$value,"
        done
        new_row=${new_row%,}

       primary_key=$(echo "$new_row" | cut -d',' -f1)
      if grep -q "^$primary_key," "$DB_DIR/$db_name/$table_name"; then
        echo "primary key exists!" 
     else
	 echo "$new_row" >> "$DB_DIR/$db_name/$table_name" 
	 echo "Inserted!"
      fi

}


select_from_table() {
	local db_name=$1
	read -p "Enter table name : " table_name
	local table_path="$DB_DIR/$db_name/$table_name"
	if [[ -f "$table_path" ]]; then
            column -s , -t < "$table_path"
	   else
		   echo "Table not found!"
	fi
}

delete_from_table() {
	local db_name=$1
	read -p "Enter table name: " table_name
	read -p "Enter ID to delete: " id 
	[[ -f "$DB_DIR/$db_name/$table_name" ]] && grep -q "^$id," "$DB_DIR/$db_name/$table_name" && grep -v "^$id," "$DB_DIR/$db_name/$table_name" >temp && 
		mv temp  "$DB_DIR/$db_name/$table_name" && echo "Row deleted." || echo "ID not found!"
	}

update_table() {
	local db_name=$1
	read -p "Enter table name: " table_name
	read -p "Enter ID to update: " id 
	[[ ! -f "$DB_DIR/$db_name/$table_name" ]] && echo " Table not found! " && return 
	grep -q "$id," "$DB_DIR/$db_name/$table_name" || { echo "ID not found!" ; return; } 


	local columns=$(head -n 1 "$DB_DIR/$db_name/$table_name")
	IFS=',' read -ra cols <<< "$columns"
	new_row="$id"

	for ((i = 1; i< ${#cols[@]}; i++)); do
		read -p "Enter new value for ${cols[$i]}:" value
		new_row="$new_row,$value"
	done

 grep -v "$id," "$DB_DIR/$db_name/$table_name" > temp && mv temp "$DB_DIR/$db_name/$table_name"
 echo "$new_row" >> "$DB_DIR/$db_name/$table_name"
echo "Row updated"
}



