/*
 *	$Id: s_gsvp.c,v 1.3 2000-08-01 14:36:01 haley Exp $
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
 *  Set viewport
 */

#include <ncarg/gks.h>

extern void NGCALLF(gsvp,GSVP)(Gint*,const Gfloat*,const Gfloat*,
                                     const Gfloat*,const Gfloat*);

void gset_vp
#ifdef NeedFuncProto
(
    Gint            tran_num,     /* transformation number */
    const Glimit    *vp_limits    /* viewport limits       */
)
#else
( tran_num, vp_limits )
    Gint      tran_num;
    Glimit    *vp_limits;
#endif
{
    NGCALLF(gsvp,GSVP)(&tran_num,&vp_limits->x_min,&vp_limits->x_max,
                                 &vp_limits->y_min,&vp_limits->y_max);
}
