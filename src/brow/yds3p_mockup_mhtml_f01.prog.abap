
*&---------------------------------------------------------------------*
*&      Form  CALL_SELECTION
*&---------------------------------------------------------------------*
FORM call_selection .
  CALL SELECTION-SCREEN 050 STARTING AT 40 7.
  PERFORM refresh_screen.
ENDFORM.                    " SELECT_MONTH

*&---------------------------------------------------------------------*
*&      Form  REFRESH_SCREEN
*&---------------------------------------------------------------------*
FORM refresh_screen.
  PERFORM get_title.        " MONTA DESCRIÇÃO PROGRAMA
  PERFORM fill_html_logo_hd." MONTA LOGO H2 + Header
  PERFORM fill_html_menu.   " MONTA MENU ESQUERDO

ENDFORM.                    "refresh_screen

*&---------------------------------------------------------------------*
*&      Form  FILL_LOGO
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
FORM fill_html_logo_hd.

ENDFORM.                    "FILL_LOGO

*&---------------------------------------------------------------------*
*&      Form  refresh_screen_funcion
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
FORM refresh_screen_funcion.

  CASE lv_title1.
    WHEN '0'.
      lv_title1 = '0'.
      lv_title = 'Bloco 0'.
    WHEN OTHERS.
  ENDCASE.

ENDFORM.                    "refresh_screen_funcion

*&---------------------------------------------------------------------*
*&      Form  iniciar_classes
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
FORM iniciar_classes.

* Limpar Objetos
  PERFORM limpa_objetos.
  SET PF-STATUS '0100'.

ENDFORM.                    "INICIAR_CLASSES

*&---------------------------------------------------------------------*
*&      Form  call_ldb_process
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
FORM call_ldb_process.

*  REFRESH: lt_cosel, lt_params, lt_callbacks, lt_balance_data.

  " Monta os Selects
  CONSTANTS: gc_ldb TYPE trdir-ldbname VALUE 'SDF'.

  PERFORM build_rsparams TABLES lt_cosel
                                lt_params
                         USING  gc_ldb.

  " Monta os CallBacks
  PERFORM build_callback TABLES lt_callbacks.

  " Chama a função
  CALL FUNCTION 'LDB_PROCESS'
    EXPORTING
      ldbname                     = gc_ldb
    TABLES
      callback                    = lt_callbacks
      selections                  = lt_params
    EXCEPTIONS
      ldb_selections_not_accepted = 4
      OTHERS                      = 1.

  IF sy-subrc EQ 4.
    MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
            WITH sy-msgv1 sy-msgv2.
  ENDIF.

  FREE MEMORY ID 'CLASSIC_BALANCE_SDF'.

ENDFORM.                    "CALL_LDB_PROCESS

*&---------------------------------------------------------------------*
*&      Form  build_cosel
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
FORM build_cosel TABLES pt_cosel STRUCTURE cosel
                 USING  iv_bukrs  TYPE bukrs
                        iv_saknr  TYPE yds3p_tt_range_saknr
                        iv_gjahr  TYPE gjahr
                        pd_curtp  LIKE rfpdo2-allgcrtp.

  DATA: lr_saknr TYPE RANGE OF saknr WITH HEADER LINE.

*  lr_saknr[] = iv_saknr[].

  pt_cosel-field = 'BUKRS'.
  pt_cosel-sign   = 'I'.
  pt_cosel-option = 'EQ'.
  pt_cosel-low    = iv_bukrs.
  APPEND pt_cosel.

  pt_cosel-field = 'SAKNR'.
  LOOP AT lr_saknr.
    MOVE-CORRESPONDING lr_saknr TO pt_cosel.
    APPEND pt_cosel.
  ENDLOOP.

  pt_cosel-field = 'GJAHR'.
  pt_cosel-sign   = 'I'.
  pt_cosel-option = 'EQ'.
  pt_cosel-low    = iv_gjahr.
  pt_cosel-high   = '0000'.
  APPEND pt_cosel.

  pt_cosel-field = 'CURTP'.
  pt_cosel-low   = pd_curtp.
  APPEND pt_cosel.

  pt_cosel-field = 'RTCUR'.
  pt_cosel-low   = '*'.
  APPEND pt_cosel.

