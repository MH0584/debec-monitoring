#!/usr/bin/env python3
import smtplib
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart
import os
from datetime import datetime

# Gmail 설정
# 참고: Gmail에서 앱 비밀번호를 생성해야 합니다:
# 1. Google 계정 설정 → 보안 → 2단계 인증 활성화
# 2. 앱 비밀번호 생성 (Gmail → 기타)
gmail_user = 'alsgy0584@gmail.com'  # 여기에 실제 Gmail 주소 입력
gmail_password = 'lmyc zgag ulvc ufxd'  # 여기에 앱 비밀번호 입력 (일반 비밀번호가 아님!)
to_email = 'minhyo.kim@cndfactory.com'

# 결과 파일 찾기 (여러 위치 확인)
result_file = 'monitoring_result.txt'
possible_paths = [
    result_file,  # 현재 디렉토리
    os.path.join(os.path.dirname(__file__), result_file),  # 스크립트 디렉토리
    os.path.join(os.getcwd(), result_file)  # 작업 디렉토리
]

body = "모니터링 결과 파일을 찾을 수 없습니다."
file_found = False

for file_path in possible_paths:
    if os.path.exists(file_path):
        try:
            with open(file_path, 'r', encoding='utf-8') as f:
                body = f.read()
            print(f"파일을 찾았습니다: {file_path}")
            file_found = True
            break
        except Exception as e:
            print(f"파일 읽기 오류 ({file_path}): {e}")
            continue

if not file_found:
    print("모니터링 결과 파일을 찾을 수 없습니다.")
    print(f"확인한 경로들: {possible_paths}")
    print(f"현재 작업 디렉토리: {os.getcwd()}")
    print(f"스크립트 디렉토리: {os.path.dirname(__file__)}")

# 메일 생성
msg = MIMEMultipart()
msg['From'] = gmail_user
msg['To'] = to_email
msg['Subject'] = f'서버 모니터링 결과 - {datetime.now().strftime("%Y-%m-%d %H:%M")}'

# 본문 추가
msg.attach(MIMEText(body, 'plain', 'utf-8'))

# 메일 전송
try:
    server = smtplib.SMTP_SSL('smtp.gmail.com', 465)
    server.login(gmail_user, gmail_password)
    server.send_message(msg)
    server.quit()
    print("메일이 성공적으로 전송되었습니다.")
except Exception as e:
    print(f"메일 전송 실패: {e}")