#!/bin/sh

ylist="2012"
mlist="07 08"

for yyyy in ${ylist} ; do
for mm in ${mlist} ; do

    if [ ${mm} = "01" -o ${mm} = "03" -o ${mm} = "05" -o ${mm} = "07" -o ${mm} = "08" -o ${mm} = "10" -o ${mm} = "12" ] ; then
	dlist="01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31"
    elif [ ${mm} = "04" -o ${mm} = "06" -o ${mm} = "09" -o ${mm} = "11" ] ; then
	dlist="01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30"
    elif [ ${mm} = "02" ] ; then
	if [ ${yyyy} = "2000" -o ${yyyy} = "2004" -o ${yyyy} = "2008" -o ${yyyy} = "2012" -o ] ; then
	    dlist="01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29"
	else
	    dlist="01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28"
	fi
    fi

    for dd in ${dlist} ; do
	echo "Now execute time: ${yyyy}${mm}${dd}"
	csh amedas10.csh ${yyyy}${mm}${dd}
	sleep 5 # execute program par 5 seconds
    done # loop for day list

done # loop for month list
done # loop for year list