ENDFORM.                               " BUILD_COSEL

*&---------------------------------------------------------------------*
*&      Form  build_rsparams
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
FORM build_rsparams TABLES pt_cosel  TYPE tcosel
                           pt_params STRUCTURE rsparams
                    USING  pd_ldb    LIKE trdir-ldbname.

  CONSTANTS: lc_selname_gsber LIKE rsparams-selname VALUE 'SD_GSB_S'.


*...refresh return table...............................................*

  REFRESH pt_params.


*...process all entries in table PT_COSEL..............................*

  LOOP AT pt_cosel.
    CASE pt_cosel-field.
      WHEN 'GSBER'.
        pt_params-selname = lc_selname_gsber.
      WHEN OTHERS.
        pt_params-selname(2)   = pd_ldb(2).
        pt_params-selname+2(1) = '_'.
        pt_params-selname+3    = pt_cosel-field.
    ENDCASE.
    MOVE-CORRESPONDING pt_cosel TO pt_params.
    APPEND pt_params.
  ENDLOOP.

  pt_params-selname = 'SD_CURTP'.
  pt_params-sign    = 'I'.
  pt_params-option  = 'EQ'.
  pt_params-low     = '10'.
  CLEAR pt_params-high.
  APPEND pt_params.

ENDFORM.                               " BUILD_RSPARAMS

*&---------------------------------------------------------------------*
*&      Form  build_callback
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
FORM build_callback TABLES pt_callback STRUCTURE ldbcb.

  pt_callback-ldbnode     = 'SKC1C'.
  pt_callback-get         = 'X'.
  pt_callback-get_late    = ' '.
  pt_callback-cb_prog     = sy-repid.
  pt_callback-cb_form     = 'LDB_CALLBACK'.
  APPEND pt_callback.

ENDFORM.                               " BUILD_CALLBACK

*&---------------------------------------------------------------------*
*&      Form  ldb_callback
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
FORM ldb_callback USING pd_node LIKE ldbn-ldbnode
                        pd_workarea
                        pd_mode     TYPE c
                        pd_selected TYPE c.

  DATA: ls_knc1  LIKE knc1,
        ls_knc3  LIKE knc3,
        ls_lfc1  LIKE lfc1,
        ls_lfc3  LIKE lfc3,
        ls_skc1c LIKE skc1c.

  CASE pd_node.
    WHEN 'SKC1C'.
      ls_skc1c = pd_workarea.
  ENDCASE.

  pd_selected = 'X'.

ENDFORM.                    "LDB_CALLBACK

*&---------------------------------------------------------------------*
*&      Form  z_popup
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*----------------------------------------------------------------------*
FORM z_popup USING default
                   linha1
                   linha2
                   titulo
                   scoluna
                   slinha
                   cancel
                   answer.

  CALL FUNCTION 'POPUP_TO_CONFIRM_STEP'
    EXPORTING
      defaultoption  = default
      textline1      = linha1
      textline2      = linha2
      titel          = titulo
      start_column   = scoluna
      start_row      = slinha
      cancel_display = cancel
    IMPORTING
      answer         = v_sim.

ENDFORM.                    " Z_POPUP

*&---------------------------------------------------------------------*
*&      Form  PROGRESS_BAR
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      -->P_1300   text
*      -->P_LC_TABIX  text
*      -->P_GV_COUNT  text
*----------------------------------------------------------------------*
FORM progress_bar USING    p_value
                           p_tabix
                           p_nlines.
  DATA: w_text(40),
        w_percentage      TYPE p,
        w_percent_char(3).
  w_percentage = ( p_tabix / p_nlines ) * 100.
  w_percent_char = w_percentage.
  SHIFT w_percent_char LEFT DELETING LEADING ' '.
  CONCATENATE p_value w_percent_char '% Completo'(002) INTO w_text.
  IF w_percentage GT gd_percent OR p_tabix EQ 1.
    CALL FUNCTION 'SAPGUI_PROGRESS_INDICATOR'
      EXPORTING
        percentage = w_percentage
        text       = w_text.
    gd_percent = w_percentage.
  ENDIF.

ENDFORM.                    "progress_bar

