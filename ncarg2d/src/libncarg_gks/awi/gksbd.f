C
C	$Id: gksbd.f,v 1.10 1994-07-01 01:20:07 fred Exp $
C
      BLOCKDATA GKSBD
C
      include 'gkscom.h'
C
C
C     DESCRIPTION OF ALL GKS COMMON BLOCKS
C
C-----------------------------------------------------------------------
C
C     GKINTR:  GKS INTERNAL VARIABLES
C
C       NOPWK   -- NUMBER OF CURRENTLY OPEN WORKSTATIONS
C       NACWK   -- NUMBER OF CURRENTLY ACTIVE WORKSTATIONS
C       WCONID  -- CONNECTION IDENTIFIER FOR WISS
C       NUMSEG  -- NUMBER OF SEGMENTS CURRENTLY IN USE
C       SEGS    -- SET OF SEGMENT NAMES CURRENTLY IN USE
C       CURSEG  -- NAME OF CURRENT SEGMENT
C       SEGLEN  -- LENGTH (IN NUMBER OF RECORDS) OF THE ASSOCIATED
C                  SEGMENTS.
C       MXSREC  -- THE NUMBER OF RECORDS IN THE SEGMENT TO PROCESS
C                  IN A COPY TO A WORKSTATION
C       SEGT    -- AN ARRAY OF SEGMENT TRANSFORMATION MATRICES
C       CURTM   -- THE CURRENT SEGMET TRANSFORMATION WHEN COPYING A
C                  SEGMENT
C       SEGDEL  -- FLAG TO INDICATE WHETHER ALL SEGMENTS SHOULD BE
C                  REMOVED AT CLOSE GKS TIME (0 = NO; 1 = YES)
C       RWKSP   -- REAL WORKSPACE ARRAY
C       SEGDEL  -- FLAG TO INDICATE WHETHER GKS CLIPPING IS ON
C                  (0 = NO; 1 = YES)
C-----------------------------------------------------------------------
C
C     GKOPDT:  OPERATING STATE AND DESCRIPTION TABLE VARIABLES
C
C       OPS    --  THE GKS OPERATING STATE
C       KSLEV  --  LEVEL OF GKS
C       WK     --  NUMBER OF AVAILABLE WORKSTATION TYPES
C       LSWK   --  LIST OF AVAILABLE WORKSTATION TYPES
C       MOPWK  --  MAXIMUM NUMBER OF SIMULTANEOUSLY OPEN WORKSTATIONS
C       MACWK  --  MAXIMUM NUMBER OF SIMULTANEOUSLY ACTIVE WORKSTATIONS
C       MNT    --  MAXIMUM NORMALIZATION TRANSFORMATION NUMBER
C-----------------------------------------------------------------------
C
C     GKSTAT: GKS STATE LIST VARIABLES--
C       SOPWK  -- SET OF OPEN WORKSTATIONS
C       SACWK  -- SET OF ACTIVE WORKSTATIONS
C       CPLI   -- CURRENT POLYLINE INDEX
C       CLN    -- CURRENT LINETYPE
C       CLWSC  -- CURRENT LINEWIDTH SCALE FACTOR
C       CPLCI  -- CURRENT POLYLINE COLOR INDEX
C       CLNA   -- CURRENT LINETYPE ASF
C       CLWSCA -- CURRENT LINEWIDTH SCALE FACTOR ASF
C       CPLCIA -- CURRENT POLYLINE COLOR INDEX ASF
C       CPMI   -- CURRENT POLYMARKER INDEX
C       CMK    -- CURRENT MARKER TYPE
C       CMKS   -- CURRENT MARKER SIZE SCALE FACTOR
C       CPMCI  -- CURRENT POLYMARKER COLOR INDEX
C       CMKA   -- CURRENT MARKER TYPE ASPECT SOURCE FLAG
C       CMKSA  -- CURRENT MARKER SIZE SCALE FACTOR ASF
C       CPMCIA -- CURRENT POLYMARKER COLOR INDEX ASF
C       CTXI   -- CURRENT TEXT INDEX
C       CTXFP  -- CURRENT TEXT FONT AND PRECISION
C       CCHXP  -- CURRENT CHARACTER EXPANSION FACTOR
C       CCHSP  -- CURRENT CHARACTER SPACING
C       CTXCI  -- CURRENT TEXT COLOR INDEX
C       CTXFPA -- CURRENT TEXT FONT AND PRECISION ASF
C       CCHXPA -- CURRENT CHARACTER EXPANSION FACTOR ASF
C       CCHSPA -- CURRENT CHARACTER SPACING ASF
C       CTXCIA -- CURRENT TEXT COLOR INDEX ASF
C       CCHH   -- CURRENT CHARACTER HEIGHT
C       CCHUP  -- CURRENT CHARACTER UP VECTOR
C       CTXP   -- CURRENT TEXT PATH
C       CTXAL  -- CURRENT TEXT ALIGNMENT
C       CFAI   -- CURRENT FILL AREA INDEX
C       CFAIS  -- CURRENT FILL AREA INTERIOR STYLE
C       CFASI  -- CURRENT FILL AREA STYLE INDEX
C       CFACI  -- CURRENT FILL AREA COLOR INDEX
C       CFAISA -- CURRENT FILL AREA INTERIOR STYLE ASF
C       CFASIA -- CURRENT FILL AREA STYLE INDEX ASF
C       CFACIA -- CURRENT FILL AREA COLOR INDEX ASF
C       CPA    -- CURRENT PATTERN SIZE
C       CPARF  -- CURRENT PATTERN REFERENCE POINT
C       CNT    -- CURRENT NORMALIZATION TRANSFORMATION NUMBER
C       LSNT   -- LIST OF NORMALIZATION TRANSFORMATIONS (ORDERED
C                 BY VIEWPORT INPUT PRIORITY)
C       NTWN   -- NORMALIZATION TRANSFORMATION WINDOWS
C       NTVP   -- NORMALIZATION TRANSFORMATION VIEWPORTS
C       CCLIP  -- CURRENT CLIPPING INDICATOR
C       SWKTP  -- SET OF WORKSTATION TYPES ASSOCIATED WITH THE
C                 OPEN WORKSTATIONS
C       NOPICT -- FLAG TO INDICATE NO PICTURE ELEMENTS HAVE BEEN
C                 ISSUED FOR THE CURRENT PICTURE
C       NWKTP  -- WORKSTATION TYPE
C       LXWKID -- LOCAL X WINDOW WKID RETRIEVED FROM THE X DRIVER
C                 AT OPEN WORKSTATION TIME
C       ECONID -- THE WINDOW ID FOR WORKSTATIONS OF TYPE GXWE (EXISTING
C                 X WINDOW).  THIS VALUE IS SUPPLIED VIA THE CONNECTION
C                 ID AT OPEN WORKSTATION TIME.
C       CLLX   -- LOWER LEFT X COORDINATE FOR POSITIONING PICTURE ON PAGE
C       CLLY   -- LOWER LEFT Y COORDINATE FOR POSITIONING PICTURE ON PAGE
C       CURX   -- UPPER RIGHT X COORDINATE FOR POSITIONING PICTURE ON PAGE
C       CURY   -- UPPER RIGHT Y COORDINATE FOR POSITIONING PICTURE ON PAGE
C       CPSCL  -- SCALE FACTOR FOR POSTSCRIPT WORKSTATIONS
C-----------------------------------------------------------------------
C
C     GKEROR:  GKS ERROR STATE LIST
C       ERS    --  ERROR STATE
C       ERF    --  ERROR FILE
C       CUFLAG --  A UTILITY FLAG THAT IS USED TO MARK THAT A PARTICULAR 
C                  WORKSTATION IS BEING ADDRESSED IN THE INTERFACE.  IF 
C                  CUFLAG IS POSITIVE, THEN IT IS EQUAL TO THE 
C                  WORKSTATION ID OF THE PARTICULAR WORKSTATION FOR 
C                  WHICH INSTRUCTIONS ARE TARGETED; IF CUFLAG = -1, THEN 
C                  INSTRUCTIONS SHOULD GO TO ALL APPROPRIAT WORKSTATIONS.
C       MXERMG --  MAXIMUM NUMBER OF ERROR MESSAGES TO ISSUE BEFORE ABORT
C                   
C-----------------------------------------------------------------------
C
C     GKETBI:
C       IERNMS --  AN ARRAY CONTAINING THE NCAR GKS ERROR NUMERS
C     GKETBC:
C       ERMSGS --  AN ARRAY CONTAINING THE NCAR GKS ERROR MESSAGE STRINGS     
C-----------------------------------------------------------------------
C
C     GKENUM: GKS ENUMERATION TYPE VARIABLES
C       GBUNDL -- BUNDLED
C       GINDIV -- INDIVIDUAL
C       GGKCL  -- GKS CLOSED
C       GGKOP  -- GKS OPEN
C       GWSOP  -- WORKSTATION OPEN
C       GWSAC  -- WORKSTATION ACTIVE
C       GSGOP  -- SEGMENT OPEN
C       GOUTPT -- OUTPUT WORKSTATION
C       GINPUT -- INPUT WORKSTATION
C       GOUTIN -- OUTPUT/INPUT WORKSTATION
C       GWISS  -- WORKSTATION INDEPENDENT SEGMENT STORAGE
C       GMO    -- METAFILE OUTPUT WORKSTATION
C       GMI    -- METAFILE INPUT WORKSTATION
C       GCGM   -- WORKSTATION TYPE CGM
C       GWSS   -- WORKSTATION TYPE WISS
C       GXWE   -- WORKSTATION TYPE EXISTING COLOUR X WINDOW
C       GXWC   -- WORKSTATION TYPE COLOUR X WINDOW
C       GPSMIN -- MINIMUM TYPE FOR THE POSTSCRIPT DRIVERS
C       GPSMAX -- MAXIMUM TYPE FOR THE POSTSCRIPT DRIVERS
C
C-----------------------------------------------------------------------
C
C     GKSNAM: NAMES
C
C       GNAM   -- ARRAY OF GKS FUNCTION NAMES IS AS PER THE BINDING
C       SEGNAM -- FILE NAMES ASSOCIATED WITH THE SEGMENT NUMBERS IN
C                 VARIABLE SEGS
C       GFNAME -- FILENAME FOR MO WORKSTATIONS
C
C-----------------------------------------------------------------------
C
C     GKSIN1 & GKSIN2: WORKSTATION INTERFACE COMMON BLOCKS
C
C       FCODE  -- FUNCTION CODE FOR THE CURRENT INSTRUCTION
C       CONT   -- CONTINUATION FLAG (1 MEANS MORE TO COME; 0 MEANS LAST)
C       IL1    -- TOTAL NUMBER OF ELEMENTS TO BE PASSED IN THE ID
C                 ARRAY FOR THE CURRENT INSTRUCTION
C       IL2    -- NUMBER OF ELEMENTS IN THE ID ARRAY FOR THE GIVEN
C                 WORKSTATION INTERFACE INVOCATION
C       ID     -- ARRAY FOR PASSING INTEGERS
C       IC1    -- TOTAL NUMBER OF ELEMENTS TO BE PASSED IN THE IC
C                 ARRAY FOR THE CURRENT INSTRUCTION
C       IC2    -- NUMBER OF ELEMENTS IN THE IC ARRAY FOR THE GIVEN
C                 WORKSTATION INTERFACE INVOCATION
C       IC     -- ARRAY FOR PASSING COLOR INDICES
C       RL1    -- TOTAL NUMBER OF ELEMENTS TO BE PASSED IN THE RX AND
C                 RY ARRAYS FOR THE CURRENT INSTRUCTION
C       RL2    -- NUMBER OF ELEMENTS IN THE RX AND RY ARRAYS FOR THE
C                 GIVEN WORKSTATION INTERFACE INVOCATION
C       RX     -- ARRAY FOR PASSING REAL X COORDINATE VALUES
C       RY     -- ARRAY FOR PASSING REAL Y COORDINATE VALUES
C       STRL1  -- TOTAL NUMBER OF CHARACTERS TO BE PASSED IN THE
C                 CHARACTER VARIABLE STR FOR THE CURRENT INSTRUCTION
C       STRL2  -- NUMBER OF CHARACTERS IN THE CHARACTER VARIABLE STR
C                 FOR THE CURRENT INVOCATION OF THE WORKSTATION
C                 INTERFACE
C       RERR   -- RETURN VARIABLE FOR ERROR INDICATOR
C       STR    -- CHARACTER VARIABLE FOR PASSING CHARACTERS
C
C-----------------------------------------------------------------------
      DATA KSLEV,WK/0, 17/
      DATA LSWK/  1, 3, 7, 8,10,20,21,22,23,24,25,26,27,28,29,30,31/
      DATA MOPWK,MACWK,MNT
     +    /   15,   15,  1/
      DATA OPS/0/
      DATA ERS,ERF,CUFLAG,MXERMG/0,6,-1,10/
      DATA GBUNDL,GINDIV/0,1/
      DATA GGKCL,GGKOP,GWSOP,GWSAC,GSGOP/0,1,2,3,4/
      DATA GOUTPT,GINPUT,GOUTIN,GWISS,GMO,GMI/0,1,2,3,4,5/
      DATA GCGM,GWSS,GXWE,GXWC,GDMP,GPSMIN,GPSMAX/1,3,7,8,10,20,31/       
      DATA NOPWK,NACWK,NUMSEG,CURSEG,SEGDEL,GKSCLP/0,0,0,-1,1,1/
      DATA NOPICT/-1/
      DATA GFNAME/'DEFAULT'/
      DATA CLLX,CLLY,CURX,CURY,CPSCL/-1,-1,-1,-1,-1/
