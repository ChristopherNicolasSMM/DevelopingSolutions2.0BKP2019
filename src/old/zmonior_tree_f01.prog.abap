*-------------------------------------------------------------------
***INCLUDE column_tree_control_demoF01 .
*-------------------------------------------------------------------
*&---------------------------------------------------------------------*
*&      Form  GET_START_PARAMETER
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM get_start_parameter .

ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  EXIT_PROGRAM
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM exit_program .
  CALL METHOD tree1->free.
  LEAVE PROGRAM.
ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  FO_FIELDCAT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM fo_fieldcat USING p_hierarchy_header TYPE treev_hhdr.
  DATA: ls_fieldcatalog TYPE lvc_s_fcat.

  DATA: lv_structor TYPE dd02l-tabname.

  SELECT SINGLE value FROM zmdat_paran
    INTO @lv_structor
     WHERE program_name = @p_prog
    AND scren = @p_dyn
    AND paramiters = 'LVC_FIELDCATALOG_MERGE'.

  CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
    EXPORTING
      i_structure_name = lv_structor
    CHANGING
      ct_fieldcat      = gt_fieldcatalog.


  LOOP AT gt_fieldcatalog INTO ls_fieldcatalog.

    READ TABLE gt_mdat_lyt INTO gs_mdat_lyt
    WITH KEY name_feld = ls_fieldcatalog-fieldname
                   .
    IF sy-subrc EQ 0.

      ls_fieldcatalog-col_pos   = gs_mdat_lyt-level_node.
      ls_fieldcatalog-fieldname = gs_mdat_lyt-name_feld.
      ls_fieldcatalog-tabname   = gs_mdat_lyt-table_name.
      ls_fieldcatalog-coltext   = gs_mdat_lyt-label_column.
      ls_fieldcatalog-just = 'L'.
      IF gs_mdat_lyt-isnode EQ 'X'.
*      ls_fieldcatalog-no_out = 'X'.
        ls_fieldcatalog-key = 'X'.
      ELSE.
        IF ls_fieldcatalog-coltext EQ p_hierarchy_header-heading.
          ls_fieldcatalog-no_out = 'X'.
        ELSE.
          ls_fieldcatalog-no_out = ''.
        ENDIF.
        ls_fieldcatalog-key    = ''.
      ENDIF.
      ls_fieldcatalog-outputlen = gs_mdat_lyt-width.
      MODIFY gt_fieldcatalog FROM ls_fieldcatalog.
    ENDIF.
    CLEAR ls_fieldcatalog.

  ENDLOOP.

ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  CREATE_TREE
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM create_tree .

* create container for alv-tree
  DATA: l_tree_container_name(30) TYPE c,
        l_custom_container        TYPE REF TO cl_gui_custom_container.
  l_tree_container_name = 'TREE1'.
  IF sy-batch IS INITIAL.
    CREATE OBJECT l_custom_container
      EXPORTING
        container_name              = l_tree_container_name
      EXCEPTIONS
        cntl_error                  = 1
        cntl_system_error           = 2
        create_error                = 3
        lifetime_error              = 4
        lifetime_dynpro_dynpro_link = 5.
    IF sy-subrc <> 0.
      MESSAGE x208(00) WITH 'ERROR'.
    ENDIF.
  ENDIF.
* create tree control
  CREATE OBJECT tree1
    EXPORTING
      parent                      = l_custom_container
      node_selection_mode         = cl_gui_column_tree=>node_sel_mode_single
      item_selection              = 'X'
      no_html_header              = ''
      no_toolbar                  = ''
    EXCEPTIONS
      cntl_error                  = 1
      cntl_system_error           = 2
      create_error                = 3
      lifetime_error              = 4
      illegal_node_selection_mode = 5
      failed                      = 6
      illegal_column_name         = 7.
  IF sy-subrc <> 0.
    MESSAGE x208(00) WITH 'ERROR'.                          "#EC NOTEXT
  ENDIF.
