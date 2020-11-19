*&---------------------------------------------------------------------*
*&  Include           YDS3P_MOD_TREE_ALV_CLS
*&---------------------------------------------------------------------*

*---------------------------------------------------------------------*
*       CLASS lcl_event_handler DEFINITION
*---------------------------------------------------------------------*
*       ........                                                      *
*---------------------------------------------------------------------*
CLASS lcl_event_handler DEFINITION.

  PUBLIC SECTION.

    CLASS-METHODS:
*&--------------------------------Definições dos metodos da ALV Tree
      on_item_cxt_menu_request
      FOR EVENT item_context_menu_request OF
                    cl_gui_alv_tree
        IMPORTING menu,

      on_item_click
      FOR EVENT link_click OF
                    cl_gui_alv_tree
        IMPORTING fieldname
                    node_key,


      on_item_double_click
      FOR EVENT item_double_click OF
                    cl_gui_alv_tree
        IMPORTING fieldname
                    node_key,


      on_item_cxt_menu_selected
      FOR EVENT item_context_menu_selected OF
                    cl_gui_alv_tree
        IMPORTING fcode,


*& Observação: use o evento ON_DROP_COMPLETE para processar as ações
*& finais como excluir um nó no caso de uma operação dnd de movimento

*&--------------------------------Definições dos metodos da Toolbar

    on_function_selected
    for event function_selected of
                  cl_gui_toolbar
      importing fcode.

ENDCLASS.

*---------------------------------------------------------------------*
*       CLASS lcl_event_handler IMPLEMENTATION
*---------------------------------------------------------------------*
*       ........                                                      *
*---------------------------------------------------------------------*
CLASS lcl_event_handler IMPLEMENTATION.
  METHOD on_item_cxt_menu_request.
*&  Adiciona botõ na barra de opções
    CALL METHOD menu->add_submenu
      EXPORTING
        menu = g_change_menu
        text = 'Change'.

  ENDMETHOD.

  METHOD on_item_cxt_menu_selected.
    CALL METHOD on_function_selected
      EXPORTING
        fcode = fcode.
  ENDMETHOD.

  METHOD on_function_selected.
    CASE fcode.
      WHEN 'FONT_DEFAULT'.
        PERFORM change USING 1 cl_gui_column_tree=>item_font_default.
      WHEN 'PROP'.
        PERFORM change USING 1 cl_gui_column_tree=>item_font_prop.
      WHEN 'FIXED'.
        PERFORM change USING 1 cl_gui_column_tree=>item_font_fixed.


      WHEN 'STYLE_DEFAULT'.
        PERFORM change USING 2 cl_gui_column_tree=>style_default.
      WHEN 'INHERITED'.
        PERFORM change USING 2 cl_gui_column_tree=>style_inherited.
      WHEN 'INTENSIFIED'.
        PERFORM change USING 2 cl_gui_column_tree=>style_intensified.
      WHEN 'INACTIVE'.
        PERFORM change USING 2 cl_gui_column_tree=>style_inactive.
      WHEN 'CRITICAL'.
        PERFORM change
          USING 2 cl_gui_column_tree=>style_intensifd_critical.
      WHEN 'POSITIVE'.
        PERFORM change
          USING 2 cl_gui_column_tree=>style_emphasized_positive.
      WHEN 'NEGATIVE'.
        PERFORM change
          USING 2 cl_gui_column_tree=>style_emphasized_negative.
      WHEN 'EMPHASIZED'.
        PERFORM change USING 2 cl_gui_column_tree=>style_emphasized.


      WHEN 'TEXT'.
        PERFORM change USING 0 cl_gui_column_tree=>item_class_text.
      WHEN 'CHECKBOX'.
        PERFORM change USING 0 cl_gui_column_tree=>item_class_checkbox.
      WHEN 'BUTTON'.
        PERFORM change USING 0 cl_gui_column_tree=>item_class_button.
      WHEN 'LINK'.
        PERFORM change USING 0 cl_gui_column_tree=>item_class_link.


      WHEN 'IMAGE'.
        PERFORM change USING 3 0.
      WHEN 'NOIMAGE'.
        PERFORM change USING 3 1.
    ENDCASE.
  ENDMETHOD.

  METHOD on_item_click.
  ENDMETHOD.

  METHOD on_item_double_click.
  ENDMETHOD.

ENDCLASS.
