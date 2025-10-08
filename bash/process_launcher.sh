#!/bin/bash
PID_FILE="./monitor.pid"
LOCK_FILE="./monitor.lock"
LOG_DIR="./logs"

mkdir -p "$LOG_DIR"

case "$1" in 
    START)
        if [ -f "$PID_FILE" ]; then
            PID=$(cat "$PID_FILE")
            if [ ps -p "$PID" > /dev/null 2>&1 ]; then
                echo "process already started"
                exit 1
            else
                rm -f "$PID_FILE"
            fi
        fi

        if [ -f "$LOCK_FILE" ]; then
            echo "lock detected"
            exit 1
        fi

        echo "monitor statring..."
        nohup "$0" _run &> "$LOG_DIR/monitor.log" &
        echo $! > "$PID_FILE"
        echo "monitor started with pid = $(cat $PID)"
        ;;
    STOP)
        if [ -f "$PID_FILE" ]; then
            PID=$(cat "$PID_FILE")
            if ps -p "$PID" > /dev/null 2>&1; then
                kill "$PID"
                rm -f "$PID_FILE" "$LOCK_FILE"
                echo "monitor stopped"
            else
                echo "monitor process not found"
            fi
        else
            echo "monitor does not started"
        fi
    ;;
    STATUS)
        if [ -f "$PID_FILE" ]; then
            PID=$(cat "$PID_FILE")
            if ps -p "$PID" > /dev/null 2>&1; then
                echo "monitor is active, pid = $PID"
            else
                echo "monitor is not active, but PID file exists with PID = $PID (strange)"
            fi
        else
            echo "monitor is not active"
        fi
    ;;
    _run)
        touch "$LOCK_FILE"

        while true; do
            TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

            MEM_INFO=$(free -m | awk 'NR==2{printf "%.0f %.0f %.2f", $2, $4, $3*100/$2}')
            ALL_MEM=$(echo "$MEM_INFO" | awk '{print $1}')
            FREE_MEM=$(echo "$MEM_INFO" | awk '{print $2}')
            PERC_MEM=$(echo "$MEM_INFO" | awk '{print $3}')

            CPU_PERC=$(top -l 1 | grep "CPU usage" | awk '{print $3}' | sed 's/%//' | awk -F'%' '{print $1}')

            DISK_PERC=$(df -h / | awk 'NR==2 {print $5}' | sed 's/%//')

            LOAD_AVG=$(uptime | awk -F'load average:' '{print $2}' | awk '{print $1}' | sed 's/,//')

            CSV_FILE="$LOG_DIR/metrics.csv"

            if [ ! -f "$CSV_FILE" ]; then
                echo "timestamp;all_memory;free_memory;%memory_used;%cpu_used;%disk_used;load_average_1m" > "$CSV_FILE"
            fi
            echo "$TIMESTAMP;$ALL_MEM;$FREE_MEM;$PERC_MEM;$CPU_PERC;$DISK_PERC;$LOAD_AVG" >> "$CSV_FILE"

            sleep 2
        done
        ;;

    *)
        echo "wrong arg: $1 {START|STOP|STATUS}"
        exit 1
        ;;
esac