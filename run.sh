#!/bin/bash

# 프로젝트 디렉토리로 이동
cd "$(dirname "$0")"

# 컴파일
javac -cp ../jsch-0.2.17.jar -d out/production/ssh-mornitoring src/main/java/main/ssh/*.java

# 실행
java -cp out/production/ssh-mornitoring:../jsch-0.2.17.jar main.ssh.Main 