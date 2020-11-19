*&---------------------------------------------------------------------*
*&  Include           YDS3P_PANEL_VIEW_F01
*&---------------------------------------------------------------------*


*---------------------------------------------------------------------*
*      Form  config_load
*---------------------------------------------------------------------*
FORM config_load.

  DATA: o_null   TYPE REF TO cl_gui_custom_container,
        o_text   TYPE REF TO cl_gui_textedit,
        lc_tabix TYPE sy-tabix.
  DATA transacao(50) TYPE c.

  REFRESH i_data.
  READ REPORT 'YDS3P_PANEL_VIEW_HTML' INTO i_data.
  LOOP AT i_data.
    MOVE i_data+1 TO i_data.
    MODIFY i_data.
  ENDLOOP.

*&-------------------------------------------------------------
*&----------Inicio da tratativa de valores --------------------
*&-------------------------------------------------------------

  DATA: it_bwt0001 TYPE TABLE OF zbwt0001 WITH HEADER LINE.
*-- Parametrização do Cockpit
  SELECT * FROM zbwt0001 INTO TABLE it_bwt0001.
  IF sy-subrc NE 0.
    MESSAGE s398(00) WITH 'Não há entradas na Tabela'.
  ENDIF.

  SORT it_bwt0001 BY id ASCENDING.

  DATA: transf(20) TYPE c .

  READ TABLE it_bwt0001 INDEX 1 .

  LOOP AT i_data.
    lc_tabix = sy-tabix.

    FIND '#VLFAT' IN i_data.
    IF sy-subrc EQ 0.
      transf =  it_bwt0001-vlfat.
      PERFORM formatar_moeda USING transf transf.
      REPLACE '#VLFAT' WITH transf  INTO i_data.
      MODIFY i_data.
    ENDIF.

    FIND '#VLREC' IN i_data.
    IF sy-subrc EQ 0.
      transf = it_bwt0001-vlrec.
      PERFORM formatar_moeda USING transf transf.
      REPLACE '-' WITH '' INTO transf.
      REPLACE '#VLREC' WITH transf  INTO i_data.
      MODIFY i_data.
    ENDIF.
    FIND '#PINA' IN i_data.
    IF sy-subrc EQ 0.
      transf = it_bwt0001-pina.

      REPLACE '#PINA' WITH transf INTO i_data.
      MODIFY i_data.
    ENDIF.
    FIND '#VLPAG' IN i_data.
    IF sy-subrc EQ 0.
      transf = it_bwt0001-vlpag.
      PERFORM formatar_moeda USING transf transf.
      REPLACE '#VLPAG' WITH transf INTO i_data.
      MODIFY i_data.
    ENDIF.
    FIND '#VLAFAT' IN i_data.
    IF sy-subrc EQ 0.
      transf = it_bwt0001-vlafat.
      PERFORM formatar_moeda USING transf transf.
      REPLACE '#VLAFAT' WITH transf INTO i_data.
      MODIFY i_data.
    ENDIF.
    FIND '#VLAREC' IN i_data.
    IF sy-subrc EQ 0.
      transf = it_bwt0001-vlarec.
      PERFORM formatar_moeda USING transf transf.
      REPLACE '#VLAREC' WITH transf INTO i_data.
      MODIFY i_data.
    ENDIF.
    FIND '#MARGC' IN i_data.
    IF sy-subrc EQ 0.
      transf = it_bwt0001-margc.
      PERFORM formatar_moeda USING transf transf.
      REPLACE '#MARGC' WITH transf INTO i_data.
      MODIFY i_data.
    ENDIF.
    FIND '#VLAPAG' IN i_data.
    IF sy-subrc EQ 0.
      transf = it_bwt0001-vlapag.
      PERFORM formatar_moeda USING transf transf.
      REPLACE '#VLAPAG' WITH transf INTO i_data.
      MODIFY i_data.
    ENDIF.
    FIND '#PZMEDREC' IN i_data.
    IF sy-subrc EQ 0.
      transf = it_bwt0001-pzmedrec.
*     PERFORM formatar_moeda USING transf transf.
      REPLACE '#PZMEDREC' WITH transf INTO i_data.
      MODIFY i_data.
    ENDIF.
    FIND '#cheque' IN i_data.
    IF sy-subrc EQ 0.
      transf = it_bwt0001-vlarecchq.
      PERFORM formatar_moeda USING transf transf.
      REPLACE '#cheque' WITH transf INTO i_data.
      MODIFY i_data.
    ENDIF.
    FIND '#PMARGC' IN i_data.
    IF sy-subrc EQ 0.
      transf = it_bwt0001-pmargc.

      REPLACE '#PMARGC' WITH transf INTO i_data.
      MODIFY i_data.
    ENDIF.
    FIND '#PZMEDPAG' IN i_data.
    IF sy-subrc EQ 0.
      transf = it_bwt0001-pzmedpag.
