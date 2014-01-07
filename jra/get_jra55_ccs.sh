#!/bin/sh -x
#
# get_jra55_ccs.sh
#
# original script coded by Takashi Unuma, Kyoto Univ.
# Last modified: 2013/10/18
#
# You may need to chenge "userid" and "passwd" by yourself.
#
USER='userid'
PASSWD='passwd'
#
# specify the date
#
yyyys=1959
mms=09
dds="25 26"
hhs="00 06 12 18"

#ccccccccccccccccccccccccccccccccccccccccccccccccc
#
# for kuins proxy
#
#export http_proxy=http://proxy.kuins.net:8080/
#export ftp_proxy=http://proxy.kuins.net:8080/
#
# for wget options
#
WGET=wget
WOPTS="--http-user=${USER} --http-password=${PASSWD} -nc"
URL=http://gpvjma.ccs.hpcc.jp/data/jra55/Hist/Daily
#
# for the requirements of value and data dype
#
dtypes="anl_surf125 anl_p125"
dvars="hgt rh spfh tmp ugrd vgrd"
#
# execute section
#
for yyyy in ${yyyys} ; do
for mm in ${mms} ; do
for dd in ${dds} ; do
for hh in ${hhs} ; do
for dtype in ${dtypes} ; do
    if test ${dtype} = "anl_p125" ; then
	for dvar in ${dvars} ; do
	    ${WGET} ${WOPTS} ${URL}/${dtype}/${yyyy}${mm}/${dtype}_${dvar}.${yyyy}${mm}${dd}${hh}
	done # dvar loop
    else
	${WGET} ${WOPTS} ${URL}/${dtype}/${yyyy}${mm}/${dtype}.${yyyy}${mm}${dd}${hh}
    fi
done # dtype loop
done # yyyy loop
done # mm loop
done # dd loop
done # hh loop
#
# end of file
#
