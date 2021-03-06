#!/bin/sh
logfile=/var/log/mail.log
logfile1=/var/log/mail.log.1
failedip=/tmp/failedip.log
failedipcon=/tmp/failedipcon.log
datehour=$(date "+%H")
datemins=$(date "+%M")
datemins10=$(expr $datemins - 10)
datemins59=$(expr $datemins - 59)
iptables -F
awk '/failure$/ && $3 > "'"$datehour"":""$datemins10"":""00"'" {print }' $logfile > $failedip
awk '{print $7}' /tmp/failedip.log |awk -F[ '{print $2}' |awk -F] '{print $1}' |awk '{++a[$0]}END{for(i in a){if(a[i]>9){print i"\t"a[i]}}}' > $failedipcon
awk '{cmd="iptables -A INPUT -s "$1"/255.255.255.255 -j DROP";system(cmd)}' $failedipcon
echo "Finish 10" >>  $failedip
date >>  $failedip
awk '/failure$/ && $3 > "'"$datehour"":""$datemins59"":""00"'" {print }' $logfile > $failedip
awk '{print $7}' /tmp/failedip.log |awk -F[ '{print $2}' |awk -F] '{print $1}' |awk '{++a[$0]}END{for(i in a){if(a[i]>49){print i"\t"a[i]}}}' > $failedipcon
awk '{cmd="iptables -A INPUT -s "$1"/255.255.255.255 -j DROP";system(cmd)}' $failedipcon
echo "Finishi 49" >>  $failedip
date >>  $failedip
awk '/failure$/{print }' $logfile > $failedip
awk '{print $7}' /tmp/failedip.log |awk -F[ '{print $2}' |awk -F] '{print $1}' |awk '{++a[$0]}END{for(i in a){if(a[i]>99){print i"\t"a[i]}}}' > $failedipcon
awk '{cmd="iptables -A INPUT -s "$1"/255.255.255.255 -j DROP";system(cmd)}' $failedipcon
echo "Finishi 99" >>  $failedip
date >>  $failedip
awk '/failure$/{print }' $logfile1 > $failedip
awk '{print $7}' /tmp/failedip.log |awk -F[ '{print $2}' |awk -F] '{print $1}' |awk '{++a[$0]}END{for(i in a){if(a[i]>999){print i"\t"a[i]}}}' > $failedipcon
awk '{cmd="iptables -A INPUT -s "$1"/255.255.255.255 -j DROP";system(cmd)}' $failedipcon
echo "Finishi 999" >>  $failedip
date >>  $failedip
