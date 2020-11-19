*&----------------------------------------------------------------------
*& Tabelas
*&----------------------------------------------------------------------

*&----------------------------------------------------------------------
*& Tipos
*&----------------------------------------------------------------------

TYPE-POOLS: icon.

DEFINE create_button.
  &1-icon_id    = &2.
  &1-text       = &3.
  &1-icon_text  = &3.
END-OF-DEFINITION.


TYPES: BEGIN OF typ_makt,
         matnr TYPE makt-matnr,
         maktx TYPE makt-maktx,
       END OF typ_makt.

TYPES: BEGIN OF typ_t001k,
         bwkey TYPE t001k-bwkey,
         bukrs TYPE t001k-bukrs,
       END OF typ_t001k,

       BEGIN OF typ_objectid,
         objectid TYPE cdhdr-objectid,
       END OF typ_objectid,

       BEGIN OF y_html,
         dataset(255) TYPE c,
       END OF y_html,

       BEGIN OF typ_img,
         image  TYPE char50,
         url    TYPE c LENGTH 255,
         ximage TYPE xstring,
       END OF typ_img,

       BEGIN OF typ_tree,
         node(10),
         desc(30),
       END OF typ_tree.

TYPES: node_table_type LIKE STANDARD TABLE OF mtreesnode
  WITH DEFAULT KEY.
*&----------------------------------------------------------------------
*& Estruturas
*&----------------------------------------------------------------------

*&----------------------------------------------------------------------
*& Tabela Interna
*&----------------------------------------------------------------------

*       Batchinputdata of single transaction
DATA:   bdcdata LIKE bdcdata    OCCURS 0 WITH HEADER LINE.
*       messages of call transaction
DATA:   messtab LIKE bdcmsgcoll OCCURS 0 WITH HEADER LINE.
*       error session opened (' ' or 'X')


DATA: bdc_tab LIKE bdcdata    OCCURS 0 WITH HEADER LINE.
DATA: t_msg            TYPE STANDARD TABLE OF bapiret2,
      ts_data          TYPE STANDARD TABLE OF y_html,
      ts_data_menu     TYPE STANDARD TABLE OF y_html,
      ts_data_header   TYPE STANDARD TABLE OF y_html,
      ts_data_timeline TYPE STANDARD TABLE OF y_html,
      ts_data_textarea TYPE STANDARD TABLE OF y_html,
      ts_data_aux      TYPE STANDARD TABLE OF y_html,
      ts_data_h        TYPE STANDARD TABLE OF y_html.

*&----------------------------------------------------------------------
*& Constantes
*&----------------------------------------------------------------------

CONSTANTS:
  lc_i  TYPE tvarv-sign                  VALUE 'I',
  lc_eq TYPE tvarv-opti                  VALUE 'EQ',
  lc_bt TYPE tvarv-opti                  VALUE 'BT'.

CONSTANTS: BEGIN OF c_ucomm,
             xml TYPE sy-ucomm   VALUE 'XML',
           END OF c_ucomm.

*&----------------------------------------------------------------------
*& Classes
*&----------------------------------------------------------------------

CLASS lcl_application DEFINITION DEFERRED.
CLASS cl_gui_cfw DEFINITION LOAD.

*&----------------------------------------------------------------------
*& Variáveis
*&----------------------------------------------------------------------

DATA: gr_details       TYPE REF TO cl_gui_container,
      gr_painel        TYPE REF TO cl_gui_container,
      g_menu_container TYPE REF TO cl_gui_custom_container,
      g_main_container TYPE REF TO cl_gui_custom_container,
      g_custom_painel  TYPE REF TO cl_gui_custom_container,
      html_str         TYPE string,
      html_str_time    TYPE string,
      html_str_text    TYPE string,
      error_list       TYPE yds3p_cl_abap_browser=>html_table.

DATA: o_null TYPE REF TO cl_gui_custom_container,
      o_text TYPE REF TO cl_gui_textedit.
DATA: i_data TYPE TABLE OF char1024.

