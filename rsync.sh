#!/bin/bash
echo "Start rsync"
rsync -a --delete /media/yandexdisk/ /home/admin/backups/yadisk/files
echo "Finish rsync"
cd /home/admin/backups/yadisk
/bin/bash /home/admin/backups/yadisk/git_backup.sh
echo "Git commited and notifications sent"
