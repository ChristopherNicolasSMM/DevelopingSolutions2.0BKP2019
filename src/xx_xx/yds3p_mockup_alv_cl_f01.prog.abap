*&---------------------------------------------------------------------*
*&  Include           YDS3P_MOCKUP_ALV_CL_F01
*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*
*&      Form  PAI_SELECTION_SCREEN
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM pai_selection_screen .
  CASE sy-ucomm.
    WHEN 'CRET'.
*    CLEAR: SY-UCOMM.
*    IF SY-DYNNR EQ '1002'.
**      CALL SELECTION-SCREEN 9100 STARTING AT 40 5.
*    ELSEIF SY-DYNNR EQ '1003'.
**      CALL SCREEN 9002.
**      LEAVE PROGRAM.
*    ELSEIF SY-DYNNR EQ '9003'. "Atualizar
**      LEAVE PROGRAM.
*    ENDIF.
    WHEN 'CANCEL'.
      LEAVE PROGRAM.
    WHEN OTHERS.
  ENDCASE.
ENDFORM.

*&---------------------------------------------------------------------*
*&      Form  CONFIG_SCREEN
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM config_screen .
  SET PF-STATUS 'STATUS_0100'.
  SET TITLEBAR 'TITLE_0100'.
ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  GET_DATA
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM get_data .
  SELECT * INTO TABLE gt_mara FROM mara UP TO 10 ROWS.
ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  CONFIG_ALV_GRID
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM config_alv_grid .
  IF main_container IS INITIAL.

******    PERFORM executa_processamento.


    CREATE OBJECT main_container
      EXPORTING
        container_name              = 'CC_M0100'
      EXCEPTIONS
        cntl_error                  = 1
        cntl_system_error           = 2
        create_error                = 3
        lifetime_error              = 4
        lifetime_dynpro_dynpro_link = 5.
    IF sy-subrc NE 0.
      CALL FUNCTION 'POPUP_TO_INFORM'
        EXPORTING
          titel = sy-repid
          txt2  = sy-subrc
          txt1  = 'Controle de telas não foi criado!'(510).
    ENDIF.


    CREATE OBJECT grid
      EXPORTING
        i_parent = main_container.


    PERFORM estilo_grid.

    gs_layout-sel_mode = 'A'.

    CALL METHOD grid->set_table_for_first_display
      EXPORTING
        i_structure_name = 'MARA'
        is_layout        = gs_layout
      CHANGING
        it_sort          = gt_sort
        it_fieldcatalog  = gt_fieldcat
        it_outtab        = gt_mara.

    CREATE OBJECT gcl_event.
    SET HANDLER gcl_event->handle_user_command FOR grid.
    SET HANDLER gcl_event->handle_toolbar FOR grid.
    CALL METHOD grid->set_toolbar_interactive.
  ENDIF.

  CALL METHOD cl_gui_control=>set_focus
    EXPORTING
      control = grid.
ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  ESTILO_GRID
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM estilo_grid .
  CLEAR: gt_fieldcat[].


  gs_layout-sel_mode    = 'A'.
  gs_layout-info_fname  = 'COLOR'.

  CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
    EXPORTING
      i_structure_name = 'MARA'
    CHANGING
      ct_fieldcat      = gt_fieldcat.

  LOOP AT gt_fieldcat INTO gs_fieldcat.

*    CASE gs_fieldcat-fieldname.
*      WHEN 'STATUS'.
*        gs_fieldcat-col_pos   = 1.
*      WHEN 'COLOR'.
*        gs_fieldcat-no_out    = 'X'.
*    ENDCASE.

    gs_fieldcat-scrtext_l = gs_fieldcat-reptext.
    gs_fieldcat-scrtext_m = gs_fieldcat-reptext.
    gs_fieldcat-scrtext_s = gs_fieldcat-reptext.

    MODIFY gt_fieldcat FROM gs_fieldcat.
  ENDLOOP.
  SORT gt_fieldcat BY  col_pos.
  gs_sort-fieldname = 'MATNR'.

  APPEND gs_sort TO gt_sort.
ENDFORM.
