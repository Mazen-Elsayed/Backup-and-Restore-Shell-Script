SRC_DIR := makedir
BACKUP_DIR := makedirbackup
INTERVAL := 60 
MAX_BACKUPS := 5  

run_backup:
	sh ./backup.sh $(SRC_DIR) $(BACKUP_DIR) $(INTERVAL) $(MAX_BACKUPS)

run_restore:
	bash ./restore.sh $(SRC_DIR) $(BACKUP_DIR)
