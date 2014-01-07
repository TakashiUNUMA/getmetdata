#!/bin/sh
#
# Get JRA/JCDAS data from the FTP site of JMA
#
# original script coded by Takashi Unuma, Kyoto Univ.
# Last modified: 2013/02/18
#

#PREFIX=/work7/work2/DATA/jra_grib1
PREFIX=.
RUSER=user
RPASS=passwd
FTPSITE=ds.data.jma.go.jp
KUINS=ftp-proxy.kuins.net

if test $# -lt 1 ; then
    echo "USAGE: jcdas_lftp.sh YYYYMM"
    exit 1
fi

INPUT=$1
if test ${#INPUT} -lt 6 ; then
    echo "please specify data as a following format:"
    echo " YYYYMM"
    exit 1
fi

yyyy=${INPUT:0:4}
mm=${INPUT:4:2}
dd=${INPUT:6:2}

# trasfar
export http_proxy=http://proxy.kuins.net:8080/
export ftp_proxy=http://ftp-proxy.kuins.net:21/

#echo "DATE: ${yyyy}${mm}${dd}"


### dstrage
# anl_p anl_chipsi anl_mdl fcst_phy2m

### GPGPU /work2
# fcst_phyland anl_snow106_mdl anl_snow25


# mtypes="anl_z anl_isentrop ges_p"

#mtypes="anl_p25 anl_z25 anl_isentrop25 ges_p25"

#mtypes="fcst_phy2m25 anl_land25 anl_land anl_chipsi25"

mtypes="anl_land anl_chipsi25"

for mtype in ${mtypes} ; do
mkdir -p ${PREFIX}/${mtype}
lftp ${KUINS} << EOF
user ${RUSER}@${FTPSITE} ${RPASS}
lcd ${PREFIX}/${mtype}/
mirror -c --verbose=3 -i ${yyyy}${mm}${dd} download/data/GribFinal/${mtype}/${yyyy}${mm}/
quit
EOF
pbzip2 -p4 ${PREFIX}/${mtype}/${yyyy}${mm}/*
done

echo ""
echo "Finish getting JRA/JCDAS"
