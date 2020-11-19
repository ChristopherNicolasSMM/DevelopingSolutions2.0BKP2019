
**********************************************************************
* Tabelas
**********************************************************************
TABLES: zmdat_lyt, zmdat_config.
**********************************************************************
* Tipos
**********************************************************************
TYPE-POOLS: slis.
TYPES:  BEGIN OF it ,
          node_main(15) TYPE c,
          node_n01(15)  TYPE c,
          node_n02(15)  TYPE c,
          node_n03(15)  TYPE c,
        END OF it.

TYPES: BEGIN OF typ_paramiters,
         program_name TYPE zmdat_config-program_name,
         scren        TYPE zmdat_config-scren,
         title        TYPE zmdat_config-title,
         level_node   TYPE zmdat_lyt-level_node,
         name_feld    TYPE zmdat_lyt-name_feld,
         type         TYPE zmdat_lyt-type,
         isnode       TYPE zmdat_lyt-isnode,
         label_column TYPE zmdat_lyt-label_column,
         width        TYPE zmdat_lyt-width,
       END OF typ_paramiters.

TYPES: BEGIN OF typ_nodes,
         name_feld    TYPE zmdat_lyt-name_feld,
         label_column TYPE zmdat_lyt-label_column,
         level_node   TYPE zmdat_lyt-level_node,
       END OF typ_nodes.


TYPES: BEGIN OF typ_mara,
         matnr TYPE mara-matnr,
         mtart TYPE mara-mtart,
         mbrsh TYPE mara-mbrsh,
         matkl TYPE mara-matkl,
         bismt TYPE mara-bismt,
         meins TYPE mara-meins,
       END OF typ_mara.




**********************************************************************
* Includes
**********************************************************************
INCLUDE <icon>.
INCLUDE bcalv_tree_event_receiver.
**********************************************************************
* Estruturas
**********************************************************************
DATA: gs_mdat_lyt TYPE zmdat_lyt .
DATA: gs_mara TYPE typ_mara .
**********************************************************************
* Tabela Interna
**********************************************************************
DATA: gt_paramiters TYPE STANDARD TABLE OF typ_paramiters,
      gt_mdat_lyt   TYPE STANDARD TABLE OF zmdat_lyt.
DATA: gt_mara TYPE STANDARD TABLE OF typ_mara .
DATA: lt_dados       TYPE STANDARD TABLE OF zmonior_tree_mara.
**********************************************************************
* Constantes
**********************************************************************

**********************************************************************
* Variáveis
**********************************************************************
DATA:
  lo_structdescr TYPE REF TO cl_abap_structdescr,
  lo_tabledescr  TYPE REF TO cl_abap_tabledescr,
  lt_comp_all    TYPE cl_abap_structdescr=>component_table,
  lv_assing_data TYPE REF TO data.
FIELD-SYMBOLS:
  <component>   TYPE LINE OF abap_component_tab,
  <ft_mdat_lyt> TYPE ANY TABLE.

DATA: i_source LIKE line OCCURS 100 WITH HEADER LINE.
DATA: newline(72).
DEFINE ap.
  APPEND &1 TO I_SOURCE.
END-OF-DEFINITION.
**********************************************************************
* Classes
**********************************************************************
CLASS cl_gui_column_tree DEFINITION LOAD.
CLASS cl_gui_cfw DEFINITION LOAD.
****STRUCTURE FOR ALV TREE
DATA:
  lt_list_commentary TYPE slis_t_listheader,       "COMENTARY
  l_logo             TYPE sdydo_value,             "LOGO
  ls_variant         TYPE disvariant,              "VARIANT
  l_hierarchy_header TYPE treev_hhdr,              "HEADER
  tree1              TYPE REF TO cl_gui_alv_tree,  "TREE
  gt_fieldcatalog    TYPE lvc_t_fcat,              "CATALOG
  ok_code            TYPE sy-ucomm.                "OK-CODE

DATA: BEGIN OF lt_aux_node OCCURS 0,
        field   TYPE name_komp,
        level   TYPE i,
        dad     type name_komp,
*        f_type  TYPE komp_type,
        old_val TYPE string,
*        new_val TYPE string,
        old_key TYPE LVC_NKEY,
        new_key TYPE LVC_NKEY,
      END OF lt_aux_node.

INITIALIZATION.

  SELECT * FROM zmdat_lyt INTO CORRESPONDING FIELDS OF TABLE gt_mdat_lyt
    WHERE program_name = sy-cprog AND
          scren        = sy-dynnr
    ORDER BY isnode DESCENDING level_node ASCENDING.

  DATA l_string TYPE string.
  SELECT * FROM zmdat_lyt INTO @DATA(mdat_lyt)
    WHERE program_name = @sy-cprog AND
          scren        = @sy-dynnr AND
          isnode       = 'X'
    ORDER BY  level_node ASCENDING.

    APPEND INITIAL LINE TO lt_comp_all ASSIGNING <component>.
    IF mdat_lyt-type IS INITIAL.
      <component>-type ?= cl_abap_datadescr=>describe_by_data( l_string ).
    ELSE.
      <component>-type ?= cl_abap_datadescr=>describe_by_data( mdat_lyt-type ).
    ENDIF.

    <component>-name = mdat_lyt-name_feld.

  ENDSELECT.

  SELECT * FROM zmdat_lyt INTO mdat_lyt
    WHERE program_name = sy-cprog AND
          scren        = sy-dynnr AND
          isnode       <> 'X'.

    APPEND INITIAL LINE TO lt_comp_all ASSIGNING <component>.
    IF mdat_lyt-type IS INITIAL.
      <component>-type ?= cl_abap_datadescr=>describe_by_data( l_string ).
    ELSE.
      <component>-type ?= cl_abap_datadescr=>describe_by_data( mdat_lyt-type ).
    ENDIF.
    <component>-name = mdat_lyt-name_feld.

  ENDSELECT.


* create structure description
  lo_structdescr = cl_abap_structdescr=>create( lt_comp_all ).

* create table description for structure
  lo_tabledescr = cl_abap_tabledescr=>create(
                  p_line_type  = lo_structdescr
                  p_table_kind = cl_abap_tabledescr=>tablekind_std
                  p_unique     = abap_false ).

* create data object
  CREATE DATA lv_assing_data TYPE HANDLE lo_tabledescr.

  ASSIGN lv_assing_data->* TO <ft_mdat_lyt>.


  DATA: it_exit  TYPE it OCCURS 0,
        it_exit1 TYPE it OCCURS 0,
        wa_exit1 LIKE LINE OF it_exit,
        wa_exit  LIKE LINE OF it_exit.
