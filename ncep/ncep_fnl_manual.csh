#!/bin/csh

if ( $#argv == 1 ) then
    echo "INPUT TIME: $1 (UTC)"
else
    echo "USAGE: csh $(basename $0) YYYYMMDDHH"
    exit -1
endif

set YYYY = `echo $1 | cut -b 1-4`
set MM = `echo $1 | cut -b 5-6`
set DD = `echo $1 | cut -b 7-8`
set HH = `echo $1 | cut -b 9-10`

if ( $#HH < 1 ) then
    echo "USAGE: csh $(basename $0) YYYYMMDDHH"
    exit -1
endif


#---+->--directory
set PREFIX = .
#---+->--remote host
set RHOST = rda.ucar.edu
set RUSER = kijima.m.u@gmail.com
set RPASS = Ock1ujg1-kijimamu
#---+->--proxy
setenv http_proxy proxy.kuins.net:8080
setenv https_proxy proxy.kuins.net:8080
#---+->--wget
set WGET = /usr/bin/wget
set WOPT = ( -N -nH -np )
#---+->--authkey
set AUTHKEY = auth.rda_ucar_edu
#---+->--1----+----2----+----3----+----4----+----5----+----6----+----7-<
if ( -f ${AUTHKEY} ) \rm -f ${AUTHKEY}
${WGET} --no-check-certificate -O /dev/null --save-cookies ${AUTHKEY} --post-data="email=${RUSER}&passwd=${RPASS}&action=login" -q https://${RHOST}/cgi-bin/login
set T  = `echo "${YYYY} ${MM} ${DD} ${HH}" | awk '{print mktime($1" "$2" "$3" "$4" 0 0")}'`
set TE = `echo "${YYYY} ${MM} ${DD} ${HH}" | awk '{print mktime($1" "$2" "$3" "$4" 0 0")}'`
set TT = `awk 'BEGIN{print mktime(strftime("2008 09 30 12 00 00"))}'`
while ( ${T} <= ${TE} )
set Y = `echo ${T} | awk '{print strftime("%Y",$1)}'`
set M = `echo ${T} | awk '{print strftime("%m",$1)}'`
set RFILE1 = `echo ${T} | awk '{print strftime("fnl_%Y%m%d_%H_00",$1)}'`
set RFILE2 = `echo ${T} | awk '{print strftime("fnl_%Y%m%d_%H_00_c",$1)}'`
if ( ${T} < ${TT} ) then
${WGET} --no-check-certificate --load-cookies ${AUTHKEY} ${WOPT} http://${RHOST}/data/ds083.2/grib1/${Y}/${Y}.${M}/${RFILE1}
else
${WGET} --no-check-certificate --load-cookies ${AUTHKEY} ${WOPT} http://${RHOST}/data/ds083.2/grib1/${Y}/${Y}.${M}/${RFILE2}
endif
endif
@ T += 21600
end
if ( -f ${AUTHKEY} ) \rm -f ${AUTHKEY}
exit
