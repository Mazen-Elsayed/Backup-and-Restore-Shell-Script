#!/bin/sh

dir=$1
backupdir=$2
interval=$3
maxbackups=$4

if [ $# -ne 4 ]; then
    echo "Please provide all 4 parameters"
    exit 1
fi

# ba check law el directory mawgood w law msh mawgood b3ml create leha
ls -lr "$dir" > directory-info.last

perform_backup() {   
    echo "Performing backup..."
    timestamp=$(date +%Y-%m-%d_%H-%M-%S) 
    new_backup_dir="$backupdir/$timestamp"
    mkdir -p "$new_backup_dir" # b3ml create lel directory el gdeda el name bta3ha timestamp
    cp -r "$dir/" "$new_backup_dir/" # cp -r bt3ml copy mn el src lel directory el gdeda
    echo "Backup completed at $new_backup_dir"
}

while true; do
    if [ ! -d "$backupdir" ]; then # ba check law el backup directory mawgooda
        echo "Backup directory not found, creating backup directory..."
        mkdir -p "$backupdir"
    fi

    # ba check law feh t8yerat fel directory
    # lw feh t8yerat b3ml backup w b3ml update lel directory-info.last
    ls -lR "$dir" > directory-info.new
    if ! cmp -s directory-info.last directory-info.new; then
        perform_backup
        mv directory-info.new directory-info.last
    else
        echo "No changes detected."
        rm directory-info.new
    fi

    # ba check law el maxbackups akbar mn el backups el mawgoda w law kda delete el oldest backup 
    # grep ^d de by3ml filter 3la el directories
    # tail -n 1 bta5od akher directory
    # awk '{print $9}' bta5od el name bta3 el directory
    # rm -rf bt3ml remove lel directory
    if [ $(ls -l "$backupdir" | grep ^d | wc -l) -gt "$maxbackups" ]; then 
        oldest=$(ls -lt "$backupdir" | grep ^d | tail -n 1 | awk '{print $9}')
        echo "Removing oldest backup: $oldest"
        rm -rf "$backupdir/$oldest"
    fi

    sleep "$interval"
done
