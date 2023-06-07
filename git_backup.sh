#!/bin/bash

# Переменные для Telegram API
TOKEN="TELEGRAM_BOT_SECRET"
CHAT_ID="TELEGRAM_CHAT_ID"

# Получение списка файлов, готовых к коммиту
commit_files=$(git status --porcelain)

# Проверка наличия файлов для коммита
if [ -z "$commit_files" ]; then
    message="Нет файлов для коммита."
else
    # Коммит всех файлов в текущей директории
    git add .
    git commit -m "Committing all files"

    # Формирование сообщения с списком файлов в HTML формате
    message="<b>Список файлов в коммите:</b>"
    while read -r file; do
        message+=$'\n'"- $file"
    done <<< "$commit_files"

    # Отправка сообщения в HTML формате через Telegram API
    curl -s -X POST "https://api.telegram.org/bot$TOKEN/sendMessage" -d "chat_id=$CHAT_ID" -d "text=$message" -d "parse_mode=HTML"

    echo "Коммит выполнен и сообщение отправлено в Telegram в формате HTML."
fi
