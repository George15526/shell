#!/bin/bash

# 源資料夾路徑
source_folder="/home/george/source_folder"

# 目標資料夾路徑
mkdir -p /home/george/backup_folder
backup_folder="/home/george/backup_folder"

# 備份時間格式（用於檔案命名）
backup_time=$(date +"%Y%m%d.%H%M%S")

# 備份命令
backup_command="cp -r $source_folder $backup_folder/backup_$backup_time"

# 備份日誌文件
mkdir -p /home/george/log_history/log.txt
log_file="/home/george/log_history/log.txt"

# 記錄執行時間
current_date=$(date +"西元%Y年%m月%d日 (%A) %H時%M分%S秒 %Z")
echo "[$current_date] Starting backup process" >> "$log_file"

# 執行備份命令
$backup_command >> "$log_file" 2>&1

# 檢查備份命令的執行結果
if [ $? -eq 0 ]
then
  echo "[$current_date] Backup completed successfully" >> "$log_file"
else
  echo "[$current_date] Error: Backup failed" >> "$log_file"
fi
# 壓縮成.tgz檔
tar -zcvf ${backup_folder}.tgz ${backup_folder}

# 刪除30天前的檔案（指定檔案：一般檔案,名字：.tgz,時間：30天,動作：刪除)
find ~/backup_folder -type f -name "*.tgz" -mtime +30 -exec rm -rf {} \;