*     PERFORM formatar_moeda USING transf transf.
      REPLACE '#PZMEDPAG' WITH transf INTO i_data.
      MODIFY i_data.
    ENDIF.
    FIND '#VLEST' IN i_data.
    IF sy-subrc EQ 0.
      transf = it_bwt0001-vlest.
      PERFORM formatar_moeda USING transf transf.
      REPLACE '#VLEST' WITH transf INTO i_data.
      MODIFY i_data.
    ENDIF.

  ENDLOOP.



*&-------------------------------------------------------------
*&---------------Final da tratativa de valores ----------------
*&-------------------------------------------------------------




  CREATE OBJECT o_null
    EXPORTING
      container_name = 'NULL'.

  CREATE OBJECT o_text
    EXPORTING
      parent = o_null.

  CALL METHOD o_text->set_text_as_r3table
    EXPORTING
      table = i_data[].

  CALL METHOD cl_gui_cfw=>flush.
  REFRESH i_data[].

  CALL METHOD o_text->get_text_as_stream
    IMPORTING
      text = i_data[].


  CALL METHOD o_html->load_data
    EXPORTING
*     url                  = v_url
      type                 = 'text'
      subtype              = 'html'
    IMPORTING
      assigned_url         = v_url
    CHANGING
      data_table           = i_data[]
    EXCEPTIONS
      dp_invalid_parameter = 1
      dp_error_general     = 2
      cntl_error           = 3
      OTHERS               = 4.
  IF sy-subrc <> 0.
    MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
               WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
  ENDIF.

  CALL METHOD o_html->show_data( url = v_url ).

ENDFORM.                    " bds_load

*---------------------------------------------------------------------*
*      Form  HTM_CONVERT
*---------------------------------------------------------------------*
FORM htm_convert  USING p_text.

  DATA v_len.
  PERFORM fill_codes.
  LOOP AT i_codes.
    CONDENSE i_codes-cod NO-GAPS.
    v_len = strlen( i_codes-cod ).
    DO 20 TIMES.
      REPLACE i_codes-char WITH i_codes-cod(v_len)
         INTO p_text.
      IF sy-subrc NE 0.
        EXIT.
      ENDIF.
    ENDDO.
  ENDLOOP.
ENDFORM.                    " HTM_CONVERT

