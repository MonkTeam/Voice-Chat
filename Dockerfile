FROM ubuntu:20.04

WORKDIR /usr/src/app
RUN chmod 777 /usr/src/app

RUN apt-get -qq update && \
    apt-get install -y software-properties-common && \
    rm -rf /var/lib/apt/lists/* && \
    apt-add-repository non-free && \
    apt-get -qq update && \
    apt-get -qq install -y pulseaudio mplayer python3 python3-pip && \
    apt-get purge -y software-properties-common

COPY requirements.txt .
COPY extract /usr/local/bin
RUN chmod +x /usr/local/bin/extract
RUN pip3 install --no-cache-dir -r requirements.txt
COPY . .
RUN chmod +x pa.sh

CMD ["bash","start.sh"]