DATA:
  t_objectid TYPE STANDARD TABLE OF typ_objectid,
  t_cdhdr    TYPE cdhdr_tab,
  it_cdhdr   TYPE cdhdr_tab,
  t_cdpos    TYPE cdpos_tab,
  it_cdpos   TYPE cdpos_tab,
  ls_cdpos   TYPE cdpos,
  ls_cdhdr   TYPE cdhdr.

DATA: opt LIKE ctu_params.

CONSTANTS: c_n TYPE c VALUE 'N'.
DATA: ctumode TYPE ctu_params-dismode VALUE 'E'.

DATA: lo_tree          TYPE REF TO cl_salv_tree,
      lo_salv_table    TYPE REF TO cl_salv_table,
      lo_nodes         TYPE REF TO cl_salv_nodes,
      lo_node          TYPE REF TO cl_salv_node,
      lo_item          TYPE REF TO cl_salv_item,
      lo_column_tree   TYPE REF TO cl_salv_column_tree,
      lo_columns_tree  TYPE REF TO cl_salv_columns_tree,
      lo_columns       TYPE REF TO cl_salv_columns,
      lo_tree_settings TYPE REF TO cl_salv_tree_settings,
      lo_events        TYPE REF TO cl_salv_events_tree.

DATA:
  lr_objectid    TYPE RANGE OF cdhdr-objectid,
  lr_tabname     TYPE RANGE OF cdpos-objectid,
  lr_tabkey      TYPE RANGE OF cdpos-tabkey,
  lv_title       TYPE char100,
  lv_title1      TYPE char50,
  lv_title2      TYPE char50,
  lv_title3      TYPE char50,
  lv_data_title  TYPE char10,
  lv_data2_title TYPE char10,
  lv_tpamb       TYPE char20,
  lv_rfc_status  TYPE char20.

DATA:  lc_cont TYPE i.

DATA:  lc_tabix  TYPE sy-tabix,
       lt_fields TYPE sval.

DATA: wc_node_key TYPE tv_nodekey.
DATA: gd_percent TYPE i.

DATA: nodata(1) VALUE '/'.          "nodata
DATA: ok_code LIKE sy-ucomm.

DATA result TYPE char50.
DATA lv_msgid TYPE sy-msgid.
DATA lv_msgno TYPE sy-msgno.
DATA ls_msg    TYPE bapiret2.
DATA lc_erro    TYPE char1.
DATA ls_icons TYPE typ_img.
DATA gt_icons TYPE TABLE OF typ_img.


DATA: e_data            TYPE y_html,
      e_data_aux        TYPE y_html,
      gv_control_logo   TYPE c LENGTH 1,
      gv_control_menu   TYPE c LENGTH 1,
      gv_control_header TYPE c LENGTH 1,
      e_user            TYPE usr03,
      w_uname           TYPE char20,
      w_url             TYPE char255,
      w_url_atual       TYPE char255,
      v_url             TYPE localfile,
      v_img             TYPE bds_compid.

DATA: gs_toolbar         TYPE stb_button.
DATA  repid TYPE sy-repid.
DATA  dynnr TYPE sy-dynnr.
DATA: selected VALUE 'X',
      v_sim.

DATA: gt_fieldcat_rel_a        TYPE slis_t_fieldcat_alv,
      gw_layout_rel_a          TYPE slis_layout_alv,
      it_fieldcatalog_rel_a    TYPE lvc_t_fcat,
      ls_fieldcatalog_rel_a    TYPE lvc_s_fcat,
      it_sort_grid_rel_a       TYPE lvc_t_sort,
      gs_layout_rel_a          TYPE lvc_s_layo,
      gs_alv_refres_cond_rel_a TYPE lvc_s_stbl,
      it_exclude_fcode_rel_a   TYPE ui_functions,
      wa_exclude_fcode_rel_a   LIKE LINE OF it_exclude_fcode_rel_a,
      gs_variant_rel_a         TYPE disvariant.

