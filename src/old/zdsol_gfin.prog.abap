REPORT zdsol_gfin.

TABLES : zdsol_gfin_mov .

TYPE-POOLS: slis.


TYPES :

  BEGIN OF typ_gfin_mov,
    lancamento TYPE zdsol_gfin_mov-lancamento,
    ano        type c LENGTH 4,
    mes        type c LENGTH 2,
    data_pag   TYPE zdsol_gfin_mov-data_pag,
    valor      TYPE zdsol_gfin_mov-valor,
    categoria  TYPE zdsol_gfin_mov-categoria,
    origem     TYPE zdsol_gfin_mov-origem,
    descricao  TYPE zdsol_gfin_mov-descricao,
    pago       TYPE zdsol_gfin_mov-pago,
    detalhes   TYPE zdsol_gfin_mov-detalhes,
  END OF   typ_gfin_mov .

" Estruturas ....
DATA : ls_gfin_mov TYPE typ_gfin_mov
      .

" Tabelas Internas ....
DATA : lt_gfin_mov TYPE TABLE OF typ_gfin_mov
      .

" Declarações usadas no ALV.

DATA : it_fieldcat TYPE slis_t_fieldcat_alv,
       st_fieldcat TYPE slis_fieldcat_alv,
       it_sort     TYPE slis_t_sortinfo_alv,
       wa_sort     TYPE slis_sortinfo_alv,
       it_layout   TYPE TABLE OF slis_layout_alv,
       st_layout   TYPE slis_layout_alv
       .


SELECTION-SCREEN BEGIN OF BLOCK b1.
SELECT-OPTIONS :
    so_date FOR zdsol_gfin_mov-data_pag.
SELECTION-SCREEN END OF BLOCK b1.

START-OF-SELECTION.

  PERFORM : z_feed_table,
            z_fieldcat,
            z_alv
           .

*&---------------------------------------------------------------------*
*&      Form  Z_feed_table
*&---------------------------------------------------------------------*

FORM z_feed_table .

  SELECT *
    INTO CORRESPONDING FIELDS OF TABLE lt_gfin_mov
    FROM zdsol_gfin_mov  WHERE data_pag in so_date.

  LOOP AT lt_gfin_mov INTO ls_gfin_mov.

    IF ls_gfin_mov-lancamento(1) EQ 'D'.
      ls_gfin_mov-valor = ( ls_gfin_mov-valor * -1 ) .
    ENDIF.
    ls_gfin_mov-mes = ls_gfin_mov-data_pag+4(2).
    ls_gfin_mov-ano = ls_gfin_mov-data_pag(4).

    MODIFY lt_gfin_mov from ls_gfin_mov.
  ENDLOOP.

ENDFORM.                    " Z_feed_table

*&---------------------------------------------------------------------*
*&      Form  Z_FIELDCAT
*&---------------------------------------------------------------------*

FORM z_fieldcat .


  PERFORM z_feed_fieldcat USING :
    "Fname  Seltext                     check   Edit  Col_pos
    'LANCAMENTO'  'Lancamento'            ' '   ' '     1  ,
    'ANO'         'Ano'                   ' '   ' '     2  ,
    'MES'         'Mês'                   ' '   ' '     3  ,
    'DATA_PAG'    'Data de Pagamento'     ' '   ' '     4  ,
    'VALOR'       'Valor'                 ' '   ' '     5  ,
    'CATEGORIA'   'Categoria'             ' '   ' '     6  ,
    'ORIGEM'      'Origem'                ' '   ' '     7  ,
    'DESCRICAO'   'Descricao'             ' '   ' '     8  ,
    'PAGO'        'Pago?'                 ' '   ' '     9  ,
    'DETALHES'    'Detalhes'              ' '   ' '     10 .

 wa_sort-spos      = 1.
  wa_sort-fieldname = 'ANO'.
  wa_sort-up        = 'X'.
  wa_sort-subtot    = 'X'.
  APPEND wa_sort TO it_sort.

  wa_sort-spos      = 2.
  wa_sort-fieldname = 'MES'.
  wa_sort-up        = 'X'.
  wa_sort-subtot    = 'X'.
  APPEND wa_sort TO it_sort.

  wa_sort-spos      = 3.
  wa_sort-fieldname = 'LANCAMENTO'.
  wa_sort-up        = 'X'.
  wa_sort-subtot    = 'X'.
  APPEND wa_sort TO it_sort.

  st_layout-zebra = 'X'.
  st_layout-colwidth_optimize = 'X'.

