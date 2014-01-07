#!/bin/sh
#
# wget wrapper script
#
# original script coded by Takashi Unuma, Kyoto Univ.
# Last modified: 2013/12/11
#
debug_level=100

source ~/dropbox/Dropbox/bin/kuins_proxy.sh

if test $# -lt 2 ; then
    echo "USAGE: $(basename $0) [JSTTIME] [STNM]"
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
if test ${debug_level} -ge 100 ; then
    echo "DEBUG: JSTTIME = ${JSTTIME}"
    echo "DEBUG: STNM    = ${STNM}"
fi

YEAR=${JSTTIME:0:4}
MONTH=${JSTTIME:4:2}
DAY=${JSTTIME:6:2}
HOUR=${JSTTIME:8:2}
if test ${debug_level} -ge 100 ; then
    echo "DEBUG: JSTTIME = ${JSTTIME}"
    echo "DEBUG: YEAR    = ${YEAR}"
    echo "DEBUG: MONTH   = ${MONTH}"
    echo "DEBUG: DAY     = ${DAY}"
    echo "DEBUG: HOUR    = ${HOUR}"
fi

OUTPUT=${YEAR}${MONTH}${DAY}${HOUR}JST_${STNM}.txt
URL="http://www.data.jma.go.jp/obd/stats/etrn/upper/view/hourly_usp.php?year=${YEAR}&month=${MONTH}&day=${DAY}&hour=${HOUR}&atm=&point=${STNM}"
if test ${debug_level} -ge 100 ; then
    echo "DEBUG: OUTPUT  = ${OUTPUT}"
    echo "DEBUG: URL     = ${URL}"
fi

w3m ${URL} | sed -e "s/\/\/\//-999./g" | awk 'NR>21 && NR<39 {printf ("%5s %7s %7.1f %7.1f %7.1f %7.1f\n", $1,$2,$3,$4,$5,$6)}' > ${OUTPUT}
