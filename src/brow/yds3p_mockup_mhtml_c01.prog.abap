**----------------------------------------------------------------------*
**       CLASS khtml DEFINITION
**----------------------------------------------------------------------*
**
**----------------------------------------------------------------------*
CLASS khtml DEFINITION INHERITING FROM cl_gui_html_viewer.
  PUBLIC SECTION.
    METHODS: constructor IMPORTING  parent TYPE REF TO cl_gui_container
                         EXCEPTIONS no_html,

      callback FOR EVENT sapevent
                    OF cl_gui_html_viewer
        IMPORTING action
                    frame
                    getdata
                    postdata
                    query_table,

      get_prefix RETURNING VALUE(ret) TYPE char255.
ENDCLASS.                    "khtml DEFINITION

*---------------------------------------------------------------------*
*                              kHandle                                *
*---------------------------------------------------------------------*
* Implementação
*=====================================================================*
CLASS khtml IMPLEMENTATION.

  METHOD constructor.

    DATA: i_event TYPE cntl_simple_events,
          e_event TYPE cntl_simple_event.

    CALL METHOD super->constructor
      EXPORTING
        parent             = parent
*       SAPHTMLP           = 'X'
      EXCEPTIONS
        cntl_error         = 1
        cntl_install_error = 2
        dp_install_error   = 3
        dp_error           = 4.
    IF sy-subrc NE 0.
      RAISE no_html.
    ENDIF.

    MOVE me->m_id_sapevent TO e_event-eventid.
    APPEND e_event TO i_event.

    CALL METHOD me->set_registered_events
      EXPORTING
        events = i_event[].

    SET HANDLER me->callback FOR me.

  ENDMETHOD.                    "constructor
  METHOD callback.

    DATA: e_postdata LIKE LINE OF postdata,

          i_split    TYPE TABLE OF char256,
          e_split    TYPE char256,

          v_ucomm    TYPE syucomm.

    LOOP AT postdata INTO e_postdata.

      SPLIT e_postdata AT 'FCODE' INTO TABLE i_split.
      LOOP AT i_split INTO e_split.
        IF e_split(1) EQ '='.
          EXIT.
        ENDIF.
      ENDLOOP.

      IF e_split CA space.
        SUBTRACT 1 FROM sy-fdpos.
        IF sy-fdpos GT 0.
          MOVE e_split+1(sy-fdpos) TO v_ucomm.
        ELSE.
          EXIT.
        ENDIF.
      ENDIF.

    ENDLOOP.

    IF sy-subrc NE 0.
      MOVE action TO v_ucomm.
    ENDIF.

    CHECK NOT v_ucomm IS INITIAL.
*    PERFORM ucomm USING v_ucomm.

  ENDMETHOD.                    "callback

  METHOD get_prefix.
    CALL METHOD me->get_property
      EXPORTING
        property   = 'URLPrefixLocal'
        queue_only = ' '
      IMPORTING
        value      = ret
      EXCEPTIONS
        OTHERS     = 1.
    IF sy-subrc NE 0.
    ENDIF.
  ENDMETHOD.                    "get_prefix

ENDCLASS.                    "khtml IMPLEMENTATION















**********************************************************************
* LOCAL CLASSES
**********************************************************************
*---------- Definition -----------------------------------------------*

*----------------------------------------------------------------------*
*       CLASS LCL_APPLICATION DEFINITION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
CLASS lcl_application DEFINITION.
  PUBLIC SECTION.
* Eventos para a Árvore
    METHODS:
      handle_node_double_click
            FOR EVENT node_double_click OF cl_simple_tree_model
        IMPORTING
            node_key.
ENDCLASS.                    "LCL_APPLICATION DEFINITION

*----------------------------------------------------------------------*
*       CLASS lcl_application IMPLEMENTATION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
CLASS lcl_application IMPLEMENTATION.

  METHOD handle_node_double_click.
    wc_node_key = node_key.
*    IF p_bukrs IS INITIAL.
    PERFORM call_selection.