*---------------------------------------------------------------------*
*      Form  FILL_CODES
*---------------------------------------------------------------------*
FORM fill_codes.
  CHECK i_codes IS INITIAL.
  MOVE: 'Á' TO i_codes-char,
        'Á' TO i_codes-cod.
  APPEND i_codes.
  MOVE: 'á' TO i_codes-char,
        'á' TO i_codes-cod.
  APPEND i_codes.
  MOVE: 'Â' TO i_codes-char,
        'Â' TO i_codes-cod.
  APPEND i_codes.
  MOVE: 'â' TO i_codes-char,
        'â' TO i_codes-cod.
  APPEND i_codes.
  MOVE: 'À' TO i_codes-char,
        'À' TO i_codes-cod.
  APPEND i_codes.
  MOVE: 'à' TO i_codes-char,
        'à' TO i_codes-cod.
  APPEND i_codes.
  MOVE: 'Å' TO i_codes-char,
        'Å' TO i_codes-cod.
  APPEND i_codes.
  MOVE: 'å' TO i_codes-char,
        'å' TO i_codes-cod.
  APPEND i_codes.
  MOVE: 'Ã' TO i_codes-char,
        'Ã' TO i_codes-cod.
  APPEND i_codes.
  MOVE: 'ã' TO i_codes-char,
        'ã' TO i_codes-cod.
  APPEND i_codes.
  MOVE: 'Ä' TO i_codes-char,
        'Ä' TO i_codes-cod.
  APPEND i_codes.
  MOVE: 'ä' TO i_codes-char,
        'ä' TO i_codes-cod.
  APPEND i_codes.
  MOVE: 'Æ' TO i_codes-char,
        'Æ' TO i_codes-cod.
  APPEND i_codes.
  MOVE: 'æ' TO i_codes-char,
        'æ' TO i_codes-cod.
  APPEND i_codes.
  MOVE: 'É' TO i_codes-char,
        'É' TO i_codes-cod.
  APPEND i_codes.
  MOVE: 'é' TO i_codes-char,
        'é' TO i_codes-cod.
  APPEND i_codes.
  MOVE: 'Ê' TO i_codes-char,
        'Ê' TO i_codes-cod.
  APPEND i_codes.
  MOVE: 'ê' TO i_codes-char,
        'ê' TO i_codes-cod.
  APPEND i_codes.
  MOVE: 'È' TO i_codes-char,
        'È' TO i_codes-cod.
  APPEND i_codes.
  MOVE: 'è' TO i_codes-char,
        'è' TO i_codes-cod.
  APPEND i_codes.
  MOVE: 'Ë' TO i_codes-char,
        'Ë' TO i_codes-cod.
  APPEND i_codes.
  MOVE: 'ë' TO i_codes-char,
        'ë' TO i_codes-cod.
  APPEND i_codes.
  MOVE: 'Ð' TO i_codes-char,
        'Ð' TO i_codes-cod.
  APPEND i_codes.
  MOVE: 'ð' TO i_codes-char,
        'ð' TO i_codes-cod.
  APPEND i_codes.
  MOVE: 'Í' TO i_codes-char,
        'Í' TO i_codes-cod.
  APPEND i_codes.
  MOVE: 'í' TO i_codes-char,
        'í' TO i_codes-cod.
  APPEND i_codes.
  MOVE: 'Î' TO i_codes-char,
        'Î' TO i_codes-cod.
  APPEND i_codes.
  MOVE: 'î' TO i_codes-char,
        'î' TO i_codes-cod.
  APPEND i_codes.
  MOVE: 'Ì' TO i_codes-char,
        'Ì' TO i_codes-cod.
  APPEND i_codes.
  MOVE: 'ì' TO i_codes-char,
        'ì' TO i_codes-cod.
  APPEND i_codes.
  MOVE: 'Ï' TO i_codes-char,
        'Ï' TO i_codes-cod.
  APPEND i_codes.
  MOVE: 'ï' TO i_codes-char,
        'ï' TO i_codes-cod.
  APPEND i_codes.
  MOVE: 'Ó' TO i_codes-char,
        'Ó' TO i_codes-cod.
  APPEND i_codes.
  MOVE: 'ó' TO i_codes-char,
        'ó' TO i_codes-cod.
  APPEND i_codes.
  MOVE: 'Ô' TO i_codes-char,
        'Ô' TO i_codes-cod.
  APPEND i_codes.
  MOVE: 'ô' TO i_codes-char,
        'ô' TO i_codes-cod.
  APPEND i_codes.
  MOVE: 'Ò' TO i_codes-char,
        'Ò' TO i_codes-cod.
  APPEND i_codes.
  MOVE: 'ò' TO i_codes-char,
        'ò' TO i_codes-cod.
  APPEND i_codes.
  MOVE: 'Ø' TO i_codes-char,
        'Ø' TO i_codes-cod.
  APPEND i_codes.
  MOVE: 'ø' TO i_codes-char,
        'ø' TO i_codes-cod.
  APPEND i_codes.
  MOVE: 'Õ' TO i_codes-char,
        'Õ' TO i_codes-cod.
  APPEND i_codes.
  MOVE: 'õ' TO i_codes-char,
        'õ' TO i_codes-cod.
  APPEND i_codes.
  MOVE: 'Ö' TO i_codes-char,
        'Ö' TO i_codes-cod.
  APPEND i_codes.
  MOVE: 'ö' TO i_codes-char,
        'ö' TO i_codes-cod.
  APPEND i_codes.
  MOVE: 'Ú' TO i_codes-char,
        'Ú' TO i_codes-cod.
  APPEND i_codes.
  MOVE: 'ú' TO i_codes-char,
        'ú' TO i_codes-cod.
  APPEND i_codes.
  MOVE: 'Û' TO i_codes-char,
        'Û' TO i_codes-cod.
  APPEND i_codes.
  MOVE: 'û' TO i_codes-char,
        'û' TO i_codes-cod.
  APPEND i_codes.
  MOVE: 'Ù' TO i_codes-char,
        'Ù' TO i_codes-cod.
  APPEND i_codes.
  MOVE: 'ù' TO i_codes-char,
        'ù' TO i_codes-cod.
  APPEND i_codes.
  MOVE: 'Ü' TO i_codes-char,
        'Ü' TO i_codes-cod.
  APPEND i_codes.
  MOVE: 'ü' TO i_codes-char,
        'ü' TO i_codes-cod.
  APPEND i_codes.
  MOVE: 'Ç' TO i_codes-char,
        'Ç' TO i_codes-cod.
  APPEND i_codes.
  MOVE: 'ç' TO i_codes-char,
        'ç' TO i_codes-cod.
  APPEND i_codes.
  MOVE: 'Ñ' TO i_codes-char,
        'Ñ' TO i_codes-cod.
  APPEND i_codes.
  MOVE: 'ñ' TO i_codes-char,
        'ñ' TO i_codes-cod.
  APPEND i_codes.
  MOVE: '<' TO i_codes-char,
        '<' TO i_codes-cod.
  APPEND i_codes.
  MOVE: '>' TO i_codes-char,
        '>' TO i_codes-cod.
  APPEND i_codes.
