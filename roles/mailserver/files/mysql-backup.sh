#!/bin/bash

# Variables
BACKUP_DIR="/backups/mysql"
DATE=$(date +%Y-%m-%d-%H%M%S)
LOGFILE="/var/log/mysql-backup.log"

# Ensure backup directory exists
if [ ! -d "$BACKUP_DIR" ]; then
    mkdir -p $BACKUP_DIR
    chmod 700 $BACKUP_DIR
fi

# Start backup
echo "Starting backup at $(date)" >> $LOGFILE

for DB in $(mysql -e 'SHOW DATABASES;' | grep -Ev "(Database|information_schema|performance_schema|sys)")
do
    echo "Backing up ${DB}" >> $LOGFILE
    mysqldump --databases $DB | gzip > "$BACKUP_DIR/${DB}_$DATE.sql.gz"
    if [ $? -eq 0 ]; then
        echo "${DB} backed up successfully" >> $LOGFILE
    else
        echo "Error backing up ${DB}" >> $LOGFILE
    fi
done

echo "Backup completed at $(date)" >> $LOGFILE
