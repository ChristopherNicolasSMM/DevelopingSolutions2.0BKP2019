*&---------------------------------------------------------------------*
*&  Include           YDS3P_MOD_REL_UNCATE_ALV_TOP
*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*
*& Tabelas
*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*
*& Tipos
*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*
*& Estruturas
*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*
*& Tabela Interna
*&---------------------------------------------------------------------*

DATA: gt_outtab TYPE STANDARD TABLE OF sbook,
      gt_okcode TYPE navp_t_okcode.

*&---------------------------------------------------------------------*
*& Constantes
*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*
*& Variáveis
*&---------------------------------------------------------------------*

DATA: okcode                TYPE sy-ucomm.

*&---------------------------------------------------------------------*
*& Variáreis de Classes
*&---------------------------------------------------------------------*

DATA: go_grid      TYPE REF TO cl_gui_alv_grid_ext,
      go_container TYPE REF TO cl_gui_custom_container.
