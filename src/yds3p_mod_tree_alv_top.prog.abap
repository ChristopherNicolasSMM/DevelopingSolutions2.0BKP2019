*&---------------------------------------------------------------------*
*&  Include           YDS3P_MOD_TREE_ALV_TOP
*&---------------------------------------------------------------------*

*&----------------------------------------------------------------------
*& Tabelas
*&----------------------------------------------------------------------

*&----------------------------------------------------------------------
*& Tipos
*&----------------------------------------------------------------------

*&----------------------------------------------------------------------
*& Estruturas
*&----------------------------------------------------------------------

*&----------------------------------------------------------------------
*& Tabela Interna
*&----------------------------------------------------------------------

*&----------------------------------------------------------------------
*& Constantes
*&----------------------------------------------------------------------

*&----------------------------------------------------------------------
*& Variáveis
*&----------------------------------------------------------------------

DATA: g_tree             TYPE REF TO cl_gui_alv_tree,
      g_custom_container TYPE REF TO cl_gui_custom_container,
      g_change_menu      TYPE REF TO cl_ctmenu,
      gt_sflight         TYPE TABLE OF sflight,
      gt_outtab          TYPE TABLE OF sflight,
      gt_fieldcatalog    TYPE lvc_t_fcat, "Fieldcatalog
      ok_code            LIKE sy-ucomm,   "OK-Code
      save_ok            LIKE sy-ucomm.

*&----------------------------------------------------------------------
*& Classes
*&----------------------------------------------------------------------

CLASS cl_gui_column_tree DEFINITION LOAD.
CLASS cl_gui_cfw DEFINITION LOAD.

*&----------------------------------------------------------------------
*& Include
*&----------------------------------------------------------------------

INCLUDE <icon>.
