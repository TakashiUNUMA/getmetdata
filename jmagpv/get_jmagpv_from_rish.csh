#!/bin/csh
#
# get_jmagpv_from_rish.csh
#
# original script coded by Takashi Unuma, Kyoto Univ.
# Last modified: 2014/01/09
#

if ($#argv == 0) then
    echo "USAGE: csh $(basename $0) YYYYMMDDHH"
    exit -1
endif

set YYYY = `echo $1 | cut -b 1-4`
set MM = `echo $1 | cut -b 5-6`
set DD = `echo $1 | cut -b 7-8`
set HH = `echo $1 | cut -b 9-10`

#---+->--directory
set PREFIX = .

#---+->--remote host
set RHOST = database.rish.kyoto-u.ac.jp

#---+->--wget
set WGET = wget
set WOPT = ( -nH -np )

#---+->--file type
# CWM
#set FILETIPE = CWM_GPV_Rjp_Gll0p05deg_FD0000-0300_grib2
# JMA-GSM
#set FILETYPE = GSM_GPV_Rgl_FD0000_grib2
#set FILETYPE = GSM_GPV_Rjp_L-pall_FD0000-0312_grib2
#set FILETYPE = GSM_GPV_Rjp_Lsurf_FD0000-0312_grib2
# JMA-MSM
set FILETYPE = MSM_GPV_Rjp_L-pall_FH00-15_grib2
#set FILETYPE = MSM_GPV_Rjp_Lsurf_FH00-15_grib2

#---+->--1----+----2----+----3----+----4----+----5----+----6----+----7-<
${WGET} ${WOPT} http://${RHOST}/arch/jmadata/data/gpv/original/${YYYY}/${MM}/${DD}/Z__C_RJTD_${YYYY}${MM}${DD}${HH}0000_${FILETYPE}.bin
exit