*    ENDIF.

    "Validação do menu ALV monitor extrator.
    g_grid_batch->refresh_table_display( ).

    CALL METHOD cl_gui_cfw=>flush.

  ENDMETHOD.                    "handle_node_double_click

ENDCLASS.                    "lcl_application IMPLEMENTATION

*----------------------------------------------------------------------*
*       CLASS lcl_event_receiver DEFINITION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
CLASS lcl_event_receiver DEFINITION.

*   event receiver definitions for ALV actions
  PUBLIC SECTION.
    CLASS-METHODS:
      handle_data_changed
                    FOR EVENT data_changed OF cl_gui_alv_grid
        IMPORTING er_data_changed
                    e_ucomm,

      handle_user_command
                    FOR EVENT user_command OF cl_gui_alv_grid
        IMPORTING e_ucomm,

      handle_toolbar
                    FOR EVENT toolbar OF cl_gui_alv_grid
        IMPORTING e_object e_interactive.

ENDCLASS.                    "lcl_event_receiver DEFINITION

*----------------------------------------------------------------------*
*       CLASS lcl_event_receiver IMPLEMENTATION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
CLASS lcl_event_receiver IMPLEMENTATION.

  METHOD handle_data_changed.

    DATA: wa_mod    TYPE lvc_s_modi.

    LOOP AT er_data_changed->mt_mod_cells INTO wa_mod.

*      READ TABLE it_gerar_blocos
*        INTO wa_config
*        INDEX wa_mod-row_id.
*
*      CASE wa_mod-fieldname.
*        WHEN 'GERAR'.
*          wa_config-gerar      = wa_mod-value.
*        WHEN OTHERS.
*      ENDCASE.
*
*      MODIFY it_gerar_blocos FROM wa_config INDEX wa_mod-row_id.
*
*      CLEAR: wa_config, wa_mod.
    ENDLOOP.

  ENDMETHOD.                    "handle_data_changed

  METHOD handle_user_command.
    CASE e_ucomm.
      WHEN 'MARCAR_TODOS'.
        CALL METHOD cl_gui_cfw=>flush.
      WHEN 'DESMARCAR_TODOS'.
        CALL METHOD cl_gui_cfw=>flush.
    ENDCASE.
  ENDMETHOD.                           "handle_user_command

  METHOD handle_toolbar.
    DATA: ls_toolbar  TYPE stb_button.

* append a separator to normal toolbar
    CLEAR ls_toolbar.
    MOVE 3 TO ls_toolbar-butn_type.
    APPEND ls_toolbar TO e_object->mt_toolbar.

*   ADICIONANDO BOTÃO DE ATRIBUIR TODOS
    CLEAR ls_toolbar.
    MOVE 'MARCAR_TODOS'                   TO ls_toolbar-function.
    MOVE icon_select_all                  TO ls_toolbar-icon.
    MOVE 'Marcar Todos Blocos'(111)       TO ls_toolbar-quickinfo.
    MOVE ''(112)                          TO ls_toolbar-text.
    MOVE ' '                              TO ls_toolbar-disabled.
    APPEND ls_toolbar TO e_object->mt_toolbar.

*   ADICIONANDO BOTÃO DE ATRIBUIR TODOS
    CLEAR ls_toolbar.
    MOVE 'DESMARCAR_TODOS'                  TO ls_toolbar-function.
    MOVE  icon_deselect_block               TO ls_toolbar-icon.
    MOVE 'Desmarcar Todos Bloos'(111)       TO ls_toolbar-quickinfo.
    MOVE ''(112)                            TO ls_toolbar-text.
    MOVE ' '                                TO ls_toolbar-disabled.
    APPEND ls_toolbar TO e_object->mt_toolbar.

  ENDMETHOD.                    "handle_toolbar

ENDCLASS.                    "lcl_event_receiver IMPLEMENTATION

*&---------------------------------------------------------------------*

*----------------------------------------------------------------------*
*       CLASS gcl_html_menu DEFINITION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
CLASS gcl_html_menu DEFINITION.
*
  PUBLIC SECTION.
    CLASS-METHODS main.
  PRIVATE SECTION.
    CLASS-METHODS handle_sapevent
      FOR EVENT sapevent
                  OF yds3p_cl_abap_browser
      IMPORTING action.

