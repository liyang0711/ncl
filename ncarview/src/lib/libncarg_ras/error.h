/*
 *	$Id: error.h,v 1.4 1992-09-10 21:25:26 don Exp $
 */
/************************************************************************
*									*
*			     Copyright (C)  1992			*
*	     University Corporation for Atmospheric Research		*
*			     All Rights Reserved			*
*									*
************************************************************************/
/*
 *	File:		error.h
 *
 *	Author:		Don Middleton
 *			National Center for Atmospheric Research
 *			PO 3000, Boulder, Colorado
 *
 *	Date:		Wed Aug 12 03:23:03 MDT 1992
 *
 *	Description:	This is the include file for the error.c
 *			error processing module.
 *
 *			NOTE: If you change or add an error
 *			number/message, this file *and* ncarg_ras.h
 *			must be appropriately modified.
 */
#ifndef __RAS_ERROR__
#define __RAS_ERROR__
#endif /*__RAS_ERROR__*/

static const char *ras_errlist[] = {
	"System Error",
	"Internal Error - ",
	"Only 8-bit pixels supported",
	"Only 8-bit intensities supported",
	"Only 8-bit run lengths supported",
	"Image not in correct format",
	"Unsupported image encoding",
	"Improper colormap load",
	"Colormap too big",
	"Image size changed within file",
	"Image encoding changed within file",
	"No format specified",
	"Internal Error - NULL name provided",
	"Unknown format",
	"Invalid colormap entry",
	"No option parameter",
	"Unsupported resolution",
	"Bogus raster structure",
	"Unsupported function",
	"Sun RLE encoding not supported",
	"Parallax frame buffer",
	"Premature EOF",
	"Programming Error",
	"Too many dither bits",
	"Unknown resource",
	"Bogus magic cookie"
};

static const char *hdf_errlist[] = {
	"File not found",
	"Access to file denied",
	"File already open",
	"Too many DF's or files open",
	"Bad file name on open",
	"Bad file access mode",
	"Other open error",
	"File can't be closed 'cause it isn't open",
	"fclose wouldn't work!",
	"DF is a null pointer",
	"DF has an illegal type: internal error",
	"Feature not currently supported",
	"The DD list is non-existent: internal error",
	"This is not a DF file and it is not 0 length",
	"The DD list already seeded: internal error",
	"Malloc failed",
	"There is no such tag in the file: search failed",
	"There was a read error",
	"There was a write error",
	"There was a seek error",
	"There are no free DD's left: internal error",
	"illegal WILDCARD tag",
	"illegal WILDCARD reference #",
	"The DF is read only",
	"Calls in wrong order",
	"NULL ptr argument",
	"negative len specified",
	"Attempt to seek past end of element",
	"No (more) DDs which match specified tag/ref",
	"Warning: Set contained unknown tag: ignored",
	"negative or zero dimensions specified",
	"Illegal offset specified",
	"Unknown compression scheme specified",
	"No dimension record associated with image",
	"space provided insufficient for size of data",
	"Values not available",
	"File is corrupted OR Don't know how to convert data type",
	"The file contained an illegal floating point no",
	"no more reference numbers are available",
	"unknown or unavailable data type specified",
	"unknown or unavailable machine type specified",
	"unknown or unavailable number type specified",
	"unknown or illegal array order specified",
	"This feature not yet implemented"
};