ENDFORM.                    " Z_FIELDCAT

*&---------------------------------------------------------------------*
*&      Form  Z_FEED_FIELDCAT
*&---------------------------------------------------------------------*
FORM z_feed_fieldcat  USING    fieldname
                               seltext_m
                               checkbox
                               edit
                               col_pos .

  st_fieldcat-fieldname   = fieldname.
  st_fieldcat-seltext_m   = seltext_m.
  st_fieldcat-checkbox    = checkbox.
  st_fieldcat-edit        = edit.
  st_fieldcat-col_pos     = col_pos.

  FIND 'VALOR' IN st_fieldcat-fieldname.
  IF SY-subrc EQ 0.
    st_fieldcat-do_sum = 'X'.
  ENDIF.

  " Coloca a estrutura alimentada na Tabela.
  APPEND st_fieldcat TO it_fieldcat.
  " Limpa a estrutura e volta pra poxima linha do form.
  CLEAR  st_fieldcat.
ENDFORM.                    " Z_FEED_FIELDCAT

*&---------------------------------------------------------------------*
*&      Form  Z_ALV
*&---------------------------------------------------------------------*
FORM z_alv .
  "  Aki tah o prato principal deste Post, a function que torna o ALV em
  " realidade, como vc pode ver esta function tem muitos parametros de exporting
  " cada um com seu objetivo para que o ALV saia bunitinho, eu ia colocar
  " um post falando sobre essa function, mas são muitas as propriedades
  " entaum vou fazer ao contrário essa, depois que fala sobre cada propriedade
  " eu lanço um post sobre esta function com o link explicando cada
  " parametro, não sei quando, mais um dia eu termino rsrs.
  " Aki eu soh estou preenchendo os parametros minimos pra que a function
  " funcione,
  " Obs.: se vc naum quiser colocar o field catalog tudo bem mas aih vc vai
  " ter que colocar uma estrutura z ou naum no parametro 'I_STRUCTURE_NAME'.

  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
    EXPORTING
*     I_INTERFACE_CHECK  = ' '
*     I_BYPASSING_BUFFER = ' '
*     I_BUFFER_ACTIVE    = ' '
      i_callback_program = sy-repid    " Nome do programa
*     i_callback_pf_status_set          = ' '
*     i_callback_user_command           = ' '
*     I_CALLBACK_TOP_OF_PAGE            = ' '
*     I_CALLBACK_HTML_TOP_OF_PAGE       = ' '
*     I_CALLBACK_HTML_END_OF_LIST       = ' '
*      i_structure_name   =
*     I_BACKGROUND_ID    = ' '
*     I_GRID_TITLE       =
*     I_GRID_SETTINGS    =
     is_layout          = st_layout
    it_fieldcat            = it_fieldcat " catalogo de campos
*     IT_EXCLUDING       =
*     IT_SPECIAL_GROUPS  =
      it_sort            = it_sort
*     IT_FILTER          =
*     IS_SEL_HIDE        =
*     I_DEFAULT          = 'X'
      i_save             = 'X'
*     IS_VARIANT         =
*     IT_EVENTS          =
*     IT_EVENT_EXIT      =
*     IS_PRINT           =
*     IS_REPREP_ID       =
*     I_SCREEN_START_COLUMN             = 0
*     I_SCREEN_START_LINE               = 0
*     I_SCREEN_END_COLUMN               = 0
*     I_SCREEN_END_LINE  = 0
*     I_HTML_HEIGHT_TOP  = 0
*     I_HTML_HEIGHT_END  = 0
*     IT_ALV_GRAPHICS    =
*     IT_HYPERLINK       =
*     IT_ADD_FIELDCAT    =
*     IT_EXCEPT_QINFO    =
*     IR_SALV_FULLSCREEN_ADAPTER        =
* IMPORTING
*     E_EXIT_CAUSED_BY_CALLER           =
*     ES_EXIT_CAUSED_BY_USER            =
    TABLES
      t_outtab           = lt_gfin_mov   " Tabela com os dados
    EXCEPTIONS
      program_error      = 1
      OTHERS             = 2.
  IF sy-subrc <> 0.
    MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
            WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
  ENDIF.

ENDFORM.                    " Z_ALV
