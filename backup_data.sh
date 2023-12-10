#!/bin/bash

# 源資料夾路徑
source_folder="/home/george/source_folder"

# 目標資料夾路徑
backup_folder="/home/george/backup_folder"

# 備份時間格式（用於檔案命名）
backup_time=$(date +"%Y%m%d%H%M%S")

# 備份命令
backup_command="cp -r $source_folder $backup_folder/backup_$backup_time"

# 備份日誌文件
log_file="//home/george/log_history/log.txt"

# 記錄執行時間
echo "[$(date)] Starting backup process" >> "$log_file"

# 執行備份命令
$backup_command >> "$log_file" 2>&1

# 檢查備份命令的執行結果
if [ $? -eq 0 ]; then
  echo "[$(date)] Backup completed successfully" >> "$log_file"
else
  echo "[$(date)] Error: Backup failed" >> "$log_file"
fi