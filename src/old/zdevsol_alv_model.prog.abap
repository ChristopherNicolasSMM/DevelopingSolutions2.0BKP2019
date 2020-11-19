REPORT ZDEVSOL_ALV_MODEL.
*&----------------------------------------------------------------------*
*& Nome do objeto.:                                                     *
*& Título.........:                                                     *
*& Objetivo.......:                                                     *
*& Transação......:                                                     *
*&----------------------------------------------------------------------*
*& Autor..........:                                                     *
*& Consultoria....:                                                     *
*& Data desenv....:                                                     *
*& Tipo de prg....:                                                     *
*&----------------------------------------------------------------------*

**********************************************************************
* Tabelas
**********************************************************************

**********************************************************************
* Tipos
**********************************************************************

**********************************************************************
* Estruturas
**********************************************************************

**********************************************************************
* Tabela Interna
**********************************************************************
DATA: lt_mara TYPE STANDARD TABLE OF mara WITH HEADER LINE.
**********************************************************************
* Constantes
**********************************************************************

**********************************************************************
* Variáveis
**********************************************************************

**********************************************************************
* Classes
**********************************************************************
CLASS lcl_event_receiver DEFINITION.
  PUBLIC SECTION.
    METHODS on_user_command
                  FOR EVENT double_click OF cl_gui_alv_grid
      IMPORTING e_row e_column es_row_no.
ENDCLASS.

CLASS lcl_event_receiver IMPLEMENTATION.
  METHOD on_user_command.
    BREAK-POINT.
    IF sy-dynnr = ''.
      PERFORM get_register_on_click USING e_row e_column es_row_no.
    ENDIF.
  ENDMETHOD.
ENDCLASS.

DATA: go_alv     TYPE REF TO cl_salv_table,
      go_columns TYPE REF TO cl_salv_columns_table,
      go_column  TYPE REF TO cl_salv_column,
      go_handler TYPE REF TO lcl_event_receiver.

**********************************************************************
* Tela de Seleção
**********************************************************************
PARAMETERS: p_pop AS CHECKBOX DEFAULT 'X'.

**********************************************************************
* Início da Seleção
**********************************************************************
START-OF-SELECTION.




  PERFORM select_data.

  PERFORM output_alv.





END-OF-SELECTION.

***********************************************************************
*Rotinas
***********************************************************************

*&---------------------------------------------------------------------*
*&      Form  SELECT_DATA
*&---------------------------------------------------------------------*
FORM select_data .
**********************************************************************
* Selecionar Dados
**********************************************************************
  SELECT * FROM mara
    INTO CORRESPONDING FIELDS OF TABLE lt_mara
    UP TO 10 ROWS.

ENDFORM.

*&---------------------------------------------------------------------*
*&      Form  OUTPUT_ALV
*&---------------------------------------------------------------------*
FORM output_alv .
**********************************************************************
* Saida em Tela
**********************************************************************
  TRY.
      cl_salv_table=>factory(
        IMPORTING
          r_salv_table = go_alv
        CHANGING
          t_table      = lt_mara[] ).

    CATCH cx_salv_msg.
  ENDTRY.
  BREAK-POINT.
  " Ordem dos Parametros para Fieldcat:
  " PERFORM field_catalog USING 'MATNR' 'Qtd' 'Quanti.' 'Quantidade' 100 3 'X'.
  "   Campo            Char30
  "   Texto Pequeno    Char10
  "   Texto Médio      Char20
  "   Texto Longo      Char40
  "   Tamanho          Numc6
  "   Alinhamento      Numc1   '1 = LEFT' '2 = RIGHT' '3 = CENTERED'
  "   Visivel?         Boolean 'X = S'

  PERFORM field_catalog USING 'MATNR' 'Qtd' 'Quanti.' 'Quantidade' 100 3 'X'.

  CREATE OBJECT go_handler.
  SET HANDLER go_handler->on_user_command FOR ALL INSTANCES.

* Display ALV, verificando se deve ou não ser Popup.
  IF go_alv IS BOUND.
    IF p_pop EQ 'X'.
      go_alv->set_screen_popup(
       start_column = '32'
       end_column   = '152'
       start_line   = '2'
       end_line     = '10' ).
    ENDIF.
    go_alv->display( ).
  ENDIF.
ENDFORM.

*&---------------------------------------------------------------------*
*&      Form  GET_REGISTER_ON_CLICK
*&---------------------------------------------------------------------*
FORM get_register_on_click  USING row  TYPE lvc_s_row
                                       column TYPE lvc_s_col
                                       row_id TYPE lvc_s_roid.

* Utiliza a tabela interna do Alv, pois tem que ter a rowid do filtro pesquisado
  DATA: ls_mara   LIKE LINE OF lt_mara[].

* Identifica a linha que sofreu a ação.
  READ TABLE lt_mara INTO ls_mara
  INDEX row_id-row_id.

  SELECT * FROM mara INTO TABLE lt_mara WHERE matnr = ls_mara-matnr.

  CALL METHOD cl_gui_cfw=>set_new_ok_code
    EXPORTING
      new_code = 'REFRESH'.
ENDFORM.

*&---------------------------------------------------------------------*
*&      Form  field_catalog
*&---------------------------------------------------------------------*
FORM field_catalog USING  VALUE(iv_fieldname)   TYPE lvc_s_fcat-fieldname
                          VALUE(iv_short_text)  TYPE scrtext_s
                          VALUE(iv_medium_text) TYPE scrtext_m
                          VALUE(iv_long_text)   TYPE scrtext_l
                          VALUE(iv_length)      TYPE lvc_outlen
                          VALUE(iv_alignment)   TYPE numeric
                          VALUE(iv_visible)     TYPE boolean.

  go_columns = go_alv->get_columns( ).
  go_columns->set_optimize( abap_true ).
*  go_columns->set_column_position( columnname = iv_fieldname position = iv_position ).

  go_column = go_columns->get_column( iv_fieldname ).
  go_column->set_short_text( iv_short_text ).
  go_column->set_medium_text( iv_medium_text ).
  go_column->set_long_text( iv_long_text ).
  go_column->set_output_length( iv_length ).
  go_column->set_alignment( iv_alignment ).
  go_column->set_visible( iv_visible ).

ENDFORM.
