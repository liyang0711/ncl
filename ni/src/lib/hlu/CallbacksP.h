/*
 *      $Id: CallbacksP.h,v 1.2 1996-09-14 17:05:52 boote Exp $
 */
/************************************************************************
*									*
*			     Copyright (C)  1996			*
*	     University Corporation for Atmospheric Research		*
*			     All Rights Reserved			*
*									*
************************************************************************/
/*
 *	File:		CallbacksP.h
 *
 *	Author:		Jeff W. Boote
 *			National Center for Atmospheric Research
 *			PO 3000, Boulder, Colorado
 *
 *	Date:		Sat May 4 00:40:29 MDT 1996
 *
 *	Description:	
 */

#ifndef	_NHL_CALLBACKSP_H
#define	_NHL_CALLBACKSP_H
#include <ncarg/hlu/Callbacks.h>

struct _NhlCBRec {
	_NhlCBList	cblist;
	int		index;
	_NhlCBFunc	cbfunc;
	NhlArgVal	udata;
	_NhlCB		next;
};

struct _NhlCBListRec {
	int		size;
	long		mask;
	_NhlCB		single;
	_NhlCB		*hash;
	_NhlCBAddHash	add_hash;
	_NhlCBCallHash	call_hash;
};

#endif	/* _NHL_CALLBACKSP_H */
