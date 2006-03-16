C
C	$Id: cfvld.f,v 1.4 2006-03-16 17:41:12 kennison Exp $
C                                                                      
C                Copyright (C)  2000
C        University Corporation for Atmospheric Research
C                All Rights Reserved
C
C This file is free software; you can redistribute it and/or modify
C it under the terms of the GNU General Public License as published
C by the Free Software Foundation; either version 2 of the License, or
C (at your option) any later version.
C
C This software is distributed in the hope that it will be useful, but
C WITHOUT ANY WARRANTY; without even the implied warranty of
C MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
C General Public License for more details.
C
C You should have received a copy of the GNU General Public License
C along with this software; if not, write to the Free Software
C Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307
C USA.
C
      SUBROUTINE CFVLD (IENTRY,IIX,IIY)
C
C CFVLD CONNECTS POINTS WHOSE COORDINATES ARE SUPPLIED IN THE ARGUMENTS,
C ACCORDING TO THE DASH PATTERN WHICH IS PASSED FROM ROUTINE DASHDB
C OR DASHDC IN THE COMMON-BLOCK DASHD1.
C
      CHARACTER*16  IPC(100)
C
      COMMON/INTPR/IPAU,FPART,TENSN,NP,SMALL,L1,ADDLR,ADDTB,MLLINE,
     1    ICLOSE
C
C THE VARIABLES IN DASHD1 AND DASHD2 ARE USED FOR COMMUNICATION WITH
C DASHDC AND DASHDB.
C
      COMMON /DASHD1/  ISL,  L,  ISIZE,  IP(100),  NWDSM1,  IPFLAG(100)
     1                 ,MNCSTR, IGP
      COMMON /DASHD2/  IPC
C
C THE VARIABLES IN DSAVE1 HAVE TO BE SAVED FOR THE NEXT CALL TO CFVLD.
C
      COMMON /DSAVE1/ X,Y,X2,Y2,X3,Y3,M,BTI,IB,IX,IY
C
C THE FLAGS IFSTFL AND IVCTFG ARE INITIALIZED IN THE BLOCK DATA DASHBD.
C IFSTFL CONTROLS THAT FRSTD IS CALLED BEFORE VECTD IS CALLED.
C IVCTFG IS A FLAG TO INDICATE IF CFVLD IS BEING CALLED FROM VECTD OR
C LASTD.
C
      COMMON /DCFLAG/ IFSTFL
      COMMON /CFFLAG/ IVCTFG
      SAVE
C
C
C CMN IS USED TO DETERMINE WHEN TO STOP DRAWING A LINE SEGMENT
C
      DATA CMN/1.5/
C
C IMPOS IS USED AS AN IMPOSSIBLE PEN POSITION.
C
      DATA IMPOS /-9999/
C
C
C  ISL= -1  ALL BLANK  ) FLAG TO AVOID MOST CALCULATIONS
C        0  DASHED     )   IF PATTERN IS ALL SOLID OR
C        1  ALL SOLID  )   ALL BLANK
C
C     X,IX,Y,IY    CURRENT POSITION
C     X1,Y1        START OF A USER LINE SEGMENT
C     X2,Y2        END OF A USER LINE SEGMENT
C     X3,Y3        START OF A GAP PATTERN SEGMENT
C
C  SYMBOLS,IF PRESENT ARE CENTERED IN AN IMMEDIATLY PRECEEDING
C     GAP SEGMENT, OR DONE AT THE CURRENT POSITION OTHERWISE
C
C  SEGMENT TYPES ARE RECOGNIZED AS FOLLOWS
C     SOLID - WORD IN IP-ARRAY CONTAINS POSITIVE INTEGER, CORRESPONDING
C             ELEMENT IN IPFLAG IS 1.
C     GAP - WORD IN IP-ARRAY CONTAINS POSITIVE INTEGER, CORRESPONDING
C             ELEMENT IN IPFLAG IS -1.
C     SYMBOL - WORD IN IP-ARRAY CONTAINS CHARACTER REPRESENTATIONS.
C             CORRESPONDING ELEMENT IN IPFLAG IS 0.
C             SYMBOL COUNT FOR CHAR STRING IN CHAR NUMBER MNCSTR+1.
C     THE IP ARRAY AND THE IPFLAG ARRAY ARE COMPOSED OF L ELEMENTS.
C
C     BTI - BITS THIS INCREMENT
C     BPBX,BPBY BITS PER BIT X(Y)
C
C
C BRANCH DEPENDING ON FUNCTION TO BE PERFORMED.
C
      GO TO (330,305,350),IENTRY