DATA: gt_fieldcat_rel_b        TYPE slis_t_fieldcat_alv,
      gw_layout_rel_b          TYPE slis_layout_alv,
      it_fieldcatalog_rel_b    TYPE lvc_t_fcat,
      ls_fieldcatalog_rel_b    TYPE lvc_s_fcat,
      it_sort_grid_rel_b       TYPE lvc_t_sort,
      gs_layout_rel_b          TYPE lvc_s_layo,
      gs_alv_refres_cond_rel_b TYPE lvc_s_stbl,
      it_exclude_fcode_rel_b   TYPE ui_functions,
      gs_variant_rel_b         TYPE disvariant,
      wa_exclude_fcode_rel_b   LIKE LINE OF it_exclude_fcode_rel_b.

* Containers
DATA g_dock_main        TYPE REF TO cl_gui_docking_container.
DATA g_dock_hist        TYPE REF TO cl_gui_docking_container.
DATA g_cont_batch       TYPE REF TO cl_gui_custom_container.
DATA g_header_cont      TYPE REF TO cl_gui_custom_container.

* Splitter
DATA g_splitter         TYPE REF TO cl_gui_splitter_container.
DATA g_splitter2        TYPE REF TO cl_gui_splitter_container.

* Grids
DATA g_grid_batch       TYPE REF TO cl_gui_alv_grid.

* Tree
DATA gr_tree            TYPE REF TO cl_simple_tree_model.
DATA gr_tree_cont       TYPE REF TO cl_gui_container.
DATA gr_header          TYPE REF TO cl_gui_container.
DATA:  ref_html_tree    TYPE REF TO cl_gui_html_viewer.
DATA:  ref_html_header  TYPE REF TO cl_gui_html_viewer.
DATA it_tree_table      TYPE TABLE OF typ_tree.
DATA: lo_dock          TYPE REF TO cl_gui_docking_container,
      lo_html          TYPE REF TO cl_gui_html_viewer,
      lt_html          TYPE TABLE OF w3_html,
      t_event_tab_html TYPE cntl_simple_events,
      ls_event_html    LIKE LINE OF t_event_tab_html.

DATA: g_node_key  TYPE tv_nodekey,
      g_item_name TYPE tv_itmname.

* Tree Events
DATA: events_html TYPE cntl_simple_events,
      event_html  TYPE cntl_simple_event.

*---------- Internal tables (and related work areas)-------------------*
DATA: wa_fcode TYPE sy-ucomm,
      it_fcode LIKE TABLE OF wa_fcode.
CONSTANTS:
 c_dest_none TYPE rfcdest VALUE 'NONE'.

DATA: w_rfcdest    TYPE rfcdest.

DATA: g_obj_application    TYPE REF TO lcl_application.

*----------------------------------------------------------------------*
* Textos para geração do arquivo
*----------------------------------------------------------------------*
DATA: gv_line_text(4096)  TYPE c,
      gt_block_text(4096) TYPE c OCCURS 0,
      gt_lin_text(4096)   TYPE c OCCURS 0.

*----------------------------------------------------------------------*
* Declarações Fieldcat Tela Exportar Bocos
*----------------------------------------------------------------------*
DATA: g_custom_container_gera_bl TYPE REF TO cl_gui_custom_container,
      g_grid_gerar_blocos        TYPE REF TO cl_gui_alv_grid,
      ge_layout_gerar_blocos     TYPE lvc_s_layo,
      gt_fieldcat_gerar_blocos   TYPE lvc_t_fcat,
      g_container_gerar_blocos   TYPE scrfname VALUE 'BATCH_CONT',
      txt_op_conf_centro         TYPE werks_d,
      txt_op_conf_material       TYPE matnr,
      it_exclude                 TYPE ui_functions.

*------------------------------------------------------------------------
* Botões Dinâmicos
*------------------------------------------------------------------------
DATA: exportar_key TYPE smp_dyntxt.

*------------------------------------------------------------------------
* LDB
*------------------------------------------------------------------------
DATA: lt_cosel     TYPE tcosel,
      ls_cosel     TYPE cosel,
      lt_params    TYPE STANDARD TABLE OF rsparams,
      lt_callbacks TYPE STANDARD TABLE OF ldbcb.

*...build table with selection criteria..............................*

*&----------------------------------------------------------------------
*& Fiel-Symbols
*&----------------------------------------------------------------------

FIELD-SYMBOLS: <fs_data> TYPE char1024.
