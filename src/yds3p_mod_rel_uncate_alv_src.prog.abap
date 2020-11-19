*&---------------------------------------------------------------------*
*&  Include           YDS3P_MOD_REL_UNCATE_ALV_SRC
*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*
*& Tela de Seleção
*&---------------------------------------------------------------------*

SELECTION-SCREEN BEGIN OF BLOCK input_file WITH FRAME TITLE text-030.

PARAMETERS: p_path  TYPE rlgrap-filename
           DEFAULT 'C:\temp\yds3p.dat' NO-DISPLAY .

SELECTION-SCREEN END OF BLOCK input_file.

*& Customizar Parametros para rodar de maneira oculta
*& e assim automatizar processos e opções do relatório.

SELECTION-SCREEN BEGIN OF BLOCK parameters WITH FRAME TITLE text-029.
PARAMETERS:
  "Funções adicionais
  p_ext_na TYPE char1    DEFAULT 'X' NO-DISPLAY,
  "Desativar perfil de navegação
  p_no_nav TYPE char1    DEFAULT ' ' NO-DISPLAY,
  "Ocultar colunas vazias
  p_hid_em TYPE char1    DEFAULT 'X' NO-DISPLAY,
  "Layout
  p_layout TYPE disvariant-variant   NO-DISPLAY.

SELECTION-SCREEN END OF BLOCK parameters.

*& Validar campos da seleção
AT SELECTION-SCREEN OUTPUT.
*AT SELECTION-SCREEN ON VALUE-REQUEST FOR (p_path).
  PERFORM validade_input_screen_0100.