C
      DATA IERNMS/    1,    2,    3,    4,    5,    6,    7,    8,
     +               20,   21,   22,   23,   24,   25,   26,   27,
     +               28,   29,   30,   32,   33,   34,   35,   36,
     +               38,   50,   51,   52,   53,   54,   60,   63,
     +               65,   66,   69,   72,   75,   77,   78,   79,
     +               80,   84,   85,   87,   91,   92,   93,   96,
     +              100,  101,  102,  103,  120,  121,  122,  124,
     +              160,  161,  162,  163,  165,  166,  167,  168,
     +              180,  182,  300,  302,  303,  304,  305,  306,
     +              307,  308, 2000, 2001, 2002, 2003, -100, -101,
     +             -102, -103, -105, -106, -107, -108, -109, -110,
     +             -111, -112, -200, -201, -202, -203, -204, -205,
     +             -206, -207, -208, -209, -210, -211, -212, -213,
     +             -214, -215, -216, -300, -301, -302, -303, -217,
     +             -218, -219, -220, 2200, 2201, 2202, 2203, 2204,
     +               90                                           /
      DATA ERMSGS(  1)/' --GKS NOT IN PROPER STATE: GKS SHALL BE IN STAT
     +E GKCL'/
      DATA ERMSGS(  2)/' --GKS NOT IN PROPER STATE: GKS SHALL BE IN STAT
     +E GKOP'/
      DATA ERMSGS(  3)/' --GKS NOT IN PROPER STATE: GKS SHALL BE IN STAT
     +E WSAC'/
      DATA ERMSGS(  4)/' --GKS NOT IN PROPER STATE: GKS SHALL BE IN STAT
     +E SGOP'/
      DATA ERMSGS(  5)/' --GKS NOT IN PROPER STATE: GKS SHALL BE EITHER 
     +IN THE STATE WSAC OR IN THE STATE SGOP'/
      DATA ERMSGS(  6)/' --GKS NOT IN PROPER STATE: GKS SHALL BE EITHER 
     +IN THE STATE WSOP OR IN THE STATE WSAC'/
      DATA ERMSGS(  7)/' --GKS NOT IN PROPER STATE: GKS SHALL BE IN ONE 
     +OF THE STATES  WSOP, WSAC, OR SGOP'/
      DATA ERMSGS(  8)/' --GKS NOT IN PROPER STATE: GKS SHALL BE IN ONE 
     +OF THE STATES  GKOP, WSOP, WSAC, OR SGOP'/
      DATA ERMSGS(  9)/' --SPECIFIED WORKSTATION IDENTIFIER IS INVALID  
     +'/
      DATA ERMSGS( 10)/' --SPECIFIED CONNECTION IDENTIFIER IS INVALID'/
      DATA ERMSGS( 11)/' --SPECIFIED WORKSTATION TYPE IS INVALID'/
      DATA ERMSGS( 12)/' --SPECIFIED WORKSTATION TYPE DOES NOT EXIST'/
      DATA ERMSGS( 13)/' --SPECIFIED WORKSTATION IS OPEN'/
      DATA ERMSGS( 14)/' --SPECIFIED WORKSTATION IS NOT OPEN'/
      DATA ERMSGS( 15)/' --SPECIFIED WORKSTATION CANNOT BE OPENED'/
      DATA ERMSGS( 16)/' --WORKSTATION INDEPENDENT SEGMENT STORAGE IS NO       
     +T OPEN'/
      DATA ERMSGS( 17)/' --WORKSTATION INDEPENDENT SEGMENT STORAGE IS AL
     +READY OPEN'/
      DATA ERMSGS( 18)/' --SPECIFIED WORKSTATION IS ACTIVE'/
      DATA ERMSGS( 19)/' --SPECIFIED WORKSTATION IS NOT ACTIVE'/
      DATA ERMSGS( 20)/' --SPECIFIED WORKSTATION IS NOT OF CATEGORY MO'/
      DATA ERMSGS( 21)/' --SPECIFIED WORKSTATION IS OF CATEGORY MI'/
      DATA ERMSGS( 22)/' --SPECIFIED WORKSTATION IS NOT OF CATEGORY MI'/
      DATA ERMSGS( 23)/' --SPECIFIED WORKSTATION IS OF CATEGORY INPUT'/
      DATA ERMSGS( 24)/' --SPECIFIED WORKSTATION IS WORKSTATION INDEPEND       
     +ENT SEGMENT STORAGE'/
      DATA ERMSGS( 25)/' --SPECIFIED WORKSTATION IS NEITHER OF CATEGORY 
     +INPUT NOR OF CATEGORY OUTIN'/
      DATA ERMSGS( 26)/' --TRANSFORMATION NUMBER IS INVALID'/
      DATA ERMSGS( 27)/' --RECTANGLE DEFINITION IS INVALID'/
      DATA ERMSGS( 28)/' --VIEWPORT IS NOT WITHIN THE NORMALIZED DEVICE 
     +COORDINATE UNIT SQUARE'/
      DATA ERMSGS( 29)/' --WORKSTATION WINDOW IS NOT WITHIN THE NORMALIZ
     +ED DEVICE COORDINATE UNIT SQUARE'/
      DATA ERMSGS( 30)/' --WORKSTATION VIEWPORT IS NOT WITHIN THE DISPLA
     +Y SPACE'/
      DATA ERMSGS( 31)/' --POLYLINE INDEX IS INVALID'/
      DATA ERMSGS( 32)/' --LINETYPE IS LESS THAN OR EQUAL TO ZERO'/
      DATA ERMSGS( 33)/' --LINEWIDTH SCALE FACTOR IS LESS THAN ZERO'/
      DATA ERMSGS( 34)/' --POLYMARKER INDEX IS INVALID'/
      DATA ERMSGS( 35)/' --MARKER TYPE IS LESS THAN OR EQUAL TO ZERO'/
      DATA ERMSGS( 36)/' --TEXT INDEX IS INVALID'/
      DATA ERMSGS( 37)/' --TEXT FONT IS EQUAL TO ZERO'/
      DATA ERMSGS( 38)/' --CHARACTER EXPANSION FACTOR IS LESS THAN OR EQ
     +UAL TO ZERO'/
      DATA ERMSGS( 39)/' --CHARACTER HEIGHT IS LESS THAN OR EQUAL TO ZER
     +O'/
      DATA ERMSGS( 40)/' --LENGTH OF CHARACTER UP VECTOR IS ZERO'/
      DATA ERMSGS( 41)/' --FILL AREA INDEX IS INVALID'/
      DATA ERMSGS( 42)/' --STYLE (PATTERN OR HATCH) INDEX IS LESS THAN O
     +R EQUAL TO ZERO'/
      DATA ERMSGS( 43)/' --SPECIFIED PATTERN INDEX IS INVALID'/
      DATA ERMSGS( 44)/' --PATTERN SIZE VALUE IS NOT POSITIVE'/
      DATA ERMSGS( 45)/' --DIMENSIONS OF COLOR ARRAY ARE INVALID'/
      DATA ERMSGS( 46)/' --COLOR INDEX IS LESS THAN ZERO'/
      DATA ERMSGS( 47)/' --COLOR INDEX IS INVALID'/
      DATA ERMSGS( 48)/' --COLOR IS OUTSIDE RANGE ZERO TO ONE INCLUSIVE'
     +/      
      DATA ERMSGS( 49)/' --NUMBER OF POINTS IS INVALID'/
      DATA ERMSGS( 50)/' --INVALID CODE IN STRING'/
      DATA ERMSGS( 51)/' --GENERALIZED DRAWING PRIMITIVE IDENTIFIER IS I       
     +NVALID'/
      DATA ERMSGS( 52)/' --CONTENT OF GENERALIZED DRAWING PRIMITIVE DATA
     + RECORD IS INVALID'/
      DATA ERMSGS( 53)/' --SPECIFIED SEGMENT NAME IS INVALID'/
      DATA ERMSGS( 54)/' --SPECIFIED SEGMENT NAME IS ALREADY IN USE'/
      DATA ERMSGS( 55)/' --SPECIFIED SEGMENT DOES NOT EXIST'/
      DATA ERMSGS( 56)/' --SPECIFIED SEGMENT DOES NOT EXIST ON WORKSTATI
     +ON INDEPENDENT SEGMENT STORAGE'/
      DATA ERMSGS( 57)/' --ITEM TYPE IS NOT ALLOWED FOR USER ITEMS'/
      DATA ERMSGS( 58)/' --ITEM LENGTH IS INVALID'/
      DATA ERMSGS( 59)/' --NO ITEM IS LEFT IN GKS METAFILE INPUT'/
      DATA ERMSGS( 60)/' --METAFILE ITEM IS INVALID'/
      DATA ERMSGS( 61)/' --CONTENT OF ITEM DATA RECORD IS INVALID FOR TH
     +E SPECIFIED ITEM TYPE'/
      DATA ERMSGS( 62)/' --MAXIMUM ITEM DATA RECORD LENGTH IS INVALID'/
      DATA ERMSGS( 63)/' --USER ITEM CANNOT BE INTERPRETED'/
      DATA ERMSGS( 64)/' --SPECIFIED FUNCTION IS NOT SUPPORTED IN THIS L
     +EVEL OF GKS'/
      DATA ERMSGS( 65)/' --SPECIFIED ESCAPE FUNCTION IS NOT SUPPORTED'/
      DATA ERMSGS( 66)/' --CONTENTS OF ESCAPE DATA RECORD ARE INVALID'/
      DATA ERMSGS( 67)/' --STORAGE OVERFLOW HAS OCCURRED IN GKS'/
      DATA ERMSGS( 68)/' --INPUT/OUTPUT ERROR HAS OCCURRED WHILE READING
     +'/     
      DATA ERMSGS( 69)/' --INPUT/OUTPUT ERROR HAS OCCURRED WHILE WRITING
     +'/
      DATA ERMSGS( 70)/' --INPUT/OUTPUT ERROR HAS OCCURRED WHILE SENDING
     + DATA TO A WORKSTATION'/
      DATA ERMSGS( 71)/' --INPUT/OUTPUT ERROR HAS OCCURRED WHILE RECEIVI
     +NG DATA FROM A WORKSTATION'/
      DATA ERMSGS( 72)/' --INPUT/OUTPUT ERROR HAS OCCURRED DURING PROGRA
     +M LIBRARY MANAGEMENT'/
      DATA ERMSGS( 73)/' --INPUT/OUTPUT ERROR HAS OCCURRED WHILE READING
     + WORKSTATION DESCRIPTION TABLE'/
      DATA ERMSGS( 74)/' --ARITHMETIC ERROR HAS OCCURRED'/
      DATA ERMSGS( 75)/' --ENUMERATION TYPE OUT OF RANGE'/
      DATA ERMSGS( 76)/' --OUTPUT PARAMETER SIZE INSUFFICIENT'/
      DATA ERMSGS( 77)/' --LIST OR SET ELEMENT NOT AVAILABLE'/
      DATA ERMSGS( 78)/' --INVALID DATA RECORD'/
      DATA ERMSGS( 79)/' --UNKNOWN ERROR CODE'/
      DATA ERMSGS( 80)/' --NO ADDITIONAL WORKSTATIONS MAY BE ACTIVATED'/       
      DATA ERMSGS( 81)/' --GKS SYSTEM ERROR--IMPROPER CONTINUATION SEQUE
     +NCE'/
      DATA ERMSGS( 82)/' --THE NCAR GKS IMPLEMENTATION REQUIRES THAT WIS
     +S BE ACTIVE BEFORE A SEGMENT IS CREATED'/
      DATA ERMSGS( 83)/' --ERROR OPENING DISK FILE'/
      DATA ERMSGS( 84)/' --LOGICAL UNIT NUMBER FOR SEGMENT STORAGE CANNO
     +T BE THE SAME AS THAT FOR METAFILE OUTPUT'/
      DATA ERMSGS( 85)/' --MAXIMUM NUMBER OF ERROR MESSAGES EXCEEDED'/
      DATA ERMSGS( 86)/' --ILLEGAL PLACEMENT OF A CALL TO ASSIGN A PICTU
     +RE NAME'/
      DATA ERMSGS( 87)/' --THIS FUNCTION NOT YET IMPLEMENTED FOR WORKSTA
     +TIONS OF CATEGORY OUTPUT'/
      DATA ERMSGS( 88)/' --CHARACTER STRING TOO LARGE'/
      DATA ERMSGS( 89)/' --SYSTEM ERROR'/
      DATA ERMSGS( 90)/' --ONLY ONE METAFILE WORKSTATION CAN BE OPEN AT 
     +A TIME'/
      DATA ERMSGS( 91)/' --X driver error: memory allocation in processi
     +ng a character from a fontcap'/
      DATA ERMSGS( 92)/' --X driver error: error opening fontcap'/
      DATA ERMSGS( 93)/' --X driver error: error reading fontcap'/
      DATA ERMSGS( 94)/' --X driver warning: invalid font index, using t
     +he default font'/
      DATA ERMSGS( 95)/' --X driver error: memory allocation error in cr
     +eating device table'/
      DATA ERMSGS( 96)/' --X driver error: too many open devices'/
      DATA ERMSGS( 97)/' --X driver error: error in internal memory mana
     +gement'/
      DATA ERMSGS( 98)/' --X driver error: error in allocating memory fo
     +r device dependent table'/
      DATA ERMSGS( 99)/' --X driver error: DISPLAY environment variable 
     +not set'/
      DATA ERMSGS(100)/' --X driver error: error opening display'/
      DATA ERMSGS(101)/' --X driver error: error getting window attribut
     +es'/
      DATA ERMSGS(102)/' --X driver error: error creating pixmap'/
      DATA ERMSGS(103)/' --X driver error: cell array has zero width or 
     +height'/
      DATA ERMSGS(104)/' --X driver error: memory allocation error in pr
     +ocessing cell array'/
      DATA ERMSGS(105)/' --X driver error: error creating X image'/
      DATA ERMSGS(106)/' --X driver error: memory allocation error in cr
     +eating X image'/
      DATA ERMSGS(107)/' --X driver error: pixel size must be byte multi
     +ple'/
      DATA ERMSGS(108)/' --PostScript error: Encapsulated PostScript can
     + have only one page'/
      DATA ERMSGS(109)/' --PostScript error: error in allocating memory 
     +for device dependent table'/
      DATA ERMSGS(110)/' --PostScript error: error opening output file'/
      DATA ERMSGS(111)/' --PostScript warning: requested character not a
     +vailable, asterisk plotted, use Plotchar'/
      DATA ERMSGS(112)/' --X driver error: error in retrieving fontcap n
     +ame'/
      DATA ERMSGS(113)/' --X driver error: invalid index into GKS workst
     +ation identifiers'/
      DATA ERMSGS(114)/' --X driver error: color index exceeds maximum a
     +llowed'/
      DATA ERMSGS(115)/' --X driver warning: color allocated is differen
     +t from the color requested'/
      DATA ERMSGS(116)/' --C-binding specific error: buffer overflow in 
     +input or inquiry function'/
      DATA ERMSGS(117)/' --C-binding specific error: start index out of 
     +range'/
      DATA ERMSGS(118)/' --C-binding specific error: enumeration type ou
     +t of range'/
      DATA ERMSGS(119)/' --C-binding specific error: length of list is n
     +egative'/
      DATA ERMSGS(120)/' --C-binding specific error: cannot allocate mem
     +ory'/
      DATA ERMSGS(121)/' --INTERIOR STYLE PATTERN IS NOT SUPPORTED ON TH
     +IS WORKSTATION'/