*  move: '&' to i_codes-char,
*        '&' to i_codes-cod.
  APPEND i_codes.
  MOVE: '"' TO i_codes-char,
        '"' TO i_codes-cod.
  APPEND i_codes.
  MOVE: '®' TO i_codes-char,
        '®' TO i_codes-cod.
  APPEND i_codes.
  MOVE: '©' TO i_codes-char,
        '©' TO i_codes-cod.
  APPEND i_codes.
  MOVE: 'Ý' TO i_codes-char,
        'Ý' TO i_codes-cod.
  APPEND i_codes.
  MOVE: 'ý' TO i_codes-char,
        'ý' TO i_codes-cod.
  APPEND i_codes.
  MOVE: 'Þ' TO i_codes-char,
        'Þ' TO i_codes-cod.
  APPEND i_codes.
  MOVE: 'þ' TO i_codes-char,
        'þ' TO i_codes-cod.
  APPEND i_codes.
  MOVE: 'ß' TO i_codes-char,
        'ß' TO i_codes-cod.
  APPEND i_codes.
ENDFORM.                    " FILL_CODES
*&---------------------------------------------------------------------*
*&      Form  FORMATAR_MOEDA
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      -->P_TRANSF  text
*----------------------------------------------------------------------*
FORM formatar_moeda  USING  i_valor  e_valor.

  DATA: 1_bloco  TYPE c LENGTH 3,
        2_bloco  TYPE c LENGTH 3,
        3_bloco  TYPE c LENGTH 3,
        4_bloco  TYPE c LENGTH 2,
        tamanho  TYPE i,
        valor    TYPE c LENGTH 20,
        valores  TYPE TABLE OF string WITH HEADER LINE,
        negativo TYPE c.

  valor = i_valor.
  CONDENSE valor.
  COMPUTE tamanho = strlen(  valor ).
  REPLACE '.' WITH ',' INTO valor.

  IF NOT valor EQ '0,00'.
    FIND '-' IN valor.
    IF sy-subrc EQ 0.
      negativo = 'X'.
    ENDIF.

    IF NOT negativo EQ 'X'.
      tamanho = tamanho - 3.
*     tamanho = tamanho - 2.
      APPEND  valor+tamanho(3) TO valores.
      valor+tamanho(3) = ''.
      tamanho = tamanho - 3.
    ELSE.
      tamanho = tamanho - 3.
*     tamanho = tamanho - 3.
      APPEND  valor+tamanho(3) TO valores.
      valor+tamanho(3) = ''.
      tamanho = tamanho - 3.
    ENDIF.

    IF tamanho >= 3.
      APPEND valor+tamanho(4) TO valores.
      valor+tamanho(4) = ''.
      tamanho = tamanho - 3.
    ENDIF.
    IF tamanho > 3.
      APPEND valor+tamanho(3) TO valores.
      valor+tamanho(3) = ''.
      tamanho = tamanho - 3.
    ENDIF.
    IF tamanho > 3.
      APPEND valor+tamanho(3) TO valores.
      valor+tamanho(3) = ''.
      tamanho = tamanho - 3.
    ENDIF.
    IF tamanho < 3.

      COMPUTE tamanho = strlen(  valor ).
      IF tamanho => 3.
        tamanho = tamanho - 3.
        APPEND valor+tamanho(3) TO valores.
        valor+tamanho(3) = ''.
        tamanho = tamanho - 3.
      ELSE.
        APPEND valor TO valores.
      ENDIF.

      IF tamanho => 3.
        APPEND valor+tamanho(3) TO valores.
        valor+tamanho(3) = ''.
        tamanho = tamanho - 3.
      ELSE.
        APPEND valor TO valores.
      ENDIF.

    ENDIF.

  ENDIF.
  CLEAR  e_valor.
  LOOP AT valores.

    IF sy-tabix > 2.
      CONCATENATE valores '.' e_valor INTO e_valor.
    ELSE.
      CONCATENATE valores e_valor INTO e_valor.
    ENDIF.
  ENDLOOP.

  CONCATENATE 'R$' e_valor INTO e_valor.
  CLEAR negativo.

  IF e_valor EQ 'R$'.
    CLEAR e_valor.
  ENDIF.
  IF e_valor+0(3) EQ 'R$.'.
    e_valor+0(3) = 'R$ '.
  ENDIF.


ENDFORM.
