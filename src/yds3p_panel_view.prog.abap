*&---------Developing Solutions off people, process and project's-------
*& &
*& & Author...........: Christopher Nicolas Mauricio .'.
*& & Consultancy .....: DS3P
*& & Date develop ....: 10.07.2019
*& & Type of prg .....: Executable
*& & Transaction .....: YDS3P_R001
*&----------------------------------------------------------------------

REPORT yds3p_panel_view.

*& Declaração de dados
INCLUDE yds3p_panel_view_top.

*& Classes
INCLUDE yds3p_panel_view_cls.

*& Define's
INCLUDE yds3p_panel_view_def.

*& Seleção de filtros em tela
INCLUDE yds3p_panel_view_src.

*& Forms de código
INCLUDE yds3p_panel_view_f01.

*& Processos antes da tela
INCLUDE yds3p_panel_view_b01.

*& Eventos após carregar tela
INCLUDE yds3p_panel_view_p01.



START-OF-SELECTION.

  MOVE sy-repid TO v_repid.

  CREATE OBJECT o_cont
    EXPORTING
      repid                       = v_repid
      dynnr                       = '0100'
      side                        = o_cont->dock_at_top
      extension                   = 3000
      style                       = o_cont->ws_child
      metric                      = o_cont->metric_pixel
      no_autodef_progid_dynnr     = 'X'
    EXCEPTIONS
      cntl_error                  = 1
      cntl_system_error           = 2
      create_error                = 3
      lifetime_error              = 4
      lifetime_dynpro_dynpro_link = 5
      OTHERS                      = 6.

  IF sy-subrc EQ 0.

    CREATE OBJECT o_html
      EXPORTING
        parent  = o_cont
      EXCEPTIONS
        no_html = 1.

    CALL METHOD cl_gui_cfw=>flush.

  ENDIF.

  IF sy-subrc IS INITIAL.
    PERFORM config_load.
    CALL SCREEN 0100.
  ENDIF.

END-OF-SELECTION.



include YDS3P_PANEL_VIEW_HTML.
