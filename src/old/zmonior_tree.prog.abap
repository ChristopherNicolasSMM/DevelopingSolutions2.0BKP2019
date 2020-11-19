*&----------------------------------------------------------------------*
*& Nome do objeto.: ZMONIOR_TREE                                        *
*& Título.........: Modelo Dinâmico para Monitor de eventos             *
*& Objetivo.......:                                                     *
*& Transação......:                                                     *
*&----------------------------------------------------------------------*
*& Autor..........: Christopher Nicolas Mauricio .'.                    *
*& Consultoria....: H2 Consult                                          *
*& Data desenv....: 19/09/2018                                         *
*& Tipo de prg....: Pool                                               *
*&----------------------------------------------------------------------*
REPORT: ZMONIOR_TREE MESSAGE-ID TREE_CONTROL_MSG..

INCLUDE ZMONIOR_TREE_TOP.
**********************************************************************
* Tela de Seleção
**********************************************************************
INCLUDE ZMONIOR_TREE_SCREN.

INCLUDE ZMONIOR_TREE_O01.
INCLUDE ZMONIOR_TREE_I01.
INCLUDE ZMONIOR_TREE_F01.

**********************************************************************
* Início da Seleção
**********************************************************************
  START-OF-SELECTION.

  SET SCREEN P_DYN.
