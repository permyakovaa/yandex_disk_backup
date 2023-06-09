#!/bin/bash
source variables.sh
echo "Starting rsync process"
rsync -a --delete $YANDEX_DISK_SOURCE_DIR $RSYNC_DESTINATION_DIR/files
echo "Finished rsync process"
cd $RSYNC_DESTINATION_DIR
/bin/bash $RSYNC_DESTINATION_DIR/git_backup.sh
echo "Git commited and notifications sent"
