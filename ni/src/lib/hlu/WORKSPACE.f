C
C $Id: WORKSPACE.f,v 1.2 1997-05-05 21:45:31 boote Exp $
C
C****************************************************************
C								*
C			Copyright (C)  1994			*
C	University Corporation for Atmospheric Research		*
C			All Rights Reserved			*
C								*
C****************************************************************
C
C      File:            WORKSPACE.f
C
C      Author:          Jeff W. Boote
C                       National Center for Atmospheric Research
C                       PO 3000, Boulder, Colorado
C
C      Date:            Fri Apr 15 16:55:57 MDT 1994
C
C      Description:     
C
      subroutine nhlfgetworkspaceobjectid(id)
	integer id

	call nhlpfgetworkspaceobjectid(id)
      end
