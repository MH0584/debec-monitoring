#!/bin/bash

# 매일 11시 50분에 모니터링 실행하는 반복 스크립트
SCRIPT_DIR="/Users/minhyo.kim/Downloads/monitoring/ssh-mornitoring"
LOG_FILE="$SCRIPT_DIR/cron.log"

echo "[$(date)] Monitoring loop script started" >> "$LOG_FILE"

while true; do
    current_time=$(date +"%H:%M")
    
    # 테스트: 1분 후에 실행
    if [ "$current_time" = "11:58" ]; then
        echo "[$(date)] Executing monitoring script" >> "$LOG_FILE"
        cd "$SCRIPT_DIR"
        ./run_with_email.sh
        echo "[$(date)] Monitoring script completed" >> "$LOG_FILE"
        
        # 테스트 후 종료
        break
    else
        # 1분마다 시간 체크
        sleep 60
    fi
done 