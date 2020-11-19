REPORT zdevsol_upload_excel.
*&----------------------------------------------------------------------*
*& Nome do objeto.:                                                     *
*& Título.........:                                                     *
*& Objetivo.......:                                                     *
*& Transação......:                                                     *
*&----------------------------------------------------------------------*
*& Autor..........:                                                     *
*& Consultoria....: H2 Consult                                          *
*& Data desenv....:                                                     *
*& Tipo de prg....:                                                     *
*&----------------------------------------------------------------------*

**********************************************************************
* Tabelas
**********************************************************************
TABLES: dd02l.
**********************************************************************
* Tipos
**********************************************************************
TYPE-POOLS: ole2.

TYPES: BEGIN OF typ_excel,
         a TYPE string,
         b TYPE string,
         c TYPE string,
         d TYPE string,
         e TYPE string,
         f TYPE string,
         g TYPE string,
         h TYPE string,
         i TYPE string,
         j TYPE string,
         k TYPE string,
         l TYPE string,
         m TYPE string,
         n TYPE string,
         o TYPE string,
         p TYPE string,
         q TYPE string,
         r TYPE string,
         s TYPE string,
         t TYPE string,
         u TYPE string,
         v TYPE string,
         w TYPE string,
         x TYPE string,
         y TYPE string,
         z TYPE string,
*	 AA  TYPE STRING,
*	 AB  TYPE STRING,
*	 AC  TYPE STRING,
*	 AD  TYPE STRING,
*	 AE  TYPE STRING,
*	 AF  TYPE STRING,
*	 AG  TYPE STRING,
*	 AH  TYPE STRING,
*	 AI  TYPE STRING,
*	 AJ  TYPE STRING,
*	 AK  TYPE STRING,
*	 AL  TYPE STRING,
*	 AM  TYPE STRING,
*	 AN  TYPE STRING,
*	 AO  TYPE STRING,
*	 AP  TYPE STRING,
*	 AQ  TYPE STRING,
*	 AR  TYPE STRING,
*	 AS  TYPE STRING,
*	 AT  TYPE STRING,
*	 AU  TYPE STRING,
*	 AV  TYPE STRING,
*	 AW  TYPE STRING,
*	 AX  TYPE STRING,
*	 AY  TYPE STRING,
*	 AZ  TYPE STRING,
*	 BA  TYPE STRING,
*	 BB  TYPE STRING,
*	 BC  TYPE STRING,
*	 BD  TYPE STRING,
*	 BE  TYPE STRING,
*	 BF  TYPE STRING,
*	 BG  TYPE STRING,
*	 BH  TYPE STRING,
*	 BI  TYPE STRING,
*	 BJ  TYPE STRING,
*	 BK  TYPE STRING,
*	 BL  TYPE STRING,
*	 BM  TYPE STRING,
*	 BN  TYPE STRING,
*	 BO  TYPE STRING,
*	 BP  TYPE STRING,
*	 BQ  TYPE STRING,
*	 BR  TYPE STRING,
*	 BS  TYPE STRING,
*	 BT  TYPE STRING,
*	 BU  TYPE STRING,
*	 BV  TYPE STRING,
*	 BW  TYPE STRING,
*	 BX  TYPE STRING,
*	 BY  TYPE STRING,
*	 BZ  TYPE STRING,
       END OF typ_excel.

TYPES: BEGIN OF typ_data,
         row   TYPE  kcd_ex_row_n,
         col   TYPE  kcd_ex_col_n,
         value TYPE string,
       END OF typ_data.


TYPES: ty_d_itabvalue TYPE string,

       ty_t_itab      TYPE typ_data OCCURS 0,

       BEGIN OF ty_s_senderline,
         line(4096) TYPE c,
       END OF ty_s_senderline,
       ty_t_sender TYPE ty_s_senderline  OCCURS 0.



*************************************************************************
" ALTERAR ESTA ESTRUTURA PARA O ID DA TABELA OU CAMPO QUE DESEJE ORDENAR E NÃO SE REPETIR
*************************************************************************

**********************************************************************
* Tabela Interna
**********************************************************************
DATA: itab TYPE STANDARD TABLE OF typ_data WITH HEADER LINE.
DATA: lt_excel TYPE STANDARD TABLE OF typ_excel.
**********************************************************************
* Estruturas
**********************************************************************
DATA: ls_excel LIKE LINE OF lt_excel.
**********************************************************************
* Constantes
**********************************************************************
CONSTANTS:  gc_esc              VALUE '"'.
**********************************************************************
* Variáveis
**********************************************************************
DATA: gd_currentrow TYPE i.

  DATA: excel_tab     TYPE  ty_t_sender.
  DATA: ld_separator  TYPE  c.
  DATA: application   TYPE  ole2_object,
        workbook      TYPE  ole2_object,
        range         TYPE  ole2_object,
        worksheet     TYPE  ole2_object.
  DATA: h_cell        TYPE  ole2_object,
        h_cell1       TYPE  ole2_object.
  DATA:
    ld_rc             TYPE i.

