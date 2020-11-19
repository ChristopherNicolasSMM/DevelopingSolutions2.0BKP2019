*&---------Developing Solutions off people, process and project's-------
*& &
*& & Author...........: Christopher Nicolas Mauricio .'.
*& & Consultancy .....: DS3P
*& & Date develop ....: 16.12.2011
*& & Type of prg .....: Executable
*& & Transaction .....: YDS3P_DEMO_MULT_POOL
*&----------------------------------------------------------------------
REPORT yds3p_demo_mult_pool.


*&---------------------------------------------------------------------
* Elementos de dados Globais
*&---------------------------------------------------------------------
INCLUDE yds3p_demo_mult_pool_top.

*Tela de Seleção Filtros do relatório
INCLUDE yds3p_demo_mult_pool_top_0101.

*Tela 0102 e Sub telas 0103, 0104, 0105
INCLUDE yds3p_demo_mult_pool_top_0102.

*Tela 0108 Log de processamento
INCLUDE yds3p_demo_mult_pool_top_0106.

*Tela 0101 Log de processamento aperfeiçoado
INCLUDE yds3p_demo_mult_pool_top_0107.

*&---------------------------------------------------------------------
* CLASSES
*&---------------------------------------------------------------------
INCLUDE yds3p_demo_mult_pool_c0102.
INCLUDE yds3p_demo_mult_pool_c0106.
INCLUDE yds3p_demo_mult_pool_c0107.

*&---------------------------------------------------------------------
* Tela de seleção 0101
*&---------------------------------------------------------------------
INCLUDE yds3p_demo_mult_pool_scr.

START-OF-SELECTION.

*  CALL SCREEN 0101.

END-OF-SELECTION.
*&---------------------------------------------------------------------
* PBO Modules
*&---------------------------------------------------------------------
  INCLUDE yds3p_demo_mult_pool_o0101.
  INCLUDE yds3p_demo_mult_pool_o0102.
  INCLUDE yds3p_demo_mult_pool_o0103.
  INCLUDE yds3p_demo_mult_pool_o0104.
  INCLUDE yds3p_demo_mult_pool_o0105.
  INCLUDE yds3p_demo_mult_pool_o0106.
  INCLUDE yds3p_demo_mult_pool_o0107.

*&---------------------------------------------------------------------
* INCLUDES for FORM ROUTINES
*&---------------------------------------------------------------------
  INCLUDE yds3p_demo_mult_pool_f0102.
  INCLUDE yds3p_demo_mult_pool_f0103.
  INCLUDE yds3p_demo_mult_pool_f0104.
  INCLUDE yds3p_demo_mult_pool_f0105.
  INCLUDE yds3p_demo_mult_pool_f0106.
  INCLUDE yds3p_demo_mult_pool_f0107.

*&---------------------------------------------------------------------
* PAI Modules
*&---------------------------------------------------------------------
  INCLUDE yds3p_demo_mult_pool_i0101.
  INCLUDE yds3p_demo_mult_pool_i0102.
  INCLUDE yds3p_demo_mult_pool_i0103.
  INCLUDE yds3p_demo_mult_pool_i0104.
  INCLUDE yds3p_demo_mult_pool_i0105.
  INCLUDE yds3p_demo_mult_pool_i0106.
  INCLUDE yds3p_demo_mult_pool_i0107.

*&---------------------------------------------------------------------
* Include HTML do menu lateral
*&---------------------------------------------------------------------
  INCLUDE yds3p_demo_mult_pool_menuhtml.
*&---------------------------------------------------------------------
* Dastboard página inicial HTML ao abrir cockpit
*&---------------------------------------------------------------------
  INCLUDE yds3p_demo_mult_pool_html2.
  INCLUDE yds3p_demo_mult_pool_html3.
