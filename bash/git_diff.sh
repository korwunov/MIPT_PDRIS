#!/bin/bash
if [ $# -ne 3 ]; then
    echo "not enough arguments"
    exit 1
fi

REPO_URL="$1"
BRANCH1="$2"
BRANCH2="$3"

TEMP_DIR=$(mktemp -d)

git clone "$REPO_URL" "$TEMP_DIR"

cd "$TEMP_DIR"

DIFF_STATUS=$(git diff --name-status "origin/$BRANCH1" "origin/$BRANCH2")

ADDED=$(echo $DIFF_STATUS | grep -c 'A')
DELETED=$(echo $DIFF_STATUS | grep -c 'D')
MODIFIED=$(echo $DIFF_STATUS | grep -c 'M')
TOTAL=$(echo $DIFF_STATUS | wc -l)

echo $ADDED
echo $DELETED
echo $MODIFIED

echo "Отчет о различиях между ветками"
echo ""
echo "================================"
echo "Реопзиторий:    $REPO_URL"
echo "Ветка 1:        $BRANCH1"
echo "Ветка 2:        $BRANCH2"
echo "Дата генерации: $(date '+%Y-%m-%d %H:%M:%S')"
echo "================================"
echo ""
echo "СПИСОК ИЗМЕНЕННЫХ ФАЙЛОВ:"
echo "$DIFF_STATUS"
echo ""
echo "СТАТИСТИКА:"
echo "Всего измененных файлов: $TOTAL"
echo "Добавлено (A):    $ADDED"
echo "Удалено (D):      $DELETED"
echo "Изменено (M):     $MODIFIED"
echo ""

rm -rf "$TEMP_DIR"