REPORT zdevsol_cons_cnpj_json_ws.

**********************************************************************
* Tipos criados
**********************************************************************
TYPES: BEGIN OF typ_cnpj_cons,
         dat_ult_cons TYPE zdsol_cnpj_cons-dat_ult_cons,
         cnpj         TYPE zdsol_cnpj_cons-cnpj,
       END OF typ_cnpj_cons.

TYPES: BEGIN OF typ_retcons_cnpj,
         cnpj                   TYPE ztretcons_cnpj-cnpj,
         atividade_principal    TYPE ztretcons_cnpj-atividade_principal,
         text1                  TYPE ztretcons_cnpj-text1,
         data_situacao          TYPE ztretcons_cnpj-data_situacao,
         nome                   TYPE ztretcons_cnpj-nome,
         uf                     TYPE ztretcons_cnpj-uf,
         telefone               TYPE ztretcons_cnpj-telefone,
         email                  TYPE ztretcons_cnpj-email,
         text2                  TYPE ztretcons_cnpj-text2,
         code2                  TYPE ztretcons_cnpj-code2,
         text3                  TYPE ztretcons_cnpj-text3,
         code3                  TYPE ztretcons_cnpj-code3,
         text4                  TYPE ztretcons_cnpj-text4,
         code4                  TYPE ztretcons_cnpj-code4,
         text5                  TYPE ztretcons_cnpj-text5,
         code5                  TYPE ztretcons_cnpj-code5,
         situacao               TYPE ztretcons_cnpj-situacao,
         bairro                 TYPE ztretcons_cnpj-bairro,
         logradouro             TYPE ztretcons_cnpj-logradouro,
         numero                 TYPE ztretcons_cnpj-numero,
         cep                    TYPE ztretcons_cnpj-cep,
         municipio              TYPE ztretcons_cnpj-municipio,
         abertura               TYPE ztretcons_cnpj-abertura,
         natureza_juridica      TYPE ztretcons_cnpj-natureza_juridica,
         fantasia               TYPE ztretcons_cnpj-fantasia,
         ultima_atualizacao     TYPE ztretcons_cnpj-ultima_atualizacao,
         status                 TYPE ztretcons_cnpj-status,
         tipo                   TYPE ztretcons_cnpj-tipo,
         complemento            TYPE ztretcons_cnpj-complemento,
         motivo_situacao        TYPE ztretcons_cnpj-motivo_situacao,
         situacao_especial      TYPE ztretcons_cnpj-situacao_especial,
         data_situacao_especial TYPE ztretcons_cnpj-data_situacao_especial,
         capital_social         TYPE ztretcons_cnpj-capital_social,
       END OF typ_retcons_cnpj.

**********************************************************************
* Tabelas
**********************************************************************

DATA: lt_zdsol_cnpj_cons TYPE STANDARD TABLE OF typ_cnpj_cons.
DATA: lt_ztretcons_cnpj  TYPE STANDARD TABLE OF typ_retcons_cnpj.
DATA: result_tab         TYPE TABLE OF string WITH HEADER LINE.

**********************************************************************
* Estruturas
**********************************************************************
DATA: ls_zdsol_cnpj_cons TYPE typ_cnpj_cons.
DATA: ls_ztretcons_cnpj  TYPE typ_retcons_cnpj.

**********************************************************************
* Variáveis
**********************************************************************
DATA: id           TYPE numc10,
      json_string  TYPE string,
      w_string     TYPE string,
      w_result     TYPE string,
      r_str        TYPE string,
      lc_campo(40) TYPE c,
      lc_field(40) TYPE c.

**********************************************************************
* Field-Symbols
**********************************************************************
FIELD-SYMBOLS : <fs_field> TYPE any.

**********************************************************************
* Classes
**********************************************************************
DATA: http_client TYPE REF TO if_http_client .

**********************************************************************
* Início da Seleção
**********************************************************************

* Seleciona os CNPJs a serem consultados
*SELECT * INTO CORRESPONDING FIELDS OF TABLE lt_zdsol_cnpj_cons
*  FROM  zdsol_cnpj_cons ."WHERE dat_ult_cons = '' or  dat_ult_cons is NULL.
*ls_zdsol_cnpj_cons-cnpj = '22065246000184'.
ls_zdsol_cnpj_cons-cnpj = '30053633000129'.
ls_zdsol_cnpj_cons-dat_ult_cons = ''.
APPEND ls_zdsol_cnpj_cons TO lt_zdsol_cnpj_cons.

IF sy-subrc EQ 0.

  LOOP AT lt_zdsol_cnpj_cons INTO ls_zdsol_cnpj_cons.

    CLEAR w_string .
    w_string = 'http://www.receitaws.com.br/v1/cnpj/'.

    CONCATENATE w_string ls_zdsol_cnpj_cons-cnpj INTO w_string.

    CALL METHOD cl_http_client=>create_by_url
      EXPORTING
        url                = w_string
      IMPORTING
        client             = http_client
      EXCEPTIONS
        argument_not_found = 1
        plugin_not_active  = 2
        internal_error     = 3
        OTHERS             = 4.

    TRY .

