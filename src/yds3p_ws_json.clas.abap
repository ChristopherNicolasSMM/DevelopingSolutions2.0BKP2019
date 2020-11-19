class YDS3P_WS_JSON definition
  public
  final
  create public .

public section.

*&----------------------------------------------------------------------
*& Tabelas
*&----------------------------------------------------------------------
*&----------------------------------------------------------------------
*& Tipos
*&----------------------------------------------------------------------
*&----------------------------------------------------------------------
*& Estruturas
*&----------------------------------------------------------------------
  data GS_RESULT_TAB type STRING .
  data:
*&----------------------------------------------------------------------
*& Tabela Interna
*&----------------------------------------------------------------------
    gt_result_tab  TYPE TABLE OF string .
*&----------------------------------------------------------------------
*& Constantes
*&----------------------------------------------------------------------
*&----------------------------------------------------------------------
*& Variáveis
*&----------------------------------------------------------------------
  data ID type NUMC10 .
  data JSON_STRING type STRING .   "Json String
  data W_RESULT type STRING .     "Resultado
  data R_STR type STRING .        "Retorno em String Json
  data:
    lc_campo(40) TYPE c .    "Campo da estrutura
  data:
    lc_field(40) TYPE c .    "Campo do WebService
  data W_STRING type STRING .
*&----------------------------------------------------------------------
*& Classes
*&----------------------------------------------------------------------
  data HTTP_CLIENT type ref to IF_HTTP_CLIENT .
  data EXPORTE_DATA type ref to DATA .
  data BAPIRET type YDS3P_TT_BAPIRET2 read-only .

  methods GET_DATA .
  class-methods MAIN .
  methods SET_WEBSERVICE
    importing
      value(LINK_WS) type STRING .
  methods GET_WEBSERVICE .
  methods SET_DATA .
protected section.

  data LO_STRUCTDESCR type ref to CL_ABAP_STRUCTDESCR .
  data LO_TABLEDESCR type ref to CL_ABAP_TABLEDESCR .
  data LT_COMP_ALL type CL_ABAP_STRUCTDESCR=>COMPONENT_TABLE .
  data LV_ASSING_DATA type ref to DATA .
  data GS_BAPIRET2 type YDS3P_BAPIRET2 .
private section.
ENDCLASS.



CLASS YDS3P_WS_JSON IMPLEMENTATION.


  METHOD get_data.

*&------------------------- Declaração dos tipos de dados -------------------------

*    TYPES: BEGIN OF typ_tabela_dados,
*             campo      TYPE name_feld,
*             typo_campo TYPE field_type,
*             ind_c      TYPE sy-tabix,
*             valor      TYPE string,
*             ind_v      TYPE sy-tabix,
*           END OF typ_tabela_dados.

*&--------------------- Declaração de variáveis -----------------------------------

*& Verifica campos duplicados
    DATA: lv_aux_campo       TYPE name_feld,

*& Variavel para erro direto de operações
          erro               TYPE string,

*& Indicador do indice
          lv_ind_do          TYPE i,

*& Auxiliar para criar estrutura dinâmica
          wa_data            TYPE REF TO data,

*& Auxiliar para posição do campo WebService
          lv_aux_point_campo TYPE i,

*& Auxiliar para contagem do campo (Nome do campo)
          lv_aux_cont_campo.
*&--------------------- Field Symbols --------------------------------------------

*& Campo auxiliar para assinar a estrutura que obtem os dados do json
    FIELD-SYMBOLS : <fs_field> TYPE any.
    FIELD-SYMBOLS : <fs_es_ret> TYPE any.
    FIELD-SYMBOLS: <fs_tabela_retorno> TYPE ANY TABLE.

*&--------------------- Tabela internas e estruturas de trabalho -----------------

*& Tratar dados de retorno do WebService
    DATA: lt_dados TYPE STANDARD TABLE OF yds3p_t_dynamic,
          ls_dados TYPE yds3p_t_dynamic.

    DATA: ls_lt_ttpar  TYPE yds3p_ws_espar.

*&--------------------- Classes e objetos utilizados para manipular o json ------

