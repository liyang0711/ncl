/*
 *	$Id: s_gspmi.c,v 1.3 2000-08-01 14:36:00 haley Exp $
 */
/************************************************************************
*                                                                       *
*                Copyright (C)  2000                                    *
*        University Corporation for Atmospheric Research                *
*                All Rights Reserved                                    *
*                                                                       *
* This file is free software; you can redistribute it and/or modify     *
* it under the terms of the GNU Lesser General Public License as        *
* published by the Free Software Foundation; either version 2.1 of the  *
* License, or (at your option) any later version.                       *
*                                                                       *
* This software is distributed in the hope that it will be useful, but  *
* WITHOUT ANY WARRANTY; without even the implied warranty of            *
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU     *
* Lesser General Public License for more details.                       *
*                                                                       *
* You should have received a copy of the GNU Lesser General Public      *
* License along with this software; if not, write to the Free Software  *
* Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307   *
* USA.                                                                  *
*                                                                       *
************************************************************************/

/*
 *  Set polymarker index  
 */

#include <ncarg/gks.h>

extern void NGCALLF(gspmi,GSPMI)(Gint*);

void gset_marker_ind
#ifdef NeedFuncProto
(
    Gint marker_ind  /*  polymarker index  */
)
#else
( marker_ind )
    Gint marker_ind;
#endif
{
    NGCALLF(gspmi,GSPMI)(&marker_ind);
}
