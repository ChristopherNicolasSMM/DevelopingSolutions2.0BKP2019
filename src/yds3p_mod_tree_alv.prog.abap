*&---------Developing Solutions off people, process and project's-------
*& &
*& & Author...........: Christopher Nicolas Mauricio .'.
*& & Consultancy .....: DS3P
*& & Date develop ....: 10.07.2019
*& & Type of prg .....: Executable
*& & Transaction .....: YDS3P_R001
*&----------------------------------------------------------------------

REPORT yds3p_mod_tree_alv.

*& Declaração de dados
INCLUDE yds3p_mod_tree_alv_top.

*& Classes
INCLUDE yds3p_mod_tree_alv_cls.

*& Seleção de filtros em tela
INCLUDE yds3p_mod_tree_alv_src.

*& Forms de código
INCLUDE yds3p_mod_tree_alv_f01.

START-OF-SELECTION.

  CALL SCREEN 100.

*& Processos antes da tela
  INCLUDE yds3p_mod_tree_alv_b01.

*& Eventos após carregar tela
  INCLUDE yds3p_mod_tree_alv_p01.
