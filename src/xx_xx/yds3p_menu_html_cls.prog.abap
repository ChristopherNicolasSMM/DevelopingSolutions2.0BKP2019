*&---------------------------------------------------------------------*
*&  Include           YDS3P_MOCKUP_ALV_CL_CLS
*&---------------------------------------------------------------------*


CLASS gcl_event_receiver DEFINITION DEFERRED.


*----------------------------------------------------------------------*
*       CLASS gcl_event_receiver DEFINITION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
CLASS gcl_event_receiver DEFINITION.

  PUBLIC SECTION.

    METHODS:
      handle_toolbar
                    FOR EVENT toolbar OF cl_gui_alv_grid
        IMPORTING e_object e_interactive,

      handle_user_command
                    FOR EVENT user_command OF cl_gui_alv_grid
        IMPORTING e_ucomm.

  PRIVATE SECTION.

ENDCLASS.                    "gcl_event_receiver DEFINITION

*----------------------------------------------------------------------*
*       CLASS gcl_event_receiver IMPLEMENTATION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
CLASS gcl_event_receiver IMPLEMENTATION.

  METHOD handle_toolbar.
    DATA: ls_toolbar  TYPE stb_button.

* append a separator to normal toolbar
    CLEAR ls_toolbar.
    MOVE 3 TO ls_toolbar-butn_type.
    APPEND ls_toolbar TO e_object->mt_toolbar.
* append an icon to show booking table
    CLEAR ls_toolbar.
    MOVE 'NEW' TO ls_toolbar-function.
    MOVE icon_intensify_critical TO ls_toolbar-icon.
    MOVE 'Campo personalisado... Informação'(111) TO ls_toolbar-quickinfo.
    MOVE 'Campo personalisado'(112) TO ls_toolbar-text.
    MOVE ' ' TO ls_toolbar-disabled.
    APPEND ls_toolbar TO e_object->mt_toolbar.

  ENDMETHOD.                    "handle_toolbar
*-------------------------------------------------------------------
  METHOD handle_user_command.
    DATA: lt_rows TYPE lvc_t_row.
    DATA: ls_row  TYPE lvc_s_row.

    CASE e_ucomm.
      WHEN 'DELETE'.
        CALL METHOD grid->get_selected_rows
          IMPORTING
            et_index_rows = lt_rows.
        CALL METHOD cl_gui_cfw=>flush.
        IF sy-subrc EQ 0.
****          LOOP AT lt_rows INTO ls_row.
****            READ TABLE lt_fit00x INTO ls_fit00x INDEX ls_row-index.
****            IF SY-SUBRC EQ 0.
****              DELETE FROM zfit00x WHERE
****              zarquivo = ls_fit00x-nome_arquivo AND
****              cnpj     = ls_fit00x-cnpj AND
****              barcode  = ls_fit00x-barras.
****              IF SY-SUBRC EQ 0.
****                COMMIT WORK.
****              ENDIF.
****              DELETE lt_fit00x INDEX ls_row-index.
****            ENDIF.
****          ENDLOOP.

          CALL METHOD grid->refresh_table_display.
        ENDIF.
    ENDCASE.
  ENDMETHOD.                           "handle_user_command
*-----------------------------------------------------------------
ENDCLASS.                    "gcl_event_receiver IMPLEMENTATION


DATA: gcl_event TYPE REF TO gcl_event_receiver.
