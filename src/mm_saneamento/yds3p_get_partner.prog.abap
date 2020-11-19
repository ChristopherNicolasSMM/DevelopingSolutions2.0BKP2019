*&---------Developing Solutions off people, process and project's-------
*& &
*& & Author...........: Christopher Nicolas Mauricio .'.
*& & Consultancy .....: DS3P
*& & Date develop ....: 25.07.2019
*& & Type of prg .....: Executable
*& & Transaction .....: YDS3P_GET_PARTNER
*&----------------------------------------------------------------------

REPORT yds3p_get_partner.

*& Declaração de dados
INCLUDE yds3p_get_partner_top.

*& Classes
INCLUDE yds3p_get_partner_cls.

*& Seleção de filtros em tela
INCLUDE yds3p_get_partner_src.

*& Forms de código
INCLUDE yds3p_get_partner_f01.

START-OF-SELECTION.

*  CALL SCREEN 100.

*& Processos antes da tela
  INCLUDE yds3p_get_partner_b01.

*& Eventos após carregar tela
  INCLUDE yds3p_get_partner_p01.
