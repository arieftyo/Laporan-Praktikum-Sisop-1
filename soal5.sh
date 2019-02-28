# !/bin/bash

awk '{ if (tolower($0) ~ /cron/ && tolower($0) !~ /sudo/ && NF <13) print $0}' /var/log/syslog >> /home/ariefp/modul1/syslogno5.log


2-30/6 * * * * /bin/bash /home/arief/soal5.sh