* Estabelece o método GET e POST
        CALL METHOD http_client->request->set_header_field
          EXPORTING
            name  = 'GET'
            value = 'GET'.

        CALL METHOD http_client->send
          EXCEPTIONS
            http_communication_failure = 1
            http_invalid_state         = 2.

        CALL METHOD http_client->receive
          EXCEPTIONS
            http_communication_failure = 1
            http_invalid_state         = 2
            http_processing_failed     = 3.
        CLEAR json_string .
    ENDTRY.

* Resultado do web service
    json_string = http_client->response->get_cdata( ).

    DATA(out) = cl_demo_output=>new( )->begin_section( `JSON-Data` ).
    DATA(json) = cl_abap_codepage=>convert_to( json_string ).
    DATA(reader) = cl_sxml_string_reader=>create( json ).
    DATA(writer) = CAST if_sxml_writer( cl_sxml_string_writer=>create( ) ).

    TRY.
        DO.
          DATA(node) = reader->read_next_node( ).

          IF node IS INITIAL.
            EXIT.
          ENDIF.

          writer->write_node( node ).
          CASE node->type.
            WHEN if_sxml_node=>co_nt_element_open.
              DATA(open_element) = CAST if_sxml_open_element( node ).
              DATA(attributes)  = open_element->get_attributes( ).
              LOOP AT attributes INTO DATA(attribute).
                IF attribute->value_type = if_sxml_value=>co_vt_text.
                  lc_campo = attribute->get_value( ).
                ENDIF.
              ENDLOOP.
              CONTINUE.
            WHEN if_sxml_node=>co_nt_element_close.
              CONTINUE.
            WHEN if_sxml_node=>co_nt_value.
              DATA(value_node) = CAST if_sxml_value_node( node ).
              IF value_node->value_type = if_sxml_value=>co_vt_text.

* Manipulação de CNAEs Principal e Secundários
                IF lc_campo EQ 'code'.
                  IF ls_ztretcons_cnpj-atividade_principal IS INITIAL.
                    lc_campo = 'atividade_principal'.
                  ELSEIF ls_ztretcons_cnpj-code2 IS INITIAL.
                    lc_campo = 'code2'.
                  ELSEIF ls_ztretcons_cnpj-code3 IS INITIAL.
                    lc_campo = 'code3'.
                  ELSEIF ls_ztretcons_cnpj-code4 IS INITIAL.
                    lc_campo = 'code4'.
                  ELSEIF ls_ztretcons_cnpj-code5 IS INITIAL.
                    lc_campo = 'code5'.
                  ENDIF.
                ELSEIF lc_campo EQ 'text'.
                  IF ls_ztretcons_cnpj-text1 IS INITIAL.
                    lc_campo = 'text1'.
                  ELSEIF ls_ztretcons_cnpj-text2 IS INITIAL.
                    lc_campo = 'text2'.
                  ELSEIF ls_ztretcons_cnpj-text3 IS INITIAL.
                    lc_campo = 'text3'.
                  ELSEIF ls_ztretcons_cnpj-text4 IS INITIAL.
                    lc_campo = 'text4'.
                  ELSEIF ls_ztretcons_cnpj-text5 IS INITIAL.
                    lc_campo = 'text5'.
                  ENDIF.
                ENDIF.

* Atribuição dinamica dos campos
                CONCATENATE 'ls_ztretcons_cnpj-' lc_campo INTO lc_field.
                ASSIGN (lc_field) TO <fs_field>.
                <fs_field> = value_node->get_value( )..

              ENDIF.
              CONTINUE.
            WHEN OTHERS.
              EXIT.
          ENDCASE.
        ENDDO.

      CATCH cx_sxml_parse_error INTO DATA(parse_error).
        out->write_text( parse_error->get_text( ) ).
    ENDTRY.

* Insere os dados do CNPJ na tabela
*    ls_ztretcons_cnpj-mandt = sy-mandt.
*    MODIFY ztretcons_cnpj  FROM  ls_ztretcons_cnpj.
*    COMMIT WORK.
    APPEND ls_ztretcons_cnpj TO lt_ztretcons_cnpj.

* Salva o Log da consulta
    ls_zdsol_cnpj_cons-dat_ult_cons = sy-datum.
    MODIFY lt_zdsol_cnpj_cons FROM ls_zdsol_cnpj_cons.
*    COMMIT WORK.
  ENDLOOP.
ELSE.

  MESSAGE ID sy-msgid TYPE 'E' NUMBER sy-msgno
            INTO DATA(mtext)
            WITH 'Não contem CNPJ a serem consultados...'.
ENDIF.

BREAK-POINT.