****
ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  BUILD_HIERARCHY_HEADER
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      <--P_L_HIERARCHY_HEADER  text
*----------------------------------------------------------------------*
FORM build_hierarchy_header  CHANGING
                               p_hierarchy_header TYPE treev_hhdr.
  SORT gt_mdat_lyt BY level_node.
  READ TABLE gt_mdat_lyt INTO gs_mdat_lyt INDEX 1 ."WITH KEY isnode = '' .

  p_hierarchy_header-heading = gs_mdat_lyt-label_column.
  p_hierarchy_header-width = 40.
  p_hierarchy_header-width_pix = ''.
ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  BUILD_COMMENT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      -->P_LT_LIST_COMMENTARY  text
*----------------------------------------------------------------------*
FORM build_comment  USING
      pt_list_commentary TYPE slis_t_listheader.
  DATA: ls_line  TYPE slis_listheader, text(60) TYPE c.

  SELECT * FROM zmdat_paran INTO TABLE @DATA(t_build_comment)
    WHERE program_name = @p_prog AND
          scren        = @p_dyn AND
          paramiters   = 'BUILD_COMMENT'
    ORDER BY level_param.

  LOOP AT t_build_comment ASSIGNING FIELD-SYMBOL(<fs_comment>).

    CLEAR ls_line.
    IF <fs_comment>-level_param EQ 1.
      ls_line-typ  = 'H'.
      ls_line-info = <fs_comment>-value.
    ELSE.
      ls_line-typ  = 'S'.
      ls_line-info = <fs_comment>-value.
    ENDIF.

    APPEND ls_line TO pt_list_commentary.
  ENDLOOP.

ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  CREATE_HIERARCHY
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM create_hierarchy .
* add data to tree
  DATA: l_key_main  TYPE lvc_nkey,
        l_key_node1 TYPE lvc_nkey,
        l_key_node2 TYPE lvc_nkey,
        l_key_node3 TYPE lvc_nkey,
        l_node      TYPE lvc_value.
  DATA: l_key_new      TYPE lvc_nkey,
        l_key_last     TYPE lvc_nkey,
        exec_sql       TYPE string,
        l_node_text    TYPE lvc_value,
        export_table   TYPE c LENGTH 100,
        fild_and_table TYPE c LENGTH 100,
        program_name   TYPE sy-cprog,
        regs           TYPE i,
        assign_ext     TYPE c LENGTH 40,
        global_typ     TYPE STANDARD TABLE OF string WITH HEADER LINE,
        query_sql      TYPE STANDARD TABLE OF string WITH HEADER LINE,
        l_tabix        TYPE sy-tabix.
  FIELD-SYMBOLS <fs_node_typ> TYPE any.

  DATA: lt_item_layout TYPE lvc_t_layi,
        ls_item_layout TYPE lvc_s_layi.

**********************************************************************

  PERFORM get_populate_data USING sy-cprog
                                  sy-dynnr.

**********************************************************************
  DATA: l_key_new1  TYPE lvc_nkey,
        l_key_last1 TYPE lvc_nkey.

*  DATA: ls_campos TYPE zmonior_tree_mara.
  DATA:  ls_node_layout TYPE lvc_s_layn.
  DATA lv_string TYPE string.
  DATA lv_ex_string TYPE string.
  DATA lv_aux_string TYPE string.
  MOVE-CORRESPONDING <ft_mdat_lyt> TO lt_dados.
*lt_aux_node


  SELECT name_feld level_node dad_note
    FROM zmdat_lyt INTO (lt_aux_node-field , lt_aux_node-level, lt_aux_node-dad)
    WHERE program_name = p_prog AND
          scren        = p_dyn AND
          isnode       = 'X'
    ORDER BY zmdat_lyt~level_node.
    APPEND lt_aux_node.
  ENDSELECT.
