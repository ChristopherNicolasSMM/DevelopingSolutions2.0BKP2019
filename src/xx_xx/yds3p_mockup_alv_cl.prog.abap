*&---------Developing Solutions off people, process and project's-------
*& &
*& & Author...........: Christopher Nicolas Mauricio .'.
*& & Consultancy .....: DS3P
*& & Date develop ....: 20.11.2020
*& & Type of prg .....: Executable
*& & Transaction .....:
*&----------------------------------------------------------------------
REPORT yds3p_mockup_alv_cl.

*& Declaração de dados
INCLUDE yds3p_mockup_alv_cl_top.

*& Classes
INCLUDE yds3p_mockup_alv_cl_cls.

*& Define's
INCLUDE yds3p_mockup_alv_cl_def.

*& Seleção de filtros em tela
INCLUDE yds3p_mockup_alv_cl_src.

*&----------------------------------------------------------------------
*& Start
*&----------------------------------------------------------------------

START-OF-SELECTION.

  CALL SCREEN 0100.

END-OF-SELECTION.

*& Forms de código
INCLUDE yds3p_mockup_alv_cl_f01.

*& Processos antes da tela
INCLUDE yds3p_mockup_alv_cl_b01.

*& Eventos após carregar tela
INCLUDE yds3p_mockup_alv_cl_p01.