**********************************************************************
* Classes
**********************************************************************

**********************************************************************
* Tela de Seleção
**********************************************************************
SELECTION-SCREEN BEGIN OF BLOCK bl1 WITH FRAME TITLE text-bl1.

*PARAMETER:  p_tabl  TYPE dd02l-tabname DEFAULT 'ZTABELA_DESTINO' NO-DISPLAY.

PARAMETERS: pa_file TYPE  rlgrap-filename OBLIGATORY DEFAULT 'C:\temp\uploadexcel\arquivo.xlsx'.

SELECTION-SCREEN END   OF BLOCK bl1.

AT SELECTION-SCREEN ON VALUE-REQUEST FOR pa_file.
  CALL FUNCTION 'F4_FILENAME'
    EXPORTING
      field_name = 'PA_FILE'
    IMPORTING
      file_name  = pa_file.


  DEFINE m_message.
    case sy-subrc.
      when 0.
      when 1.
        message id sy-msgid type sy-msgty number sy-msgno
                with sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
      when others. raise upload_ole.
    endcase.
  END-OF-DEFINITION.

**********************************************************************
* Início da Seleção
**********************************************************************

START-OF-SELECTION.

  PERFORM get_data.

FORM get_data.

  TRY .

DATA:     i_begin_col    TYPE I VALUE 1,
          i_begin_row    TYPE I VALUE 2,  "Do not require headings
          i_end_col      TYPE I VALUE 14,
          i_end_row      TYPE I VALUE 31.


* check parameters
  IF i_begin_row > i_end_row. RAISE inconsistent_parameters. ENDIF.
  IF i_begin_col > i_end_col. RAISE inconsistent_parameters. ENDIF.

* Get TAB-sign for separation of fields
  CLASS cl_abap_char_utilities DEFINITION LOAD.
  ld_separator = cl_abap_char_utilities=>horizontal_tab.

* open file in Excel
  IF application-header = space OR application-handle = -1.
    CREATE OBJECT application 'Excel.Application'.
    m_message.
  ENDIF.
  CALL METHOD  OF application    'Workbooks' = workbook.
  m_message.
  CALL METHOD  OF workbook 'Open'    EXPORTING #1 = pa_file.
  m_message.
*  set property of application 'Visible' = 1.
*  m_message.
  GET PROPERTY OF  application 'ACTIVESHEET' = worksheet.
  m_message.

* mark whole spread sheet
  CALL METHOD OF worksheet 'Cells' = h_cell
      EXPORTING #1 = i_begin_row #2 = i_begin_col.
  m_message.
  CALL METHOD OF worksheet 'Cells' = h_cell1
      EXPORTING #1 = i_end_row #2 = i_end_col.
  m_message.

  CALL METHOD  OF worksheet 'RANGE' = range
                 EXPORTING #1 = h_cell #2 = h_cell1.
  m_message.
  CALL METHOD OF range 'SELECT'.
  m_message.

* copy marked area (whole spread sheet) into Clippboard
  CALL METHOD OF range 'COPY'.
  m_message.

* read clipboard into ABAP
  CALL METHOD cl_gui_frontend_services=>clipboard_import
    IMPORTING
      data                 = excel_tab
    EXCEPTIONS
      cntl_error           = 1
      OTHERS               = 4
          .
  IF sy-subrc <> 0.
     MESSAGE a037(alsmex).
  ENDIF.

  PERFORM separated_to_intern_convert TABLES excel_tab ITAB
                                      USING  ld_separator.

* clear clipboard
  REFRESH excel_tab.
  CALL METHOD cl_gui_frontend_services=>clipboard_export
     IMPORTING
        data                 = excel_tab
     CHANGING
        rc                   = ld_rc
     EXCEPTIONS
        cntl_error           = 1
        OTHERS               = 4
          .

* quit Excel and free ABAP Object - unfortunately, this does not kill
* the Excel process
  CALL METHOD OF application 'QUIT'.
  m_message.

* >>>>> Begin of change note 575877
* to kill the Excel process it's necessary to free all used objects
  FREE OBJECT h_cell.       m_message.
  FREE OBJECT h_cell1.      m_message.
  FREE OBJECT range.        m_message.
  FREE OBJECT worksheet.    m_message.
  FREE OBJECT workbook.     m_message.
  FREE OBJECT application.  m_message.

  ENDTRY.


