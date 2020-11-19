*&---------------------------------------------------------------------*
*&  Include           YDS3P_MOCKUP_ALV_CL_SRC
*&---------------------------------------------------------------------*


*&----------------------------------------------------------------------
*& Tela de seleção
*&----------------------------------------------------------------------

SELECTION-SCREEN BEGIN OF SCREEN 1200 AS WINDOW.
SELECT-OPTIONS: matnr FOR mara-matnr,
                matkl FOR mara-matkl.
SELECTION-SCREEN END OF SCREEN 1200.


SELECTION-SCREEN BEGIN OF SCREEN 1201 AS WINDOW.

SELECTION-SCREEN BEGIN OF TABBED BLOCK tab_1201 FOR 8 LINES.
SELECTION-SCREEN TAB (20) tab_c1 USER-COMMAND comm1 DEFAULT SCREEN 1202.
SELECTION-SCREEN TAB (20) tab_c2 USER-COMMAND comm2 DEFAULT SCREEN 1203.
SELECTION-SCREEN END OF BLOCK tab_1201.

SELECTION-SCREEN END OF SCREEN 1201.

SELECTION-SCREEN BEGIN OF SCREEN 1202 AS SUBSCREEN .
SELECT-OPTIONS: 2matkl FOR mara-matkl.
SELECTION-SCREEN END OF SCREEN 1202.


SELECTION-SCREEN BEGIN OF SCREEN 1203 AS SUBSCREEN .
SELECT-OPTIONS: 2matnr FOR mara-matnr.
SELECTION-SCREEN END OF SCREEN 1203.

INITIALIZATION.
  tab_c1 = 'Ordem cenário 01'(101).
  tab_c2 = 'Ordem cenário 02'(102).
  tab_1201-activetab = 'COMM1'.
  tab_1201-dynnr = 1202.

AT SELECTION-SCREEN.
  PERFORM pai_selection_screen.
