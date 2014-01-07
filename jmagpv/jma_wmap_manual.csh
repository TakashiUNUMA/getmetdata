#!/bin/csh
#---+->--data
set TYPE  = ( japan   asia )
set RPDIR = ( observe asia )
#---+->--directory
set PREFIX = /work15/jma_wmap
#---+->--remote host
set RHOST = www.jma.go.jp
#set RUSER = 
#set RPASS = 
#---+->--proxy
setenv http_proxy proxy.kuins.net:8080
#---+->--wget
set WGET = /usr/bin/wget
set WOPT = ( -N -q -nH -np )
#---+->--option
set CHKD = 2
#---+->--1----+----2----+----3----+----4----+----5----+----6----+----7-<
set T  = `awk 'BEGIN{print mktime(strftime("%Y %m %d 00 00 00",systime()-'${CHKD}'*24*60*60))}'`
set TE = `awk 'BEGIN{print mktime(strftime("%Y %m %d %H %M %S",systime()))}'`
while ( ${T} <= ${TE} )
set Y = `echo ${T} | awk '{print strftime("%Y",$1)}'`
set M = `echo ${T} | awk '{print strftime("%m",$1)}'`
set YMD = `echo ${T} | awk '{print strftime("%Y%m%d",$1)}'`
set YMDH = `echo ${T} | awk '{print strftime("%y%m%d%H",$1)}'`
@ N = 1
while ( ${N} <= ${#TYPE} )
if ( ! -f ${PREFIX}/${TYPE[${N}]}/${Y}/${M}/${YMD}/${YMDH}.png ) then
if ( ! -d ${PREFIX}/${TYPE[${N}]}/${Y}/${M}/${YMD} ) mkdir -p ${PREFIX}/${TYPE[${N}]}/${Y}/${M}/${YMD}
${WGET} ${WOPT} -P ${PREFIX}/${TYPE[${N}]}/${Y}/${M}/${YMD} http://${RHOST}/jp/g3/images/${RPDIR[${N}]}/${YMDH}.png
endif
@ N ++
end
@ T += 10800
end
exit
