*&---------------------------------------------------------------------*
*&  Include           YDS3P_MOCKUP_ALV_CL_TOP
*&---------------------------------------------------------------------*


INCLUDE <icon>.
*&----------------------------------------------------------------------
*& Tabelas
*&----------------------------------------------------------------------

TABLES: mara.
*&----------------------------------------------------------------------
*& Tipos
*&----------------------------------------------------------------------

*&----------------------------------------------------------------------
*& Estruturas
*&----------------------------------------------------------------------
DATA: gs_mara     TYPE mara,
      gs_layout   TYPE lvc_s_layo,
      gs_fieldcat TYPE lvc_s_fcat,
      gs_sort     TYPE lvc_s_sort.
*&----------------------------------------------------------------------
*& Tabela Interna
*&----------------------------------------------------------------------
DATA: gt_mara     TYPE STANDARD TABLE OF mara,
      gt_fieldcat TYPE lvc_t_fcat,
      gt_sort     TYPE lvc_t_sort.
*&----------------------------------------------------------------------
*& Constantes
*&----------------------------------------------------------------------

*&----------------------------------------------------------------------
*& Variáveis
*&----------------------------------------------------------------------
DATA: ok_code TYPE sy-ucomm.
*&----------------------------------------------------------------------
*& Classes
*&----------------------------------------------------------------------

DATA: grid           TYPE REF TO cl_gui_alv_grid,
      main_container TYPE REF TO cl_gui_custom_container.
