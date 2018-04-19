#!/bin/bash
CMD_PATH="/home/pvelho/"
FILE_NOW=$CMD_PATH"ls-connections.now"

sudo echo -n " " | awk '{printf "%20s %8s %5s %6s %6s %20s %20s %20s\n", "PID/Program name", "user", "Proto", "Recv-Q", "Send-Q", "Local Address", "Foreign Address", "State"}' > $FILE_NOW
sudo netstat -tuvenpa | grep -E 'LISTEN|ESTAB' | sort | while read connection ; do
    USERID=`echo $connection | awk '{print $7}'`
    USERNAME=`sudo cat /etc/passwd |grep $USERID | cut -d: -f1`
    echo -n $connection | awk '{printf "%20s", $9}' >> $FILE_NOW
    echo -n $USERNAME | awk '{printf " %8s", $1 }' >> $FILE_NOW
    echo -n $connection | awk '{printf " %5s %6s %6s %20s %20s %20s\n", $1, $2, $3, $4, $5, $6}' >> $FILE_NOW
done

ORANGE="\033[1;31m"
NOCOLOR="\033[0m"

echo -e "${ORANGE}"
cat $FILE_NOW
echo -e "${NOCOLOR}"

# diff $FILE_NOW $FILE_BOOT | colordiff
