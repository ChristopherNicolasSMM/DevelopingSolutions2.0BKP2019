*&---------------------------------------------------------------------*
*&  Include           YDS3P_MOD_REL_UNCATE_ALV_F01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Form  CHECK_ACTIVE_GRID
*&---------------------------------------------------------------------*

FORM check_active_grid_0100 .

  DATA: ls_variant TYPE disvariant,
        ls_layout  TYPE lvc_s_layo.

  PERFORM data_select_0100.

*& Criar e iniciar o conteiner para a tela
  CREATE OBJECT go_container
    EXPORTING
      container_name = 'CONTROL1'.

*& Criar e iniciar a grid Alv
  CREATE OBJECT go_grid
    EXPORTING
      i_parent = go_container
    EXCEPTIONS
      OTHERS   = 1.

*& Esconder todas as colunas visíveis no primeiro display:
  go_grid->set_hide_empty_columns( EXPORTING
                                   iv_hide_empty_columns = p_hid_em ).

*& Iniciar perfil de naegação (Parametro de tela)?
  IF p_no_nav = 'X'.
    go_grid->set_navigation_profile( EXPORTING
                                          iv_navp_on = space ).
  ELSE.
*&  Navegação por perfil ativa -> adicionar função EXT ao perfil?
    go_grid->set_okcode_table( EXPORTING it_okcode = gt_okcode
                                        iv_ext_functions = p_ext_na ).
  ENDIF.

*&  Instanciar e associar as classes de evento a alv grid
  SET HANDLER lcl_eventhandler=>on_toolbar FOR go_grid.
  SET HANDLER lcl_eventhandler=>on_user_command FOR go_grid.

*& Necessário para BADI, sem que nenhum badi seja ativado!
  ls_variant-report   = sy-repid.

*& Titulo da Alv Grid
  ls_layout-grid_title = sy-title.
  ls_layout-smalltitle = 'X'.

*& Chamar Alv Grid
  go_grid->set_table_for_first_display(
    EXPORTING
      is_variant       = ls_variant
      i_save           = 'A'
      is_layout        = ls_layout
      i_structure_name = 'SBOOK'
    CHANGING
      it_outtab        = gt_outtab
    EXCEPTIONS
      OTHERS           = 1 ).

ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  DATA_SELECT
*&---------------------------------------------------------------------*
*&       text
*----------------------------------------------------------------------*
*&  -->  p1        text
*&  <--  p2        text
*----------------------------------------------------------------------*
FORM data_select_0100 .
*& Selecionar dados

  SELECT * FROM sbook INTO TABLE gt_outtab
  UP TO 200 ROWS.

  IF gt_outtab IS INITIAL.
    MESSAGE i888(navigation_profile)
            WITH 'NO TEST DATA!' 'GENERATE'
                 'WITH REPORT' 'FLIGHT_MODEL_DATA_GENERATOR'.
    LEAVE TO SCREEN 0.
  ENDIF.
ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  VALIDADE_INPUT_SCREEN_0100
*&---------------------------------------------------------------------*
*&       text
*----------------------------------------------------------------------*
*&  -->  p1        text
*&  <--  p2        text
*----------------------------------------------------------------------*
FORM validade_input_screen_0100 .

ENDFORM.
