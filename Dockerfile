FROM whoicd/icd11_sw_1904_mms_en

ENV APIBASEDURL=http://localhost
EXPOSE 80

COPY bin/docker-entrypoint.sh /docker-entrypoint-en.sh
RUN chmod 755 /docker-entrypoint-en.sh

RUN mv /startApps.sh /startICDApps.sh
RUN mv /docker-entrypoint-en.sh /startApps.sh