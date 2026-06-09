#!/bin/bash

set -e

# Проверка наличия не внесенных в индекс или незакоммиченных изменений
# Если такие имеются, то произвести автокоммит

if ! git diff --quiet || ! git diff --cached --quiet
then
    echo "Есть незакоммиченные изменения"

    git add .
    git commit -m "Auto commit before update"
else
    echo "Изменений нет"
fi

echo "Переход в master..."
git checkout master

echo "Получение изменений..."
git fetch origin

echo "Полное обновление master..."
git reset --hard origin/master

echo "Переход в solutions..."
git checkout solutions

echo "Копирование новых файлов и изменений из master..."
git checkout master -- .

echo "Добавляем в индекс и коммитим новые изменения в ветке solutions..."
git add .
git commit -m "Автомат"

echo "ГОТОВО! Молодец!"