*
*  EXPORT lt_dados TO MEMORY ID 'ZDINAMIC_PROG'.
*
*  DATA dinamic_prog TYPE TABLE OF rssource-line.
*  DATA lr_aux_node  TYPE i.
*  APPEND 'REPORT ZDINAMIC_PROG.' TO dinamic_prog.
*  APPEND '' TO dinamic_prog.
*  APPEND 'DATA LV_STRING TYPE STRING.' TO dinamic_prog.
*  APPEND 'FIELD-SYMBOLS <ex_dados> TYPE ANY TABLE.' TO dinamic_prog.
*  APPEND 'BREAK-POINT.' TO dinamic_prog.
**  ASSIGN ('(SAPMV45A)XVBAP') TO <fs_tabela>.
*  APPEND 'ASSIGN (''(ZMONIOR_TREE)lt_dados[]'')' && ' TO <ex_dados>.' TO dinamic_prog.
*  APPEND 'IF <ex_dados> IS ASSIGNED.' TO dinamic_prog.
*  APPEND 'IMPORT lt_dados TO <ex_dados> FROM MEMORY ID ''ZDINAMIC_PROG''.' TO dinamic_prog.
*  APPEND '' TO dinamic_prog.
*  DESCRIBE TABLE lt_aux_node LINES lr_aux_node.
*  LOOP AT lt_aux_node.
*
*    lv_aux_string = '''(' && lt_aux_node-field && ')'''.
*    CONCATENATE  'CONCATENATE LV_STRING '
*                 lv_aux_string
*                 ''"ASCENDING
*                 'INTO LV_STRING SEPARATED BY SPACE.'
*                 INTO lv_ex_string SEPARATED BY space.
*
*    APPEND  lv_ex_string TO dinamic_prog.
*  ENDLOOP.
*
*  APPEND 'SORT: <ex_dados> BY (LV_STRING).' TO dinamic_prog.
*  APPEND 'EXPORT <ex_dados> TO MEMORY ID ''ZDINAMIC_PROG''.' TO dinamic_prog.
*  APPEND 'ENDIF.' TO dinamic_prog.
*  INSERT REPORT 'ZDINAMIC_PROG' FROM dinamic_prog.
*  SUBMIT zdinamic_prog AND RETURN.
*  IMPORT <ex_dados> TO lt_dados FROM MEMORY ID 'ZDINAMIC_PROG'.

  FIELD-SYMBOLS  <field_current> TYPE any.
  FIELD-SYMBOLS  <structor_null> TYPE any.
  DATA: current_key type LVC_NKEY.

  LOOP AT lt_dados ASSIGNING FIELD-SYMBOL(<fs_dados>) .

    ASSIGN <fs_dados> TO <structor_null>.
*    CLEAR: <structor_null>.
    LOOP AT lt_aux_node ASSIGNING FIELD-SYMBOL(<fs_nodes>).
*      <field_current>
      ASSIGN COMPONENT <fs_nodes>-field OF STRUCTURE <fs_dados> TO <field_current>.
      IF <field_current> IS ASSIGNED.
        IF <fs_nodes>-old_val <> <field_current>.
          <fs_nodes>-old_val = <field_current>.

          l_node_text =  <fs_nodes>-old_val.
*          IF <keys>-old_key > <fs_nodes>-new_key.
*             current_key = <keys>-old_key.
*          else.
*             current_key = <keys>-new_key.
*          ENDIF.

          READ TABLE lt_aux_node ASSIGNING FIELD-SYMBOL(<keys>) WITH KEY dad = <fs_nodes>-field.


          IF sy-subrc EQ 0.
            CALL METHOD tree1->add_node
              EXPORTING
                i_relat_node_key = <keys>-old_key
                i_relationship   = cl_gui_column_tree=>relat_last_child
                i_node_text      = l_node_text
*               is_outtab_line   = <structor_null>
              IMPORTING
                e_new_node_key   = <fs_nodes>-new_key.
          ENDIF.



          CALL METHOD tree1->add_node
            EXPORTING
              i_relat_node_key = <fs_nodes>-old_key
              i_relationship   = cl_gui_column_tree=>relat_last_child
              i_node_text      = l_node_text
*             is_outtab_line   = <structor_null>
            IMPORTING
              e_new_node_key   = <fs_nodes>-new_key.
        ENDIF.
      ENDIF.

    ENDLOOP.





*    ON CHANGE OF ls_campos-mtart.
*      l_node_text = ls_campos-mtart.
*      tree1->add_node(
*        EXPORTING
*        i_relat_node_key = ''
*        i_relationship   = cl_gui_column_tree=>relat_last_child
*        i_node_text      = l_node_text
*        is_outtab_line   = ls_campos-mtart
*        IMPORTING
*        e_new_node_key   = l_key_new1
*    ).
*
*    ENDON.
*
*    ON CHANGE OF ls_campos-matnr.
*      l_node_text = ls_campos-matnr.
*
**cl_gui_alv_tree
*
*      tree1->add_node(
*        EXPORTING
*        i_relat_node_key = l_key_new1
*        i_relationship   = cl_gui_column_tree=>relat_last_child
*        i_node_text      = l_node_text
*        is_node_layout   = ls_node_layout
*        is_outtab_line   = ls_campos
**        IMPORTING
**        e_new_node_key   = l_key_new
*    ).
*
*    ENDON.

  ENDLOOP.

