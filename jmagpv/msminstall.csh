#!/bin/csh

set yyyy = 2013
set mm   = 03
set dd   = 16
set URL  = http://database.rish.kyoto-u.ac.jp/arch/jmadata/data/gpv/original

# yyyy/mm/dd
#foreach f (00 06 12 18)
foreach f (00 03 06 09 12 15 18 21)
#foreach f (06 09)

    # for pressure level
    set file0 = Z__C_RJTD_${yyyy}${mm}${dd}${f}0000_MSM_GPV_Rjp_L-pall_FH00-15_grib2.bin
    set file1 = Z__C_RJTD_${yyyy}${mm}${dd}${f}0000_MSM_GPV_Rjp_L-pall_FH18-33_grib2.bin

    # for surface level
    set file2 = Z__C_RJTD_${yyyy}${mm}${dd}${f}0000_MSM_GPV_Rjp_Lsurf_FH00-15_grib2.bin
    set file3 = Z__C_RJTD_${yyyy}${mm}${dd}${f}0000_MSM_GPV_Rjp_Lsurf_FH16-33_grib2.bin

    wget ${URL}/${yyyy}/${mm}/${dd}/${file0}
    wget ${URL}/${yyyy}/${mm}/${dd}/${file1}
    wget ${URL}/${yyyy}/${mm}/${dd}/${file2}
    wget ${URL}/${yyyy}/${mm}/${dd}/${file3}
end

mkdir -p ${yyyy}/${mm}
mv Z__C_RJTD_*.bin ${yyyy}/${mm}

echo '-----------------------------------------'
echo '  save data in '${yyyy}/${mm}' directry'
echo '  finish! '
echo '-----------------------------------------'

rm -f gpvinstall.csh~

#cat > ftp.get << EOF
#user ishikawa erena843
#cd /MSS00/GPV/${yyyy}/${mm}/${yyyy}${mm}${dd}
#bi
#mget *_FH00-*
#bye
#EOF
#ftp -vni 10.244.84.247 < ftp.get #>& ftpget.out
#bunzip2 *.bz2