C
C INITIALIZE VARIABLES (ENTRY FRSTD ONLY)
C
   30 CONTINUE
      X = IX
      Y = IY
      X2 = X
      X3 = X
      Y2 = Y
      Y3 = Y
      M = 1
      IB = IPFLAG(1)
      IF (IPFLAG(1) .NE. 0) GO TO 40
      IB = 0
      BTI = 0
   40 CONTINUE
      BTI = REAL(IP(1))*FPART
      GO TO 300
C
C MAIN LOOP START
C
   50 CONTINUE
         X1 = X2
         Y1 = Y2
         MX = IIX
         MY = IIY
         X2 = MX
         Y2 = MY
         DX = X2-X1
         DY = Y2-Y1
         D = SQRT(DX*DX+DY*DY)
         IF (D .LT. CMN) GO TO 190
   60    BPBX = DX/D
         BPBY = DY/D
         CALL DRAWPV (IX,IY,0)
   70    BTI = BTI-D
         IF (BTI) 100,100,80
C
C LINE SEGMENT WILL FIT IN CURRENT PATTERN ELEMENT
C
   80    X = X2
         Y = Y2
         IX = X2
         IY = Y2
         IF (IB) 200,160,90
   90    CALL DRAWPV (IX,IY,1)
         GO TO 200
C
C LINE SEGMENT WONT FIT IN CURRENT PATTERN ELEMENT
C DO IT TO END OF ELEMENT, SAVE HOW MUCH OF SEGMENT LEFT TO DO (D)
C
  100    BTI = BTI+D
         D = D-BTI
         X = X+BPBX*BTI
         Y = Y+BPBY*BTI
         IX = X+.5
         IY = Y+.5
         IF (IB) 110,160,120
  110    CALL DRAWPV (IX,IY,0)
         GO TO 130
  120    CALL DRAWPV (IX,IY,1)
C
C GET THE NEXT PATTERN ELEMENT
C
  130    M = MOD(M,L)+1
         IB = IPFLAG(M)
         IF (IB) 140,160,150
  140    X3 = X
         Y3 = Y
         BTI = REAL(IP(M))
         GO TO 70
  150    X3 = -1.
         BTI = REAL(IP(M))
         GO TO 70
C
C CHARACTER GENERATION
C
  160    S = 0.
         IF (IGP .NE. 9) GO TO 162
C
         DX = X-X3
         DY = Y-Y3
         GO TO 164
C
  162    CONTINUE
         DX = X - X1
         DY = Y - Y1
  164    CONTINUE
C
         IF (DY) 170,180,170
  170    S = ATAN2(DY,DX)
         IF (ABS(S-.00005) .GT. 1.5708) S = S-SIGN(3.14159,S)
  180    IF (IGP .NE. 9) GO TO 182
C
         MX = X3 + DX*.5
         MY = Y3 + DY*.5
         LIGP = 0
         GO TO 184
C
  182    CONTINUE
         MX = X
         MY = Y
         LIGP = 1
C
  184    CONTINUE
         IS = INT(S*180./3.14 + .5)
         IF (IS .LT. 0) IS = 360+IS
         CALL GETUSV('XF',LXSAVE)
         CALL GETUSV('YF',LYSAVE)
         MX = ISHIFT (MX,LXSAVE-15)
         MY = ISHIFT(MY,LYSAVE-15)
         CALL WTSTR(CPUX(MX),CPUY(MY),IPC(M)(1:IP(M)),ISIZE,IS,LIGP)
         CALL DRAWPV (IMPOS,IMPOS,2)
         CALL DRAWPV (IX,IY,0)
         GO TO 130
  190    X2 = X1
         Y2 = Y1
  200 CONTINUE
C
C EXIT IF CALL WAS TO VECTD.
C
      IF (IVCTFG .NE. 2) GO TO 210
      IVCTFG = 1
      GO TO 300
C
C EXIT IF NOT PLOTTING A GAP
C
  210 IF (IB .GE. 0) GO TO 300
