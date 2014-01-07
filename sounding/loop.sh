#!/bin/sh

#for yyyy in 2005 2006 2007 2008 2009 2010 2011 2012 ; do
for yyyy in 2006 2007 2008 2009 2010 2011 2012 ; do
for mm in 04 05 06 07 08 09 10 11 ; do
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
	for hh in 09 21 ; do
	    for site in $(awk '{print $1}' my_sites.txt) ; do
		sh get.sh ${yyyy}${mm}${dd}${hh} ${site} TEXT
		#sh get.sh ${yyyy}${mm}${dd}${hh} ${site} PDF
		sleep 30
	    done # site loop
	done # hh loop
	sleep 60
    done # dd loop
    sleep 30
done # mm loop
done # yyyy loop

