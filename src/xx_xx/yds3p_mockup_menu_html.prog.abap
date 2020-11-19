*&---------Developing Solutions off people, process and project's-------
*& &
*& & Author...........: Christopher Nicolas Mauricio .'.
*& & Consultancy .....: DS3P
*& & Date develop ....: 20.11.2020
*& & Type of prg .....: Executable
*& & Transaction .....:
*&----------------------------------------------------------------------
REPORT yds3p_mockup_menu_html.

*& Declaração de dados
INCLUDE YDS3P_MENU_HTML_TOP.

*& Classes
INCLUDE YDS3P_MENU_HTML_CLS.

*& Define's
INCLUDE YDS3P_MENU_HTML_DEF.

*& Seleção de filtros em tela
INCLUDE YDS3P_MENU_HTML_SRC.

*&----------------------------------------------------------------------
*& Start
*&----------------------------------------------------------------------

START-OF-SELECTION.

  CALL SCREEN 0100.

END-OF-SELECTION.

*& Forms de código
INCLUDE YDS3P_MENU_HTML_F01.

*& Processos antes da tela
INCLUDE YDS3P_MENU_HTML_B01.

*& Eventos após carregar tela
INCLUDE YDS3P_MENU_HTML_P01.

*& Include contendo código HTML&CSS&Javascript
INCLUDE YDS3P_MENU_HTML_HTML001.
