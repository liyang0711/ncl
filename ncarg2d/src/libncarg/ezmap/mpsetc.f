C
C $Id: mpsetc.f,v 1.8 1999-04-02 22:59:45 kennison Exp $
C
      SUBROUTINE MPSETC (WHCH,CVAL)
      CHARACTER*(*) WHCH,CVAL
      IF (ICFELL('MPSETC - UNCLEARED PRIOR ERROR',1).NE.0) RETURN
      CALL MAPSTC (WHCH,CVAL)
      IF (ICFELL('MPSETC',2).NE.0) RETURN
      RETURN
      END