ENDCLASS.                    "lcl_report DEFINITION

*----------------------------------------------------------------------*
*       CLASS gcl_html_menu IMPLEMENTATION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
CLASS gcl_html_menu IMPLEMENTATION.

  METHOD main.

    SET HANDLER handle_sapevent.

    PERFORM generate_html_menu.

    LOOP AT ts_data_menu INTO e_data.
      CONCATENATE html_str e_data-dataset INTO html_str.
    ENDLOOP.

    LOOP AT ts_data_timeline INTO e_data.
      CONCATENATE html_str_time e_data-dataset INTO html_str_time.
    ENDLOOP.

    IF g_menu_container IS INITIAL.

      CREATE OBJECT g_menu_container
        EXPORTING
          container_name = 'MENU_CONT'
        EXCEPTIONS
          OTHERS         = 1.
    ENDIF.

    IF g_main_container IS INITIAL.

      CREATE OBJECT g_main_container
        EXPORTING
          container_name = 'MAIN_CONT'
        EXCEPTIONS
          OTHERS         = 1.
    ENDIF.

    yds3p_cl_abap_browser=>show_html(
      EXPORTING
        html_string = html_str
        title       = 'Menu'
        buttons     = yds3p_cl_abap_browser=>navigate_off
        format      = yds3p_cl_abap_browser=>landscape
        size        = yds3p_cl_abap_browser=>medium
        container   = g_menu_container
      IMPORTING
         html_errors = error_list ).


    " Declara variaveis para a pagina html
    DATA html_pagina   TYPE string.
    DATA titulo      TYPE yds3p_cl_abap_browser=>title.
    DATA ext_data   TYPE yds3p_cl_abap_browser=>load_tab.
    DATA ext_line   TYPE yds3p_cl_abap_browser=>load_tab_line.
*    DATA error_list TYPE cl_abap_browser=>html_table.

    FIELD-SYMBOLS <error> LIKE LINE OF error_list.

**    " Exibe pagina html
    yds3p_cl_abap_browser=>show_html(
     EXPORTING
       html_string = html_str_time
       title       = titulo
       buttons     = yds3p_cl_abap_browser=>navigate_off
       format      = yds3p_cl_abap_browser=>landscape
       size        = yds3p_cl_abap_browser=>medium
       container   = g_main_container
     IMPORTING
        html_errors = error_list ).

  ENDMETHOD.                    "main

  METHOD handle_sapevent.
*& Slecionar menu lateral, tratativas

    PERFORM exclude_tb_functions CHANGING it_exclude_fcode_rel_b.
    gs_variant_rel_b-report = sy-repid.

    DATA: v_ucomm TYPE syucomm.
    v_ucomm = action.
    IF v_ucomm(2) = 'CT'.
      CALL TRANSACTION v_ucomm+3.

    ELSEIF v_ucomm(2) = 'SS'.
      " Chamar tela de Seleção
      PERFORM call_selection.

    ELSEIF v_ucomm(2) = 'LR'.
      CASE v_ucomm+3.
        WHEN 'SHOW'.
            CALL SCREEN 0200 STARTING AT 67 3.
        WHEN 'ARCHIVE'.
        WHEN 'EXTRAIR'.
         CALL SCREEN 9000.
      ENDCASE.

    ENDIF.

    PERFORM refresh_screen.

  ENDMETHOD.                    "handle_sapevent
ENDCLASS.                    "gcl_html_menu IMPLEMENTATION


*&--------------------------------------------------------------------
*&  As classes acima são utilizadas para o cockpit exclusivamente
*&  para ter uma organização melhor de código criar uma include
*&  de classe para cada tela nova a ser utilizada.
*&  No final do nome a terminação será de 6 letras.
*&  CS + número da tela exemplo _CS0100, _CS0200, _CS9000 e etc.
*&--------------------------------------------------------------------
***********************************************************************
* CLASSES Utilizadas em outras telas
***********************************************************************
