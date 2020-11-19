FUNCTION ZDSOL_GET_CNPJ_JSON.
*"----------------------------------------------------------------------
*"*"Interface local:
*"  IMPORTING
*"     REFERENCE(CNPJ) TYPE  CHAR14
*"  EXPORTING
*"     REFERENCE(RETORNO) TYPE  STRING
*"----------------------------------------------------------------------

*
*TYPES: BEGIN OF typ_parceiro,
*  atividade_principal type c LENGTH 200,
*  data_situacao type c LENGTH 200,
*  code type c LENGTH 200,
*  nome type c LENGTH 200,
*  uf type c LENGTH 200,
*  telefone type c LENGTH 200,
*  email type c LENGTH 200,
*  atividades_secundarias type c LENGTH 200,
*  atividades_secundarias2 type c LENGTH 200,
*  atividades_secundarias3 type c LENGTH 200,
*  atividades_secundarias4 type c LENGTH 200,
*  qsa type c LENGTH 200,
*  situacao type c LENGTH 200,
*  bairro type c LENGTH 200,
*  logradouro type c LENGTH 200,
*  numero type c LENGTH 200,
*  cep type c LENGTH 200,
*  municipio type c LENGTH 200,
*  abertura type c LENGTH 200,
*  natureza_juridica type c LENGTH 200,
*  fantasia type c LENGTH 200,
*  cnpj type c LENGTH 200,
*  ultima_atualizacao type c LENGTH 200,
*  status type c LENGTH 200,
*  tipo type c LENGTH 200,
*  complemento type c LENGTH 200,
*  efr type c LENGTH 200,
*  motivo_situacao type c LENGTH 200,
*  situacao_especial type c LENGTH 200,
*  data_situacao_especial type c LENGTH 200,
*  capital_social type c LENGTH 200,
*  extra type c LENGTH 200,
*  billing type c LENGTH 200,
*  free type c LENGTH 200,
*  database type c LENGTH 200,
* END OF typ_parceiro.
*
*DATA: lt_parceiro type STANDARD TABLE OF typ_parceiro,
*      ls_parceiro type typ_parceiro.

*TYPES: BEGIN OF typ_string,
*  linha type string,
*  END OF typ_string.

DATA: lv_json type string, "your json string
      lv_data type typ_string. "your structure
data: P_CNPJ TYPE CHAR14.
P_CNPJ = CNPJ.
*      lv_data type typ_string. "your structure


  DATA: http_client TYPE REF TO if_http_client .

  DATA: w_string TYPE string ,
  w_result TYPE STRING,
  r_str TYPE string .

  DATA: result_tab TYPE TABLE OF string WITH HEADER LINE.


  CLEAR w_string .



  w_string = 'http://www.receitaws.com.br/v1/cnpj/'.
  CONDENSE P_CNPJ NO-GAPS.
  CONCATENATE w_string P_CNPJ into w_string.

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


* Se establece el método GET o POST
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
  CLEAR w_result .
ENDTRY.
* Resultado del web service
  w_result = http_client->response->get_cdata( ).

    RETORNO = w_result.

ENDFUNCTION.