*&---------------------------------------------------------------------*
*&      Form  SELECT_MONTH
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM get_title.

  SET PF-STATUS '0100'.
  SET TITLEBAR '0100' WITH 'Bloco: ' lv_title1.

ENDFORM.                    " SELECT_MONTH
*&---------------------------------------------------------------------*
*&      Form  SELECT_BLOCK
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      -->P_NODE_KEY  text
*----------------------------------------------------------------------*
FORM seleciona_dados.

ENDFORM.                    " SELECT_BLOCK

*&---------------------------------------------------------------------*
*&      Form  validate_screen
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
FORM validate_screen.

ENDFORM.                    "validate_screen

*&---------------------------------------------------------------------*
*&      Form  exclude_tb_functions
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      <--PT_EXCLUDE text
*----------------------------------------------------------------------*
FORM exclude_tb_functions CHANGING pt_exclude TYPE ui_functions.
*  DATA ls_exclude TYPE ui_func.
*
*  ls_exclude = cl_gui_alv_grid=>mc_fc_fix_columns.
*  APPEND ls_exclude TO pt_exclude.
*  ls_exclude = cl_gui_alv_grid=>mc_fc_graph.
*  APPEND ls_exclude TO pt_exclude.
*  ls_exclude = cl_gui_alv_grid=>mc_fc_help.
*  APPEND ls_exclude TO pt_exclude.
*  ls_exclude = cl_gui_alv_grid=>mc_fc_html.
*  APPEND ls_exclude TO pt_exclude.
*  ls_exclude = cl_gui_alv_grid=>mc_fc_info.
*  APPEND ls_exclude TO pt_exclude.
*  ls_exclude = cl_gui_alv_grid=>mc_fc_loc_append_row.
*  APPEND ls_exclude TO pt_exclude.
*  ls_exclude = cl_gui_alv_grid=>mc_fc_loc_copy.
*  APPEND ls_exclude TO pt_exclude.
*  ls_exclude = cl_gui_alv_grid=>mc_fc_loc_copy_row.
*  APPEND ls_exclude TO pt_exclude.
*  ls_exclude = cl_gui_alv_grid=>mc_fc_loc_cut.
*  APPEND ls_exclude TO pt_exclude.
*  ls_exclude = cl_gui_alv_grid=>mc_fc_loc_delete_row.
*  APPEND ls_exclude TO pt_exclude.
*  ls_exclude = cl_gui_alv_grid=>mc_fc_loc_insert_row.
*  APPEND ls_exclude TO pt_exclude.
*  ls_exclude = cl_gui_alv_grid=>mc_fc_loc_move_row.
*  APPEND ls_exclude TO pt_exclude.
*  ls_exclude = cl_gui_alv_grid=>mc_fc_loc_paste.
*  APPEND ls_exclude TO pt_exclude.
*  ls_exclude = cl_gui_alv_grid=>mc_fc_loc_paste_new_row.
*  APPEND ls_exclude TO pt_exclude.
*  ls_exclude = cl_gui_alv_grid=>mc_fc_loc_undo.
*  APPEND ls_exclude TO pt_exclude.
*  ls_exclude = cl_gui_alv_grid=>mc_fc_print.
*  APPEND ls_exclude TO pt_exclude.
*  ls_exclude = cl_gui_alv_grid=>mc_fc_print_back.
*  APPEND ls_exclude TO pt_exclude.
*  ls_exclude = cl_gui_alv_grid=>mc_fc_print_prev.
*  APPEND ls_exclude TO pt_exclude.
*  ls_exclude = cl_gui_alv_grid=>mc_fc_refresh.
*  APPEND ls_exclude TO pt_exclude.

ENDFORM.                    " EXCLUDE_TB_FUNCTIONS

*&---------------------------------------------------------------------*
*&      Form  limpa_objetos
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
FORM limpa_objetos.

  IF NOT g_cont_batch IS INITIAL.
    g_cont_batch->free( ).
  ENDIF.

