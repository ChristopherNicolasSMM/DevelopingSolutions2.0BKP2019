*&---------------------------------------------------------------------*
*& Report  ZABAP_002
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT ZDEVSOL_BKP_TAB_OLD.
* Adaptação: Diógenes Henrique
TABLES: DD02T,
        DD03L.

* Linea
DATA: I_SOURCE LIKE LINE OCCURS 100 WITH HEADER LINE.
DATA L_RESP.
DATA: PROGRAM_NAME     LIKE SY-CPROG.
DATA: L_MANDT.

DATA: L_LINEA(72).
DATA: L_TABLA(2000).
DEFINE AP.
  APPEND &1 TO I_SOURCE.
END-OF-DEFINITION.

SELECTION-SCREEN BEGIN OF BLOCK BLK_PAR WITH FRAME.
PARAMETERS: P_TABLA LIKE DD03L-TABNAME OBLIGATORY.
PARAMETERS: P_PATH LIKE RLGRAP-FILENAME
                   DEFAULT 'C:\' OBLIGATORY.
PARAMETERS:  P_BORRAR AS CHECKBOX.
SELECTION-SCREEN END OF BLOCK BLK_PAR.

SELECTION-SCREEN BEGIN OF BLOCK BLK_PAR3 WITH FRAME TITLE TEXT-003.
PARAMETERS: P_W1(80),
            P_W2(80),
            P_W3(80),
            P_W4(80),
            P_W5(80).
SELECTION-SCREEN END OF BLOCK BLK_PAR3.

SELECTION-SCREEN BEGIN OF BLOCK BLK_PAR2 WITH FRAME TITLE TEXT-T01.
SELECTION-SCREEN BEGIN OF LINE.
SELECTION-SCREEN COMMENT 1(10) TEXT-001.
SELECTION-SCREEN POSITION 12.
PARAMETERS: P_GRAB RADIOBUTTON GROUP RAD1 DEFAULT 'X'.    "Gravar
SELECTION-SCREEN END OF LINE.

SELECTION-SCREEN BEGIN OF LINE.
SELECTION-SCREEN COMMENT 1(10) TEXT-002.
SELECTION-SCREEN POSITION 12.
PARAMETERS: P_CARG RADIOBUTTON GROUP RAD1.                "Carregar
SELECTION-SCREEN END OF LINE.
SELECTION-SCREEN END OF BLOCK BLK_PAR2.

SELECTION-SCREEN BEGIN OF BLOCK BLK_PAR4 WITH FRAME TITLE TEXT-T02.
SELECTION-SCREEN BEGIN OF LINE.
SELECTION-SCREEN COMMENT 1(10) TEXT-005.
SELECTION-SCREEN POSITION 12.
PARAMETERS: P_INS RADIOBUTTON GROUP RAD2 DEFAULT 'X'.    "Insert
SELECTION-SCREEN END OF LINE.

SELECTION-SCREEN BEGIN OF LINE.
SELECTION-SCREEN COMMENT 1(10) TEXT-006.
SELECTION-SCREEN POSITION 12.
PARAMETERS: P_MOD RADIOBUTTON GROUP RAD2.                "Modify
SELECTION-SCREEN END OF LINE.
SELECTION-SCREEN END OF BLOCK BLK_PAR4.


START-OF-SELECTION.

  PERFORM GERAR_REPORT.

  IF   NOT P_CARG IS INITIAL.
    IF NOT P_BORRAR IS INITIAL.
      PERFORM APAGAR_TABELA.
    ENDIF.
    PERFORM CARREGAR_TABELA.
  ELSE.
    PERFORM GRAVAR_TABELA.
  ENDIF.

*---------------------------------------------------------------------*
*       FORM GERAR_REPORT                                             *
*---------------------------------------------------------------------*
*       ........                                                      *
*---------------------------------------------------------------------*
FORM GERAR_REPORT.
  DATA L_TABLA(10).

  CLEAR L_MANDT.
  SELECT * FROM DD03L
   WHERE TABNAME = P_TABLA
     AND FIELDNAME = 'MANDT'.
    L_MANDT = 'X'.
  ENDSELECT.


  CONCATENATE 'I_' P_TABLA INTO L_TABLA.
  AP 'REPORT Z.'.
  CONCATENATE 'TABLES' P_TABLA '.' INTO L_LINEA SEPARATED BY SPACE.
  AP L_LINEA.
  CONCATENATE 'DATA' L_TABLA
              'LIKE' P_TABLA 'OCCURS 100 WITH HEADER LINE.'
              INTO L_LINEA SEPARATED BY SPACE.
  AP L_LINEA.
  AP 'FORM APAGAR_TABELA.'.

  IF L_MANDT = 'X'.
    CONCATENATE 'DELETE FROM' P_TABLA
                'CLIENT SPECIFIED WHERE MANDT = SY-MANDT.'
                INTO L_LINEA SEPARATED BY SPACE.
  ELSE.
    IF P_BORRAR = 'X'.
      MESSAGE E208(00) WITH
    'Nao posso apagar conteúdo da tabela nesse client'.
    ENDIF.
  ENDIF.

  AP L_LINEA.
  AP 'ENDFORM.        "APAGAR TABELA'.

  AP 'FORM GRAVAR_TABELA.'.
  CONCATENATE 'SELECT * FROM' P_TABLA
              'INTO TABLE ' L_TABLA
              INTO L_LINEA SEPARATED BY SPACE.
  AP L_LINEA.
  IF NOT P_W1 IS INITIAL.
    CONCATENATE 'WHERE' P_W1 INTO L_LINEA SEPARATED BY SPACE.
    AP L_LINEA.
    AP P_W2.
    AP P_W3.
    AP P_W4.
    AP P_W5.
  ENDIF.
  AP '.'.
  AP 'CALL FUNCTION ''WS_DOWNLOAD'''.
  AP 'EXPORTING'.
  CONCATENATE  'FILENAME = ''' P_PATH P_TABLA '.DAT''' INTO L_LINEA.
  AP L_LINEA.
  AP 'FILETYPE = ''DAT'''.
  AP 'TABLES'.
  CONCATENATE 'DATA_TAB = ' L_TABLA '.' INTO L_LINEA
  SEPARATED BY SPACE.
  AP L_LINEA.
  AP 'ENDFORM.        "GRAVAR_TABELA'.

  AP 'FORM CARREGAR_TABELA.'.
  AP 'CALL FUNCTION ''WS_UPLOAD'''.
  AP 'EXPORTING'.
  CONCATENATE  'FILENAME = ''' P_PATH P_TABLA '.DAT'''  INTO L_LINEA.
  AP L_LINEA.
  AP 'FILETYPE = ''DAT'''.
  AP 'TABLES'.
  CONCATENATE 'DATA_TAB = ' L_TABLA '.' INTO L_LINEA
  SEPARATED BY SPACE.
  AP L_LINEA.
  IF L_MANDT = 'X'.
    CONCATENATE 'LOOP AT ' L_TABLA '.' INTO L_LINEA SEPARATED BY
