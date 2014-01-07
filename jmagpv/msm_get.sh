#!/bin/sh

# -- namelist file --

for date in `cat get_msm-s_lst`
do
    year=`echo ${date} | cut -c1-4`
    month=`echo ${date} | cut -c5-6`
    day=`echo ${date} | cut -c7-8`
    hour=`echo ${date} | cut -c9-10`
    minute=`echo ${date} | cut -c11-12`
    if [ ${hour} -lt 9 ]
    then
	HH__=`expr ${hour} + 24`
	HH_=`expr ${HH__} - 9`
	if [ ${HH_} -lt 10 ]
	then
	    HH='0'${HH_}
	else
	HH=${HH_}
	fi
	DD_=`expr ${day} - 1`
	if [ ${DD_} -eq 0 ]
	then
	    if [ ${month} -eq 01 ]
	    then
		DD=31
		MM=12
		YY=`expr ${year} - 1`
	    elif [ ${month} -eq 02 ]
	    then
		DD=31
		MM=01
		YY=${year}
	    elif [ ${month} -eq 03 ]
	    then
		MM=02
		YY=${year}
		ymod=`expr ${year} % 4`
		if [ ${ymod} -eq 0 ]
		then
		    DD=29
	    else
		    DD=28
		fi
	    elif [ ${month} -eq 04 ]
	    then
		DD=31
		MM=03
	    YY=${year}
	    elif [ ${month} -eq 05 ]
	    then
		DD=30
		MM=04
		YY=${year}
	    elif [ ${month} -eq 06 ]
	    then
		DD=31
		MM=05
		YY=${year}
	    elif [ ${month} -eq 07 ]
	    then
		DD=30
		MM=06
		YY=${year}
	    elif [ ${month} -eq 08 ]
	    then
		DD=31
		MM=07
		YY=${year}
	    elif [ ${month} -eq 09 ]
	    then
		DD=31
		MM=08
		YY=${year}
	    elif [ ${month} -eq 10 ]
	    then
		DD=30
		MM=09
		YY=${year}
	    elif [ ${month} -eq 11 ]
	    then
		DD=31
		MM=10
		YY=${year}
	    elif [ ${month} -eq 12 ]
	    then
		DD=30
		MM=11
		YY=${year}
	    else
		echo 'month error !'
		exit
	    fi
	else
	    MM=${month}
	    YY=${year}
	    if [ ${DD_} -lt 10 ]
	    then
		DD='0'${DD_}
	    else
		DD=${DD_}
	    fi
	fi
    elif [ ${hour} -ge 9 ]
    then
	HH_=`expr ${hour} - 9`
	if [ ${HH_} -lt 10 ]
	then
	    HH='0'${HH_}
	else
	    HH=${HH_}
	fi
	DD=${day}
	MM=${month}
	YY=${year}
    fi
    NN=${minute}
#    echo ' '${YY}${MM}${DD}${HH}${NN}
    yyyymmddhhnn=${YY}${MM}${DD}${HH}${NN}

# -- date setting -- (UTC)
    yyyymmdd=`echo ${yyyymmddhhnn}|cut -c1-8`
    yyyy=`echo ${yyyymmddhhnn}|cut -c1-4`
    mm=`echo ${yyyymmddhhnn}|cut -c5-6`
    dd=`echo ${yyyymmddhhnn}|cut -c7-8`
    hh=`echo ${yyyymmddhhnn}|cut -c9-10`
    nn=`echo ${yyyymmddhhnn}|cut -c11-12`

    echo '  '${date}' (JST) getting...'
# grib2
    wget --wait=6 http://database.rish.kyoto-u.ac.jp/arch/jmadata/data/gpv/original/${yyyy}/${mm}/${dd}/Z__C_RJTD_${yyyy}${mm}${dd}${hh}0000_MSM_GPV_Rjp_Lsurf_FH00-15_grib2.bin
    wget --wait=6 http://database.rish.kyoto-u.ac.jp/arch/jmadata/data/gpv/original/${yyyy}/${mm}/${dd}/Z__C_RJTD_${yyyy}${mm}${dd}${hh}0000_MSM_GPV_Rjp_L-pall_FH00-15_grib2.bin


# netcdf
#    wget --wait=10 http://database.rish.kyoto-u.ac.jp/arch/jmadata/data/gpv/netcdf/MSM-S/${yyyy}/${mm}${dd}.nc #>& /dev/null
#    mv ${mm}${dd}.nc ${yyyy}${mm}${dd}s.nc


done
exit

# ----- cleaning
rm -f lst tmp_lst
rm -f kyoudo.bin 
rm -f draw*.gs draw.ctl tmp* lst.bk
rm -f Z__C_RJTD_2_0_int.bin 
rm -f Z__C_RJTD_*_RDR_JMAGPV_Ggis1km_Prr10lv_ANAL_grib2.bin 
rm -f Z__C_RJTD_*_RDR_JMAGPV_Gll2p5km_Phhlv_ANAL_grib2.bin
rm -f gd2grads.sh~

# ----- make directry
#mkdir -p work/${ymd}_JST
#mv radar_${ymd}*.gif work/${ymd}_JST

echo ' '
echo '------------------------------------'
echo ' Save picture in work/'${ymd}_JST
echo '         SUCCESS COMPLESSION'
echo '------------------------------------'
