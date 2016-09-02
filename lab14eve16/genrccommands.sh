#!/bin/sh 
OUTFILENAME=rcfile.txt
>${OUTFILENAME}

SRCBASEDIR=/root/jagadish/utl/synthesis

LIBNAME=/root/library/gsclib090_v3.3/timing/fast.lib
LIBNAMEESCAPED=`echo ${LIBNAME} | sed 's/\//\\\\\\//g' `

INPUTFILEABSPATH=${SRCBASEDIR}/$1
INPUTFILEABSPATHESCAPED=`echo ${INPUTFILEABSPATH} | sed 's/\//\\\\\\//g' `

#echo ${INPUTFILEABSPATH}
#echo ${INPUTFILEABSPATHESCAPED}

echo "set_attribute library ${LIBNAME}" >> ${OUTFILENAME}

echo read_hdl ${INPUTFILEABSPATH} >> ${OUTFILENAME}

echo elab >> ${OUTFILENAME}

echo synth -to_mapped >> ${OUTFILENAME}

echo gui_show >> ${OUTFILENAME}

echo
echo
cat ${OUTFILENAME}
echo
echo

rc -f ${OUTFILENAME}
