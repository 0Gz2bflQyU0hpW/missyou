FROM cr.d.xiaomi.net/amos/openjdk8-maven3:v1

WORKDIR /home/webgoat
COPY src /home/webgoat/src
COPY pom.xml /home/webgoat/
COPY sandboxStart.sh ./
COPY webgoatStart.sh ./

RUN cd /home/webgoat/ && \
        apt-get update && \
        apt-get install -y wget unzip && \
        wget https://cnbj1-inner-fds.api.xiaomi.net/binary/webgoat7.jar && \
        wget http://cnbj1-inner-fds.api.xiaomi.net/binary/sandbox-stable-bin.zip && \
        mvn package && \
        unzip sandbox-stable-bin.zip && \
        chmod +x sandboxStart.sh webgoatStart.sh && \
        cp target/rasp-sandbox-jar-with-dependencies.jar sandbox.jar

EXPOSE 8080

CMD sh webgoatStart.sh