ENDFORM.                    "limpa_objetos
*&---------------------------------------------------------------------*
*&      Form  F_GENEARTE_HTML
*&---------------------------------------------------------------------*
FORM generate_html_menu .
  REFRESH ts_data_menu.

  DATA: lt_menu     TYPE STANDARD TABLE OF yds3p_menu0001,
        lw_menu     TYPE yds3p_menu0001,
        lt_menu_sub TYPE STANDARD TABLE OF yds3p_menu0001,
        lw_menu_sub TYPE yds3p_menu0001,
        lv_string   TYPE y_html,
        lv_index    TYPE i,
        lt_actvt    TYPE STANDARD TABLE OF bapiagr,
        lt_return   TYPE STANDARD TABLE OF bapiret2.

  lv_index = 1.

  SELECT *
    FROM yds3p_menu0001
    INTO TABLE lt_menu
    WHERE header  EQ 'X'
      AND visible EQ 'X'
      ORDER BY order_menu.

  READ REPORT 'YDS3P_MOCKUP_MHTML_MENUHTML' INTO ts_data_menu.

  " REMOVE OS COMENTÁRIOS
  LOOP AT ts_data_menu INTO e_data.
    lc_tabix = sy-tabix.
    MOVE e_data+1 TO e_data.
    MODIFY ts_data_menu FROM e_data INDEX sy-tabix.
  ENDLOOP.

  READ REPORT 'YDS3P_MOCKUP_MHTML_DASH_HTML' INTO ts_data_timeline.

  " REMOVE OS COMENTÁRIOS
  LOOP AT ts_data_timeline INTO e_data.
    lc_tabix = sy-tabix.
    MOVE e_data+1 TO e_data.
    MODIFY ts_data_timeline FROM e_data INDEX sy-tabix.
  ENDLOOP.

  " VERIFICA PERMISSÕES
  CALL FUNCTION 'BAPI_USER_GET_DETAIL'
    EXPORTING
      username       = sy-uname
    TABLES
      activitygroups = lt_actvt
      return         = lt_return.

  LOOP AT ts_data_menu INTO e_data.
    lc_tabix = sy-tabix.

    IF e_data CS 'ABAP_MENU'.
      lv_index = lc_tabix + 1.

      " ADICIONAR VERSÃO
      lv_string-dataset = '<span class="label" style="background-color: #38bbeb; color:white">Versão: 1.1</span>'.
      INSERT lv_string INTO ts_data_menu INDEX lv_index.
      ADD 1 TO lv_index.

      LOOP AT lt_menu INTO lw_menu.

        IF lw_menu-filhos EQ space.
          CONCATENATE '<li>'
                        '<a href="SAPEVENT:'
                          lw_menu-action
                          '">'
                          '<i class="'
                          lw_menu-icon
                          '" style="'
                          lw_menu-icon_color
                          lw_menu-style
                          '"></i>'
                          '<span>'
                          lw_menu-descricao
                          '</span>'
                        '</a>'
                      '</li>'
                    INTO lv_string-dataset.
        ELSE.
          CONCATENATE '<li class="sub-menu">'
                        '<a href="javascript:;">'
                          '<i class="'
                          lw_menu-icon
                          '" style="'
                          lw_menu-icon_color
                          lw_menu-style
                          '"></i>'
                          '<span>'
                          lw_menu-descricao
                          '</span>'
                        '</a>'
                      INTO lv_string-dataset.
        ENDIF.

        INSERT lv_string INTO ts_data_menu INDEX lv_index.
        ADD 1 TO lv_index.

        CHECK lw_menu-header = 'X' AND lw_menu-filhos NE space.

        lv_string-dataset = '<ul class="sub">'.
        INSERT lv_string INTO ts_data_menu INDEX lv_index.
        ADD 1 TO lv_index.

        SELECT * FROM yds3p_menu0001
          INTO TABLE lt_menu_sub
          WHERE header_id EQ lw_menu-codigo
            AND visible EQ 'X'
          ORDER BY order_menu.

        LOOP AT lt_menu_sub INTO lw_menu_sub.

          CONCATENATE '<li>'
                        '<a href="SAPEVENT:'
                          lw_menu_sub-action
                          '">'
                          '<i class="'
                          lw_menu_sub-icon
                          '" style="'
                          lw_menu_sub-icon_color
                          lw_menu_sub-style
                          '"></i>'
                          lw_menu_sub-descricao
                        '</a>'
                      '</li>'
                    INTO lv_string-dataset.
          INSERT lv_string INTO ts_data_menu INDEX lv_index.

          ADD 1 TO lv_index.
        ENDLOOP.

        lv_string-dataset = '</ul>'.
        INSERT lv_string INTO ts_data_menu INDEX lv_index.
        ADD 1 TO lv_index.

        lv_string-dataset = '</li>'.
        INSERT lv_string INTO ts_data_menu INDEX lv_index.
        ADD 1 TO lv_index.

      ENDLOOP.

      EXIT.
    ENDIF.
  ENDLOOP.