** this method must be called to send the data to the frontend
  CALL METHOD tree1->frontend_update.

ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  REGISTER_EVENTS
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM register_events .

* define the events which will be passed to the backend
  DATA: lt_events TYPE cntl_simple_events,
        l_event   TYPE cntl_simple_event.
* define the events which will be passed to the backend
  l_event-eventid = cl_gui_column_tree=>eventid_expand_no_children.
  APPEND l_event TO lt_events.
  l_event-eventid = cl_gui_column_tree=>eventid_checkbox_change.
  APPEND l_event TO lt_events.
  l_event-eventid = cl_gui_column_tree=>eventid_header_context_men_req.
  APPEND l_event TO lt_events.
  l_event-eventid = cl_gui_column_tree=>eventid_node_context_menu_req.
  APPEND l_event TO lt_events.
  l_event-eventid = cl_gui_column_tree=>eventid_item_context_menu_req.
  APPEND l_event TO lt_events.
  l_event-eventid = cl_gui_column_tree=>eventid_header_click.
  APPEND l_event TO lt_events.
  l_event-eventid = cl_gui_column_tree=>eventid_item_keypress.
  APPEND l_event TO lt_events.
  CALL METHOD tree1->set_registered_events
    EXPORTING
      events                    = lt_events
    EXCEPTIONS
      cntl_error                = 1
      cntl_system_error         = 2
      illegal_event_combination = 3.
  IF sy-subrc <> 0.
    MESSAGE x208(00) WITH 'ERROR'.                          "#EC NOTEXT
  ENDIF.
* set Handler
  DATA: l_event_receiver TYPE REF TO lcl_tree_event_receiver.
  CREATE OBJECT l_event_receiver.
  SET HANDLER l_event_receiver->handle_node_ctmenu_request
                                                        FOR tree1.
  SET HANDLER l_event_receiver->handle_node_ctmenu_selected
                                                        FOR tree1.
  SET HANDLER l_event_receiver->handle_item_ctmenu_request
                                                        FOR tree1.
  SET HANDLER l_event_receiver->handle_item_ctmenu_selected
                                                        FOR tree1.
ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  ADD_NODE_MAIN
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      -->P_WA_EXIT1  text
*      -->P_0867   text
*      -->P_L_NODE  text
*      <--P_L_KEY_MAIN  text
*----------------------------------------------------------------------*
FORM add_node_main  USING       p_aux TYPE it
                               p_relat_key TYPE lvc_nkey
                               p_node TYPE lvc_value
                     CHANGING  p_node_key TYPE lvc_nkey.
  DATA: l_node_text TYPE lvc_value,
        ls_sflight  TYPE sflight.
* set item-layout
  DATA: lt_item_layout TYPE lvc_t_layi,
        ls_item_layout TYPE lvc_s_layi.
*  ls_item_layout-t_image = '<at:var at:name="3P" />'.
  ls_item_layout-fieldname = tree1->c_hierarchy_column_name.
  ls_item_layout-style   =
                        cl_gui_column_tree=>style_intensifd_critical.
  APPEND ls_item_layout TO lt_item_layout.
* add node
  l_node_text =  p_node.
  CALL METHOD tree1->add_node
    EXPORTING
      i_relat_node_key = p_relat_key
      i_relationship   = cl_gui_column_tree=>relat_last_child
      i_node_text      = l_node_text
      is_outtab_line   = p_aux
      it_item_layout   = lt_item_layout
    IMPORTING
      e_new_node_key   = p_node_key.

ENDFORM.


*&---------------------------------------------------------------------*
*&      Form  add_node_main
*&---------------------------------------------------------------------*
FORM add_node_old      USING       p_aux TYPE it
                               p_relat_key TYPE lvc_nkey
                               p_node TYPE lvc_value
                     CHANGING  p_node_key TYPE lvc_nkey.
  DATA: l_node_text TYPE lvc_value,
        ls_sflight  TYPE sflight.
* set item-layout
  DATA: lt_item_layout TYPE lvc_t_layi,
        ls_item_layout TYPE lvc_s_layi.
*  ls_item_layout-t_image = '<at:var at:name="3P" />'.
  ls_item_layout-fieldname = tree1->c_hierarchy_column_name.
  ls_item_layout-style   =
                        cl_gui_column_tree=>style_intensifd_critical.
  APPEND ls_item_layout TO lt_item_layout.
