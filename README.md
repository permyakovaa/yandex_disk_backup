# backup_scripts

1. rsync.sh is called by crontab
2. Script makes rsync with webdav mounted yandex directory
3. Then script calls git_backup.sh
4. Git backup script collects changes, commits them and sends changes to telegram chat


Need to specify TELEGRAM_BOT_SECRET and TELEGRAM_CHAT_ID 
