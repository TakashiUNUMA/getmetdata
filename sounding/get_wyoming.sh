#!/bin/sh
#
# wget wrapper script
#
# original script coded by Takashi Unuma, Kyoto Univ.
# Last modified: 2013/07/13
#
debug_level=100

export http_proxy=http://proxy.kuins.net:8080/
export ftp_proxy=http://proxy.kuins.net:8080/

if test $# -lt 3 ; then
    echo "USAGE: $(basename $0) [JSTTIME] [STNM] [TYPE]"
    exit 1
fi
if test ${#1} -ne 10 ; then
    echo "Error: the JSTTIME value must be 10 digits"
    exit 1
fi
if test ${#2} -ne 5 ; then
    echo "Error: the STNM value must be 5 digits"
    exit 1
fi

JSTTIME=$1
STNM=$2
TYPE=$3
WGETOPT="-q -nc"
if test ${debug_level} -ge 100 ; then
    echo "DEBUG: JSTTIME = ${JSTTIME}"
    echo "DEBUG: STNM    = ${STNM}"
    echo "DEBUG: TYPE    = ${TYPE}"
fi

UTCTIME=$(change_time ${JSTTIME}00 32400 -)
YEAR=${UTCTIME:0:4}
MONTH=${UTCTIME:4:2}
DAY=${UTCTIME:6:2}
HOUR=${UTCTIME:8:2}
FROM=${DAY}${HOUR}
TO=${DAY}${HOUR}
if test ${debug_level} -ge 100 ; then
    echo "DEBUG: UTCTIME = ${UTCTIME}"
    echo "DEBUG: YEAR    = ${YEAR}"
    echo "DEBUG: MONTH   = ${MONTH}"
    echo "DEBUG: HOUR    = ${HOUR}"
    echo "DEBUG: FROM    = ${FROM}"
    echo "DEBUG: TO      = ${TO}"
fi

if test ${TYPE} = "GIF" ; then
    TYPE1="GIF"
    TYPE2="SKEWT"
    OUTPUT=${YEAR}${MONTH}${FROM}UTC_${STNM}.gif
    URL="http://weather.uwyo.edu/upperair/images/${YEAR}${MONTH}${FROM}.${STNM}.skewt.gif"
    wget -q -nc -O tmp "http://weather.uwyo.edu/cgi-bin/sounding?region=seasia&TYPE=${TYPE1}%3A${TYPE2}&YEAR=${YEAR}&MONTH=${MONTH}&FROM=${FROM}&TO=${TO}&STNM=${STNM}"
    rm -f tmp
elif test ${TYPE} = "PDF" ; then
    TYPE1="PDF"
    TYPE2="SKEWT"
    OUTPUT=${YEAR}${MONTH}${FROM}UTC_${STNM}.pdf
    URL="http://weather.uwyo.edu/cgi-bin/sounding?region=seasia&TYPE=${TYPE1}%3A${TYPE2}&YEAR=${YEAR}&MONTH=${MONTH}&FROM=${FROM}&TO=${TO}&STNM=${STNM}"
elif test ${TYPE} = "TEXT" ; then
    TYPE1="TEXT"
    TYPE2="LIST"
    #TYPE2="AUNMERGED"
    OUTPUT=${YEAR}${MONTH}${FROM}UTC_${STNM}.txt
    URL="http://weather.uwyo.edu/cgi-bin/sounding?region=seasia&TYPE=${TYPE1}%3A${TYPE2}&YEAR=${YEAR}&MONTH=${MONTH}&FROM=${FROM}&TO=${TO}&STNM=${STNM}"
else
    echo "Error: ${TYPE} is not supported."
    exit 1
fi

if test ${debug_level} -ge 100 ; then
    echo "DEBUG: TYPE1   = ${TYPE1}"
    echo "DEBUG: TYPE2   = ${TYPE2}"
    echo "DEBUG: OUTPUT  = ${OUTPUT}"
    echo "DEBUG: URL     = ${URL}"
    WGETOPT="-v"
fi

wget ${WGETOPT} -O ${OUTPUT} ${URL}