SPACE.
    AP L_LINEA.
    CONCATENATE L_TABLA '-MANDT = SY-MANDT.' INTO L_LINEA.
    AP L_LINEA.
    CONCATENATE 'MODIFY ' L_TABLA '.' INTO L_LINEA SEPARATED BY SPACE
.
    AP L_LINEA.
    AP 'ENDLOOP.'.
  ENDIF.

  IF P_INS = 'X'.
    CONCATENATE 'INSERT ' P_TABLA
                'FROM TABLE ' L_TABLA '.'
                INTO L_LINEA SEPARATED BY SPACE.
  ELSE.
    CONCATENATE 'MODIFY ' P_TABLA
                'FROM TABLE ' L_TABLA '.'
                INTO L_LINEA SEPARATED BY SPACE.
  ENDIF.
  AP L_LINEA.
  AP 'ENDFORM.        "CARREGAR_TABELA'.

  PERFORM GENERATE_SUBROUTINE_POOL TABLES I_SOURCE.

ENDFORM.


*---------------------------------------------------------------------*
*       FORM GRAVAR_TABELA                                            *
*---------------------------------------------------------------------*
*       ........                                                      *
*---------------------------------------------------------------------*
FORM GRAVAR_TABELA.
  PERFORM GRAVAR_TABELA IN PROGRAM (PROGRAM_NAME).
ENDFORM.

*---------------------------------------------------------------------*
*       FORM CARREGAR_TABELA                                          *
*---------------------------------------------------------------------*
*       ........                                                      *
*---------------------------------------------------------------------*
FORM CARREGAR_TABELA.

* message i208(00) with '¨Esta seguro de querer cargar los datos?'.
  PERFORM CARREGAR_TABELA IN PROGRAM (PROGRAM_NAME).
ENDFORM.


*---------------------------------------------------------------------*
*       FORM APAGAR_TABELA                                            *
*---------------------------------------------------------------------*
*       ........                                                      *
*---------------------------------------------------------------------*
FORM APAGAR_TABELA.
  SELECT * FROM DD02T
  WHERE TABNAME = P_TABLA
  AND DDLANGUAGE = SY-LANGU.
    EXIT.
  ENDSELECT.
  CONCATENATE 'Deseja apagar conteúdo de' P_TABLA INTO L_LINEA
                           SEPARATED BY SPACE.
  CONCATENATE L_LINEA '?' INTO L_LINEA.

  CALL FUNCTION 'POPUP_CONTINUE_YES_NO'
       EXPORTING
            DEFAULTOPTION = 'N'
            TEXTLINE1     = L_LINEA
            TEXTLINE2     = DD02T-DDTEXT
            TITEL         = 'Confirmação'
       IMPORTING
            ANSWER        = L_RESP
       EXCEPTIONS
            OTHERS        = 1.
  IF L_RESP = 'J'.
    PERFORM APAGAR_TABELA IN PROGRAM (PROGRAM_NAME).
  ENDIF.
ENDFORM.

*---------------------------------------------------------------------*
*       FORM GENERATE_SUBROUTINE_POOL                                 *
*---------------------------------------------------------------------*
*       ........                                                      *
*---------------------------------------------------------------------*
*  -->  SOURCE_TAB                                                    *
*---------------------------------------------------------------------*
FORM GENERATE_SUBROUTINE_POOL TABLES SOURCE_TAB.

  DATA:   LINE_NO          TYPE I,
  SYNTAX_CHECK_MESSAGE(128).
  DESCRIBE TABLE SOURCE_TAB.
  CHECK SY-TFILL GT 0.
  GENERATE SUBROUTINE POOL SOURCE_TAB
  NAME PROGRAM_NAME
  MESSAGE SYNTAX_CHECK_MESSAGE
  LINE LINE_NO.
  IF SY-SUBRC NE 0.
    WRITE: / 'Error de sintaxe, mensagem', SYNTAX_CHECK_MESSAGE,
           / 'na linha', LINE_NO.
    STOP.
  ENDIF.
ENDFORM.
