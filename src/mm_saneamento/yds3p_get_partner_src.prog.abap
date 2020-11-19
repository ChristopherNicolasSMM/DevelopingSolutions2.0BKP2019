*&---------------------------------------------------------------------*
*&  Include           YDS3P_GET_PARTNER_SRC
*&---------------------------------------------------------------------*
*&----------------------------------------------------------------------
*& Tela de Seleção
*&----------------------------------------------------------------------

SELECTION-SCREEN BEGIN OF BLOCK input_file WITH FRAME TITLE text-030.

PARAMETERS: p_path  TYPE rlgrap-filename
           DEFAULT 'C:\temp\yds3p.dat' NO-DISPLAY .

SELECTION-SCREEN END OF BLOCK input_file.

*& Customizar Parametros para rodar de maneira oculta
*& e assim automatizar processos e opções do relatório.

SELECTION-SCREEN BEGIN OF BLOCK parameters WITH FRAME TITLE text-950.
PARAMETERS:
  "Funções adicionais
  p_change TYPE char1    DEFAULT 'X'," NO-DISPLAY,
  "Layout
  p_layout TYPE disvariant-variant."   NO-DISPLAY.


SELECTION-SCREEN BEGIN OF BLOCK display WITH FRAME TITLE text-951.
PARAMETERS:
  "Executar em background
  p_bakg RADIOBUTTON GROUP RBDP   DEFAULT 'X' ,
  "Exibir na tela o resultado
  p_dpyl RADIOBUTTON GROUP RBDP.

SELECTION-SCREEN END OF BLOCK display.


SELECTION-SCREEN END OF BLOCK parameters.

*&----------------------------------------------------------------------
*& Validação da Seleção
*&----------------------------------------------------------------------

*& Validar campos da seleção
AT SELECTION-SCREEN OUTPUT.
*AT SELECTION-SCREEN ON VALUE-REQUEST FOR (p_path).
  PERFORM validade_input_initial_screen.