*& Resultado do web service
    json_string = http_client->response->get_cdata( ).
    DATA(out) = cl_demo_output=>new( )->begin_section( `JSON-Data` ).
    DATA(json) = cl_abap_codepage=>convert_to( json_string ).
    DATA(reader) = cl_sxml_string_reader=>create( json ).
    DATA(writer) = CAST if_sxml_writer( cl_sxml_string_writer=>create( ) ).


*&--------------------    Leitura do retorno do WebService  ---------------------

    TRY.
        DO.
          lv_ind_do = lv_ind_do + 1.
          DATA(node) = reader->read_next_node( ).

          IF node IS INITIAL.
            EXIT.
          ENDIF.

          writer->write_node( node ).
          CASE node->type.
            WHEN if_sxml_node=>co_nt_element_open."Nome do campo e typo

              DATA(open_element) = CAST if_sxml_open_element( node ).
              DATA(attributes)  = open_element->get_attributes( ).

              LOOP AT attributes INTO DATA(attribute).
                IF attribute->value_type = if_sxml_value=>co_vt_text.

                  ls_dados-field = attribute->get_value( ).
                  ls_dados-type = 'YDS3P_STRING'.
                  ls_dados-ind_field = lv_ind_do.

                ENDIF.
              ENDLOOP.
              CONTINUE.
              CONTINUE.
            WHEN if_sxml_node=>co_nt_element_close.
              CONTINUE.
            WHEN if_sxml_node=>co_nt_value. "Valor do campo retornado
              DATA(value_node) = CAST if_sxml_value_node( node ).
              IF value_node->value_type = if_sxml_value=>co_vt_text.

                ls_dados-ind_value = lv_ind_do.
                ls_dados-value = value_node->get_value( ).
                APPEND ls_dados TO lt_dados.

              ENDIF.
              CONTINUE.
            WHEN OTHERS.
              EXIT.
          ENDCASE.
        ENDDO.

      CATCH cx_sxml_parse_error INTO DATA(parse_error).
        out->write_text( parse_error->get_text( ) ).
    ENDTRY.

    CLEAR: lv_aux_cont_campo,lv_aux_point_campo.

*&------------------------------------------------------------------------------------
*&-----  Ordenaçao de campos com mesmo nome vindos de objetos do servidor JSON   -----
*&------------------------------------------------------------------------------------
    SORT: lt_dados BY field ind_field.
    LOOP AT lt_dados INTO ls_dados.

      IF sy-tabix EQ 1."Caso seja o primeiro registo Alimente a variável auxiliar
        lv_aux_campo = ls_dados-field.
      ELSE.
        "O Campo contém o mesmo valor ?
        IF lv_aux_campo EQ ls_dados-field.
          "Caso sim aumente a numeração
          lv_aux_cont_campo = lv_aux_cont_campo + 1.

          "Verifique a posição final para adicional o contador
          lv_aux_point_campo = strlen( ls_dados-field ).

          "Acrescente a diferenciação.
          ls_dados-field+lv_aux_point_campo(1) = lv_aux_cont_campo.

        ELSE."Caso seja diferente mude a comparação.
          CLEAR lv_aux_cont_campo."Limpa numerador.
          lv_aux_campo = ls_dados-field.
        ENDIF.
      ENDIF.

      MODIFY lt_dados FROM ls_dados.

    ENDLOOP.
    SORT lt_dados BY ind_value. "Retorna ordenação

*&------------------------------------------------------------------------------------
*&--------------------------   Fim da ordenação  -------------------------------------
*&------------------------------------------------------------------------------------

    "Ajusta a tabela para criação dinamica
    REFRESH lt_comp_all.
    LOOP AT lt_dados INTO ls_dados.
      ls_lt_ttpar-name = ls_dados-field.
      ls_lt_ttpar-type ?= cl_abap_datadescr=>describe_by_data( ls_dados-type ).
      APPEND ls_lt_ttpar TO lt_comp_all.
    ENDLOOP.


*&------------------------------------------------------------------------------------
*&                  Inicio da criação dos objetos dinâmicos
*&------------------------------------------------------------------------------------

    IF NOT lt_comp_all IS INITIAL.
      TRY.
*& Criar descrição da estrutura
          lo_structdescr = cl_abap_structdescr=>create( lt_comp_all ).

