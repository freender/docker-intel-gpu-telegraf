FROM ubuntu:latest

LABEL maintainer=Freender

WORKDIR ./opt/intel-gpu-telegraf

RUN echo Starting. \

# influxdata-archive_compat.key GPG Fingerprint: 9D539D90D3328DC7D6C8D3B9D8FF8E1F7DF8B07E
 && curl -s https://repos.influxdata.com/influxdata-archive_compat.key > influxdata-archive_compat.key
 && echo '393e8779c89ac8d958f81f942f9ad7fb82a25e133faddaf92e15b16e6ac9ce4c influxdata-archive_compat.key' | sha256sum -c && cat influxdata-archive_compat.key | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/influxdata-archive_compat.gpg > /dev/null
 && echo 'deb [signed-by=/etc/apt/trusted.gpg.d/influxdata-archive_compat.gpg] https://repos.influxdata.com/debian stable main' | sudo tee /etc/apt/sources.list.d/influxdata.list
 && apt-get -q -y update \
 && apt-get -q -y install --no-install-recommends intel-gpu-tools telegraf \
#$ && apt-get -q -y install --no-install-recommends  iputils net-tools vim-enhanced \
 && apt-get -q -y full-upgrade \
 && rm -rif /var/lib/apt/lists/* \
 && echo Finished.

COPY ./opt/intel-gpu-telegraf /opt/intel-gpu-telegraf

CMD ["/usr/bin/telegraf", "--config", "/opt/intel-gpu-telegraf/telegraf.conf"]
