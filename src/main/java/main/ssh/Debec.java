package main.ssh;

import com.jcraft.jsch.ChannelExec;
import com.jcraft.jsch.JSch;
import com.jcraft.jsch.JSchException;
import com.jcraft.jsch.Session;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;

public class Debec {

    private String privateKeyPath = "";
    private String command = "df -h";
    private String command2 = "ps -ef | grep 'java'";
    private String command3 = "free -m";
    private int sshPort = 22;
    private String sshUsername = "root";
    public void debecBackoffice(){
        String sshHost = "prd-was1.debec";
        String sshUsername = "root";
        int sshPort = 22;
        String serverName = "*대백 백오피스";

        JSch jsch = null;
        Session session = null;

        try {
            jsch = new JSch();
            if(!"".equals(privateKeyPath)) jsch.addIdentity(privateKeyPath);
            session = jsch.getSession(sshUsername, sshHost, sshPort);
            session.setConfig("StrictHostKeyChecking", "no");
            session.setPassword("gksspt#0144");

            session.connect();

            // SSH 연결 성공
            System.out.println(serverName);

            // SSH 연결을 통해 명령 실행
            ChannelExec channel = (ChannelExec) session.openChannel("exec");
            channel.setCommand(command+ "\n" + command2 + "\n" + command3);
            channel.connect();

            // 명령 실행 결과를 읽기 위한 BufferedReader 생성
            BufferedReader reader = new BufferedReader(new InputStreamReader(channel.getInputStream()));

            // 출력 결과를 한 줄씩 읽어서 출력
            String line;

            while ((line = reader.readLine()) != null) {
                System.out.println(line);
            }
            System.out.println("");

            // 프로세스 종료
            channel.disconnect();
            session.disconnect();

        } catch (
                JSchException e) {
            throw new RuntimeException(e);
        } catch (IOException e) {
            throw new RuntimeException(e);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
    public void debecWas1(){
        String sshHost = "prd-api1.debec";
        String serverName = "*1번 was 서버";


        connect(this.privateKeyPath,this.sshUsername,sshHost,this.sshPort,this.command,serverName);
    }
    public void debecWas2(){
        String sshHost = "prd-api2.debec";
        String serverName = "*2번 was 서버";

        connect(this.privateKeyPath,this.sshUsername,sshHost,this.sshPort,this.command,serverName);
    }



    public void connect(String privateKeyPath, String sshUsername, String sshHost, int sshPort, String command, String serverName){
        JSch jsch = null;
        Session session = null;

        try {
            jsch = new JSch();
            session = jsch.getSession(sshUsername, sshHost, sshPort);
           if(!"".equals(privateKeyPath)) jsch.addIdentity(privateKeyPath);

            if(!sshHost.equals("prd-was1.debec")){
                session.setConfig("server_host_key", "ssh-rsa,ssh-dss,sha256");
                session.setUserInfo(new MyUserInfo());
            }else{

                session.setConfig("StrictHostKeyChecking", "no");

            }
            session.setPassword("gksspt#0144");
            session.connect();

            // SSH 연결 성공
            System.out.println(serverName);

            // SSH 연결을 통해 명령 실행
            ChannelExec channel = (ChannelExec) session.openChannel("exec");
            channel.setCommand(command + "\n" + command2 + "\n" + command3);
            channel.connect();

            // 명령 실행 결과를 읽기 위한 BufferedReader 생성
            BufferedReader reader = new BufferedReader(new InputStreamReader(channel.getInputStream()));

            // 출력 결과를 한 줄씩 읽어서 출력
            String line;

            while ((line = reader.readLine()) != null) {
                System.out.println(line);
            }
            System.out.println("");

            // 프로세스 종료
            channel.disconnect();
            session.disconnect();

        } catch (
                JSchException e) {
            throw new RuntimeException(e);
        } catch (
                IOException e) {
            throw new RuntimeException(e);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
}