* add node
  l_node_text =  p_node.
  CALL METHOD tree1->add_node
    EXPORTING
      i_relat_node_key = p_relat_key
      i_relationship   = cl_gui_column_tree=>relat_last_child
      i_node_text      = l_node_text
      is_outtab_line   = p_aux
      it_item_layout   = lt_item_layout
    IMPORTING
      e_new_node_key   = p_node_key.
*****
ENDFORM.                    " add_node
*&---------------------------------------------------------------------*
*&      Form  add_complete_line
*&---------------------------------------------------------------------*
FORM add_complete_line USING   p_aux TYPE it
                               p_relat_key TYPE lvc_nkey
                               p_node TYPE lvc_value
                     CHANGING  p_node_key TYPE lvc_nkey.
  DATA: l_node_text TYPE lvc_value.
* set item-layout
  DATA: lt_item_layout TYPE lvc_t_layi,
        ls_item_layout TYPE lvc_s_layi.
  ls_item_layout-fieldname = tree1->c_hierarchy_column_name.
  ls_item_layout-class   = cl_gui_column_tree=>item_class_text.
*  ls_item_layout-editable = 'X'.
  APPEND ls_item_layout TO lt_item_layout.
  l_node_text =  p_node.
  CALL METHOD tree1->add_node
    EXPORTING
      i_relat_node_key = p_relat_key
      i_relationship   = cl_gui_column_tree=>relat_last_child
      is_outtab_line   = p_aux
      i_node_text      = l_node_text
      it_item_layout   = lt_item_layout
    IMPORTING
      e_new_node_key   = p_node_key.
ENDFORM.                    " add_complete_line
*&---------------------------------------------------------------------*
*&      Form  GET_POPULATE_DATA
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      -->P_SY_CPROG  text
*      -->P_SY_DYNNR  text
*----------------------------------------------------------------------*
FORM get_populate_data  USING    p_sy_cprog
                                 p_sy_dynnr.

  DATA: exec_sql       TYPE string,
        export_table   TYPE c LENGTH 100,
        fild_and_table TYPE c LENGTH 100,
        program_name   TYPE sy-cprog,
        regs           TYPE i,
        assign_ext     TYPE c LENGTH 40,
        global_typ     TYPE STANDARD TABLE OF string WITH HEADER LINE,
        query_sql      TYPE STANDARD TABLE OF string WITH HEADER LINE.

  SELECT table_name ,
           name_feld
      FROM zmdat_lyt INTO TABLE @DATA(t_mdat_table)
      WHERE program_name = @p_prog AND
            scren        = @p_dyn." AND
