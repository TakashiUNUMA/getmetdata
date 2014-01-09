#!/bin/csh
#
# get_jra_from_jmaftp.csh
#
# original script coded by Takashi Unuma, Kyoto Univ.
# Last modified: 2014/01/09
#

if ($#argv == 0) then
    echo "USAGE: csh $(basename $0) YYYYMMDDHH"
    exit -1
endif

set YMDH = $1
set YYYY = `echo $1 | cut -b 1-4`
set MM = `echo $1 | cut -b 5-6`

#---+->--data
set TYPE = ( anl_p anl_chipsi )

#---+->--directory
set PREFIX = .

#---+->--remote host
set RHOST = ds.data.jma.go.jp
set RUSER = user
set RPASS = passwd
set KUINS = ftp-proxy.kuins.net

#---+->--proxy
setenv http_proxy proxy.com:80
setenv ftp_proxy ftp-proxy.com:80

#---+->--1----+----2----+----3----+----4----+----5----+----6----+----7-<
@ N = 1
while ( ${N} <= ${#TYPE} )
ftp -n ${KUINS} << EOF
user ${RUSER}@${RSITE} ${RPASS[1]}
passive
bin
prompt
cd download/data/GribFinal/${TYPE[${N}]}/${YYYY}${MM}
get ${TYPE[${N}]}.${YMDH}
quit
EOF
if ( ${status} == 1 ) then 
ftp -n ${KUINS} << EOF
user ${RUSER}@${RSITE} ${RPASS[2]}
passive
bin
prompt
cd download/data/GribFinal/${TYPE[${N}]}/${YYYY}${MM}
get ${TYPE[${N}]}.${YMDH}
quit
EOF
endif
@ N ++
end
exit
