# Backup Script

## File Structure 
  - `bachup.sh` contains the code for backing up a directory
  - `directory-info.last` contains the timeline of backups of the directories that ran on the script
  - `makedirbackup` is the backup of `makedir`, it has a folder named with the dates and times the backups of `makedir` has taken place, this folder contains all backedup files of `makedir`
  - `Screenshots` is a file containing all screenshots of the building process of the program

## How to run the code

### Terminal Run

 1. enter the command `chmod +x backup.sh`, this makes the file executable
 2. choose your source and backup directories
 3. enter the command `./backup.sh <source_directory> <backup_directory> <interval_in_seconds> <max_number_of_backups>`, with your chosen parameters; EX: `./backup.sh dir1 backupdir 60 10`, this backs up dir1 to backupdir every 60 seconds for 10 times

### Makefile Run

 1. open the `Makefile` file
 2. change the parameters `SRC_DIR := ` `BACKUP_DIR := ` with your directory names and `INTERVAL := ` `MAX_BACKUPS := ` with the interval and max number of backups you'd like 
  Ex: 
  SRC_DIR := makedir
  BACKUP_DIR := makedirbackup
  INTERVAL := 60 
  MAX_BACKUPS := 5  
  3. type the command `make run_backup` in your terminal


# Restore Script

## File Structure
 - `restore.sh` contains the code for restoring a backed up directory
 - `.current_backup_index` stores the index value of the last saved backup

## Makefile Run

 1. type the command `make run_restore` in your terminal
 2. choose an option (1,2,3) by typing the number in the terminal
    1) Restore the previous backup
    2) Restore to the next backup
    3) Exit
 3. script will display prints of the running process for easier understanding

# Cronjob

 ## Prepare the Backup Script
  - the backup script requires five path/int parameters:
    1. `backupcj.sh`: The file containing the backup script
    2. `source_dir`: The directory you want to back up
    3. `backup_dir`: The directory where backups will be stored
    4. `interval`: The time interval between backup checks
    5. `max_backups`: The maximum number of backups to keep
    6. `log_file`: The file where log messages will be written

  - example of Parameters:
    1) Backup Script: `/root/Operating\ System/8247-Lab2/backupcj.sh`
    1) Source Directory: `/root/Operating\ System/8247-Lab2/cronjobdir`
    3) Backup Directory: `/root/Operating\ System/8247-Lab2/cronjobdirbackup`
    4) Interval: `60`
    5) Max Backups: `5`
    6) Log File: `/root/Operating System/8247-Lab2/cronjobdirbackup/backup.logs`
  
  ## How to run the Cronjob
  - open the Terminal.
  - enter the command `crontab -e`, if a choice pops up press 1 and then enter
  - a nano window will open, enter the line at the end of the script `* * * * * /root/Operating\ System/8247-Lab2/backupcj.sh /root/Operating\ System/8247-Lab2/cronjobdir /root/Operating\ System/8247-Lab2/cronjobdirbackup 60 5 /root/Operating\ System/8247-Lab2/cronjobdirbackup/backup.logs` with the paths of files in your computer of course...
  - press `ctrl + s` , `ctrl + O` , `enter` and then `ctrl + X`
  - cronjob should be running; to make sure type the command: `sudo crontab -l` or open the logfiles to see the logs of the script