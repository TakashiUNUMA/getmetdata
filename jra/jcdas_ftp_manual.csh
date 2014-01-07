#!/bin/csh
#
# Get JRA/JCDAS data from the FTP site of JMA
#
# original script coded by Takashi Unuma, Kyoto Univ.
# Last modified: 2013/06/24
#

#---+->--data
set TYPE = ( anl_mdl anl_p anl_chipsi fcst_phy2m )
#---+->--directory
set PREFIX = /work14/jcdas
#---+->--remote host
set RHOST = ds.data.jma.go.jp
set RUSER = user
set RPASS = passwd
set KUINS = ftp-proxy.kuins.net
#---+->--proxy
setenv http_proxy proxy.kuins.net:8080
setenv ftp_proxy ftp-proxy.kuins.net:21
#---+->--option
set CHKD = 10
#---+->--1----+----2----+----3----+----4----+----5----+----6----+----7-<
set T  = `awk 'BEGIN{print mktime(strftime("%Y %m %d 00 00 00",systime()-'${CHKD}'*24*60*60))}'`
set TE = `awk 'BEGIN{print mktime(strftime("%Y %m %d 00 00 00",systime()))}'`
while ( ${T} <= ${TE} )
set Y = `echo ${T} | awk '{print strftime("%Y",$1)}'`
set M = `echo ${T} | awk '{print strftime("%m",$1)}'`
set YMDH = `echo ${T} | awk '{print strftime("%Y%m%d%H",$1)}'`
@ N = 1
while ( ${N} <= ${#TYPE} )
if ( -f ${PREFIX}/${TYPE[${N}]}/${Y}/${M}/${TYPE[${N}]}.${YMDH} ) \rm -f ${PREFIX}/${TYPE[${N}]}/${Y}/${M}/${TYPE[${N}]}.${YMDH}
if ( ! -f ${PREFIX}/${TYPE[${N}]}/${Y}/${M}/${TYPE[${N}]}.${YMDH}.bz2 ) then
if ( ! -d ${PREFIX}/${TYPE[${N}]}/${Y}/${M} ) mkdir -p ${PREFIX}/${TYPE[${N}]}/${Y}/${M}

ftp -n ${KUINS} << EOF
user ${RUSER}@${RSITE} ${RPASS}
passive
bin
prompt
cd download/data/GribFinal/${TYPE[${N}]}/${Y}${M}
get ${TYPE[${N}]}.${YMDH}
quit
EOF

if ( ${status} == 1 ) then 
    ftp -n ${KUINS} << EOF
user ${RUSER}@${RSITE} ${RPASS}
passive
bin
prompt
cd download/data/GribFinal/${TYPE[${N}]}/${Y}${M}
get ${TYPE[${N}]}.${YMDH}
quit
EOF
endif

if ( ${status} == 0 ) then
    mv ${TYPE[${N}]}.${YMDH} ${PREFIX}/${TYPE[${N}]}/${Y}/${M}
    bzip2 ${PREFIX}/${TYPE[${N}]}/${Y}/${M}/${TYPE[${N}]}.${YMDH}
endif

endif
@ N ++
end
@ T += 21600
end
exit