C
      DATA GNAM(001),GNAM(002),GNAM(003)/'GOPKS' ,'GCLKS' ,'GOPWK' /
      DATA GNAM(004),GNAM(005),GNAM(006)/'GCLWK' ,'GACWK' ,'GDAWK' /
      DATA GNAM(007),GNAM(008),GNAM(009)/'GCLRWK','GRSGWK','GUWK'  /
      DATA GNAM(010),GNAM(011),GNAM(012)/'GSDS'  ,'GMSG'  ,'GESC'  /
      DATA GNAM(013),GNAM(014),GNAM(015)/'GPL'   ,'GPM'   ,'GTX'   /
      DATA GNAM(016),GNAM(017),GNAM(018)/'GFA'   ,'GCA'   ,'GGDP'  /
      DATA GNAM(019),GNAM(020),GNAM(021)/'GSPLI' ,'GSLN'  ,'GLSWSC'/
      DATA GNAM(022),GNAM(023),GNAM(024)/'GSPLCI','GSPMI' ,'GSMK'  /
      DATA GNAM(025),GNAM(026),GNAM(027)/'GSMKSC','GSPMCI','GSTXI' /
      DATA GNAM(028),GNAM(029),GNAM(030)/'GSTXFP','GSCHXP','GSCHSP'/
      DATA GNAM(031),GNAM(032),GNAM(033)/'GSTXCI','GSCHH' ,'GSCHUP'/
      DATA GNAM(034),GNAM(035),GNAM(036)/'GSTXP' ,'GSTXAL','GSFAI' /
      DATA GNAM(037),GNAM(038),GNAM(039)/'GSFAIS','GSFASI','GSFACI'/
      DATA GNAM(040),GNAM(041),GNAM(042)/'GSPA'  ,'GSPARF','GSASF' /
      DATA GNAM(043),GNAM(044),GNAM(045)/'GSPKID','GSPLR' ,'GSPMR' /
      DATA GNAM(046),GNAM(047),GNAM(048)/'GSTXR' ,'GSFAR' ,'GSPAR' /
      DATA GNAM(049),GNAM(050),GNAM(051)/'GSCR'  ,'GSWN'  ,'GSVP'  /
      DATA GNAM(052),GNAM(053),GNAM(054)/'GSVPIP','GSELNT','GSCLIP'/
      DATA GNAM(055),GNAM(056),GNAM(057)/'GSWKWN','GSWKVP','GCRSG' /
      DATA GNAM(058),GNAM(059),GNAM(060)/'GCLSG' ,'GRENSG','GDSG'  /
      DATA GNAM(061),GNAM(062),GNAM(063)/'GDSGWK','GASGWK','GCSGWK'/
      DATA GNAM(064),GNAM(065),GNAM(066)/'GINSG' ,'GSSGT' ,'GSVIS' /
      DATA GNAM(067),GNAM(068),GNAM(069)/'GSHLIT','GSSGP' ,'GSDTEC'/
      DATA GNAM(070),GNAM(071),GNAM(072)/'GINLC' ,'GINSK' ,'GINVL' /
      DATA GNAM(073),GNAM(074),GNAM(075)/'GINCH' ,'GINPK' ,'GINST' /
      DATA GNAM(076),GNAM(077),GNAM(078)/'GSLCM' ,'GSSKM' ,'GSVLM' /
      DATA GNAM(079),GNAM(080),GNAM(081)/'GSCHM' ,'GSPKM' ,'GSSTM' /
      DATA GNAM(082),GNAM(083),GNAM(084)/'GRQLC' ,'GRQSK' ,'GRQVL' /
      DATA GNAM(085),GNAM(086),GNAM(087)/'GRQCH' ,'GRQPK' ,'GRQST' /
      DATA GNAM(088),GNAM(089),GNAM(090)/'GSMLC' ,'GSMSK' ,'GSMVL' /
      DATA GNAM(091),GNAM(092),GNAM(093)/'GSMCH' ,'GSMPK' ,'GSMST' /
      DATA GNAM(094),GNAM(095),GNAM(096)/'GWAIT' ,'GFLUSH','GGTLC' /
      DATA GNAM(097),GNAM(098),GNAM(099)/'GGTSK' ,'GGTVL' ,'GGTCH' /
      DATA GNAM(100),GNAM(101),GNAM(102)/'GGTPK' ,'GGTST' ,'GWITM' /
      DATA GNAM(103),GNAM(104),GNAM(105)/'GGTITM','GRDITM','GIITM' /
      DATA GNAM(106),GNAM(107),GNAM(108)/'GEVTM' ,'GACTM' ,'GPREC' /
      DATA GNAM(109)                    /'GUREC'                   /
      END
