#!/bin/bash
# Author:  Eric Weng <ieric@163.com>

THREAD=$(grep 'processor' /proc/cpuinfo | sort -u | wc -l)

# start Time
startTime=`date +%s`

export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

make defconfig

make download -j${THREAD}

find dl -size -1024c -exec ls -l {} \;
find dl -size -1024c -exec rm -f {} \;

make -j${THREAD} V=sc

endTime=`date +%s`
((installTime=($endTime-$startTime)/60))

echo "Total Install Time: ${installTime} minutes"