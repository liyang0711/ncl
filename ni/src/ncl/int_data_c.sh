#!/bin/sh
#
#      $Id: int_data_c.sh,v 1.1 1994-07-21 23:16:23 boote Exp $
#
#########################################################################
#									#
#			   Copyright (C)  1994				#
#	     University Corporation for Atmospheric Research		#
#			   All Rights Reserved				#
#									#
#########################################################################
#
#	File:		int_data_c.sh
#
#	Author:		Jeff W. Boote
#			National Center for Atmospheric Research
#			PO 3000, Boulder, Colorado
#
#	Date:		Wed Jul 20 17:21:13 MDT 1994
#
#	Description:	
#
#	Usage:
#
#	Environment:
#
#	Files:
#
#
#	Options:

sh op_funcs.sh int > .tmp.$$

if [ ! $? ]
then
	exit $?
fi

sed \
-e 's/PRINTFORMAT/\%d\\n/' \
-e 's/DATATYPE/int/g' \
-e 's/HLUTYPEREP/NhlTInteger/g' \
-e "/REPLACE/r .tmp.$$" \
-e '/REPLACE/d' \
-e '/DSPECIFIC/r NclMultiDValintData.c.specific' \
-e '/DSPECIFIC/d' \
NclMultiDValData.c.sed > NclMultiDValintData.c

rm .tmp.$$

echo "created NclMultiDValintData.c"
