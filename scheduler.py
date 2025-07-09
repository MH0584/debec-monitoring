#!/usr/bin/env python3
import schedule
import time
import subprocess
import os
from datetime import datetime
import holidays

# 한국 공휴일 설정
kr_holidays = holidays.KR()

def is_workday():
    """평일이고 공휴일이 아닌지 확인"""
    today = datetime.now().date()
    # 주말 체크 (5=토요일, 6=일요일)
    if today.weekday() >= 5:
        return False
    # 공휴일 체크
    if today in kr_holidays:
        return False
    return True

def run_monitoring():
    """모니터링 스크립트 실행"""
    if is_workday():
        print(f"[{datetime.now()}] Running monitoring on workday")
        try:
            # 모니터링 스크립트 실행
            result = subprocess.run(['./run_with_email.sh'], 
                                  capture_output=True, text=True, cwd=os.getcwd())
            print(f"[{datetime.now()}] Monitoring completed with exit code: {result.returncode}")
            if result.stdout:
                print("STDOUT:", result.stdout)
            if result.stderr:
                print("STDERR:", result.stderr)
        except Exception as e:
            print(f"[{datetime.now()}] Error running monitoring: {e}")
    else:
        print(f"[{datetime.now()}] Skipping monitoring - not a workday")

def main():
    print(f"[{datetime.now()}] Monitoring scheduler started")
    
    # 매일 9시 20분에 실행
    #schedule.every().day.at("09:20").do(run_monitoring)
    # 테스트: 매일 14:30(2시 30분)에 실행
    schedule.every().day.at("14:30").do(run_monitoring)
    
    while True:
        schedule.run_pending()
        time.sleep(60)  # 1분마다 체크

if __name__ == "__main__":
    main() 