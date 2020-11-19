REPORT YDS3P_MOCKUP_SHDB.

" Te vira!

TYPES: BEGIN OF ty_bdcdata,
         program  TYPE bdcdata-program,  " Pool de módulos BDC
         dynpro   TYPE bdcdata-dynpro,   " NÚmero de tela BDC
         dynbegin TYPE bdcdata-dynbegin, " Início BDC de uma tela
         fnam     TYPE bdcdata-fnam,     " Nome do campo
         fval     TYPE bdcdata-fval,     " Valor do campo BDC
       END OF ty_bdcdata.
DATA: st_bdcdata TYPE ty_bdcdata,
      it_bdcdata TYPE TABLE OF ty_bdcdata,
      vg_mode(1) TYPE c VALUE 'A'.



" TRANSAÇÃO -> SHDB
" ESCOLHER UMA CRIADA OU CRIAR UMA NOVA
" INFORMAR A TRANSAÇÃO E EXECUTAR
" PEGAR OS REGISTROS DA SHDB

PARAMETERS: LV_REQ type STRING.

" BLOCO 1
PERFORM z_preenche_bdc USING:
      'X'    'RDDM0001'          '0100',
      ' '    'BDC_OKCODE'        '=SNGL',
      ' '    'BDC_SUBSCR'        'RDDM0001                                0220COMMONSUBSCREEN',
      ' '    'BDC_CURSOR'        'TRDYSE01CM-USERNAME'.

" BLOCO 2
PERFORM z_preenche_bdc USING:
      'X'    'SAPLSTRH'          '1200',
      ' '    'BDC_CURSOR'        'GV_1200_TRKORR',
      ' '    'BDC_OKCODE'        '=TAKE',
      ' '    'GV_1200_TRKORR'    LV_REQ." 'DEVK953724'.

" BLOCO 3
PERFORM z_preenche_bdc USING:
      'X'    'SAPMSSY0'          '0120',
      ' '    'BDC_CURSOR'        '10/27',
      ' '    'BDC_OKCODE'        '=REQUEST_SHOW'.

CALL TRANSACTION 'SE09'   USING it_bdcdata
                          MODE  vg_mode.
*                         UPDATE 'S'.
*                         MESSAGES INTO it_msg.














*&---------------------------------------------------------------------*
*&      Form  Z_PREENCHE_BDC
*&---------------------------------------------------------------------*
FORM z_preenche_bdc  USING dynbegin
                           name
                           value.
  IF dynbegin = 'X'.
    MOVE: name      TO st_bdcdata-program,
          value     TO st_bdcdata-dynpro,
          dynbegin  TO st_bdcdata-dynbegin.
    APPEND st_bdcdata TO it_bdcdata.
  ELSE.

    MOVE: name     TO st_bdcdata-fnam,
          value    TO st_bdcdata-fval.

    CONDENSE st_bdcdata-fnam.
    CONDENSE st_bdcdata-fval.

    APPEND st_bdcdata TO it_bdcdata.

  ENDIF.
  CLEAR st_bdcdata.
ENDFORM.                    " Z_PREENCHE_BDC