*            isnode       = '' .

  IF NOT t_mdat_table IS INITIAL.

    DESCRIBE TABLE t_mdat_table LINES regs.

    "CAMPOS DINAMICOS DO LAYOUT E CRIAÇÃO DO PROGRAMA DE QUERY
    APPEND 'REPORT ZDINAMIC_SELECT.' TO query_sql.
    APPEND 'DATA: BEGIN OF GT_EXTERNAL OCCURS 0,' TO query_sql.
    LOOP AT t_mdat_table  ASSIGNING FIELD-SYMBOL(<fs_mdat_table>).

      CONCATENATE <fs_mdat_table>-table_name '-'
                  <fs_mdat_table>-name_feld INTO fild_and_table.

      CONCATENATE
        <fs_mdat_table>-name_feld
        '  TYPE '
        fild_and_table
        ','
         INTO query_sql
         SEPARATED BY space.

      APPEND query_sql.
    ENDLOOP.
    APPEND 'END OF GT_EXTERNAL.' TO query_sql.
    APPEND 'FORM DISPLAY_TABLE.' TO query_sql.
    APPEND 'SELECT ' TO query_sql.
    LOOP AT t_mdat_table  ASSIGNING <fs_mdat_table>.

      IF regs <= 1.
        CONCATENATE
          <fs_mdat_table>-table_name '~' <fs_mdat_table>-name_feld
             INTO query_sql.
      ELSE.
        CONCATENATE
          <fs_mdat_table>-table_name '~' <fs_mdat_table>-name_feld ','
             INTO query_sql.
      ENDIF.
      regs =  regs - 1.
      APPEND query_sql.
    ENDLOOP.

    "PARAMETRO COMPLEMENTAR DO SELECT DINAMICO
    SELECT SINGLE value FROM zmdat_paran INTO @DATA(from_t_mdat_table)
    WHERE program_name = @p_prog AND
          scren        = @p_dyn AND
          is_sql       = 'X' AND
          paramiters   = 'FROM_T_MDAT_TABLE'.

    FIND 'WHERE' IN from_t_mdat_table.
    IF sy-subrc EQ 0.
      REPLACE 'WHERE' WITH
      ' INTO CORRESPONDING FIELDS OF TABLE @GT_EXTERNAL[] WHERE '
      INTO from_t_mdat_table .
    ELSE.
      CONCATENATE from_t_mdat_table ' '
      ' INTO CORRESPONDING FIELDS OF TABLE @GT_EXTERNAL[] '
      INTO from_t_mdat_table.
    ENDIF.

    APPEND from_t_mdat_table TO query_sql.

    APPEND '.' TO query_sql.
    APPEND 'ENDFORM.' TO query_sql.

    GENERATE SUBROUTINE POOL query_sql NAME program_name.
    IF  sy-subrc EQ 0.
      PERFORM display_table IN PROGRAM (program_name).


      FIELD-SYMBOLS <fs_external_table> TYPE ANY TABLE.
      CONCATENATE '(' program_name ')GT_EXTERNAL[]' INTO assign_ext.
      ASSIGN (assign_ext) TO <fs_external_table>.

      IF <fs_external_table> IS ASSIGNED.
        MOVE-CORRESPONDING <fs_external_table>[] TO <ft_mdat_lyt>[].
      ENDIF.

    ENDIF.
  ENDIF.
ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  ADD_NODE
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      -->P_<FS_NODES>  text
*      -->P_L_KEY_NEW  text
*      <--P_L_KEY_LAST  text
*----------------------------------------------------------------------*
FORM add_node  USING    fs_nodes TYPE typ_nodes
                        fs_node_typ
*                        l_key_last
               CHANGING l_key_new.

*  DATA: l_node_text    TYPE lvc_value,
*        lt_item_layout TYPE lvc_t_layi,
*        ls_item_layout TYPE lvc_s_layi,
*        ls_node_layout TYPE lvc_s_layn.
*
*
*
*
*
**data:
**I_RELAT_NODE_KEY  Type  LVC_NKEY,
**I_RELATIONSHIP    Type  INT4,
**IS_OUTTAB_LINE    Type  ANY,
**IS_NODE_LAYOUT    Type  LVC_S_LAYN.
*
*  tree1->add_node(
*     EXPORTING
*      i_relat_node_key = l_key_new
*      i_relationship   = cl_gui_column_tree=>relat_last_child
*      i_node_text      = fs_nodes-label_column
*      is_node_layout   = ls_node_layout
*      is_outtab_line   = fs_node_typ
*      IMPORTING
*      e_new_node_key   = l_key_new
*  ).
**
**  CALL METHOD tree1->add_node ()
**    EXPORTING
**      i_relat_node_key = l_key_new
**      i_relationship   = cl_gui_column_tree=>relat_last_child
**      i_node_text      = l_node_text
**      is_node_layout   = ls_node_layout
**      is_outtab_line   = fs_node_typ
***     it_item_layout   = lt_item_layout
**    IMPORTING
**      e_new_node_key   = l_key_new.

ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  CONFIG
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM config .

  SELECT
      lay~program_name,
      lay~scren,
      lay~level_node,
      lay~name_feld,
      lay~table_name,
      lay~dad_note,
      lay~type,
      lay~isnode,
      lay~label_column,
      lay~width
     FROM zmdat_lyt AS lay
  INTO TABLE @DATA(gt_mdat_lyt)
  WHERE lay~program_name = @p_prog AND
        lay~scren        = @p_dyn.
ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  SORT_LT_DATE
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      -->P_LV_SORT  text
*      <--P_LT_DADOS  text
*----------------------------------------------------------------------*
FORM sort_lt_date  USING    p_sort
                   CHANGING p_dados.

*  DATA dinamic_prog TYPE TABLE OF rssource-line.
*
*  APPEND 'REPORT ZDINAMIC_PROG.' TO dinamic_prog.
*  APPEND '' TO codigo.
*
** Insere o programa na biblioteca
*  INSERT REPORT 'ZDINAMIC_PROG' FROM dinamic_prog.
*
** Executa programa em tempo de execução
*  SUBMIT zdinamic_prog.

ENDFORM.
