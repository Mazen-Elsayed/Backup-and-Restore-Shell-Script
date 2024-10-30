#!/bin/bash

src_dir=$1
bkp_dir=$2 
index_file=".current_backup_index"

if [ $# -ne 2 ]; then
    echo "Please provide the source and backup directories."
    exit 1
fi

if [ ! -d "$src_dir" ]; then
    echo "The source directory doesn't exist."
    exit 1
elif [ ! -d "$bkp_dir" ]; then
    echo "The backup directory doesn't exist."
    exit 1
fi
# -f bt3ml check law el file mawgood
if [ -f "$index_file" ]; then
    current_index=$(<"$index_file")
else
    current_index=0  
fi

# ba7ot kol el backups fel array "all_backups"
all_backups=($(ls -t "$bkp_dir")) # ls -t bt3ml sort lel files bta3t el directory bta3t el backup bel timestamp order
if [ ${#all_backups[@]} -eq 0 ]; then
    echo "No backups available in ${bkp_dir}"
    exit 1
fi

while true; do
    echo "Current backup version: ${all_backups[$current_index]}"
    echo "Choose an option:"
    echo "1. Restore to the previous backup."
    echo "2. Restore to the next backup."
    echo "3. Exit."

    read -p "Enter your choice (1/2/3): " choice

    case $choice in
        1)  if [ ${#all_backups[@]} -gt 1 ] && [ $current_index -lt $((${#all_backups[@]} - 1)) ]; then # law feh at least 2 backups
                previous_backup="${all_backups[$((current_index + 1))]}"                                # w law el current index akbar mn 0
                # -rf force removes el content bta3t el source directory
                rm -rf "$src_dir"/* # ba delete el contents bta3t el source directory
                # -s sets el dotglob option
                shopt -s dotglob # b3ml enable lel dotglob 3shan a3rf a3ml copy lel hidden files (mashtaghalsh mngheirha)
                cp -r "$bkp_dir/$previous_backup/"* "$src_dir/" # b3ml copy lel contents bta3t el previous backup lel source directory
                # -u unsets el dotglob option
                shopt -u dotglob 
                current_index=$((current_index + 1)) # b3ml update lel current index
                echo "Restoration of $previous_backup complete"
            elif [ $current_index -eq $((${#all_backups[@]} - 1)) ]; then 
                echo "No previous backups available."
            fi
            ;;
        2)  if [ $current_index -gt 0 ]; then 
                next_backup="${all_backups[$((current_index - 1))]}"    
                echo "Restoring to the next backup: $next_backup..."
                rm -rf "$src_dir"/*
                shopt -s dotglob
                cp -r "$bkp_dir/$next_backup/"* "$src_dir/"
                shopt -u dotglob
                current_index=$((current_index - 1))
                echo "Restoration complete: $next_backup"
            else
                echo "No newer backups available."
            fi
            ;;
        3)  echo "Saving current backup index..."
            echo "$current_index" > "$index_file" # b3ml save lel current index fel file
            echo "Exiting the script."
            exit 0
            ;;
        *)  echo "Invalid selection. Please choose a valid operation (1,2,3)."
            ;;
    esac
done
