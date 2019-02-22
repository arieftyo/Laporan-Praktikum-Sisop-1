# !/bin/bash

awk '{if ($0 ~ /cron/ || $0 ~ /CRON/ && $0 !~ /sudo/ && NF < 13) print $0}' /var/log/syslog >> /home/ariefp/syslog5.log


2-30/6 * * * * /bin/bash /home/arief/soal5.sh