C
C MUST BE IN A GAP AT END OF LASTD. EXIT IF NOT A LABEL GAP.
C
      MO = M
      M = MOD(M,L) + 1
      IF (IPFLAG(M) .NE. 0) GO TO 300
C
C CHECK PREVIOUS PLOTTED ELEMENT. WAS IT A GAP OR A LINE.
C
      MPREV = M - 2
      IF (MPREV .LE. 0) MPREV = MPREV + L
      IB = IPFLAG(MPREV)
      IF (IB .GE. 0) GO TO 250
C
C PREVIOUS ELEMENT WAS A GAP - LOOK FOR NEXT LINE.
C EXIT IF NO LINES IN PATTERN.
C
  230 CONTINUE
  240 M = MOD(M,L)+1
      IF (M .EQ. MO) GO TO 300
      IB = IPFLAG(M)
      IF (IB .EQ. 0) GOTO 245
      BTI = REAL(IP(M))
  245 CONTINUE
C
C IF IP(M) NOT A LINE, CONTINUE LOOKING.
C
      IF (IB) 240,230,280
C
C PREVIOUS ELEMENT WAS A LINE - LOOK FOR NEXT GAP.
C IF NO NON-LABEL GAPS IN PATTERN, GO TO 290.
C
  250 CONTINUE
  260 M = MOD(M,L)+1
      IF (M .EQ. MO) GO TO 290
      IB = IPFLAG(M)
      IF (IB .EQ. 0) GOTO 265
      BTI = REAL(IP(M))
  265 CONTINUE
C
C IF IP(M) NOT A GAP, CONTINUE LOOKING.
C
      IF (IB) 270,250,260
C
C FOUND A GAP. IF ITS A LABEL GAP, GO LOOK FOR NEXT GAP.
C
  270 MT = M
      M = MOD(M,L)+1
      IF (IPFLAG(M) .EQ. 0) GO TO 250
      M = MT
C
C M POINTS TO NEXT ELEMENT TO PLOT. SET UP AND GO PLOT.
C
  280 X1 = X3
      Y1 = Y3
      X = X3
      Y = Y3
      IX = X+0.5
      IY = Y+0.5
      DX = X2-X1
      DY = Y2-Y1
      D = SQRT(DX*DX+DY*DY)
      IF (D .GE. CMN) GO TO 60
      GO TO 300
C
C NO NON-LABEL GAPS IN THE PATTERN - FILL IN WITH SOLID LINE.
C
  290 IX = X3+0.5
      IY = Y3+0.5
      CALL DRAWPV (IX,IY,0)
      IX = X2
      IY = Y2
      CALL DRAWPV (IX,IY,1)
  300 RETURN
C
C *************************************
C
C ENTRY VECTD (XX,YY)
C
  305 CONTINUE
C
C TEST FOR PREVIOUS CALL TO FRSTD.
C
      IF (IFSTFL .EQ. 2) GO TO 310
C
C INFORM USER - NO PREVIOUS CALL TO FRSTD. TREAT CALL AS FRSTD CALL.
C
      CALL SETER ('CFVLD -- VECTD CALL OCCURS BEFORE A CALL TO FRSTD.',
     -             1,1)
      GO TO 330
  310 K = 1
      IVCTFG = 2
      IF (ISL) 300,50,320
  320 IX = IIX
      IY = IIY
      CALL DRAWPV (IX,IY,1)
      GO TO 300
C
C *************************************
C
C     ENTRY FRSTD (FLDX,FLDY)
C
  330 IX = IIX
      IY = IIY
      IFSTFL = 2
C AVOID UNEXPECTED PEN POSITION IF CALLS TO SYSTEM PLOT PACKAGE
C ROUTINES WERE MADE.
      CALL DRAWPV (IMPOS,IMPOS,2)
      IF (ISL) 300,30,340
  340 CALL DRAWPV (IX,IY,0)
      GO TO 300
C
C *************************************
C
C     ENTRY LASTD
C
  350 CONTINUE
C
C TEST FOR PREVIOUS CALL TO FRSTD
C
      IF (IFSTFL .NE. 2) GO TO 300
      IFSTFL = 1
      K = 1
      IF (ISL .NE. 0) GO TO 300
      GO TO 210
      END
