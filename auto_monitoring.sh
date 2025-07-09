#!/bin/bash

# 공휴일을 제외한 평일 9시 20분에 자동으로 모니터링 실행
SCRIPT_DIR="/Users/minhyo.kim/Downloads/monitoring/ssh-mornitoring"
LOG_FILE="$SCRIPT_DIR/cron.log"

echo "[$(date)] Auto monitoring script started" >> "$LOG_FILE"

while true; do
    current_time=$(date +"%H:%M")
    current_day=$(date +"%u")  # 1=월요일, 7=일요일
    
    # 평일(월~금) 9시 20분에 실행
    if [ "$current_time" = "09:20" ] && [ "$current_day" -ge 1 ] && [ "$current_day" -le 5 ]; then
        echo "[$(date)] Time to run monitoring! (Weekday)" >> "$LOG_FILE"
        
        # 모니터링 스크립트 실행
        cd "$SCRIPT_DIR"
        ./run_with_email.sh
        
        echo "[$(date)] Monitoring completed" >> "$LOG_FILE"
        
        # 다음 날까지 대기 (23시간 40분)
        sleep 85200
    else
        # 1분마다 시간 체크
        sleep 60
    fi
done 