* Sort table by rows and colums
  SORT itab BY row col.

* Get first row retrieved
  READ TABLE itab INDEX 1.

* Set first row retrieved to current row
  gd_currentrow = itab-row.

  LOOP AT itab.
*   Reset values for next row
    IF itab-row NE gd_currentrow.
      APPEND ls_excel TO lt_excel.
      CLEAR ls_excel.
      gd_currentrow = itab-row.
    ENDIF.

******************************************************************
******************************************************************
******************************************************************
    CASE itab-col.
      WHEN '0001'.
        ls_excel-a   = itab-value.
      WHEN '0002'.
        ls_excel-b   = itab-value.
      WHEN '0003'.
        ls_excel-c   = itab-value.
    ENDCASE.
  ENDLOOP.
  APPEND ls_excel TO lt_excel.
******************************************************************
******************************************************************
******************************************************************
  BREAK-POINT.


ENDFORM.























FORM separated_to_intern_convert TABLES i_tab       TYPE ty_t_sender
                                        i_intern    TYPE ty_t_itab
                                 USING  i_separator TYPE c.
  DATA: l_sic_tabix LIKE sy-tabix,
        l_sic_col   TYPE kcd_ex_col.
  DATA: l_fdpos     LIKE sy-fdpos.

  REFRESH i_intern.

  LOOP AT i_tab.
    l_sic_tabix = sy-tabix.
    l_sic_col = 0.
    WHILE i_tab CA i_separator.
      l_fdpos = sy-fdpos.
      l_sic_col = l_sic_col + 1.
      PERFORM line_to_cell_separat TABLES i_intern
                                   USING  i_tab l_sic_tabix l_sic_col
                                          i_separator l_fdpos.
    ENDWHILE.
    IF i_tab <> space.
      CLEAR i_intern.
      i_intern-row = l_sic_tabix.
      i_intern-col = l_sic_col + 1.
      i_intern-value = i_tab.
      APPEND i_intern.
    ENDIF.
  ENDLOOP.
ENDFORM.                    " SEPARATED_TO_INTERN_CONVERT
*---------------------------------------------------------------------*
FORM line_to_cell_separat TABLES i_intern    TYPE ty_t_itab
                          USING  i_line
                                 i_row       LIKE sy-tabix
                                 ch_cell_col TYPE kcd_ex_col
                                 i_separator TYPE c
                                 i_fdpos     LIKE sy-fdpos.
  DATA: l_string   TYPE ty_s_senderline.
  DATA  l_sic_int  TYPE i.

  CLEAR i_intern.
  l_sic_int = i_fdpos.
  i_intern-row = i_row.
  l_string = i_line.
  i_intern-col = ch_cell_col.
* csv Dateien mit separator in Zelle: --> ;"abc;cd";
  IF ( i_separator = ';' OR  i_separator = ',' ) AND
       l_string(1) = gc_esc.
      PERFORM line_to_cell_esc_sep USING l_string
                                         l_sic_int
                                         i_separator
                                         i_intern-value.
  ELSE.
    IF l_sic_int > 0.
      i_intern-value = i_line(l_sic_int).
    ENDIF.
  ENDIF.
  IF l_sic_int > 0.
    APPEND i_intern.
  ENDIF.
  l_sic_int = l_sic_int + 1.
  i_line = i_line+l_sic_int.
ENDFORM.

*---------------------------------------------------------------------*
FORM line_to_cell_esc_sep USING i_string
                                i_sic_int      TYPE i
                                i_separator    TYPE c
                                i_intern_value TYPE ty_d_itabvalue.
  DATA: l_int TYPE i,
        l_cell_end(2).
  FIELD-SYMBOLS: <l_cell>.
  l_cell_end = gc_esc.
  l_cell_end+1 = i_separator .

  IF i_string CS gc_esc.
    i_string = i_string+1.
    IF i_string CS l_cell_end.
      l_int = sy-fdpos.
      ASSIGN i_string(l_int) TO <l_cell>.
      i_intern_value = <l_cell>.
      l_int = l_int + 2.
      i_sic_int = l_int.
      i_string = i_string+l_int.
    ELSEIF i_string CS gc_esc.
*     letzte Celle
      l_int = sy-fdpos.
      ASSIGN i_string(l_int) TO <l_cell>.
      i_intern_value = <l_cell>.
      l_int = l_int + 1.
      i_sic_int = l_int.
      i_string = i_string+l_int.
      l_int = strlen( i_string ).
      IF l_int > 0 . MESSAGE x001(kx) . ENDIF.
    ELSE.
      MESSAGE x001(kx) . "was ist mit csv-Format
    ENDIF.
  ENDIF.

ENDFORM.