*  " CARREGAR O CONTENT
*  PERFORM load_content.

ENDFORM.                    " F_GENEARTE_HTML

*&---------------------------------------------------------------------*
*&      Form  GENERATE_HTML_TEXTAREA
*&---------------------------------------------------------------------*
FORM generate_html_textarea.
  DATA: gs_lin_text(4096) TYPE c,
        lv_index          TYPE i.

  CLEAR ts_data_textarea.

  REFRESH ts_data_h.
  READ REPORT 'YDS3P_MOCKUP_MHTML_TEXTEDITOR' INTO ts_data_textarea.
  LOOP AT ts_data_textarea INTO e_data.
    lc_tabix = sy-tabix.
    MOVE e_data+1 TO   e_data.
    MODIFY ts_data_textarea FROM e_data INDEX sy-tabix.
  ENDLOOP.

  LOOP AT ts_data_textarea INTO e_data.
    lc_tabix = sy-tabix.

    IF e_data CS '##TEXT##'.
      REPLACE ALL OCCURRENCES OF '##TEXT##' IN e_data WITH ''.
      MODIFY ts_data_textarea FROM e_data INDEX lc_tabix.
      lv_index = lc_tabix + 1.

      LOOP AT gt_lin_text INTO gs_lin_text.
        CONCATENATE gs_lin_text '<br />' INTO gs_lin_text.
        INSERT gs_lin_text INTO ts_data_textarea INDEX lv_index.
        ADD 1 TO lv_index.
      ENDLOOP.
    ENDIF.
  ENDLOOP.

ENDFORM.                    " GENERATE_HTML_TEXTAREA

*&---------------------------------------------------------------------*
*&      Form  FILL_HTML
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
FORM fill_html_menu .

  CHECK gv_control_menu IS INITIAL.
  gcl_html_menu=>main( ).
  gv_control_menu = 'X'.

ENDFORM.                    " FILL_HTML
*&---------------------------------------------------------------------*
*&      Form  exclude_toolbar_config
*&---------------------------------------------------------------------*
FORM exclude_toolbar_config.

  DATA: fs_fun TYPE ui_func.

  CLEAR: fs_fun, it_exclude[].

  fs_fun = cl_gui_alv_grid=>mc_fc_excl_all.
  APPEND fs_fun TO it_exclude.

ENDFORM.                    "exclude_toolbar_config
*&---------------------------------------------------------------------*
*&      Form  SET_COLOR
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM set_color .

ENDFORM.                    " SET_COLOR

*----------------------------------------------------------------------*
*        Start new screen                                              *
*----------------------------------------------------------------------*
FORM bdc_dynpro USING program dynpro.
  CLEAR bdc_tab.
  bdc_tab-program  = program.
  bdc_tab-dynpro   = dynpro.
  bdc_tab-dynbegin = 'X'.
  APPEND bdc_tab.
ENDFORM.                    "bdc_dynpro

*----------------------------------------------------------------------*
*        Insert field                                                  *
*----------------------------------------------------------------------*
FORM bdc_field USING fnam fval.
  CLEAR bdc_tab.
  bdc_tab-fnam = fnam.
  bdc_tab-fval = fval.
  APPEND bdc_tab.
ENDFORM.                    "bdc_field

*&---------------------------------------------------------------------*
*&      Form  DYNPRO
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
FORM dynpro USING dynbegin name value.
  CLEAR bdc_tab.
  IF dynbegin = 'X'.
    bdc_tab-dynbegin = 'X'.
    bdc_tab-program  = name.
    bdc_tab-dynpro   = value.
  ELSE.
    bdc_tab-fnam = name.
    bdc_tab-fval = value.
  ENDIF.
  APPEND bdc_tab.

ENDFORM.                               " DYNPRO
