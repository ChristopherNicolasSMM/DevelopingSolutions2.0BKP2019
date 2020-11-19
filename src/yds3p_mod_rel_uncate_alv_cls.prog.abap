*&---------------------------------------------------------------------*
*&  Include           YDS3P_MOD_REL_UNCATE_ALV_CLS
*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*
*&       Class LCL_EVENTHANDLER
*&---------------------------------------------------------------------*
*&        eventhandler
*&---------------------------------------------------------------------*
CLASS lcl_eventhandler DEFINITION FINAL.
  PUBLIC SECTION.
    CLASS-METHODS:
        on_toolbar FOR EVENT toolbar OF cl_gui_alv_grid_ext
        IMPORTING e_object,

        on_user_command FOR EVENT user_command OF cl_gui_alv_grid_ext
    IMPORTING e_ucomm.
ENDCLASS.                    "lcl_eventhandler DEFINITION


*&---------------------------------------------------------------------*
*       CLASS lcl_eventhandler IMPLEMENTATION
*&---------------------------------------------------------------------*
*
*&---------------------------------------------------------------------*
CLASS lcl_eventhandler IMPLEMENTATION.
  METHOD on_user_command.
    DATA: lt_rows          TYPE lvc_t_row,
          ls_rows          LIKE LINE OF lt_rows,
          ls_outtab        LIKE LINE OF gt_outtab.

    CASE e_ucomm.
      WHEN 'ANWENDUNG'.
        CALL METHOD go_grid->get_selected_rows
          IMPORTING
            et_index_rows = lt_rows.
        IF NOT lt_rows IS INITIAL.
          LOOP AT lt_rows INTO ls_rows.
*           fill gt_selected_rows.
            READ TABLE gt_outtab INDEX ls_rows-index INTO ls_outtab.
            ls_outtab-forcuram = 4000.
            MODIFY gt_outtab FROM ls_outtab INDEX ls_rows-index.
          ENDLOOP.
          go_grid->refresh_table_display( ).
        ENDIF.
    ENDCASE.
  ENDMETHOD.                    "on_user_command
  METHOD on_toolbar.

    DATA: l_toolbar LIKE LINE OF e_object->mt_toolbar.

*   DEMO: change current line
    READ TABLE e_object->mt_toolbar with key function = 'ANWENDUNG'
    TRANSPORTING no fields.
    IF sy-subrc <> 0.
      l_toolbar-function   = 'ANWENDUNG'.
      l_toolbar-icon       = icon_price.
      l_toolbar-quickinfo  = ' 4000'.
      l_toolbar-disabled   = space.
      APPEND l_toolbar TO e_object->mt_toolbar.
    ENDIF.
    CLEAR l_toolbar.
  ENDMETHOD.                    "on_toolbar

ENDCLASS.                    "lcl_eventhandler IMPLEMENTATION
