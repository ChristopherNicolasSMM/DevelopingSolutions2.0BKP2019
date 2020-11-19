*-------------------------------------------------------------------
***INCLUDE column_tree_control_demoO01 .
*-------------------------------------------------------------------
*&---------------------------------------------------------------------*
*&      Module  PBO_0400  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE pbo_100 OUTPUT.

  SET PF-STATUS '0100'.
  IF tree1 IS INITIAL.
* create Hierarchy-header
    PERFORM build_hierarchy_header CHANGING l_hierarchy_header.
* CATALOG
    PERFORM fo_fieldcat USING l_hierarchy_header.
* CREATE TREE
    PERFORM create_tree. "NAO USA NODE

* create info-table for html-header
    PERFORM build_comment USING
                   lt_list_commentary.

* repid for saving variants
    ls_variant-report = sy-repid.
* Creation of ALV
    CALL METHOD tree1->set_table_for_first_display
      EXPORTING
        is_hierarchy_header = l_hierarchy_header
        it_list_commentary  = lt_list_commentary
*       I_SAVE              = 'A'
*       IS_VARIANT          = LS_VARIANT
      CHANGING
        it_outtab           = <ft_mdat_lyt>
        it_fieldcatalog     = gt_fieldcatalog.
** create hierarchy
    PERFORM create_hierarchy.
* register events
    PERFORM register_events.
  ENDIF.
  CALL METHOD cl_gui_cfw=>flush.
ENDMODULE.                 " PBO_0100  OUTPUT