*&------------------------------------------------------------------------------------
*&                  Criação da estrutura para manipulação dos dados.
*&------------------------------------------------------------------------------------
          TRY.
              CREATE DATA wa_data  TYPE HANDLE lo_structdescr.
            CATCH cx_sy_create_data_error.
          ENDTRY.

          TRY.
              ASSIGN wa_data->* TO <fs_es_ret>.
            CATCH cx_sy_assign_cast_illegal_cast.
            CATCH cx_sy_assign_cast_unknown_type.
            CATCH cx_sy_assign_out_of_range.
          ENDTRY.
*&------------------------------------------------------------------------------------
*&                Final da criação da estrutura com dados
*&------------------------------------------------------------------------------------

*& Criar tabela com base na estrutura
          lo_tabledescr = cl_abap_tabledescr=>create(
                          p_line_type  = lo_structdescr
                          p_table_kind = cl_abap_tabledescr=>tablekind_std
                          p_unique     = abap_false ).

*& Criar data object
          CREATE DATA lv_assing_data TYPE HANDLE lo_tabledescr.

          ASSIGN lv_assing_data->* TO <fs_tabela_retorno>.

        CATCH cx_root.
          CLEAR: erro.
          CONCATENATE   'Erro ao criar estrutura de transporte de dados,'
                        'verifique campos iguais no web-service.'
                        INTO erro.
          gs_bapiret2-message = erro.
          gs_bapiret2-type    = 'E'.
          APPEND gs_bapiret2 TO bapiret.
          CLEAR gs_bapiret2.
          MESSAGE e000(o0) WITH erro.
      ENDTRY.
    ELSE.
      CLEAR: erro.
      gs_bapiret2-message = 'Erro não há retorno de campos para criar a estrutura'.
      gs_bapiret2-type    = 'E'.
      APPEND gs_bapiret2 TO bapiret.
      CLEAR gs_bapiret2.
      erro = 'Erro não há retorno de campos para criar a estrutura'.
      MESSAGE e000(o0) WITH erro.
    ENDIF.

*&------------------------------------------------------------------------------------
*&                            Final dos objetos dinâmicos
*&------------------------------------------------------------------------------------

*& Distribuição dos dados selecionados

    LOOP AT lt_dados INTO ls_dados.

      CONCATENATE '<fs_es_ret>-' ls_dados-field INTO lc_field.
      CONDENSE lc_field NO-GAPS.
      TRANSLATE lc_field TO UPPER CASE.

      ASSIGN (lc_field) TO <fs_field>.

      IF <fs_field> IS ASSIGNED.
        <fs_field> = ls_dados-value.

        CONCATENATE  'Campo ' ls_dados-field ' foi assinado !'
        INTO gs_bapiret2-message.

        gs_bapiret2-type    = 'S'.
        APPEND gs_bapiret2 TO bapiret.
        CLEAR gs_bapiret2.
*& Remover associação
        UNASSIGN <fs_field>.

      ELSE.
        CONCATENATE  'Campo ' ls_dados-field 'não foi assinado !'
        INTO gs_bapiret2-message.
        gs_bapiret2-type    = 'E'.
        APPEND gs_bapiret2 TO bapiret.
        CLEAR gs_bapiret2.
      ENDIF.

    ENDLOOP.
    IF <fs_es_ret> IS ASSIGNED AND
       <fs_tabela_retorno> IS ASSIGNED.
    ENDIF.

*& Exportar Valores para o retorno
    BREAK-POINT.

    gs_bapiret2-message = 'Retornado com sucesso'.
    gs_bapiret2-type    = 'S'.
    APPEND gs_bapiret2 TO bapiret.
    CLEAR gs_bapiret2.


  ENDMETHOD.


  method GET_WEBSERVICE.
  endmethod.


  method MAIN.


  endmethod.


  method SET_DATA.
  endmethod.


  METHOD set_webservice.

    IF NOT link_ws IS INITIAL.

      CALL METHOD cl_http_client=>create_by_url
        EXPORTING
          url                = link_ws
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


      w_string = 'Retornado com sucesso.'.

    ELSE.
      w_string = 'WebService vazio!'.
      GS_BAPIRET2-message = 'WebService vazio!'.
      GS_BAPIRET2-type    = 'E'.
      APPEND GS_BAPIRET2 TO bapiret.
      CLEAR GS_BAPIRET2.
    ENDIF.


  ENDMETHOD.
ENDCLASS.
