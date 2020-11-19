*&---------------------------------------------------------------------*
*&      Module  CREATE_OBJECTS  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE create_objects OUTPUT.

  PERFORM fill_html_menu.
  " Montar o Container Principal
  CASE ok_code.
    WHEN 'VIEW'. "Exibir Arquivo TXT
*      PERFORM generate_html_textarea.
*      PERFORM exibir_container_txt.
  ENDCASE.

ENDMODULE.                    "create_objects OUTPUT
*&---------------------------------------------------------------------*
*&      Module  STATUS_0100  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE status_0100 OUTPUT.

  SET TITLEBAR  '0100'   WITH 'Modelo de Menu HTML em relatório ALV'.
  SET PF-STATUS '0100'.

ENDMODULE.                    "status_0100 OUTPUT

*&---------------------------------------------------------------------*
*&      Module  STATUS_0200  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE init_0200 OUTPUT.

  SET PF-STATUS '0200'.

ENDMODULE.                    "init_0200 OUTPUT
*&---------------------------------------------------------------------*
*&      Module  STATUS_9000  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE status_9000 OUTPUT.
  SET PF-STATUS 'STATUS'.
   fichas-activetab = g_fichas-pressed_tab.
   free g_menu_container.

  gcl_html_menu=>main( ).
  gv_control_menu = 'X'.
ENDMODULE.
