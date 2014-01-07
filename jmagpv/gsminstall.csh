#!/bin/csh

set yyyy = 2012
set mm   = 08
set dd   = 14

mkdir -p ${yyyy}/${mm}
# yyyy/mm/dd
foreach f (00 06 12 18)
#foreach f (18)
wget http://database.rish.kyoto-u.ac.jp/arch/jmadata/data/gpv/original/${yyyy}/${mm}/${dd}/Z__C_RJTD_${yyyy}${mm}${dd}${f}0000_GSM_GPV_Rgl_FD0000_grib2.bin
mv Z__C_RJTD_${yyyy}${mm}${dd}${f}0000_GSM_GPV_Rgl_FD0000_grib2.bin ${yyyy}/${mm}
end
rm -rf gpvinstall.csh~

