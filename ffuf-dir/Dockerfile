FROM golang:1.16.4-alpine3.13

COPY start.sh ffuf_qt.py /opt/ffuf/

RUN apk --no-cache add git \
    && export GO111MODULE=on \
    && go install github.com/ffuf/ffuf@latest \
    && ln -s /go/bin/ffuf /usr/bin/ffuf \
    && cd /opt/ffuf \
    && wget https://raw.githubusercontent.com/sttuartt/wordlists/main/words_and_files_top5000.txt \
    && apk update \
    && apk --no-cache add bash python3 ca-certificates \
    && chmod +x /opt/ffuf/start.sh

WORKDIR /opt/ffuf/
VOLUME /var/reports/

ENTRYPOINT ["./start.sh"]
