/*
**      $Id: xy01c.c,v 1.1 1995-02-03 16:24:49 haley Exp $
*/
/************************************************************************
*                                                                       *
*                Copyright (C)  1995                                    *
*        University Corporation for Atmospheric Research                *
*                All Rights Reserved                                    *
*                                                                       *
************************************************************************/
/*
**  File:       xy01c.c
**
**  Author:     Mary Haley
**          National Center for Atmospheric Research
**          PO 3000, Boulder, Colorado
**
**  Date:       Fri Jan 27 08:24:42 MST 1995
**
**  Description:    This program shows how to create an XY plot with all
**                  the default resources being used.  Since there's no 
**                  "default data", we need to create some.  A resource
**                  file is included with this example, but only to show
**                  what all the XY resources are and what their defaults
**                  are.  The whole resource file is commented out.
*/


#include <stdio.h>
#include <math.h>
#include <ncarg/hlu/hlu.h>
#include <ncarg/hlu/ResList.h>
#include <ncarg/hlu/App.h>
#include <ncarg/hlu/XWorkstation.h>
#include <ncarg/hlu/XyPlot.h>
#include <ncarg/hlu/CoordArrays.h>

#define NPTS  501
#define PI100 .031415926535898

main()
{
	int     appid,xworkid,plotid,dataid;
	int     rlist
	int     i, j;
	float   ydra[NPTS], theta;
/*
 * Initialize some data for the XY plot
 */
	for( i = 0; i < NPTS; i++ ) {
		theta=PI100*(float)(i);
		ydra[i]=500.+.9*(float)(i)*sin(theta);
	}
/*
 * Initialize the HLU library and set up resource template.
 */
	NhlInitialize();
	rlist = NhlRLCreate(NhlSETRL);
/*
 * Create application and X workstation object.  The application name
 * is used to determine the name of the resource file, which will be
 * "xy01.res" in this case.
 */
	NhlRLClear(rlist);
	NhlRLSetString(rlist,NhlNappUsrDir,"./");
	NhlCreate(&appid,"xy01",NhlappLayerClass,NhlDEFAULT_APP,rlist);
	NhlCreate(&xworkid,"xy01Work",NhlxWorkstationLayerClass,NhlDEFAULT_APP,0);
/*
 * Define the data object.  The id for this object will then later be used
 * as the value for the XYPlot data resource, "xyCurveData".
 */
	NhlRLClear(rlist);
	NhlRLSetFloatArray(rlist,NhlNcaYArray,ydra,NhlNumber(ydra));
	NhlCreate(&dataid,"xyData",NhlcoordArraysLayerClass,NhlDEFAULT_APP,rlist);
/*
 * Create the Plot object which is created as a child of the X workstation
 * object.
 */
	NhlRLClear(rlist);
	NhlRLSetInteger(rlist,NhlNxyCurveData,dataid);
	NhlCreate(&plotid,"xyPlot",NhlxyPlotLayerClass,xworkid,rlist);
/*
 * Draw the plot (to its parent X Workstation)
 */
	NhlDraw(plotid);
	NhlFrame(xworkid);
/*
 * NhlDestroy destroys the given id and all of its children
 * so destroying "xworkid" will also destroy plotid.
 */
	NhlRLDestroy(rlist);
	NhlDestroy(xworkid);
	NhlDestroy(appid);
/*
 * Restores state.
 */
	NhlClose();

	exit(0);
}
