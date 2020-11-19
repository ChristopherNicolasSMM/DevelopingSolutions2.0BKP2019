REPORT yds3p_mockup_get_server.

*HTTP Client Abstraction
DATA  lo_client TYPE REF TO if_http_client.

*Data variables for storing response in xstring and string
DATA  : lv_xstring    TYPE xstring,
        lv_string     TYPE string,
        lv_node_name  TYPE string.

CLEAR : lv_xstring, lv_string, lv_node_name.

START-OF-SELECTION .

*Creation of New IF_HTTP_Client Object
cl_http_client=>create_by_url(
EXPORTING
  url                = 'https://api.github.com/users/GabrielDiasFaria/repos'
*  url                = 'http://sifdev.seg-social.pt:8000/sap/bc/zficl_igcp_bank?sap-client=100'
IMPORTING
  client             = lo_client
EXCEPTIONS
  argument_not_found = 1
  plugin_not_active  = 2
  internal_error     = 3
  ).

*lo_client->request->set_method( 'GET' ).

CALL METHOD lo_client->request->set_header_field
    EXPORTING
      name = '~request_method'
      value = 'GET'.

CALL METHOD lo_client->request->if_http_entity~set_header_field
    EXPORTING
      name  = 'Authorization'
      value = 'token a301beee45221144444555522233333366665554'.

CALL METHOD lo_client->send
    EXCEPTIONS
      http_communication_failure = 1
      http_invalid_state         = 2.
  CALL METHOD lo_client->receive
    EXCEPTIONS
      http_communication_failure = 1
      http_invalid_state         = 2
      http_processing_failed     = 3.

IF sy-subrc NE 0.
  DATA subrc TYPE sysubrc.
  DATA errortext TYPE string.

  CALL METHOD lo_client->get_last_error
    IMPORTING
      code    = subrc
      MESSAGE = errortext.

  WRITE: / 'communication_error( receive )',
         / 'code: ', subrc, 'message: ', errortext.
ENDIF.

DATA: lv_http_error_descr      TYPE string.
DATA: lv_http_return_code      TYPE i.
lo_client->response->get_status( IMPORTING code   = lv_http_return_code ).
lo_client->response->get_status( IMPORTING reason = lv_http_error_descr ).

WRITE: /, lv_http_error_descr , lv_http_return_code.

lv_xstring = lo_client->response->get_data( ).


BREAK-POINT.
