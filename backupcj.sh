#!/bin/sh

dir=$1
backupdir=$2
interval=$3
maxbackups=$4
logfile=$5

if [ $# -ne 5 ]; then
    echo "Please provide all 5 parameters: <source_dir> <backup_dir> <interval> <max_backups> <log_file>"
    exit 1
fi

ls -lr "$dir" > directory-info.last

perform_backup() {   
    echo "Performing backup..." | tee -a "$logfile"
    timestamp=$(date +%Y-%m-%d_%H-%M-%S)
    new_backup_dir="$backupdir/$timestamp"
    mkdir -p "$new_backup_dir" 
    cp -r "$dir/" "$new_backup_dir/" 
    echo "Backup completed at $new_backup_dir" | tee -a "$logfile"
}

while true; do
    if [ ! -d "$backupdir" ]; then
        echo "Backup directory not found, creating backup directory..." | tee -a "$logfile"
        mkdir -p "$backupdir"
    fi

    ls -lR "$dir" > directory-info.new
    if ! cmp -s directory-info.last directory-info.new; then
        perform_backup
        mv directory-info.new directory-info.last
    else
        echo "No changes detected" | tee -a "$logfile"
        rm directory-info.new
    fi

    if [ $(ls -l "$backupdir" | grep ^d | wc -l) -gt "$maxbackups" ]; then
        oldest=$(ls -lt "$backupdir" | grep ^d | tail -n 1 | awk '{print $9}')
        echo "Removing oldest backup: $oldest" | tee -a "$logfile"
        rm -rf "$backupdir/$oldest"
    fi

    sleep "$interval"
done
