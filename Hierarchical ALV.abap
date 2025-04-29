REPORT ZPRG4_ALV.

TYPES: BEGIN OF lty_vbak,
  VBELN TYPE VBELN_VA,
  ERDAT TYPE ERDAT,
  ERZET TYPE ERZET,
  ERNAM TYPE ERNAM,
  VBTYP TYPE VBTYP,
  end of lty_vbak.

DATA int_table type TABLE OF lty_vbak.
DATA warea TYPE lty_vbak.

TYPES: BEGIN OF lty_vbap,
  VBELN TYPE VBELN_VA,
  POSNR TYPE POSNR_VA,
  MATNR TYPE MATNR,
  end of lty_vbap.

DATA int_table1 type  TABLE OF lty_vbap.
data warea1 type lty_vbap.
DATA LV_FIELDCAT TYPE SLIS_T_FIELDCAT_ALV.
DATA : LS_FIELDCAT TYPE slis_fieldcat_alv.
DATA  LS_KEYINFO TYPE slis_keyinfo_alv.



data lv_vbeln TYPE VBELN_VA.

SELECT-OPTIONS : s_vbeln for lv_vbeln.

SELECT VBELN ERDAT ERZET ERNAM VBTYP
from vbak
into table int_table
where VBELN in s_vbeln.

if int_table is not initial.
select  VBELN POSNR  MATNR
from VBAP
INTO TABLE int_table1
for all ENTRIES IN int_table
where VBELN = int_table-VBELN.
ENDIF.

LS_FIELDCAT-col_pos = '1'.
LS_FIELDCAT-fieldname = 'VBELN'.
LS_FIELDCAT-tabname = 'LT_VBAK'.
LS_FIELDCAT-seltext_L = 'Sales Document Number'.
APPEND LS_FIELDCAT TO  LV_FIELDCAT.
CLEAR LS_FIELDCAT.

LS_KEYINFO-HEADER01 = 'VBELN'.
LS_KEYINFO-ITEM01 = 'VBELN'.

LS_FIELDCAT-col_pos = '2'.
LS_FIELDCAT-fieldname = 'ERDAT'.
LS_FIELDCAT-tabname = 'LT_VBAK'.
LS_FIELDCAT-seltext_L = ' CRAEATION DATE '.
APPEND LS_FIELDCAT TO  LV_FIELDCAT.
CLEAR LS_FIELDCAT.

LS_FIELDCAT-col_pos = '3'.
LS_FIELDCAT-fieldname = 'ERZET'.
LS_FIELDCAT-tabname = 'LT_VBAK'.
LS_FIELDCAT-seltext_L = 'TIME'.
APPEND LS_FIELDCAT TO  LV_FIELDCAT.
CLEAR LS_FIELDCAT.

LS_FIELDCAT-col_pos = '4'.
LS_FIELDCAT-fieldname = 'ERNAM'.
LS_FIELDCAT-tabname = 'LT_VBAK'.
LS_FIELDCAT-seltext_L = 'USER'.
APPEND LS_FIELDCAT TO  LV_FIELDCAT.
CLEAR LS_FIELDCAT.

LS_FIELDCAT-col_pos = '1'.
LS_FIELDCAT-fieldname = 'VBELN'.
LS_FIELDCAT-tabname = 'LT_VBAP'.
LS_FIELDCAT-seltext_L = 'SALES DOCUMENT NUMBER '.
APPEND LS_FIELDCAT TO  LV_FIELDCAT.
CLEAR LS_FIELDCAT.

LS_FIELDCAT-col_pos = '2'.
LS_FIELDCAT-fieldname = 'POSNR'.
LS_FIELDCAT-tabname = 'LT_VBAP'.
LS_FIELDCAT-seltext_L = 'ITEM NUMBER'.
APPEND LS_FIELDCAT TO  LV_FIELDCAT.
CLEAR LS_FIELDCAT.

LS_FIELDCAT-col_pos = '3'.
LS_FIELDCAT-fieldname = 'MATNR'.
LS_FIELDCAT-tabname = 'LT_VBAP'.
LS_FIELDCAT-seltext_L = 'MATERIAL NUMBER'.
APPEND LS_FIELDCAT TO  LV_FIELDCAT.
CLEAR LS_FIELDCAT.


CALL FUNCTION 'REUSE_ALV_HIERSEQ_LIST_DISPLAY'
  EXPORTING
*   I_INTERFACE_CHECK              = ' '
*   I_CALLBACK_PROGRAM             =
*   I_CALLBACK_PF_STATUS_SET       = ' '
*   I_CALLBACK_USER_COMMAND        = ' '
*   IS_LAYOUT                      =
   IT_FIELDCAT                    = LV_FIELDCAT
*   IT_EXCLUDING                   =
*   IT_SPECIAL_GROUPS              =
*   IT_SORT                        =
*   IT_FILTER                      =
*   IS_SEL_HIDE                    =
*   I_SCREEN_START_COLUMN          = 0
*   I_SCREEN_START_LINE            = 0
*   I_SCREEN_END_COLUMN            = 0
*   I_SCREEN_END_LINE              = 0
*   I_DEFAULT                      = 'X'
*   I_SAVE                         = ' '
*   IS_VARIANT                     =
*   IT_EVENTS                      =
*   IT_EVENT_EXIT                  =
    I_TABNAME_HEADER               = 'LT_VBAK'
    I_TABNAME_ITEM                 = 'LT-VBAP'
*   I_STRUCTURE_NAME_HEADER        =
*   I_STRUCTURE_NAME_ITEM          =
    IS_KEYINFO                     =  LS_KEYINFO
*   IS_PRINT                       =
*   IS_REPREP_ID                   =
*   I_BYPASSING_BUFFER             =
*   I_BUFFER_ACTIVE                =
*   IR_SALV_HIERSEQ_ADAPTER        =
*   IT_EXCEPT_QINFO                =
*   I_SUPPRESS_EMPTY_DATA          = ABAP_FALSE
* IMPORTING
*   E_EXIT_CAUSED_BY_CALLER        =
*   ES_EXIT_CAUSED_BY_USER         =
  TABLES
    T_OUTTAB_HEADER                = int_table
    T_OUTTAB_ITEM                  = int_table1.
* EXCEPTIONS
*   PROGRAM_ERROR                  = 1
*   OTHERS                         = 2
          .
IF SY-SUBRC <> 0.
* Implement suitable error handling here
ENDIF.