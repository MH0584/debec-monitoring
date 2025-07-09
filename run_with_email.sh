#!/bin/bash

export PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin

echo "[$(date)] run_with_email.sh start" >> /Users/minhyo.kim/Downloads/monitoring/ssh-mornitoring/cron.log

# 프로젝트 디렉토리로 이동
cd "$(dirname "$0")"
echo "[$(date)] Changed to directory: $(pwd)" >> /Users/minhyo.kim/Downloads/monitoring/ssh-mornitoring/cron.log

# JAVA_TOOL_OPTIONS 환경변수 제거 (Picked up 메시지 방지)
unset JAVA_TOOL_OPTIONS

# 결과 파일명 설정
OUTPUT_FILE="monitoring_result.txt"

# Java 컴파일
echo "[$(date)] Starting Java compilation..." >> /Users/minhyo.kim/Downloads/monitoring/ssh-mornitoring/cron.log
javac -cp ../jsch-0.2.17.jar -d out/production/ssh-mornitoring src/main/java/main/ssh/*.java 2>> /Users/minhyo.kim/Downloads/monitoring/ssh-mornitoring/cron.log
echo "[$(date)] Java compilation completed" >> /Users/minhyo.kim/Downloads/monitoring/ssh-mornitoring/cron.log

# 실행하고 결과를 파일로 저장
echo "[$(date)] Starting Java execution..." >> /Users/minhyo.kim/Downloads/monitoring/ssh-mornitoring/cron.log
java -cp out/production/ssh-mornitoring:../jsch-0.2.17.jar main.ssh.Main > "$OUTPUT_FILE" 2>&1
echo "[$(date)] Java execution completed" >> /Users/minhyo.kim/Downloads/monitoring/ssh-mornitoring/cron.log

# Python으로 메일 전송
echo "[$(date)] Starting Python email script..." >> /Users/minhyo.kim/Downloads/monitoring/ssh-mornitoring/cron.log
python3 send_email.py 2>> /Users/minhyo.kim/Downloads/monitoring/ssh-mornitoring/cron.log
echo "[$(date)] Python email script completed" >> /Users/minhyo.kim/Downloads/monitoring/ssh-mornitoring/cron.log 