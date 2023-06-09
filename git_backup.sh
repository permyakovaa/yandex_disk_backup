#!/bin/bash

# Get files list that are ready to commit
commit_files=$(git status --porcelain)

# Check if there are changes
if [ -z "$commit_files" ]; then
    message="Нет файлов для коммита."
else
    # Adding all new files and making commit
    git add .
    git commit -m "Committing all files"

    # Making an HTML message of commite files list
    message="<b>List of commited files:</b>"
    while read -r file; do
        message+=$'\n'"- $file"
    done <<< "$commit_files"

    # Sending notification HTML via Telegram API
    curl -s -X POST "https://api.telegram.org/bot$TELEGRAM_BOT_SECRET_ID/sendMessage" -d "chat_id=$TELEGRAM_CHAT_ID" -d "text=$message" -d "parse_mode=HTML"
fi
