#!/bin/bash

# 매일 11시 50분에 알림을 받는 스크립트
SCRIPT_DIR="/Users/minhyo.kim/Downloads/monitoring/ssh-mornitoring"

echo "[$(date)] Notification script started" >> "$SCRIPT_DIR/cron.log"

while true; do
    current_time=$(date +"%H:%M")
    
    # 매일 11시 50분에 알림
    if [ "$current_time" = "11:50" ]; then
        echo "[$(date)] Sending notification" >> "$SCRIPT_DIR/cron.log"
        
        # macOS 알림 전송
        osascript -e 'display notification "서버 모니터링을 실행하세요!" with title "모니터링 알림" sound name "Glass"'
        
        # 다음 날까지 대기 (23시간 10분)
        sleep 83400
    else
        # 1분마다 시간 체크
        sleep 60
    fi
done 