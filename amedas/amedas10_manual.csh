#!/bin/csh

if ($#argv == 0) then
    echo "USAGE: csh $(basename $0) YYYYMMDDHH"
    exit -1
endif

set YYYY = `echo $1 | cut -b 1-4`
set MM = `echo $1 | cut -b 5-6`
set DD = `echo $1 | cut -b 7-8`

#---+->--directory
set PREFIX = .

#---+->--proxy
setenv http_proxy http://proxy.com:80

#---+->--w3m command is required
set W3M = /usr/bin/w3m

#---+->--option
# r: rainfall
# t: temperature
# w: wind speed/direction
set LIST = ${PREFIX}/station_list_rtw.txt
#set LIST = ${PREFIX}/station_list_r.txt


#---+->--1----+----2----+----3----+----4----+----5----+----6----+----7-<

cat > winddir0.sed << EOF
s/[[:space:]]\+/,/g
s/\/\/\//-999./g
s/静穏/-999./g
s/北北東/22.5/g
s/東北東/67.5/g
s/東南東/112.5/g
s/南南東/157.5/g
s/南南西/202.5/g
s/西南西/247.5/g
s/西北西/292.5/g
s/北北西/337.5/g
EOF

cat > winddir1.sed << EOF
s/北東/45.0/g
s/南東/135.0/g
s/南西/225.0/g
s/北西/315.0/g
EOF

cat > winddir2.sed << EOF
s/北/0.0/g
s/東/90.0/g
s/南/180.0/g
s/西/270.0/g
EOF

set AREA = ( `awk 'NR>1 && $2 ~ /6./ {print $2}' ${LIST}` )
set SITE = ( `awk 'NR>1 && $2 ~ /6./ {print $3}' ${LIST}` )
set SLON = ( `awk 'NR>1 && $2 ~ /6./ {print $5}' ${LIST}` )
set SLAT = ( `awk 'NR>1 && $2 ~ /6./ {print $6}' ${LIST}` )

@ I = 1
while ( ${I} <= ${#SITE} )

@ T  = `echo "${YYYY} ${MM} ${DD}" | awk '{print mktime($1" "$2" "$3" 0 0 0")}'`

set YMD = `awk 'BEGIN{t='${T}';print strftime("%Y%m%d",t)}'`
set DIR = ${PREFIX}/${AREA[${I}]}/${SITE[${I}]}
if ( ! -d ${DIR} ) mkdir -p ${DIR}

set FILE = ${DIR}/${YMD}.csv
if ( -f ${FILE} ) \rm -f ${FILE}
if ( ! -f ${FILE} ) touch ${FILE}

set Y = `awk 'BEGIN{t='${T}';print strftime("%Y",t)}'`
set M = `awk 'BEGIN{t='${T}';print strftime("%m",t)}'`
set D = `awk 'BEGIN{t='${T}';print strftime("%d",t)}'`

if ( `echo ${SITE[${I}]} | awk '{print length($1)}'` == 4 ) then
    ${W3M} "http://www.data.jma.go.jp/obd/stats/etrn/view/10min_a1.php?prec_no=${AREA[${I}]}&block_no=${SITE[${I}]}&year=${Y}&month=${M}&day=${D}&elm=minutes&view=" | tail -n 149 | head -n 144 | sed -f winddir0.sed | sed -f winddir1.sed | sed -f winddir2.sed | awk '{t='${T}';print '${SLON[${I}]}'","'${SLAT[${I}]}'","strftime("%Y/%m/%d,",t)$0}' >> ${FILE}
else
    ${W3M} "http://www.data.jma.go.jp/obd/stats/etrn/view/10min_s1.php?prec_no=${AREA[${I}]}&block_no=${SITE[${I}]}&year=${Y}&month=${M}&day=${D}&elm=minutes&view=" | tail -n 150 | head -n 144 | sed -f winddir0.sed | sed -f winddir1.sed | sed -f winddir2.sed | awk '{t='${T}';print '${SLON[${I}]}'","'${SLAT[${I}]}'","strftime("%Y/%m/%d,",t)$0}' >> ${FILE}
endif

@ I ++
end

rm -f winddir?.sed
exit
